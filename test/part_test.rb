require 'minitest/spec'
require 'minitest/autorun'
require 'part'
require 'json'
# Webmock Gem: https://github.com/bblimke/webmock
require 'webmock/minitest'

describe Part do
  before do
    @digital_ocean_token = ENV['DIGITAL_OCEAN_TOKEN']
    @part = Part.new(@digital_ocean_token)
  end

  # initialization
  describe "when initialized without a version number" do
    it "defaults to api v2" do
      @part.api_base.must_equal "https://api.digitalocean.com/v2/"
    end
  end

  describe "when initialized with a specific version number" do
    it "uses the correct api_base_url" do
      part_v1 = Part.new(@digital_ocean_token, 'v1')
      part_v1.api_base.wont_equal "https://api.digitalocean.com/v2/"
      part_v1.api_base.must_equal "https://api.digitalocean.com/v1/"
    end
  end

  # Commented out test names remaining for potential implementation
  #
  # api_base
  # api_base=
  # change_droplet_kernel
  # create_domain
  # create_domain_record
  # create_droplet
  # create_key
  # delete_domain

  # delete_domain_record
  describe "delete_domain_record" do
    it "raises a not yet implemented error" do
      lambda {
        @part.delete_domain_record('https://some/resource', 5555555555)
      }.must_raise NotImplementedError
    end
  end

  # Commented out test names remaining for potential implementation
  #
  # delete_droplet
  # delete_image
  # delete_key
  # disable_backups
  # enable_ipv6
  # enable_private_networking

  # get_action
  describe "get_action" do
    it "returns information for the specified action" do
      action_id = 5555555555
      stub_request(:get, @part.api_base + "actions/#{action_id}").with(:headers => {'Authorization'=>"Bearer #{@digital_ocean_token}" }).to_return(:status => 200, :body => '{ "action": {} }', :headers => {})

      response = @part.send(:get_action, action_id)
      response.code.must_equal 200
    end
  end

  # Droplet subresources
  #
  # get_backups
  # get_kernels
  # list_kernels
  # get_snapshots
  describe "droplet subresource get methods" do
    it "return information for the appropriate subresources" do
      droplet_id = 5555555555
      droplet_subresources = [:backups, :kernels, :snapshots].collect{ |s| s.to_s }

      droplet_subresources.each do | subresource |
        # Stub out each droplet subresource
        stub_request(:get, @part.api_base + "droplets/#{droplet_id}/#{subresource}").
          with(:headers => {'Authorization'=>"Bearer #{@digital_ocean_token}" }).
          to_return(:status => 200, :body => "{ \"#{subresource}\": {} }", :headers => {})

        # Send the appropriate method to the Part client with
        # the the droplet_id argument
        response = @part.send('get_' + subresource.to_s, droplet_id)
        response.code.must_equal 200

        # Parse the response as JSON and verify that a key exists
        # for the expected subresource
        response = JSON.parse(response)
        response.has_key?(subresource).must_equal true, "Response did not contain the expected key '#{subresource}'"
      end

    end
  end

  # Commented out test names remaining for potential implementation
  #
  # get_domain
  # get_domain_record
  # get_droplet
  # get_droplet_action
  # get_droplet_actions
  # get_image
  # get_image_action
  # get_key
  # list_actions
  # list_domain_records


  # list_domains
  describe "list_domains" do
    it "returns the list of droplets" do
      stub_request(:get, @part.api_base + "domains").with(:headers => {'Authorization'=>"Bearer #{@digital_ocean_token}" }).to_return(:status => 200, :body => '{ "domains": {} }', :headers => {})

      response = @part.list_domains
      response.code.must_equal 200

      response = JSON.parse(response)
      response.has_key?("domains").must_equal true
    end
  end

  # list_droplets
  describe "list_droplets" do
    it "returns a list of droplets" do
      stub_request(:get, @part.api_base + "droplets").with(:headers => {'Authorization'=>"Bearer #{@digital_ocean_token}" }).to_return(:status => 200, :body => '{ "droplets": {} }', :headers => {})

      response = @part.list_droplets
      response.code.must_equal 200

      response = JSON.parse(response)
      response.has_key?("droplets").must_equal true
    end
  end

  # Commented out test names remaining for potential implementation
  #
  # list_images
  # list_keys
  # list_regions
  # list_sizes

  # make_api_request
  describe "make_api_request" do
    it "raises an error for invalid HTTP methods" do
      lambda {
        @part.make_api_request('https://some/resource', :FAKE)
      }.must_raise ArgumentError
    end
  end

  # Commented out test names remaining for potential implementation
  #
  # password_reset_droplet
  # power_cycle_droplet
  # power_off_droplet
  # power_on_droplet
  # reboot_droplet
  # rebuild_droplet
  # rename_droplet
  # resize_droplet
  # restore_droplet
  # set_authorization_header
  # shutdown_droplet
  # snapshot
  # token
  # token=
  # transfer_image
  # update_domain_record
  # update_image
  # update_key
end
