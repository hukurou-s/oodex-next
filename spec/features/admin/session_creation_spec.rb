# frozen_string_literal: true

require 'rails_helper'

describe 'create session', feature: true do
  context 'succeeding' do
    before do
      login_as create(:user, :admin)
      visit new_admin_session_path
      find('.input.name').set('hogehoge')
      find('.textarea.detail').set("pogepoge\nfoobar")
      find('.datetime.start_at').set('2017-01-01T00:00+09:00')
      find('.datetime.end_at').set('2017-12-31T23:59+09:00')
      find('nav.navbar').click
    end

    let(:submit) { find('.button.is-link').click }

    it 'expected current path is root path' do
      submit
      expect(page.current_path).to eq(admin_sessions_path)
      session = Session.last
      expect(session.name).to eq('hogehoge')
      expect(session.detail).to eq("pogepoge\r\nfoobar")
      expect(session.start_at).to eq(Time.parse('2017-01-01T00:00+09:00'))
      expect(session.end_at).to eq(Time.parse('2017-12-31T23:59+09:00'))
    end
  end

  context 'faulting' do
    before do
      login_as create(:user, :admin)
      visit new_admin_session_path
    end

    let(:submit) { find('.button.is-link').click }

    it 'expected to fail create session record' do
      submit
      expect(page).to have_content('入力してください')
    end
  end
end
