module RspecDispatch 
	class Configuration 

		attr_accessor :service_url, :custom_data, :verbose

		def initialize
			@service_url = 'http://localhost:3000/'
			@custom_data = {}
			@verbose = true
		end

	end
end