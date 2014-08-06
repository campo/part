require 'rest-client'

class DigitalOcean

  def initialize(token)
    @token = token
    @api_base = "https://api.digitalocean.com/v2/"
  end

  def list_images
    # puts "Authorization: Bearer #{self.token}"
    api_request_url = @api_base + "images"
    api_request_payload = {}
    api_request_headers = {}
    api_request_headers[:Authorization] = "Bearer #{self.token}"
    response = RestClient.get api_url, {:Authorization => "Bearer #{self.token}"}
  end

  def list_droplets
    api_request_url = @api_base + "droplets"
    response = make_api_request(api_request_url)
  end  

  def create_droplet(options={})
    api_url = @api_base + "droplets"
    api_request_payload = {}
    api_request_headers = {}
    api_request_headers[:Authorization] = "Bearer #{self.token}"
    response = RestClient.post api_url, api_request_payload, api_request_headers
  end

  def token=(token)
    @token = token
  end

  def token
    @token
  end

  # Standardize API calls using this helper method
  #
  def make_api_request(api_url, request_method=:GET, api_request_payload={}, api_request_headers={})
    api_request_headers = set_authorization_header(api_request_headers)

    case request_method
    when :GET
      response = RestClient.get api_url, api_request_headers
    when :POST
      response = RestClient.post api_url, api_request_payload, api_request_headers
    when :PUT
      puts "Error: PUT method not yet implemented for API calls."
    when :DELETE
      puts "Error: DELETE method not yet implemented for API calls."
    else
      puts "Error: Invalid HTTP method used for this request."
    end
  end

  # Standardize the setting of the Authorization header with this
  # helper method
  #
  def set_authorization_header(request_headers)
    request_headers.merge({:Authorization => "Bearer #{self.token}"})
  end

end


