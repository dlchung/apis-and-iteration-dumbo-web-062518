require 'rest-client'
require 'json'
require 'pry'

def web_request
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
end

def parse_data
  character_hash = JSON.parse(web_request)
end

def get_results
  result = parse_data.fetch("results")
end

def get_films(character)
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  character_films = get_results.find {|character_hash| character_hash["name"].downcase == character.downcase}["films"]
end

def request_film_data(character)
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  get_films(character).map {|film_url| JSON.parse(RestClient.get(film_url))}

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def show_character_movies(character)
  # some iteration magic and puts out the movies in a nice list
  # films_hash = get_character_movies_from_api(character)
  request_film_data(character).each {|film_hash| puts film_hash["title"]}
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
