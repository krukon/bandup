require 'spec_helper'

describe Instrument do

	before do
		@instrument = Instrument.new(name: "An instrument")
	end

	it { should respond_to :name }

	it { should be_valid }

end
