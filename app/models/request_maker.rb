class RequestMaker
  attr_reader :endpoint, :token

  def initialize(endpoint, token=nil)
    @endpoint = endpoint
    @token    = token
  end

  def make_authenticated_request!
  end

  
end