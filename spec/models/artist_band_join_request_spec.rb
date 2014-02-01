require 'spec_helper'

describe ArtistBandJoinRequest do

  let(:artist) { Artist.create(username: "test", password: "test", email: "test@email.com") }
  let(:band) { Band.create(page: "test", name: "test") }
  let(:req) { ArtistBandJoinRequest.new(artist_id: artist.id, band_id: band.id) }

  subject { req }

  it { should respond_to :artist_id }
  it { should respond_to :artist_accepted }
  it { should respond_to :band_id }
  it { should respond_to :band_accepted }

  it { should be_valid }

  it "when Artist wants to join Band" do
    artist.band_requests.create(band_id: band.id, artist_accepted: true)

    artist.band_requests.count.should == 1
    artist.band_requests.last.band_accepted.should == false
    artist.band_requests.last.artist_accepted.should == true

    band.reload
    band.artist_requests.count.should == 1
    artist.band_requests.last.should == band.artist_requests.last
  end

  it "when Bands wants the Artist to join in" do
    band.artist_requests.create(artist_id: artist.id, band_accepted: true)

    band.artist_requests.count.should == 1
    band.artist_requests.last.artist_accepted.should == false
    band.artist_requests.last.band_accepted.should == true

    artist.reload
    artist.band_requests.count.should == 1
    band.artist_requests.last.should == artist.band_requests.last
  end

end
