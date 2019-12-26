#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

task resort_crawler: :environment do 
  base_url = "https://opensnow.com"
  base_state_url = "#{base_url}/state"

  #fetch resort list
  base_state_page = Nokogiri::HTML(open(base_state_url))

  state_parse = base_state_page.css("div.title-location a").each do |link|
    @state_url = (base_url + link['href']).strip
    @state_name = link.text.strip

    #State Progress Check
    puts @state_name
    puts @state_url

        specific_state_page = Nokogiri::HTML(open(@state_url))

        resort_parse = specific_state_page.css("div.title-location a").each do |link|
          @resort_name = link.text.strip
          @resort_url = (base_url + link['href']).strip
          
          #fetch resort location details
          resort_page = Nokogiri::HTML(open(@resort_url))

          @recent_time = resort_page.css("#report-data > div:nth-child(2) > div:nth-child(2) > div > div").text.strip.gsub("\n",'').squeeze(' ')
          @recent_snowfall = resort_page.css("#report-data > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
          @next_snowfall = resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
          @next5_snowfall = resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(2) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i

          #Resort rake progress check
          puts @resort_name
          puts @resort_url
          puts @recent_time
          puts @recent_snowfall
          puts @next_snowfall
          puts @next5_snowfall
          
          #set resort association to state
          assign_state = State.find_by state_name: @state_name
          
          if !Resort.exists?(:resort_name => @resort_name, :resort_url => @resort_url, :recent_time => @recent_time, :recent_snowfall => @recent_snowfall, :next_snowfall => @next_snowfall, :next5_snowfall => @next5_snowfall)
            r = Resort.create(
              resort_name: @resort_name,
              resort_url: @resort_url,
              recent_time: @recent_time,
              recent_snowfall: @recent_snowfall,
              next_snowfall: @next_snowfall,
              next5_snowfall: @next5_snowfall,
              state_id: assign_state.id
            )
          end
        end
    end
end