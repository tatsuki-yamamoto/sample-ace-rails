# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# 全てのresponseのJSON keysはsnake_caseからcamelCase に変換される
Jbuilder.key_format camelize: :lower
