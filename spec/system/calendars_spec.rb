require 'rails_helper'

describe 'カレンダー管理機能', type: :system, js: true do
  describe 'カレンダー表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA',email: 'a@email.com',password: 'password',benchpress: 10,squat: 50,deadlift: 100 )
      FactoryBot.create(:calendar, title: 'テストをします', memo: 'テスト用メモ' )
    end

    context 'ユーザーAがログインしているとき' do
      before do
        visit sessions_new_path
        fill_in "session_email", with: 'a@email.com'
        fill_in "session_password", with: 'password'
        click_button 'session_button'
      end

      it 'ログインしたときにログインしましたと表示される' do
        expect(page).to have_content 'ログインしました。'
      end

      it 'ユーザーAが登録しているMAX記録が表示されている' do
        within '#benchpress_max' do
          expect(page).to have_content '10'
        end
        within '#squat_max' do
          expect(page).to have_content '50'
        end
        within '#deadlift_max' do
          expect(page).to have_content '100'
        end
      end
    end
  end
end