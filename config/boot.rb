ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
ENV['OPTIMAL_VALIDATION'] ||= "0000"

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
