require 'rspec/core'

require 'rspec_dispatch/monitor'
require 'rspec_dispatch/report'

module RspecDispatch
	class Formatter < RSpec::Core::Formatters::ProgressFormatter

		RSpec::Core::Formatters.register self, :start, :example_passed, :example_pending, :example_failed, :start_dump, :dump_summary

		def start(example_count)
			@monitor = RspecDispatch::Monitor.new
		end

		def example_passed(notification)
			@monitor.track notification.example
			super(notification)
		end

		def example_pending(notification)
			@monitor.track notification.example
			super(notification)
		end

		def example_failed(notification)
			@monitor.track notification.example
			super(notification)
		end

		def start_dump(notification)
			super(notification)
			output.puts
		end

		def dump_summary(examples)
			rspec_data = {
				duration: examples.duration,
				example_count: examples.example_count,
				success_count: examples.example_count.to_i - examples.failure_count.to_i - examples.pending_count.to_i,
				failure_count: examples.failure_count,
				pending_count: examples.pending_count
			}

			report = RspecDispatch::Report.new(rspec_data)
			report.monitor_data = @monitor
			report.deliver

			super(examples)
		end

	end
end