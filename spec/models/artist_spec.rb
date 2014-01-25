require 'spec_helper'

describe Artist do

  before do
  	@artist = Artist.new(username: "fake", email: "fake@email.com", first_name: "First",
  							last_name: "Last", stage_name: "Stage", password: "P@ssw0rd")
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

  it { should be_valid }
  it { should_not be_admin }

  describe "should have band relations" do
  	it { should respond_to(:bands) }
  	it { should respond_to(:band_relations) }
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
                            password: "pass") }

    it { should_not be_valid }
  end

  describe "with not unique username" do
    before { Artist.create(username: "fake", email: "unique@email.com",
                            password: "pass") }
    
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

end
