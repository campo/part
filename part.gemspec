Gem::Specification.new do |s|
  s.name        = 'part'
  s.version     = '0.0.2'
  s.date        = '2014-09-01'
  s.summary     = "Parting the Digital Ocean"
  s.description = "An easy to use client for v2 of the Digital Ocean API"
  s.authors     = ["Josh Campoverde"]
  s.email       = 'joshcampoverde@gmail.com'
  s.files       = ["lib/part.rb"]
  s.homepage    =
    'http://rubygems.org/gems/part'
  s.license       = 'MIT'
  s.add_runtime_dependency 'rest-client'
  s.add_development_dependency 'webmock'
end
