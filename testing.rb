require './digital_ocean'
require 'yaml'

CONFIG = YAML.load_file("config.yml")
# puts CONFIG['digital_ocean_token']

client = DigitalOcean.new(CONFIG['digital_ocean_token'])
puts client.list_droplets
