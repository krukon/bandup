require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ArtistsHelper. For example:
#
# describe ArtistsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ArtistsHelper do

	describe "Extract_link" do

		let(:link_https_www) { "https://www.test.com/test/123?p=4&r=abc" }
		let(:link_https) { "https://test.com/test/123?p=4&r=abc" }
		let(:link_http_www) { "http://www.test.com/test/123?p=4&r=abc" }
		let(:link_http) { "http://test.com/test/123?p=4&r=abc" }
		let(:link_www) { "www.test.com/test/123?p=4&r=abc" }
		let(:link_no_www) { "test.com/test/123?p=4&r=abc" }

		describe "with https://www. prefix" do
			it { extract_link(link_https_www).should == link_no_www }
			it { extract_link(link_https_www, false).should == link_www }
		end

		describe "with https:// prefix" do
			it { extract_link(link_https).should == link_no_www }
			it { extract_link(link_https, false).should == link_no_www }
		end

		describe "with http://www. prefix" do
			it { extract_link(link_http_www).should == link_no_www }
			it { extract_link(link_http_www, false).should == link_www }
		end

		describe "with http:// prefix" do
			it { extract_link(link_http).should == link_no_www }
			it { extract_link(link_http, false).should == link_no_www }
		end

		describe "with www prefix" do
			it { extract_link(link_www).should == link_no_www }
			it { extract_link(link_www, false).should == link_www }
		end

		describe "without prefix" do
			it { extract_link(link_no_www).should == link_no_www }
			it { extract_link(link_no_www, false).should == link_no_www }
		end

	end

end
