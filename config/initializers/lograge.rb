# ログの設定
Rails.application.configure do
  config.lograge.enabled = true

  # If you're using Rails 5's API-only mode and inherit from ActionController::API, you must define it as the controller base class which lograge will patch:
  # NOTE: 今回は使用しないこととした
  # config.lograge.base_controller_class = 'ActionController::API'

  # JSON(logstash形式)で出力
  config.lograge.formatter = Lograge::Formatters::Logstash.new

  # オリジナルのlogを残す
  config.lograge.keep_original_rails_log = false

  # logrageのlogを別ファイルに保存
  # config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"

  # 独自パラメータを設定 (ActiveSupport::Notifications::Event name='process_action.action_controller' が落ちてくる)
  config.lograge.custom_options = lambda do |event|
    data = {
      request_id: event.payload[:request_id],
      user: event.payload[:user],
      exception: nil,
      exception_backtrace: nil,
    }
    if event.payload[:exception].present?
      data[:exception] = event.payload[:exception]
      data[:exception_backtrace] = event.payload[:exception_object]&.backtrace
    end
    data
  end
end
