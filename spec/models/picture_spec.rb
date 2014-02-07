require 'spec_helper'

describe Picture do

	before do
		@picture = Picture.new(title: "Test", description: "This is a test picture",
			picture_file_name: "test.jpg", picture_content_type: "image/jpg", picture_file_size: 0)
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

	describe "without file name" do
		before { @picture.picture_file_name = nil }
		it { should_not be_valid }
	end

	describe "with wrong content-type" do
		before { @picture.picture_content_type = "wrong/type" }
		it { should_not be_valid }
	end

	describe "with too big file size" do
		before { @picture.picture_file_size = 500.kilobytes }
		it { should_not be_valid }
	end
end
