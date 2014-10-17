require 'spec_helper'

module RspecDispatch

	describe '#configure' do
		before do
			RspecDispatch.configure do |config|
				config.service_url = 'http://example.com'
				config.custom_data = {example: 'test'}
				config.verbose = false
			end
		end

		it 'will have the values saved from config block' do
			expect(RspecDispatch.configuration.service_url).to eq('http://example.com')
			expect(RspecDispatch.configuration.custom_data).to eq({example: 'test'})
			expect(RspecDispatch.configuration.verbose).to eq(false)
		end
	end

end