require 'spec_helper'

describe Band do

	before do
		@band = Band.new(name: "Test band", about: "Short description")
	end

	subject { @band }

	it { should respond_to(:name) }
	it { should respond_to(:about)}

	it { should be_valid }

end
