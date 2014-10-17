require 'spec_helper'

module RspecDispatch
	describe Configuration do

		describe '#initialize' do
			before(:all) do
				@config = RspecDispatch::Configuration.new
			end

			it 'will set a default @service_url' do
				expect(@config.service_url).to eq('http://localhost:3000/')
			end

			it 'will set default @custom_data as an empty hash' do
				expect(@config.custom_data).to eq({})
			end

			it 'will set @verbose to true' do
				expect(@config.verbose).to eq(true)
			end
		end

	end
end