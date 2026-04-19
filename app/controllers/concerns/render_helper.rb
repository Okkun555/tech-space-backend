module RenderHelper
  private

  # 401 unauthorized error
  def render_unauthorized(message: "認証が必要です")
    render_base_error(message: message, code: :unauthorized)
  end

  # 409 conflict error
  def render_conflict(message:)
    render_base_error(message: message, code: :conflict)
  end

  # 422 validation error
  def rescue_record_invalid(exception)
    render json: {
      code: "validation_error",
      errors: ErrorSerializer.render(exception.record.errors)
    }, status: :unprocessable_entity
  end

  def render_base_error(message:, code:)
    render json: {
      code: code.to_s,
      errors: [
        { field: "base", message: }
      ]
    }, status: code
  end
end
