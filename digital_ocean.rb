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
    # puts "Authorization: Bearer #{self.token}"
    api_request_url = @api_base + "droplets"
    api_request_payload = {}
    api_request_headers = {}
    api_request_headers[:Authorization] = "Bearer #{self.token}"
    response = RestClient.get api_request_url, api_request_headers
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

end


