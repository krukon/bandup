require 'spec_helper'

describe Post do

	before do
		@artist = Artist.create(username: "test", email: "test@test.com", password: "test")
		@post = Post.new(artist_id: @artist.id, content: "Test post")
	end

	subject { @post }

	it { should respond_to :content }
	it { should respond_to :link }
	it { should respond_to :artist }
	it { should respond_to :artist_id }
	it { should respond_to :band }
	it { should respond_to :band_id }
	it { should respond_to :picture }
	it { should respond_to :picture_id }

	it { should be_valid }
	
end
