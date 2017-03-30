require 'rails_helper'

describe 'User visits root', type: :feature do
  it 'renders the readME markdwon in html' do
    visit root_path
    
    expect(page).to have_content("Johari Window API")
  end
end