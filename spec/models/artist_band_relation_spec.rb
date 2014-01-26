require 'spec_helper'

describe ArtistBandRelation do

	let(:artist) { Artist.create!(username: "test", email: "test@email.com", password: "foobar", birthday: DateTime.now) }
	let(:band) { Band.create!(name: "The Test Band") }
	let(:relation) { artist.band_relations.build(band_id: band.id, owner: true) }

	subject { relation }

	it { should be_valid }

	describe "when artist id is not present" do
		before { relation.artist_id = nil }
		it { should_not be_valid }
	end

	describe "when band id is not present" do
		before { relation.band_id = nil }
		it { should_not be_valid }
	end

end
