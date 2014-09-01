require 'rest-client'

class Part

  def initialize(token, version="v2")
    @token = token
    @api_base = "https://api.digitalocean.com/" + version + "/"
  end

  def api_base
    @api_base
  end

  def api_base=(base_api_url)
    @api_base = base_api_url
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
    raise NotImplementedError, "create_domain_record not yet implemented."
  end

  def get_domain_record(domain_name, record_id)
    api_request_url = @api_base + "domains/" + domain_name + "/records/" + record_id.to_s
    response = make_api_request(api_request_url)
  end

  def delete_domain_record(domain_name, record_id)
    api_request_url = @api_base + "domains/" + domain_name + "/records/" + record_id.to_s
    raise NotImplementedError, "delete_domain_record not yet implemented."
  end

  def update_domain_record(domain_name, record_id)
    api_request_url = @api_base + "domains/" + domain_name + "/records/" + record_id.to_s
    raise NotImplementedError, "update_domain_record not yet implemented."
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
    raise NotImplementedError, "delete_domain not yet implemented."
  end

  # Droplet Actions
  # https://developers.digitalocean.com/#droplet-actions
  #
  def reboot_droplet(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "reboot" }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  def power_cycle_droplet(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "power_cycle" }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  def shutdown_droplet(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "shutdown" }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def power_off_droplet(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "power_off" }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  def power_on_droplet(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "power_on" }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def password_reset_droplet(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "password_reset" }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def resize_droplet(droplet_id, new_size)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "resize", :size => new_size }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def restore_droplet(droplet_id, image_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "restore", :image => image_id }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def rebuild_droplet(droplet_id, image_id_or_slug)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "rebuild", :image => image_id_or_slug }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  def rename_droplet(droplet_id, new_name)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "rename", :name => new_name }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def change_droplet_kernel(droplet_id, kernel_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "change_kernel", :kernel => kernel_id }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def enable_ipv6(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "enable_ipv6" }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def disable_backups(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "disable_backups" }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def enable_private_networking(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "enable_private_networking" }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def snapshot(droplet_id, snapshot_name)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    api_request_payload = { :type => "snapshot", :name => snapshot_name }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  def get_droplet_action(droplet_id, action_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions/" + action_id.to_s
    response = make_api_request(api_request_url)
  end

  # Droplets
  # https://developers.digitalocean.com/#droplets
  #
  def list_droplets
    api_request_url = @api_base + "droplets"
    response = make_api_request(api_request_url)
    # JSON.parse(response)["droplets"]
  end

  def list_kernels(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/kernels"
    response = make_api_request(api_request_url)
  end

  def get_snapshots(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/snapshots"
    response = make_api_request(api_request_url)
  end

  def get_backups(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/backups"
    response = make_api_request(api_request_url)
  end

  def get_droplet_actions(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s + "/actions"
    response = make_api_request(api_request_url)
  end

  def create_droplet(droplet_name, droplet_region, droplet_image, droplet_size="512mb", ssh_keys=nil, backups=nil, ipv6=nil, private_networking=nil)
    api_request_url = @api_base + "droplets"
    api_request_payload = {
      :name => droplet_name,
      :region => droplet_region,
      :size => droplet_size,
      :image => droplet_image
    }
    api_request_payload[:ssh_keys] = ssh_keys unless ssh_keys.nil?
    api_request_payload[:backups] = ssh_keys unless backups.nil?
    api_request_payload[:ipv6] = ssh_keys unless ipv6.nil?
    api_request_payload[:private_networking] = ssh_keys unless private_networking.nil?

    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  def get_droplet(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s
    response = make_api_request(api_request_url)
  end

  def delete_droplet(droplet_id)
    api_request_url = @api_base + "droplets/" + droplet_id.to_s
    response = make_api_request(api_request_url, :DELETE)
  end

  # Image Actions
  # https://developers.digitalocean.com/#image-actions
  #
  # Not tested
  def transfer_image(image_id, destination_region)
    api_request_url = @api_base + "images/" + image_id.to_s + "/actions"
    api_request_payload = { :type => "transfer", :region => destination_region }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  # Not tested
  def get_image_action(image_id, action_id)
    api_request_url = @api_base + "images/" + image_id.to_s + "/actions/" + action_id.to_s
    make_api_request(api_request_url)
  end

  # Images
  # https://developers.digitalocean.com/#images
  #
  def list_images
    api_request_url = @api_base + "images"
    response = make_api_request(api_request_url)
  end

  # Not tested
  def get_image(image_id_or_slug)
    api_request_url = @api_base + "images/" + image_id_or_slug.to_s
    make_api_request(api_request_url)
  end

  # Not tested
  def delete_image(image_id)
    api_request_url = @api_base + "images/" + image_id_or_slug.to_s
    response = make_api_request(api_request_url, :DELETE)
  end

  # Not tested
  def update_image(image_id, new_name)
    api_request_url = @api_base + "images/" + image_id_or_slug.to_s
    api_request_payload = { :name => new_name }
    # response = make_api_request(api_request_url, :PUT, api_request_payload)
    raise NotImplementedError, "update_image not yet implemented."
  end

  # Keys
  # https://developers.digitalocean.com/#keys
  #
  def list_keys
    api_request_url = @api_base + "account/keys"
    response = make_api_request(api_request_url)
  end

  def create_key(key_name, public_key)
    api_request_url = @api_base + "account/keys"
    api_request_payload = { :name => key_name, :public_key => public_key }
    response = make_api_request(api_request_url, :POST, api_request_payload)
  end

  def get_key(key_id_or_fingerprint)
    api_request_url = @api_base + "account/keys/" + key_id_or_fingerprint.to_s
    response = make_api_request(api_request_url)
  end

  def update_key(key_id_or_fingerprint, new_name)
    api_request_url = @api_base + "account/keys/" + key_id_or_fingerprint.to_s
    api_request_payload = { :name => new_name }
    response = make_api_request(api_request_url, :PUT, api_request_payload)
  end

  def delete_key(key_id_or_fingerprint)
    api_request_url = @api_base + "account/keys/" + key_id_or_fingerprint.to_s
    response = make_api_request(api_request_url, :DELETE)
  end

  # Regions
  # https://developers.digitalocean.com/#regions
  #
  def list_regions
    api_request_url = @api_base + "regions"
    response = make_api_request(api_request_url)
  end

  # Sizes
  # https://developers.digitalocean.com/#sizes
  #
  def list_sizes
    api_request_url = @api_base + "sizes"
    response = make_api_request(api_request_url)
  end

  # Helper Methods
  #
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
      response = RestClient.put api_url, api_request_payload, api_request_headers
    when :DELETE
      response = RestClient.delete api_url, api_request_headers
    else
      raise ArgumentError, "Invalid HTTP method used for this request."
    end
  end

  # Standardize the setting of the Authorization header with this
  # helper method
  #
  def set_authorization_header(request_headers)
    request_headers.merge({:Authorization => "Bearer #{self.token}"})
  end

end


