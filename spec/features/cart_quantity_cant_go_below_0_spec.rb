require 'rails_helper'

RSpec.feature 'Cart quantity cant be negative' do
  context 'There is a creature in the cart' do
    scenario 'The user tries to decrement the cart creature below 0' do
      creature = create :creature

      visit creatures_path

      click_on 'Add to Cart'

      click_on 'View Cart'

      expect(current_path).to eq cart_path

      within "#cart-creature-#{creature.id}" do
        expect(page).to have_content 'Quantity: 1'
        expect(page).to have_content 'Subtotal: $10.00'

        click_on 'Decrease Quantity'
      end

      expect(page).to_not have_css "#cart-creature-#{creature.id}"
    end
  end
end
