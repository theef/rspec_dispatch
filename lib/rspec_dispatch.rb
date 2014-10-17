require "rspec_dispatch/version"
require "rspec_dispatch/configuration"
require "rspec_dispatch/monitor"
require "rspec_dispatch/formatter"
require "rspec_dispatch/report"

module RspecDispatch

	begin 
		require 'pry'
	rescue LoadError
	end

	class << self
		attr_writer :configuration 
	end

	def self.configuration
		@configuration ||= RspecDispatch::Configuration.new
	end
  
	def self.configure
		yield(configuration)
	end

end