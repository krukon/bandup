require 'spec_helper'

describe Artist do

  before do
  	@artist = Artist.new(email: "fake@email.com", first_name: "First",
  							last_name: "Last", stage_name: "Stage", password: "P@ssw0rd",
  							password_confirmation: "P@ssw0rd")
  end

 	subject { @artist }

  it { should respond_to(:admin) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:stage_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }

  it { should be_valid }
  it { should_not be_admin }

  describe "should have band relations" do
  	it { should respond_to(:bands) }
  	it { should respond_to(:band_relations) }
  end

  describe "should have instrument relations" do
  	it { should respond_to(:instruments) }
  end

end
