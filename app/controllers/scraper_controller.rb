class ScraperController < ApplicationController

    include HTTParty
    include Nokogiri
    # require 'Nokogiri'

    require 'rspotify'
    RSpotify.authenticate(ENV["client_id"], ENV["client_secret"])

   

    def index
        doc = HTTParty.get('https://spotifycharts.com/regional/co/daily/latest')
        @parse_page = Nokogiri::HTML(doc)

    

        tempoArr = 0
        tempo_sum = 0
        i=1

        # puts @parse_page

        puts "### Search for nodes by css"

        # vaina_loca = @parse_page.css('.chart-table-track strong')[1].content
        # tracks = RSpotify::Track.search(vaina_loca, limit: 1)
        # track_id = tracks[0].id
        # audio_features = RSpotify::AudioFeatures.find(track_id)
        
        # puts vaina_loca
        # puts audio_features.tempo

        @parse_page.css('.chart-table-track strong').each do |link|
            
            
            names = link.content
            if i<172 
                i +=1
                tracks = RSpotify::Track.search(names, limit: 1)
                track_id = tracks[0].id
                audio_features = RSpotify::AudioFeatures.find(track_id)
                puts names
                tempoArr += audio_features.tempo
            end 
        end
        
        puts "Blahssdsd"
        puts i

        puts avg_tempo = tempoArr/i



        

        # tempoArr.each_with_index do |element,index|
        #     element.do_stuff(index)
        #   end
        # puts song_names[50]
    end 
end
