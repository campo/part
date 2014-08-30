require 'minitest/spec'
require 'minitest/autorun'
require 'part'

describe Part do
  before do
    @digital_ocean_token = ENV['DIGITAL_OCEAN_TOKEN']
  end

  describe "when initialized without a version number" do
    it "defaults to api v2" do
      @part = Part.new(@digital_ocean_token)
      @part.api_base.must_equal "https://api.digitalocean.com/v2/"
    end
  end

  describe "when initialized with a specific version number" do
    it "uses the correct api_base_url" do
      @part = Part.new(@digital_ocean_token, 'v1')
      @part.api_base.wont_equal "https://api.digitalocean.com/v2/"
      @part.api_base.must_equal "https://api.digitalocean.com/v1/"
    end
  end
end
