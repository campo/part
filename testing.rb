require './lib/part'

digital_ocean_token = ENV['DIGITAL_OCEAN_TOKEN']
client = Part.new(digital_ocean_token)

puts client.list_droplets
