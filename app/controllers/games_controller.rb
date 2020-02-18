require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'a'..'z'].sample }
  end

  def score
    @word = params[:word].downcase
    @letters = params[:letters]
    result(@word, @letters)
  end

  def result(word, letters)
    @check_result = match_letters(word, letters)
    @check_english = english_word(word)
    if @check_result == true && @check_english == true
      @result_message = "Congratulations! #{word.upcase} is a valid English word!"
    elsif @check_result == true
      @result_message = "Sorry, but #{word.upcase} does not seem to be a valid English word..."
    else
      @result_message = "Sorry, but #{word.upcase} can't be built out of #{letters.upcase}!"
    end
  end

  def match_letters(word, letters)
    word.chars.all? { |c| word.count(c) <= letters.split.count(c) }
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    dict = JSON.parse(open(url).read)
    return dict["found"]
  end
end
