# frozen_string_literal: true
require 'sinatra'
require "dotenv/load"
require 'helpers/contentful_helper'
require 'sinatra/param'
require 'sinatra/flash'



class Recipes < Sinatra::Base
  helpers ContentfulHelper
  helpers Sinatra::Param
  enable :sessions
  register Sinatra::Flash

  set :raise_sinatra_param_exceptions, true

  get '/' do
    param :skip,  Integer, default: 0, min: 0, max: 30, required: false
    param :limit, Integer, default: 2, min: 2, max: 10, required: false

    @result = contentful_service.recipes_list(params[:skip], params[:limit])
    @recipes = @result[:recipes]
    erb :index
  rescue Sinatra::Param::InvalidParameterError => e
    flash[:warning] = "Invalid Params!"
    @result = contentful_service.recipes_list(0, 2)
    @recipes = @result[:recipes]
    erb :index
  rescue Contentful::Error => e
    flash[:danger] = "We had a problem with Contentful API! #{e.message}"
    @result = nil
    erb :index
  end

  get '/show/:id' do |id|
    @recipe = contentful_service.get_recipe(id)
    if @recipe
      erb :show
    else
      flash[:warning] = "Recipe not found"
      @result = contentful_service.recipes_list(0, 2)
      @recipes = @result[:recipes]
      erb :index
    end
  rescue Contentful::Error => e
    flash[:danger] = "We had a problem with Contentful API! #{e.message}"
    @result = nil
    erb :index
  end
end