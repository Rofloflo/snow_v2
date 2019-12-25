#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

task resort_crawler: :environment do
  # class Resort_Crawler
  #   attr_reader :resort_name, :resort_url, :recent_time, :recent_snowfall, :next_snowfall, :next5_snowfall, :state_id
  #   def initialize
  #     @resort_name = 0
  #     @resort_url = 0
  #     @recent_time = 0
  #     @recent_snowfall = 0
  #     @next_snowfall = 0
  #     @next5_snowfall = 0
  #     @state_id = 0
  #   end
  # end

  base_url = "https://opensnow.com"
  base_state_url = "#{base_url}/state"

  #fetch resort list
  base_state_page = Nokogiri::HTML(open(base_state_url))

  state_parse = base_state_page.css("div.title-location a").each do |link|
    @state_url = (base_url + link['href']).strip
    @state_name = link.text.strip

    puts @state_name
    puts @state_url

        specific_state_page = Nokogiri::HTML(open(@state_url))

          resort_parse = specific_state_page.css("div.title-location a").each do |link|
          @resort_name = link.text.strip
          @resort_url = (base_url + link['href']).strip
        #fetch resort location details
          resort_page = Nokogiri::HTML(open(@resort_url))

          @recent_time = resort_page.css("#report-data > div:nth-child(2) > div:nth-child(2) > div > div").text.strip.gsub("\n",'').squeeze(' ') #make it pretty, removes /n and squish(rails)
          @recent_snowfall = resort_page.css("#report-data > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
          @next_snowfall = resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
          @next5_snowfall = resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(2) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i

              #   if @state_name == "Alabama"
              #     state_id = 1
              #   elsif @state_name == "Alaska"
              #     state_id = 2
              #   else state_id = 3
              #   end
              puts @resort_name
              puts @resort_url
              puts @recent_time
              puts @recent_snowfall
              puts @next_snowfall
              puts @next5_snowfall

          # > user = User.first
          # > post = Post.create(title: "sample", user_id: user.id)

          a = State.find_by state_name: @state_name

          r = Resort.create(
            resort_name: @resort_name,
            resort_url: @resort_url,
            recent_time: @recent_time,
            recent_snowfall: @recent_snowfall,
            next_snowfall: @next_snowfall,
            next5_snowfall: @next5_snowfall,
            state_id: a.id
          )

          #user = User.first
          #user.posts.create(title: "sample")
          # s = State.new
          # s.state_url = state_url
          # s.state_name = state_name
          # s.save
          end
        end
      end
  
    # nav = doc.css('div#ttBR_row_8').each do |row|
                #   # puts row.content
          #   TimeTable.create({
          #     start_city: row.content[0], 
          #     destination_city: row.content[1], 
          #     departure_time: row.content[2], 
          #     arrival_time: row.content[3]
          # end