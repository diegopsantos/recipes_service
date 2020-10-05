# frozen_string_literal: true

require 'spec_helper'
require 'contentful_service'
require 'contentful'

RSpec.describe ContentfulService, :vcr do
  subject(:contentful_service) do
    described_class.new(client)
  end

  describe '#recipes_list' do
    it 'returns the recipes list' do
      expect(contentful_service.recipes_list(0, 4)[:recipes].size).to eq(4)
    end

    it 'returns Recipe objects' do
      expect(contentful_service.recipes_list(0, 4)[:recipes].first).to be_a(Recipe)
    end

     it 'returns total' do
      expect(contentful_service.recipes_list(0, 4)[:total]).to eq(4)
    end

    it 'returns skip' do
      expect(contentful_service.recipes_list(0, 4)[:skip]).to eq(0)
    end

    it 'returns limit' do
      expect(contentful_service.recipes_list(0, 4)[:limit]).to eq(4)
    end
  end

  describe '#get_recipe' do
    context 'valid id' do
      it 'returns the recipe' do
        expect(contentful_service.get_recipe('4dT8tcb6ukGSIg2YyuGEOm').title)
          .to eq('White Cheddar Grilled Cheese with Cherry Preserves & Basil')
      end

      it 'returns Recipe object' do
        expect(contentful_service.get_recipe('4dT8tcb6ukGSIg2YyuGEOm')).to be_a(Recipe)
      end
    end

    context 'invalid id' do
      it 'returns nil' do
        expect(contentful_service.get_recipe('invalid_id')).to eq(nil)
      end
    end
  end

  def client
    Contentful::Client.new(
      access_token: ENV.fetch('CONTENTFUL_ACCESS_TOKEN'),
      space: ENV.fetch('CONTENTFUL_SPACE', 'kk2bw5ojx476'),
      environment: ENV.fetch('CONTENTFUL_ENVIRONMENT', 'master')
    )
  end
end