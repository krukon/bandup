require 'spec_helper'

describe Band do

  before do
    @band = Band.new(name: "Test band", page: "testBand", about: "Short description")
  end

  subject { @band }

  it { should respond_to(:name) }
  it { should respond_to(:about) }
  it { should respond_to(:page) }
  it { should respond_to(:link_website) }
  it { should respond_to(:link_facebook) }
  it { should respond_to(:link_youtube) }
  it { should respond_to(:established) }

  it { should be_valid }

  describe "should have artist relations" do
    it { should respond_to(:artists) }
    it { should respond_to(:artist_relations) }
  end

  describe "should have artist join requests" do
    it { should respond_to(:artist_requests) }
  end

  describe "with allowed characters" do
    before do
      @band.page = "a.B-c_D~1"
    end
    it { should be_valid }
  end

  describe "with not allowed characters" do
    before do
      @band.page = "incorrect#page!@?"
    end
    it { should_not be_valid }
  end

  describe "established date" do
    describe "from string" do
      before do
        @band.established = "2013-02-01"
        @band.save
      end
      it { @band.established.should == Date.new(2013,2,1)}
    end

    describe "from date" do
      before do
        @date = Date.new(2013, 2, 1)
        @band.established = @date
        @band.save
      end
      it { @band.established.should == @date }
    end
  end

end
