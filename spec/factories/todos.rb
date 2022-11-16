FactoryBot.define do
  # faker、gimeiのダミー値を設定することを推奨する
  # https://github.com/faker-ruby/faker
  # https://github.com/willnet/gimei
  factory :todo do
    title { '明日やること' }
    description { '説明説明説明説明説明' }
  end
end
