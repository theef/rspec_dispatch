module RspecDispatch
	class Monitor

		attr_accessor :failures, :successes, :pending

		def initialize
			@failures = []
			@successes = []
			@pending = []
		end

		def track(example)
			status = example.execution_result[:status]

			content = {
				description: example.full_description,
				status: status,
				run_time: example.execution_result[:run_time],
				file_path: example.file_path,
				line_number: example.location.split('.rb')[1]
			}

			if status == "failed"
				@failures << content
			elsif status == "passed"
				@successes << content
			elsif status == "pending"
				@pending << content
			end
		end

	end
end