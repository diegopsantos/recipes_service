# frozen_string_literal: true

require 'contentful_gateway'
require 'recipe'

class ContentfulService
  def initialize(client)
    @gateway =  ContentfulGateway.new(client)
  end

  def recipes_list(skip, limit)
    contentful_response = @gateway.recipes_list(skip, limit)
    paginate(contentful_response)
  end

  def get_recipe(id)
    contentful_recipe = @gateway.get_recipe(id)
    Recipe.new(contentful_recipe) if contentful_recipe
  end

  private

  def paginate(contentful_response)
    recipes = contentful_response.map{ |contentful_recipe| Recipe.new(contentful_recipe)  }

    {
      recipes: recipes,
      skip: contentful_response.skip,
      limit: contentful_response.limit,
      total: contentful_response.total
    }
  end
end