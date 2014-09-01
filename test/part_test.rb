require 'minitest/spec'
require 'minitest/autorun'
require 'part'
require 'json'

describe Part do
  before do
    @digital_ocean_token = ENV['DIGITAL_OCEAN_TOKEN']
    @part = Part.new(@digital_ocean_token)
  end

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

  describe "list droplets" do
    it "returns the list of droplets" do
      response = @part.list_droplets
      response = JSON.parse(response)
      response.has_key?("droplets").must_equal true
    end
  end

  describe "make_api_request" do
    it "raises an error for invalid HTTP methods" do
      lambda {
        @part.make_api_request('https://some/resource', :FAKE)
      }.must_raise ArgumentError
    end
  end

  describe "delete_domain_record" do
    it "raises a not yet implemented error" do
      lambda {
        @part.delete_domain_record('https://some/resource', 5555555555)
      }.must_raise NotImplementedError
    end
  end
end
