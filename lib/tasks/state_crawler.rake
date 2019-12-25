#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'


task state_crawler: :environment do

  base_url = "https://opensnow.com"
  base_state_url = "#{base_url}/state"

    #fetch state list
    base_state_page = Nokogiri::HTML(open(base_state_url))

    state_parse = base_state_page.css("div.title-location a").each do |link|
      @state_url = (base_url + link['href']).strip
      @state_name = link.text.strip

      #Progress check
      puts @state_name
      puts @state_url

      #Save only if no duplicate entries
      if !State.exists?(:state_url => @state_url, :state_name => @state_name)
        s = State.new
        s.state_url = @state_url
        s.state_name = @state_name
        s.save
      end
    end
end

     







