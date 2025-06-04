# frozen_string_literal: true

class JokesController < ApplicationController
  def index
    @jokes = Joke.all
  end
end
