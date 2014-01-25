require 'spec_helper'

describe ArtistInstrumentRelation do
	before do
		@artist = Artist.create!(username: "test", email: "test@email.com", password: "foobar")
		@instrument = Instrument.create!(name: "instrument")
		@relation = @artist.instrument_relations.create!(instrument_id: @instrument.id)
	end
	#let(:artist) { Artist.create!(email: "test@email.com", password: "foobar") }
	#let(:instrument) { Instrument.create!(name: "instrument") }
	#let(:relation) { artist.instrument_relations.create!(instrument_id: instrument.id) }

	describe "Artist-Instrument relation" do
		subject { @relation }

		it { should be_valid }

		describe "when artist id is not present" do
			before { @relation.artist_id = nil }
			it { should_not be_valid }
		end

		describe "when instrument id is not present" do
			before { @relation.instrument_id = nil }
			it { should_not be_valid }
		end
	end

	describe "Artist's instruments" do
		subject { @artist.instruments }
		before { @artist.reload }

		it "should consist of one element" do
			subject.length.should == 1
			subject[0].should == @instrument
		end

	end

end
