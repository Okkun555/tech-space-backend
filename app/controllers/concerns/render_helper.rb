module RenderHelper
  private

  # 401 unauthorized error
  def render_unauthorized(message: "認証が必要です", code: "unauthorized")
    render json: {
      code:,
      errors: [
        { field: "base", message: }
      ]
    }, status: :unauthorized
  end

  # 422 validation error
  def rescue_record_invalid(exception)
    render json: {
      code: "validation_error",
      errors: ErrorSerializer.render(exception.record.errors),
    }, status: :unprocessable_entity
  end
end