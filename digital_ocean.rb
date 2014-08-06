require 'rest-client'

class DigitalOcean

  def initialize(token, version="v2")
    @token = token
    @api_base = "https://api.digitalocean.com/" + version + "/"
  end

  # Actions
  # https://developers.digitalocean.com/#actions
  #
  def list_actions
    api_request_url = @api_base + "actions"
    response = make_api_request(api_request_url)
  end

  def get_action(action_id)
    api_request_url = @api_base + "actions/" + action_id.to_s
    response = make_api_request(api_request_url)
  end

  # Domain Records
  # https://developers.digitalocean.com/#domain-records
  #
  # Example: list_domain_records("google.com")
  #
  def list_domain_records(domain_name)
    api_request_url = @api_base + "domains/" + domain_name + "/records"
    response = make_api_request(api_request_url)
  end

  def create_domain_record(domain_name)
    api_request_url = @api_base + "domains/" + domain_name + "/records"
    # response = make_api_request(api_request_url, :POST)
    puts "Error: create_domain_record not yet implemented."
  end

  def get_domain_record(domain_name, record_id)
    api_request_url = @api_base + "domains/" + domain_name + "/records/" + record_id.to_s
    response = make_api_request(api_request_url)
  end

  def delete_domain_record(domain_name, record_id)
    api_request_url = @api_base + "domains/" + domain_name + "/records/" + record_id.to_s
    puts "Error: delete_domain_record not yet implemented."
  end

  def update_domain_record(domain_name, record_id)
    api_request_url = @api_base + "domains/" + domain_name + "/records/" + record_id.to_s
    puts "Error: update_domain_record not yet implemented."
  end

  # Domains
  # https://developers.digitalocean.com/#domains
  #
  def list_domains
    api_request_url = @api_base + "domains"
    response = make_api_request(api_request_url)
  end

  # Not yet tested
  def create_domain(domain_name, ip_address)
    api_request_url = @api_base + "domains"
    api_request_palyload = { :name => domain_name, :ip_address => ip_address }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Example: get_domain("google.com")
  #
  def get_domain(domain_name)
    api_request_url = @api_base + "domains/" + domain_name.to_s
    response = make_api_request(api_request_url)
  end

  def delete_domain(domain_name)
    api_request_url = @api_base + "domains/" + domain_name.to_s
    puts "Error: delete_domain not yet implemented."
  end



  def list_images
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


