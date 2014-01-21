require 'spec_helper'

describe ArtistInstrumentRelation do
	let(:artist) { Artist.create!(email: "test@email.com", password: "foo", password_confirmation: "foo") }
	let(:instrument) { Instrument.create!(name: "instrument") }
	let(:relation) { artist.instruments.build(instrument_id: instrument.id) }

	subject { relation }

	it { should be_valid }

	describe "when artist id is not present" do
		before { relation.artist_id = nil }
		it { should_not be_valid }
	end

	describe "when instrument id is not present" do
		before { relation.instrument_id = nil }
		it { should_not be_valid }
	end

end
