require 'rails_helper'

describe 'カレンダー管理機能', type: :system, js: true do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA',email: 'a@email.com',password: 'password',benchpress: 10,squat: 50,deadlift: 100 ) }
    let(:user_c_build) { FactoryBot.build(:user, name: 'ユーザーC',email: 'c@email.com',password: 'password',benchpress: 10,squat: 50,deadlift: 100 ) }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB',email: 'b@email.com',password: 'password',benchpress: 100,squat: 500,deadlift: 1000 ) }
    let!(:task1_a) { FactoryBot.create(:calendar, title: 'テストをします', start_time: Time.now ,memo: 'テスト用メモ', user: user_a ) }
    let!(:task2_a) { FactoryBot.create(:calendar, title: 'テストをします2', start_time: Time.now.yesterday ,memo: 'テスト用メモ2', workouted: 'true' ,user: user_a ) }
  before do    
    visit sessions_new_path
    fill_in "session_email", with: login_user.email
    fill_in "session_password", with: login_user.password
    click_button 'session_button'
  end

  describe 'ログインログアウト機能' do
    context 'ユーザーAがログインしようとしたとき' do
      context 'ログインに成功したとき' do
        let(:login_user){ user_a }
        it 'ログインしました。と表示される' do
          expect(page).to have_content 'ログインしました。'
        end
      end
      context '登録していないユーザーCを入力してログインしたとき' do
        let(:login_user){ user_c_build } 
        it 'ログインに失敗しましたと表示される' do
          expect(page).to have_content 'ログインに失敗しました'
        end
      end
    end
    context 'ユーザーAがログアウトしたとき' do
      let(:login_user){ user_a }
      it 'ユーザーAがログアウトしたらログアウトしましたと表示される' do
        click_button 'navbar-toggler'
        page.accept_confirm do
          click_on :delete_button
        end
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end
  describe '新規登録機能' do
    context '新規登録に成功したとき' do
      let(:login_user) { user_c_build }
      it 'ログインしました。と表示される' do
        click_button 'navbar-toggler'
        page.accept_confirm do
          click_link 'サインアップ'
        end
        fill_in 'session_name', with: user_c_build.name
        fill_in 'session_email', with: user_c_build.email
        fill_in 'session_password', with: user_c_build.password
        fill_in 'session_password_confirmation', with: user_c_build.password
        # click_button 'session_button'
        expect(page).to have_content 'ログインしました。'
      end
    end
    context 'ユーザーAがすでに存在し新規登録に失敗したとき' do
      let(:login_user) { user_c_build }
      it '' do
        click_button 'navbar-toggler'
        page.accept_confirm do
          click_link 'サインアップ'
        end

        visit new_user_path
        fill_in 'new_name', with: login_user.name
        fill_in 'new_email', with: login_user.email
        fill_in 'new_password', with: login_user.password
        fill_in 'new_password_confirmation', with: login_user.password
        click_button 'session_button'
        expect(page).to have_content 'ログインしました。'
      end
    end
  end

  describe 'ログイン時のカレンダーアプリの機能' do
    describe 'カレンダー表示機能' do
      context 'ユーザーAがログイン時の動き' do
        let(:login_user){ user_a }
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
        it 'ユーザーAがMAX記録を変更した時間が一覧画面に反映される' do
          click_button 'navbar-toggler'
          click_link 'アカウント'
          fill_in "user_benchpress", with: '500'
          click_button 'update_button'
          click_button 'navbar-toggler'
          click_link 'HOME'
          within '.benchpress_update' do
            expect(page).to have_content "(更新日：#{user_a.squat_update.to_s(:datetime_jp)})"
          end
        end
      end
      
      context 'ユーザーBがログイン時の動き' do
        let(:login_user) { user_b }
        it 'ユーザーBが登録しているMAX記録が表示される' do
          within '.benchpress_max' do
            expect(page).to have_content '100'
          end
          within '.squat_max' do
            expect(page).to have_content '500'
          end
          within '.deadlift_max' do
            expect(page).to have_content '1000'
          end
        end
        it 'ユーザーAが今日の日付で作成したタイトルが今日のカレンダーの場所に表示されない' do
          within '.today' do
            expect(page).to have_no_content 'テストをします'
          end
        end
      end
    end

    describe 'カレンダー詳細表示機能' do
      context 'ユーザーAがログインしているとき' do
        let(:login_user){ user_a }
        it 'ユーザーAが登録したメモのタイトルをクリックすると詳細画面が表示される' do
          within '.today' do
            click_link 'テストをします'
          end
          within '#start_time' do
            expect(page).to have_content "#{task1_a.start_time.strftime("%Y年%m月%d日")}"
          end
          within '#title' do
            expect(page).to have_content "#{task1_a.title}"
          end
          within '#memo' do
            expect(page).to have_content "#{task1_a.memo}"
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
          expect(page).to have_content "#{task1_a.start_time.strftime("%Y年%m月%d日")}の#{task1_a.title}を削除しました"
        end
      end
    end

    describe 'アカウント画面' do
      describe 'アカウント情報一覧機能' do
        context 'ユーザーAがログインしているとき' do
          let(:login_user){ user_a }
          before do
            click_button 'navbar-toggler'
            click_link 'アカウント'
          end
          it 'ユーザーAの名前が表示される' do
            within 'h1' do
              expect(page).to have_content "ユーザーA"
            end
          end
          it 'ユーザーAがMAX記録の値を変更して、更新ボタンを押すと更新しましたと表示される' do
            fill_in "user_benchpress", with: '500'
            click_button 'update_button'
            expect(page).to have_content "更新しました"
          end
        end

        context 'ユーザーBがログインしているとき' do
          let(:login_user){ user_b }
          before do
            click_button 'navbar-toggler'
            click_link 'アカウント'
          end
          it 'ユーザーAの名前が表示されない' do
            within 'h1' do
              expect(page).to have_no_content "ユーザーA"
            end
          end
        end
      end

      describe 'youtube検索機能' do
        context 'ユーザーAがログインしているとき' do
          let(:login_user){ user_a }
          before do
            click_button 'navbar-toggler'
            click_link 'アカウント'
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
  end
end

