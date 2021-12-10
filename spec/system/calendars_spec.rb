require 'rails_helper'

describe 'カレンダー管理機能', type: :system, js: true do
  describe 'カレンダー表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA',email: 'a@email.com',password: 'password',benchpress: 10,squat: 50,deadlift: 100 )
      FactoryBot.create(:user, name: 'ユーザーB',email: 'b@email.com',password: 'password',benchpress: 100,squat: 500,deadlift: 1000 )
      FactoryBot.create(:calendar, title: 'テストをします', start_time: Time.now ,memo: 'テスト用メモ', user: user_a )
      FactoryBot.create(:calendar, title: 'テストをします2', start_time: Time.now.yesterday ,memo: 'テスト用メモ2', user: user_a )
    end

    context 'ユーザーAがログインしているとき' do
      before do
        visit sessions_new_path
        fill_in "session_email", with: 'a@email.com'
        fill_in "session_password", with: 'password'
        click_button 'session_button'
      end

      it 'ユーザーAがログインしたときにログインしましたと表示される' do
        expect(page).to have_content 'ログインしました。'
      end

      it 'ユーザーAが登録しているMAX記録が表示されている' do
        within '.benchpress_max' do
          expect(page).to have_content '10'
        end
        within '.squat_max' do
          expect(page).to have_content '50'
        end
        within '.deadlift_max' do
          expect(page).to have_content '100'
        end
      end

      it 'ユーザーAが今日の日付で作成したタイトルが今日のカレンダーの場所に表示される' do
        within '.today' do
          expect(page).to have_content 'テストをします'
        end
      end

      it 'ユーザーAが前日の日付で作成したタイトルが前日のカレンダーの場所に表示される' do
        within '.past.current-month.has-events' do
          expect(page).to have_content 'テストをします2'
        end
      end

      it 'ユーザーAが前日の日付で作成したタイトルが今日のカレンダーの場所には表示されない' do
        within '.today' do
          expect(page).to have_content 'テストをします'
        end
      end
    end

    context "ユーザーBがログインしているとき" do
      before do
        visit sessions_new_path
        fill_in "session_email", with: 'b@email.com'
        fill_in "session_password", with: 'password'
        click_button 'session_button'
      end
    end
  end
end