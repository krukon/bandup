require 'spec_helper'

describe Picture do

	before do
		@picture = Picture.new(title: "Test", description: "This is a test picture")
	end

	subject { @picture }

	it { should respond_to :title }
	it { should respond_to :description }
	it { should respond_to :artist_id }
	it { should respond_to :artist }
	it { should respond_to :picture_file_name }
	it { should respond_to :picture_content_type }
	it { should respond_to :picture_file_size }
	it { should respond_to :picture_updated_at }

	it { should be_valid }
end
