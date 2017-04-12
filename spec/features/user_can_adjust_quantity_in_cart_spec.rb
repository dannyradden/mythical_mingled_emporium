require 'rails_helper'

RSpec.feature 'User can adjust quantity' do
  context 'user is not logged in and there is at least one item in the cart' do
    attr_reader :creature1

    before do
      @creature1 = create(:creature)
      creature2 = create(:creature)

      visit '/creatures'

      within("#creature-#{@creature1.id}") do
        click_on 'Add to Cart'
        click_on 'Add to Cart'
      end
      within("#creature-#{creature2.id}") do
        click_on 'Add to Cart'
      end
      visit '/carts'
    end

    scenario 'user increases cart quantity' do
      within("li#cart-creature-#{creature1.id}") do
        expect(page).to have_content('Quantity: 2')
        click_on 'Increase Quantity'
        expect(current_path).to eq '/carts'
        expect(page).to have_content('Quantity: 3')
        expect(page).to have_content('Price: $30.00')
      end
      within('div.cart-total') do
        expect(page).to have_content('Total Price: $40.00')
      end
    end

    scenario 'user decreases cart quantity' do
      within("li#cart-creature-#{creature1.id}") do
        expect(page).to have_content('Quantity: 2')
        click_on 'Decrease Quantity'
        expect(current_path).to eq '/carts'
        expect(page).to have_content('Quantity: 1')
        expect(page).to have_content('Price: $10.00')
      end
      within('div.cart-total') do
        expect(page).to have_content('Total Price: $20.00')
      end
    end
  end
end
