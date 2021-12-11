require 'rails_helper'

describe 'カレンダー管理機能', type: :system, js: true do
  describe 'カレンダー表示機能' do
    before do
      @user_a = FactoryBot.create(:user, name: 'ユーザーA',email: 'a@email.com',password: 'password',benchpress: 10,squat: 50,deadlift: 100 )
      FactoryBot.create(:user, name: 'ユーザーB',email: 'b@email.com',password: 'password',benchpress: 100,squat: 500,deadlift: 1000 )
      @calendar_a = FactoryBot.create(:calendar, title: 'テストをします', start_time: Time.now ,memo: 'テスト用メモ', user: @user_a )
      FactoryBot.create(:calendar, title: 'テストをします2', start_time: Time.now.yesterday ,memo: 'テスト用メモ2', workouted: 'true' ,user: @user_a )
    end

    context 'ユーザーAがログイン時のアプリの動き' do
      before do
        visit sessions_new_path
        fill_in "session_email", with: 'a@email.com'
        fill_in "session_password", with: 'password'
        click_button 'session_button'
      end

      context 'ユーザーAがログインログアウトするとき' do
        it 'ユーザーAがログインしたときにログインしましたと表示される' do
          expect(page).to have_content 'ログインしました。'
        end

        it 'ユーザーAがログアウトしたらログアウトしましたと表示される' do
          click_button 'navbar-toggler'
          page.accept_confirm do
            click_on :delete_button
          end
          expect(page).to have_content 'ログアウトしました。'
        end
      end

      context 'ユーザーAがログインしているときのカレンダー一覧画面機能' do


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

        it 'ユーザーAが完了のタイトルには線が引かれている' do
          within '.past.current-month.has-events' do
            within '#del' do
              expect(page).to have_content 'テストをします'
            end
          end
        end

        it 'ユーザーAが未完了のタイトルには線が引かれていない' do
          within '.past.current-month.has-events' do
            expect(page).to have_content 'テストをします'
          end
        end

        it 'ユーザーがMAX記録を変更した時間が一覧画面に反映される' do
          click_button 'navbar-toggler'
          click_link 'アカウント'
          fill_in "user_benchpress", with: '500'
          click_button 'update_button'
          click_button 'navbar-toggler'
          click_link 'HOME'
          within '.benchpress_update' do
            expect(page).to have_content "(更新日：#{@user_a.squat_update.to_s(:datetime_jp)})"
          end
        end


        it 'ユーザーAが登録したメモのタイトルをクリックすると詳細画面が表示される' do
          within '.today' do
            click_link 'テストをします'
          end
          within '#start_time' do
            expect(page).to have_content "#{@calendar_a.start_time.strftime("%Y年%m月%d日")}"
          end
          within '#title' do
            expect(page).to have_content "#{@calendar_a.title}"
          end
          within '#memo' do
            expect(page).to have_content "#{@calendar_a.memo}"
          end
          within '#workouted' do
            expect(page).to have_content "未完了"
          end
        end

        it 'ユーザーAが登録したメモを削除したとき、削除しましたと表示される' do
          within '.today' do
            click_link 'テストをします'
          end
          page.accept_confirm do
            click_on :delete_button_show
          end
          expect(page).to have_content "#{@calendar_a.start_time.strftime("%Y年%m月%d日")}の#{@calendar_a.title}を削除しました"
        end
      end

      context "ユーザーAがログインしているときのアカウント画面" do
        before do
          click_button 'navbar-toggler'
          click_link 'アカウント'
        end
        it 'ユーザーAの名前が表示される' do
          within 'h1' do
            expect(page).to have_content "ユーザーA"
          end
        end

        context 'YOUTUBE検索機能' do
          it 'ユーザーAがMAX記録の値を変更して、更新ボタンを押すと更新しましたと表示される' do
            fill_in "user_benchpress", with: '500'
            click_button 'update_button'
            expect(page).to have_content "更新しました"
          end

          it '検索したあと検索したYOUTUBEが表示されている' do
            fill_in "search", with: '筋肉'
            click_button 'search_button'
            expect(page).to have_css('.youtube-css')
          end

          it 'なにも検索しなかった場合YOUTUBEが表示されない' do
            fill_in "search", with: ''
            click_button 'search_button'
            expect(page).to have_no_css('.youtube-css')
          end
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

      it 'ユーザーAが登録しているMAX記録は表示されない' do
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

      it 'ユーザーAが今日の日付で作成したタイトルが表示されない' do
        within '.today' do
          expect(page).to have_no_content 'テストをします'
        end
      end
    end
  end
end