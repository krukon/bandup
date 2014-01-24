require 'spec_helper'

describe Genre do
	before do
		@genre = Genre.new(name: "genre")
	end

	it { should respond_to :name }

	it { should be_valid }
end
