require 'spec_helper'

describe Artist do

  before do
  	@artist = Artist.new(username: "fake", email: "fake@email.com", first_name: "First",
  							last_name: "Last", stage_name: "Stage", password: "P@ssw0rd", birthday: DateTime.now)
  end

 	subject { @artist }

  it { should respond_to(:admin) }
  it { should respond_to(:username) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:stage_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:birthday) }
  it { should respond_to(:location_city) }
  it { should respond_to(:location_state) }
  it { should respond_to(:link_facebook) }
  it { should respond_to(:link_youtube) }
  it { should respond_to(:link_website) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:profile_picture) }
  it { should respond_to(:cover_picture) }

  it { should be_valid }
  it { should_not be_admin }

  describe "should have band relations" do
    it { should respond_to(:bands) }
    it { should respond_to(:band_relations) }
  end

  describe "should have band join requests" do
    it { should respond_to(:band_requests) }
  end

  describe "should have instrument relations" do
    it { should respond_to(:instruments) }
    it { should respond_to(:instrument_relations) }
  end

  describe "should have genre relations" do
    it { should respond_to(:genres) }
    it { should respond_to(:genre_relations) }
  end

  describe "with too short password" do
    before { @artist.password = "aaa" }
    it { should_not be_valid }
  end

  describe "with too long password" do
    before { @artist.password = "a"*51 }
    it { should_not be_valid }
  end

  describe "with too long username" do
    before { @artist.username = "a"*51 }
    it { should_not be_valid }
  end

  describe "without username" do
    before { @artist.username = nil }
    it { should_not be_valid }
  end

  describe "with not unique email" do
    before { Artist.create(username: "unique", email: "fake@email.com",
                            password: "pass", birthday: DateTime.now) }

    it { should_not be_valid }
  end

  describe "with not unique username" do
    before { Artist.create(username: "fake", email: "unique@email.com",
                            password: "pass", birthday: DateTime.now) }
    
    it { should_not be_valid }
  end

  describe "is saved, and then updated without password" do
    before do
      @artist.save
      @artist.first_name = "New name"
      @artist.password = nil
    end
    
    it { should be_valid }
  end

  describe "when authenticated with correct password" do
    it { @artist.authenticate("P@ssw0rd").should_not == false }
  end

  describe "when authenticated with incorrect password" do
    it { @artist.authenticate("incorrect_password").should == false }
  end

  describe "get_legal_name" do
    it "with first and last name" do
      @artist.get_legal_name.should == "First Last"
    end
    it "with first name only" do
      @artist.last_name = nil
      @artist.get_legal_name.should == "First"
    end
    it "with last name only" do
      @artist.first_name = nil
      @artist.get_legal_name.should == "Last"
    end
    it "without first and last name" do
      @artist.first_name = nil
      @artist.last_name = nil
      @artist.get_legal_name.should == ""
    end
  end

  describe "get_full_name" do
    it "with legal name" do
      @artist.get_full_name.should == "Stage (First Last)"
    end
    it "without legal name" do
      @artist.first_name = nil
      @artist.last_name = nil
      @artist.get_full_name.should == "Stage"
    end
    it "without stage name" do
      @artist.stage_name = nil
      @artist.get_full_name.should == "First Last"
    end
  end

  describe "get_printable_name" do
    it "with full name" do
      @artist.get_printable_name.should == "Stage (First Last)"
    end
    it "without full name" do
      @artist.first_name = nil
      @artist.last_name = nil
      @artist.stage_name = nil
      @artist.get_printable_name.should == "fake"
    end
  end

end
