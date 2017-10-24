# frozen_string_literal: true

require 'rails_helper'

describe 'user sign in', feature: true do
  let(:user) { create :user, :normal }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
  end

  let(:submit) { find('.button.is-medium.is-primary').click }

  it 'expected root path' do
    submit; expect(page.current_path).to eq '/'
  end
end
