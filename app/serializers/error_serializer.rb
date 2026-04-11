class ErrorSerializer
  def self.render(errors)
    errors.map do |error|
      {
        field: error.attribute.to_s,
        message: error.full_message,
      }
    end
  end
end
