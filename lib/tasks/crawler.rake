#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

BASE_URL = "https://opensnow.com"
BASE_STATE_URL = "#{BASE_URL}/state"

def normalize_snowfall_str(text)
  text.blank? ? nil : text.to_i
end


def crawl_state_url
  base_state_page = Nokogiri::HTML(open(BASE_STATE_URL))

  state_parse = base_state_page.css("div.title-location a").each do |link|
    state_url = (BASE_URL + link['href']).strip
    state_name = link.text.strip

    save_state_data(state_url, state_name) #Do this for all inputs
    #Progress check
    puts state_name
    puts state_url
  end
end

def save_state_data(state_url, state_name)
    #Save only if no duplicate entries
    s = State.find_by(state_url: state_url)
    unless s
      s = State.new
      s.state_url = state_url
      s.state_name = state_name
      s.save
    end
end


def crawl_resort_url
  state_list = State.pluck(:state_url)
  state_list.each do |state|
  specific_state_page = Nokogiri::HTML(open(state))

  resort_parse = specific_state_page.css("div.title-location a").each do |link|
    resort_name = link.text.strip
    resort_url = (BASE_URL + link['href']).strip
    # set resort association to state
    s = State.find_by(state_url: state)

    save_resort_data(resort_name, resort_url, s)
    #Resort rake progress check
    puts resort_name
    puts resort_url

  end
end
end

def save_resort_data(resort_name, resort_url, s)
  #Save resort data to database
  if !Resort.exists?(:resort_url => resort_url)
    r = s.resorts.create(
      resort_name: resort_name,
      resort_url: resort_url,
    )
  end
end


def crawl_snow_data
  resort_list = Resort.pluck(:resort_url)
  resort_list.each do |resort|
  resort_page = Nokogiri::HTML(open(resort))

  check_header_for_snow = resort_page.at_css("#report-data > h3:nth-child(1)")
    if check_header_for_snow.try(:text) == "New Snow"
      recent_time = resort_page.css("#report-data > div:nth-child(2) > div:nth-child(2) > div > div").text.strip.gsub("\n",'').squeeze(' ')
      recent_snowfall = resort_page.css("#report-data > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
    else 
      recent_time = nil
      recent_snowfall = nil
      puts "No New Snow"
    end
  future_snowfall = resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('')
  future5_snowfall  = resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(2) > div > div:nth-child(1)").text.strip.scan(/\d/).join('')
  next_snowfall = normalize_snowfall_str(future_snowfall)  
  next5_snowfall = normalize_snowfall_str(future5_snowfall)
  r = Resort.find_by(resort_url: resort) #setup snow data association to resort
  r_id = r.id

  save_snow_data(recent_time, recent_snowfall, next_snowfall, next5_snowfall, r, r_id)
  #Rake progress check
  puts resort_url
  puts recent_time
  puts recent_snowfall
  puts next_snowfall
  puts next5_snowfall
  end
end

def save_snow_data(recent_time, recent_snowfall, next_snowfall, next5_snowfall, r, r_id)
  #Save resort data to database
  if !SnowDatum.exists?(:recent_time => recent_time, :recent_snowfall => recent_snowfall, :next_snowfall => next_snowfall, :next5_snowfall => next5_snowfall, :resort_id => r_id)
    sd = r.snow_data.create(
      recent_time: recent_time,
      recent_snowfall: recent_snowfall,
      next_snowfall: next_snowfall,
      next5_snowfall: next5_snowfall
    )
  end
end


task state_crawler: :environment do
  desc "Scrape Open Snow for State info"
begin
  crawl_state_url
rescue => ex
  byebug
end
end

task resort_crawler: :environment do 
  desc "Scrape Open Snow for resort and location info"
begin
  crawl_resort_url
rescue => ex
  byebug
end
end

task snow_crawler: :environment do 
  desc "Scrape Open Snow for resort and location info"
begin
  crawl_snow_data
rescue => ex
  byebug
end
end

