require 'spec_helper'

describe ArtistGenreRelation do
	before do
		@artist = Artist.create!(username: "test", email: "test@email.com", password: "foobar")
		@genre = Genre.create!(name: "genre")
		@relation = @artist.genre_relations.create!(genre_id: @genre.id)
	end

	describe "Artist-Genre relation" do
		subject { @relation }

		it { should be_valid }

		describe "when artist id is not present" do
			before { @relation.artist_id = nil }
			it { should_not be_valid }
		end

		describe "when genre id is not present" do
			before { @relation.genre_id = nil }
			it { should_not be_valid }
		end
	end

	describe "Artist's genres" do
		subject { @artist.genres }
		before { @artist.reload }

		it "should consist of one element" do
			subject.length.should == 1
			subject[0].should == @genre
		end

	end
end
