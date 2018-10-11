class ScraperController < ApplicationController

    include HTTParty
    include Nokogiri

    require 'rspotify'
    RSpotify.authenticate(ENV["client_id"], ENV["client_secret"])

   

    def index
       
        do_api_call = false

        if  do_api_call == true

        j=0
           
            country_codes = ['us', 'gb', 'ar', 'at', 'au', 'be', 'bo', 'br', 'ca', 'ch', 'cl', 'co', 'cr', 'cz', 'de', 'dk', 'do', 'ec', 'ee', 'es', 'fi', 'fr', 'gr', 'gt', 'hk', 'hn', 'hu', 'id', 'ie', 'il', 'is', 'it', 'jp', 'lt', 'lu', 'lv', 'mt', 'mx', 'my', 'ni', 'nl', 'no', 'nz', 'pa', 'pe', 'ph', 'pl', 'pt', 'py', 'ro', 'se', 'sg', 'sk', 'sv', 'th', 'tr', 'tw', 'uy', 'vn']

            # country_codes = ['hk', 'hn', 'hu', 'id', 'ie', 'il', 'is', 'it', 'jp', 'lt', 'lu', 'lv', 'mt', 'mx', 'my', 'ni', 'nl', 'no', 'nz', 'pa', 'pe', 'ph', 'pl', 'pt', 'py', 'ro', 'se', 'sg', 'sk', 'sv', 'th', 'tr', 'tw', 'uy', 'vn']
            # country_codes = ['us']
        if j == 0 
        country_codes.each do |country_code|
       

        doc = HTTParty.get("https://spotifycharts.com/regional/#{country_code}/weekly/latest")
        @parse_page = Nokogiri::HTML(doc)

        country_name  = @parse_page.css('.chart-filters-list .responsive-select .responsive-select-value')

            country_name = country_name[0].content

            Country.create(:country_code => country_code, :name => country_name)

        i=0

        song_artists_arr = []
        song_names_arr = []

       
            @parse_page.css('.chart-table-track strong').each do |song_name|

                #this will yield 51 results but the first one isn't actual song
                if i<=50 
                song_names_arr.push(song_name.content)
                i+=1 
                end 
            end
           i = 0
            @parse_page.css('.chart-table-track span').each do |artist|
                if i<=50
                    artist_name = artist.content
                    length = artist_name.length
                song_artists_arr.push(artist_name[3..length])
                i+=1 
                end 
            end

        i=1

        artist_song_hash = {}

        while i <= 50 
            artist_song_hash[i] = [song_names_arr[i], song_artists_arr[i]]
            i+=1 
        end 



    country_id = Country.last.id

    j = 1

    artist_song_hash.each_value {|value|
                RSpotify.raw_response = true

                tracks = RSpotify::Track.search("#{value[0]} #{value[1]} ", limit: 1, market: country_code)

                if tracks.code < 500
                    RSpotify.raw_response = false 
                    tracks = RSpotify::Track.search("#{value[0]} #{value[1]} ", limit: 1, market: country_code)
                

                puts "#{value[0]} #{value[1]} "
                
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
 
                    # need to check here if the song exist. Validation is set
                    if Song.where({spotify_id: spotify_id}).length == 0
                        Song.create(:name => value[0], :artist => value[1], :spotify_id => spotify_id, :acousticness => acousticness, :danceability => danceability, :duration_ms => duration_ms, :energy => energy, :instrumentalness => instrumentalness, :key => key, :liveness => liveness, :mode => mode, :speechiness => speechiness, :tempo => tempo, :time_signature => time_signature, :valence => valence)
                    
                    song_id = Song.last.id 
                     else 
                    song_id = Song.where({spotify_id: spotify_id})[0].id
                    end 
                    
                    
                    
                
                else 
                    Song.create(:name => value[0], :artist => value[1])
                    song_id = Song.last.id
                    
                end 
                Chart.create(:country_id => country_id, :position => j, :song_id => song_id)
            else 
                j+=1 
                next 
            end
                j+=1 
            }     
            
        end 
       

        end 
    end 
    end 
end 



