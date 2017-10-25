# frozen_string_literal: true

require 'rails_helper'

describe 'session create in admin', feature: true do
  let(:user) { create :user, :admin }

  before do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
  end

  let(:submit) { find('.button.is-medium.is-primary').click }

  it 'expected root path' do
    submit; expect(page.current_path).to eq '/'
  end
end
