#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'


task crawler: :environment do


class Crawler
  attr_reader :state_name, :state_url, :resort_name, :resort_url, :recent_time, :recent_snowfall, :next_snowfall, :next5_snowfall
  def initialize
    @state_name = 0
    @state_url = 0
    @resort_name = 0
    @resort_url = 0
    @recent_time = 0
    @recent_snowfall = 0
    @next_snowfall = 0
    @next5_snowfall = 0
    @state_id = 0
  end

  base_url = "https://opensnow.com"
  base_state_url = "#{base_url}/state"

  #fetch state list
  base_state_page = Nokogiri::HTML(open(base_state_url))

  state = base_state_page.css("div.title-location a").each do |link|
    @state_url = base_url + link['href']
    @state_name = link.text.strip
    state_data = State.new(
      :state_url => @state_url,
      :state_name => @state_name
    )
    if @state_url != ""
      state_data.save
    else puts "Failed state save"
    end
      #fetch resort list
      @specific_state_page = Nokogiri::HTML(open(@state_url.strip))

        resort = @specific_state_page.css("div.title-location a").each do |link|
        @resort_url = base_url + link['href']
        @resort_name = link.text.strip

        #fetch resort location details
        @resort_page = Nokogiri::HTML(open(@resort_url.strip))

        @recent_time = @resort_page.css("#report-data > div:nth-child(2) > div:nth-child(2) > div > div").text.strip.gsub("\n",'').squeeze(' ') #make it pretty, removes /n and squish(rails)
        @recent_snowfall = @resort_page.css("#report-data > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
        @next_snowfall = @resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
        @next5_snowfall = @resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(2) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
        resort_data = Resort.new(
          :resort_url => @resort_url,
          :resort_name => @resort_name,
          :recent_time => @recent_time,
          :recent_snowfall => @recent_snowfall,
          :next_snowfall => @next_snowfall,
          :next5_snowfall => @next5_snowfall,
          :state_id => @state_id
        )
        if @resort_url != ""
          resort_data.save
        else puts "Failed resort save"
        end

      end
    end
end
end


# @resort_page = Nokogiri::HTML(open(state_url))
# p state




# desc "Print reminder about eating more fruit."
# task :apple do
#   puts "Eat more apples!"
# end

# rake apple

# task :import do
#   puts "Importing data..."
#   Dir.chdir(Rails.root.join("data")) { ruby "load-data.rb" }
# end

# namespace :backup do
#   task :create do
#     # ...
#   end
#   task :list do
#     # ...
#   end
#   task :restore do
#     # ...
#   end
# end

# # rake backup:create

# task create_examples: "load_database" do   #The list of dependent tasks can also be an array of strings or an array of symbols.
#   # ...
# end



