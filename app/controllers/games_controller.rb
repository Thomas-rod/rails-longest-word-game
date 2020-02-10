require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      letter = ('A'..'Z').to_a
      @letters << letter.sample
    end
    @letters
  end

  def score
    url = 'https://wagon-dictionary.herokuapp.com/'
    @result = nil
    @word = params['word'].downcase
    @letters = params['letters'].downcase

    if !include?(@word.split(''), @letters.split(' '))
      @result = "Sorry but #{@word} can\'t be built out of #{@letters}"
    elsif !english_word(url, @word)
      @result = "Sorry but #{@word} doesn't seems to be a valid English word..."
    else
      @result = "Well done mate, good point"
    end
  end

  private

  def include?(word, letters)
    word.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end

  def english_word(url, word)
    url_merge = url + word
    array_word = JSON.parse(open(url_merge).read)
    array_word['found']
  end
end
