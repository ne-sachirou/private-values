require 'aruba/cucumber'

Aruba.configure do |config|
  config.home_directory = "#{__dir__}/../tmp"
end
