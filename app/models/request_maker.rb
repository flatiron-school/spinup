class RequestMaker
  attr_reader :endpoint, :auth_header, :connection

  def initialize(base_url, endpoint, auth_header={})
    @endpoint    = endpoint
    @auth_header = auth_header
    @connection  = Faraday.new(:url => base_url) do |faraday|
      faraday.adapter :typhoeus
    end
  end

  def make_authenticated_request!
    response = connection.get do |req|
      req.url endpoint
      auth_header.each do |header, value|
        req.headers[header] = value
      end
    end
    response.body
  end

  def make_request!(params)
    response = connection.get do |req|
      req.url endpoint
      params.each do |param, value|
        req.params[param] = value
      end
    end
    response.body
  end
end