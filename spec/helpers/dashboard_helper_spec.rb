require "rails_helper"

RSpec.describe DashboardHelper, type: :helper do
  describe "#place_parts" do
    it "drops the zip code from the headline" do
      location = Location.new(latitude: 0, longitude: 0, postal_code: "95014", country_code: "us",
                              name: "95014, Cupertino, Santa Clara County, California, United States")

      expect(helper.place_parts(location)).to eq([ "Cupertino", "Santa Clara County, California, United States" ])
    end
  end
end
