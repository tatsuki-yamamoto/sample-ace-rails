source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3", ">= 7.0.3.1"

# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# 定数管理
gem 'config'

# ログ出力
gem 'lograge'
gem 'logstash-event'

# 認証
gem 'devise_token_auth'

# 言語
gem 'devise-i18n'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # 環境変数
  gem 'dotenv-rails'

  # テストツール
  gem 'rspec-rails'
  gem "factory_bot_rails"
  gem 'faker'
  gem 'gimei' # fakerでカバーできない日本語の値を提供
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # 静的コード解析ツール（コーディングチェックツール）
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'

  # コード自動補完
  gem 'solargraph', require: false
end

group :test do
  gem 'rspec-openapi', '~> 0.7.0'
end
