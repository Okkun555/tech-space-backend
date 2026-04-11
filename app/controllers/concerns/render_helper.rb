module RenderHelper
  private

  # 422 validation_error
  def rescue_record_invalid(exception)
    render json: {
      code: "validation_error",
      errors: ErrorSerializer.render(exception.record.errors),
    }, status: :unprocessable_entity
  end
end