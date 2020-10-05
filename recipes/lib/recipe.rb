# frozen_string_literal: true

class Recipe
  def initialize(attributes)
    @id =  attributes.sys[:id]
    @title =  attributes.fields[:title]
    @photo_url =  attributes.fields[:photo]&.url
    @tags =  (attributes.fields[:tags]|| []).map(&:name)
    @description =  attributes.fields[:description]
    @chef_name =  attributes.fields[:chef]&.name
  end

  attr_accessor :id, :title, :photo_url, :tags, :description, :chef_name
end