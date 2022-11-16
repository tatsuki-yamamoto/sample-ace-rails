class ApplicationController < ActionController::API
  before_action :snake2camel_params

  # エラーハンドリング
  # ハンドルしきれなかったエラーは500エラー扱い
  # 評価は右から左、下から上へなされるのでこの場所で良い。
  rescue_from Exception, with: :rescue500
  # その他細々したエラーをハンドル
  rescue_from ActionController::BadRequest, with: :rescue400
  Forbidden = Class.new(ActionController::ActionControllerError)
  rescue_from Forbidden, with: :rescue403
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  rescue_from ActiveRecord::RecordInvalid, with: :rescue422
  rescue_from ActiveRecord::RecordNotDestroyed, with: :rescue422
  before_action :set_default_response

  private

  # デフォルトレスポンス設定
  def set_default_response
    @success = false
    @message = ''
    @http_status = 200
  end

  # 汎用的なJSONを返却
  def render_success_json(
    success: true,
    message: '',
    http_status: 200
  )
    render json: { success:, message: }, status: http_status
  end

  # 汎用的なエラーJSONを返却
  def render_error_json(
    success: false,
    message: '',
    http_status: 400
  )
    render json: { success:, message: }, status: http_status
  end

  # 500 Internal Server Error
  # サーバ内部エラー。サーバ内部にエラーが発生した場合に返される。
  def rescue500(e)
    logger.fatal(e)
    @exception = e
    @message = 'Internal Server Error'
    render_error_json(
      success: false,
      message: 'システムエラー',
      http_status: 500
    )
  end

  # 400 Bad Request
  # リクエストが不正である。
  # 定義されていないメソッドを使うなど、クライアントのリクエストがおかしい場合に返却。
  def rescue400(e)
    logger.fatal(e)
    @exception = e
    render_error_json(
      success: false,
      message: e.message,
      http_status: 400
    )
  end

  # 401 Unauthorized
  # 認証が必要である。
  def rescue401(e)
    logger.fatal(e)
    @exception = e
    render_error_json(
      success: false,
      message: e.message,
      http_status: 401
    )
  end

  # 403 Forbidden
  # 禁止されている。
  # リソースにアクセスすることを拒否。
  # リクエストはしたが処理できない。
  # アクセス権がない場合や、ホストがアクセス禁止処分を受けた場合などに返される。
  def rescue403(e)
    logger.fatal(e)
    @exception = e
    render_error_json(
      success: false,
      message: e.message,
      http_status: 403
    )
  end

  # 404 Not Found
  # 未検出。リソース・ページが見つからなかった。
  # アクセス権がない。
  # 単に要求に応えられない理由をごまかすため使用。
  def rescue404(e)
    logger.fatal(e)
    @exception = e
    render_error_json(
      success: false,
      message: e.message,
      http_status: 404
    )
  end

  # 422 Unprocessable Entity
  # 処理できないエンティティ。
  # 入力値の検証の失敗（バリデーションエラー）。
  def rescue422(e)
    logger.fatal(e)
    @exception = e
    @success = false
    render_error_json(
      success: false,
      message: e.message,
      http_status: 422
    )
  end

  protected

  # payloadに情報追加
  # ログ出力用
  # 関連ファイル: api/config/initializers/lograge.rb
  def append_info_to_payload(payload)
    super
    payload[:request_id] = request.request_id
    return if @exception.blank?

    puts @exception.backtrace if Rails.env.development? # rubocop:disable Rails/Output

    payload[:exception_object] ||= @exception
    payload[:exception] ||= [@exception.class.name, @exception.message]
  end

  # RequestのkeysをcamelCaseからsnake_caseへ変換
  def snake2camel_params
    params.deep_transform_keys!(&:underscore)
  end
end
