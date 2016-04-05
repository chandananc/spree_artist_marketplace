require "spec_helper"

feature "Admin - Artists", js: true do

  before do
    country = create(:country, name: "United States")
    create(:state, name: "Vermont", country: country)
    @artist = create :artist
  end

  context "as an Admin" do

    before do
      login_user create(:admin_user)
      visit spree.admin_path
      within "ul[data-hook=admin_tabs]" do
        click_link "artists"
      end
      page.should have_content("Listing artists")
    end

    scenario "should be able to create new artist" do
      click_link "New artist"
      check "artist_active"
      fill_in "artist[name]", with: "Test artist"
      fill_in "artist[email]", with: "spree@example.com"
      fill_in "artist[url]", with: "http://www.test.com"
      fill_in "artist[commission_flat_rate]", with: "0"
      fill_in "artist[commission_percentage]", with: "0"
      fill_in "artist[address_attributes][firstname]", with: "First"
      fill_in "artist[address_attributes][lastname]", with: "Last"
      fill_in "artist[address_attributes][address1]", with: "1 Test Drive"
      fill_in "artist[address_attributes][city]", with: "Test City"
      fill_in "artist[address_attributes][zipcode]", with: "55555"
      select2 "United States", from: "Country"
      select2 "Vermont", from: "State"
      fill_in "artist[address_attributes][phone]", with: "555-555-5555"
      click_button "Create"
      page.should have_content('artist "Test artist" has been successfully created!')
    end

  end
end
