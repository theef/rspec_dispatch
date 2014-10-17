require 'rspec/core/formatters/progress_formatter'

require 'rspec_dispatch/monitor'
require 'rspec_dispatch/report'

# This Formatter Class inherits its methods directly from the RSpec Core 
# Progress Formatter (which is the default RSpec Formatter).  Notes can be 
# found at: http://www.rubydoc.info/gems/rspec-core/RSpec/Core/Formatters

module RspecDispatch
	class Formatter < RSpec::Core::Formatters::ProgressFormatter

		def start(example_count)
			@monitor = RspecDispatch::Monitor.new
		end

		def example_passed(example)
			@monitor.track example
			super(example)
		end

		def example_pending(example)
			@monitor.track example
			super(example)
		end

		def example_failed(example)
			@monitor.track example
			super(example)
		end

		def start_dump()
			super()
			output.puts
		end

		def dump_summary(duration, example_count, failure_count, pending_count)
			rspec_data = {
				duration: duration,
				example_count: example_count,
				failure_count: failure_count,
				pending_count: pending_count
			}

			report = RspecDispatch::Report.new(rspec_data, custom_data)
			report.monitor_data = @monitor
			report.deliver

			super(duration, example_count, failure_count, pending_count)
		end

	end
end