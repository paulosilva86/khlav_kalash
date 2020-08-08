require 'rails_helper'

RSpec.describe "Orders", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "allows the user to create an order successfully" do
    visit "/orders/new"

    fill_in "First name", :with => "User"
    fill_in "Postal code", :with => "35001"
    fill_in "Email address", :with => "user@example.com"

    click_button "Place Order"

    expect(page).to have_text("Order was successfully created.")
  end

  it "does not allow the user to create an order successfully" do
    visit "/orders/new"

    click_button "Place Order"

    expect(page).to have_text("errors prohibited this order from being saved")
  end
end
