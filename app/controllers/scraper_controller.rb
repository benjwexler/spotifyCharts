class ScraperController < ApplicationController

    include HTTParty
    include Nokogiri
    # require 'Nokogiri'

    require 'rspotify'
    RSpotify.authenticate(ENV["client_id"], ENV["client_secret"])

   

    def index

        #   country_codes = ['us', 'gb', 'ar', 'at', 'au', 'be', 'bo', 'br', 'ca', 'ch', 'cl', 'co', 'cr', 'cz', 'de', 'dk', 'do', 'ec', 'ee', 'es', 'fi', 'fr', 'gr', 'gt', 'hk', 'hn', 'hu', 'id', 'ie', 'il', 'is', 'it', 'jp', 'lt', 'lu', 'lv', 'mt', 'mx', 'my', 'ni', 'nl', 'no', 'nz', 'pa', 'pe', 'ph', 'pl', 'pt', 'py', 'ro', 'se', 'sg', 'sk', 'sv', 'th', 'tr', 'tw', 'uy', 'vn']

        country_codes = ['us']
        country_codes.each do |country|
       

        doc = HTTParty.get("https://spotifycharts.com/regional/#{country}/weekly/latest")
        @parse_page = Nokogiri::HTML(doc)

       

    

        tempoArr = []
        tempo_sum = 0
        danceability_sum = 0
        i=1

        # puts @parse_page

        puts "### Search for nodes by css"
        puts country 

        # vaina_loca = @parse_page.css('.chart-table-track strong')[1].content
        # tracks = RSpotify::Track.search(vaina_loca, limit: 1)
        # track_id = tracks[0].id
        # audio_features = RSpotify::AudioFeatures.find(track_id)
        
        # puts vaina_loca
        # puts audio_features.tempo

        @parse_page.css('.chart-table-track strong').each do |link|
            
            
            names = link.content
            if i<=50
                
                tracks = RSpotify::Track.search(names, limit: 1)
                puts i
                puts names
                if tracks.length >0
                    track_id = tracks[0].id
                    audio_features = RSpotify::AudioFeatures.find(track_id)
                    song_tempo = audio_features.tempo
                    danceability_sum += audio_features.danceability
                    tempoArr.push(song_tempo)
                    
                    puts track_id
                    tempo_sum += audio_features.tempo 
                end 
                    i +=1
                
                
            end 
        end
        
        puts "Blahssdsd"
        puts i
  
        puts tempoArr.length
        puts avg_tempo = tempo_sum/i
        puts avg_dance = danceability_sum/i

    end 



        

        # tempoArr.each_with_index do |element,index|
        #     element.do_stuff(index)
        #   end
        # puts song_names[50]
    end 

    def bugs

        buggy_tracks = ["Wie ein Alpha", ]
        # name = "Wie ein Alpha"
        # puts name 
        # tracks = RSpotify::Track.search(name, limit: 1)
        # puts tracks.length
    end 

end
