# frozen_string_literal: true

require 'spec_helper'
require 'recipes'

RSpec.describe Recipes do
  include Rack::Test::Methods

  def app
    described_class
  end

  describe 'index', :vcr do
    context 'when params are valid' do 
      before do
        get '/', { skip: 0, limit: 2 }
      end

      it 'should returns 200' do
        expect(last_response.status).to eq(200)
      end

      it 'should render the title of the recipes' do
        expect(last_response.body)
          .to include(
          'White Cheddar Grilled Cheese with Cherry Preserves & Basil', 
          'Tofu Saag Paneer with Buttery Toasted Pita'
        )
      end

       it 'should render the photo of the recipes' do
        expect(last_response.body)
          .to include(
          '<img src="//images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg">',
          '<img src="//images.ctfassets.net/kk2bw5ojx476/48S44TRZN626y4Wy4CuOmA/9c0a510bc3d18dda9318c6bf49fac327/SKU1498_Hero_154__2_-adb6124909b48c69f869afecb78b6808-2.jpg">'
        )
      end
    end

    context 'when params are invalid' do 
      before do
        get '/', { skip: 0, limit: 100 }
      end

      it 'should had flash warning' do
        expect(last_request.session["flash"]).to include(:warning => "Invalid Params!")
      end
    end

    context 'conteful error' do
      before do
        get '/'
      end 

      it 'should had flash warning' do
        expect(last_request.session["flash"])
          .to include(:danger => "We had a problem with Contentful API! HTTP status code: 401 Unauthorized\nMessage: The access token you sent could not be found or is invalid.\nRequest ID: 5bc180f6-ba63-49e9-8d17-73f956701d17")
      end  
    end
  end

  describe 'show', :vcr do

    context 'successs' do 
      before do
        get '/show/4dT8tcb6ukGSIg2YyuGEOm'
      end

      it 'should returns 200' do
        expect(last_response.status).to eq(200)
      end

      it 'should render the correct recipe' do
        expect(last_response.body)
          .to include('White Cheddar Grilled Cheese with Cherry Preserves & Basil')
      end
    end

    context 'conteful error' do
      before do
        get '/'
      end 

      it 'should had flash warning' do
        expect(last_request.session["flash"])
          .to include(:danger => "We had a problem with Contentful API! HTTP status code: 401 Unauthorized\nMessage: The access token you sent could not be found or is invalid.\nRequest ID: 5bc180f6-ba63-49e9-8d17-73f956701d17")
      end  
    end
  end
end