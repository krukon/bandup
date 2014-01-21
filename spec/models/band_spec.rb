require 'spec_helper'

describe Band do

	before do
		@band = Band.new(name: "Test band", about: "Short description")
	end

	subject { @band }

	it { should respond_to(:name) }
	it { should respond_to(:about)}

	it { should be_valid }

  describe "should have artist relations" do
  	it { should respond_to(:artists) }
  	it { should respond_to(:artist_relations) }
  end

end
