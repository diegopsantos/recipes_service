# frozen_string_literal: true
require 'sinatra'

class Recipes < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end