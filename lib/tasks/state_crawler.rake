#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'


task state_crawler: :environment do
  # class State_Crawler
  #   attr_reader :state_name, :state_url
  #   def initialize
  #     state_name = 0
  #     state_url = 0
  #   end
  # end

  base_url = "https://opensnow.com"
  base_state_url = "#{base_url}/state"

  #fetch state list

    base_state_page = Nokogiri::HTML(open(base_state_url))

    state_parse = base_state_page.css("div.title-location a").each do |link|
      @state_url = (base_url + link['href']).strip
      @state_name = link.text.strip
  
      if !State.exists?(:state_url => @state_url, :state_name => @state_name)
        s = State.new
        s.state_url = @state_url
        s.state_name = @state_name
        s.save
      end
      puts @state_name
      puts @state_url

    #   specific_state_page = Nokogiri::HTML(open(@state_url))

    #   resort_parse = specific_state_page.css("div.title-location a").each do |link|
    #   @resort_name = link.text.strip
    #   @resort_url = (base_url + link['href']).strip
    # #fetch resort location details
    #   resort_page = Nokogiri::HTML(open(@resort_url))

    #   @recent_time = resort_page.css("#report-data > div:nth-child(2) > div:nth-child(2) > div > div").text.strip.gsub("\n",'').squeeze(' ') #make it pretty, removes /n and squish(rails)
    #   @recent_snowfall = resort_page.css("#report-data > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
    #   @next_snowfall = resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
    #   @next5_snowfall = resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(2) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i

    #   if @state_name == "Alabama"
    #     state_id = 1
    #   elsif @state_name == "Alaska"
    #     state_id = 2
    #   else state_id = 3
    #   end

    #   puts @resort_url
    #   puts @resort_name
    #   puts @recent_time
    #   puts @recent_snowfall
    #   puts @next_snowfall
    #   puts @next5_snowfall
    #   puts state_id
    #   # > user = User.first
    #   # > post = Post.create(title: "sample", user_id: user.id)

    #   # a = State.first

    #   r = Resort.create(
    #     resort_name: @resort_name,
    #     resort_url: @resort_url,
    #     recent_time: @recent_time,
    #     recent_snowfall: @recent_snowfall,
    #     next_snowfall: @next_snowfall,
    #     next5_snowfall: @next5_snowfall,
    #     state_id: state_id
    #   )

    end
  #end

end
      #fetch resort list


  #       specific_state_page = Nokogiri::HTML(open(@state_url.strip))

  #         resort = specific_state_page.css("div.title-location a").each do |link|
  #         @resort_url = base_url + link['href']
  #         @resort_name = link.text.strip

  #       #fetch resort location details
  #         resort_page = Nokogiri::HTML(open(@resort_url.strip))

  #         @recent_time = resort_page.css("#report-data > div:nth-child(2) > div:nth-child(2) > div > div").text.strip.gsub("\n",'').squeeze(' ') #make it pretty, removes /n and squish(rails)
  #         @recent_snowfall = resort_page.css("#report-data > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
  #         @next_snowfall = resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(1) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
  #         @next5_snowfall = resort_page.css("#forecast-block > div:nth-child(2) > div > div:nth-child(2) > div > div:nth-child(1)").text.strip.scan(/\d/).join('').to_i
        


  #         puts @resort_url
  #         puts @resort_name
  #         puts @recent_time
  #         resort_data = Resort.new(
  #           :resort_url => @resort_url,
  #           :resort_name => @resort_name,
  #           :recent_time => @recent_time,
  #           :recent_snowfall => @recent_snowfall,
  #           :next_snowfall => @next_snowfall,
  #           :next5_snowfall => @next5_snowfall,
  #           :state_id => @state_id
  #         ) 
  #         resort_data.save
  #       end
  #     end



# @resort_page = Nokogiri::HTML(open(state_url))
# p state



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



