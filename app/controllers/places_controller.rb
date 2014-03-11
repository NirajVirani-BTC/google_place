class PlacesController < ApplicationController
  require 'net/http'
  respond_to :json

  def index
	  if params[:search].present?
	  end
	end

	def search
		main = 'https://maps.googleapis.com/maps/api/place/textsearch/json?'
    key = ENV['key'] || 'AIzaSyCQw1mWQj1SDFHHhAL7buDnrWbs72n4FM4'
    query = { query: params[:search],
    	types: 'street_address',
    	sensor: 'false',
    	key: key
    }.to_query

    query = main + query

		url = URI.parse(query)

		response = Net::HTTP.start(url.host,
		  use_ssl: true,
		  verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
      http.get url.request_uri
    end
    reply = JSON.parse response.body
    @results = reply['results']
    @error_message = reply['error_message']
    logger.debug "========>#{reply} "  

  	respond_to :js
	end
end