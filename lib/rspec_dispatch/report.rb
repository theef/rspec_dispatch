require 'httparty'

module RspecDispatch
	class Report

		attr_accessor :rspec_data, :monitor_data

		def initialize(rspec_data)
			success_calculation = ((1 - (rspec_data[:failure_count].to_f/rspec_data[:example_count].to_f)) * 100).to_s[0..5]

			if RspecDispatch.configuration.verbose == true

				if rspec_data[:duration].to_f > 60
					custom_duration = "#{(rspec_data[:duration].to_f / 60).to_s[0..5]} minutes."
				else
					custom_duration = "#{rspec_data[:duration]} seconds."
				end

				puts "\nRSpec Dispatch ----\n"
				puts "Duration: #{custom_duration}\n"
				puts "Example Count: #{rspec_data[:example_count]}\n"
				puts "Success Rate: #{success_calculation}%"
			end

			self.rspec_data = rspec_data
		end

		def deliver
			endpoint = RspecDispatch.configuration.service_url

			payload = {
				custom_data: RspecDispatch.configuration.custom_data,
				rspec_data: self.rspec_data,
				failures: self.monitor_data.failures,
				successes: self.monitor_data.successes,
				pending: self.monitor_data.pending
			}

			begin
				response = HTTParty.post(endpoint,
																 body: payload.to_json,
																 headers: {'Content-Type' => 'application/json'})

				body = response.body
				if (200..206).include?(response.code.to_i)
					if RspecDispatch.configuration.verbose == true
						puts "\nResponse Status: #{response.code}\n"
						if body.blank? || body == ''
							body = "*no content*"
						end
						puts "Response Body: #{body}"
					end

				else
					puts "\nResponse: ERROR (status #{response.code})\n"
				end

			rescue Errno::ECONNREFUSED
				puts "RSpec Dispatch: ERROR - Could not connect to given endpoint. Ensure that you have properly configured your target service url in the configuration block.  See Documentation at: https://github.com/theef/rspec_dispatch"
			end

		end
	end
end