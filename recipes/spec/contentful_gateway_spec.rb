# frozen_string_literal: true

require 'spec_helper'
require 'contentful_gateway'
require 'contentful'

RSpec.describe ContentfulGateway, :vcr do
  subject(:contentful_gateway) do
    described_class.new(client)
  end

  describe '#recipes_list' do
    context 'without params' do
      it 'returns the recipes list' do
        expect(contentful_gateway.recipes_list.total).to eq(4)
      end
    end

    context 'with skip and limit' do
      it 'returns the 2 last recipes' do
        expect(contentful_gateway.recipes_list(2, 2).size).to eq(2)
      end
    end
  end

  describe '#get_recipe' do
    context 'valid id' do
      it 'returns the recipe' do
        expect(contentful_gateway.get_recipe('4dT8tcb6ukGSIg2YyuGEOm').title)
          .to eq('White Cheddar Grilled Cheese with Cherry Preserves & Basil')
      end
    end

    context 'invalid id' do
      it 'returns nil' do
        expect(contentful_gateway.get_recipe('invalid_id')).to eq(nil)
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