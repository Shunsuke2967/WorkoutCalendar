# WorkoutCalendar
毎日の筋トレの記録やメモをカレンダーに記録できるアプリです。<br>
herokuに上げています
サンプルユーザーを用意しているので下記を使用してログインしてください。
- メールアドレス: test1@email.com
- パスワード    : password
- url           : https://workoutcalendar1234.herokuapp.com/sessions/new
# 使用技術
- VMware Ubuntu20.04(開発環境)
- Ruby 2.5.1
- RubyonRails 5.2.6
- bootstrap 5.1.3
# 機能一覧
- ユーザー登録、ログイン、ログアウト機能(session)
- カレンダー一覧表示、メモ機能(simple-calendar)
- 筋トレ記録更新機能
- youtubeの検索機能(YOUTUBEAPIを使用)
- メール送信機能(Mailer、開発環境)
# テスト
Rspec(System Test)
- Capybara
- FactoryBot
