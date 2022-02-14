class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    return @letters
  end

  def score
    attempt = params[:word]
    filepath = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    serialized_dictionary = URI.open(filepath).read
    result = JSON.parse(serialized_dictionary)
    if result["found"] == true
      if attempt.chars.all? { |letter| attempt.count(letter) <= new.count(letter)}
        @score = "Congratulations! #{attempt.upcase} is a valid English word!"
      else
        @score = "Sorry but #{attempt.upcase} can't be built out of #{new.join(", ")}"
      end
    else
      @score = "Sorry but #{attempt.upcase} does not seem to be a valid English word..."
    end
  end
end
