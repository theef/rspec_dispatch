# RSpec Dispatch

RSpec Dispatch is a simple gem that replaces your default RSpec Formatter to send results from a test run to a web service of your choice.  Useful to track RSpec suite results overtime through a custom web application (or endpoint).

## Installation

Add this line to your application's Gemfile:

    gem 'rspec_dispatch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec_dispatch

## Usage

#### Setup
To use this custom RSpec Formatter (or any custom formatter), you'll need to set it in your RSpec Config:
```ruby
RSpec.configure do |config|
	config.add_formatter(RspecDispatch::Formatter)
end
```

#### Configuration
A variety of configuration options are available for RSpec Dispatch, some optional.  
Setup your RSpec Dispatch block (similar to your RSpec.config block):
```ruby
RspecDispatch.configure do |config|
	...
end
```

Within this config block, a required parameter is "service_url" which is the endpoint that RSpec Dispatch will POST the suite/test results to.
```ruby
config.service_url = "http://examplehost.com"
```

Other parameters include:  
"verbose" - true/false (boolean) which allows text to be output within the command line when running your test suite.  
"custom_data" - (hash) this allows you to dynamically add any hash values to your results before they are sent to your specific web service.  Examples might include the current date, a particular build, the environment or other server details, etc...  

A full configuration block could look like:
```ruby
RspecDispatch.configure do |config|
	config.service_url = "http://examplehost.com/results"
	config.verbose = false
	config.custom_data = {author: "Kevin Wanek", date: Date.now}
end
```

#### POST Body
When the results from your test run are sent to your web service, that endpoint will recieve a body with the following structure:
```json
{
	"custom_data"=>{...}, 
	"rspec_data"=>{
		"duration"=>0.003571, 
		"example_count"=>4, 
		"success_count"=>2, 
		"failure_count"=>1, 
		"pending_count"=>1
	}, 
	"failures"=>[
		{...}
	], 
	"successes"=>[
		{...}, 
	], 
	"pending"=>[
		{...}
	]
}
```
The "failures", "successes", and "pending" values will be arrays filled with data about each example that was executed during your test run.  Those will be structured as follows:
```json
{
	"description"=>"example test description", 
	"status"=>"failed", 
	"run_time"=>0.000421, 
	"file_path"=>"profile_spec.rb", 
	"line_number"=>"15"
}
```

## TODO
1. Needs the ability to add authentication parameters to POST request
2. Clean up tests
3. Clean up the Report module (specifically the text output and the #deliver method)  

## Contributing

1. Fork it ( https://github.com/theef/rspec_dispatch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
