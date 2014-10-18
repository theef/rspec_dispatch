module RspecDispatch
	class Monitor

		attr_accessor :failures, :successes, :pending

		def initialize
			@failures = []
			@successes = []
			@pending = []
		end

		def track(example)
			status = example.metadata[:execution_result].status

			content = {
				description: example.metadata[:full_description],
				status: status,
				run_time: example.metadata[:execution_result].run_time,
				file_path: example.metadata[:file_path].gsub('./spec/', ''),
				line_number: example.metadata[:location].split('.rb')[1].gsub(':', '')
			}

			if status == :failed
				@failures << content
			elsif status == :passed
				@successes << content
			elsif status == :pending
				@pending << content
			end
		end

	end
end