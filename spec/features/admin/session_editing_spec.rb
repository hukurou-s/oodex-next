# frozen_string_literal: true

require 'rails_helper'

describe 'user sign in', feature: true do
  let(:session) { create :session }

  before do
    login_as create(:user, :admin)
    visit edit_admin_session_path(session.id)
    find('.input.name').set('updated')
    find('.textarea.detail').set('updated')
    find('nav.navbar').click
  end

  let(:submit) { find('.button.is-link').click }

  context 'succsessful' do
    it 'expected root path' do
      submit
      expect(page.current_path).to eq(admin_sessions_path)
      visit admin_session_path(session.id)
      expect(page).to have_content('updated')
      expect(page).to have_content('updated')
    end
  end
end
