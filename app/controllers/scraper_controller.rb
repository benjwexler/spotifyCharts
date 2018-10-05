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


        puts "### Search for nodes by css"
        puts country 


        @parse_page.css('.chart-table-track strong').each do |link|
            song_name = link.content
            if i<=50
                tracks = RSpotify::Track.search(song_name, limit: 1)
                puts i
                puts song_name
                if tracks.length >0
                    name = tracks[0].name
                    spotify_id = tracks[0].id
                    audio_features = RSpotify::AudioFeatures.find(spotify_id)
                    acousticness = audio_features.acousticness
                    danceability = audio_features.danceability
                    duration_ms = audio_features.duration_ms
                    energy = audio_features.energy 
                    instrumentalness = audio_features.instrumentalness
                    key = audio_features.key
                    liveness = audio_features.liveness
                    mode = audio_features.mode
                    speechiness = audio_features.speechiness
                    tempo = audio_features.tempo
                    time_signature = audio_features.time_signature
                    valence = audio_features.valence

                    puts spotify_id

                    # Song.create(:name => name, :artist => "unknown", :spotify_id => spotify_id, :acousticness => acousticness, :danceability => danceability, :duration_ms => duration_ms, :energy => energy, :instrumentalness => instrumentalness, :key => key, :liveness => liveness, :mode => mode, :speechiness => speechiness, :tempo => tempo, :time_signature => time_signature, :valence => valence)  
                end 
                    i +=1  
            end 
        end
        
        puts "Blahssdsd"
        puts i
  
     

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
