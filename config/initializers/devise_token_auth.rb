DeviseTokenAuth.setup do |config|
  # リクエストごとにトークンを更新するか
  config.change_headers_on_each_request = false

  # トークンの有効期間
  config.token_lifespan = 2.weeks

  # headersの名前対応
  config.headers_names = {:'access-token' => 'access-token',
                          :'client' => 'client',
                          :'expiry' => 'expiry',
                          :'uid' => 'uid',
                          :'token-type' => 'token-type',
                          :'authorization' =>  'authorization'}

  # アカウント確認後に遷移するURL
  config.default_confirm_success_url = "http://localhost:3000/login"

  # パスワード再設定画面のURL
  config.default_password_reset_url = "http://localhost:3000/auth/password-reset"

  # パスワード再設定時にトークンを使用するか
  config.require_client_password_reset_token = true

  # メールアドレス変更時に確認メールを送るか
  config.send_confirmation_email = true

  # パスワード変更時に現在のパスワードもチェックするか
  config.check_current_password_before_update = true
end
