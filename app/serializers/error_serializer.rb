class ErrorSerializer
  def self.render(errors)
    errors.group_by { |error| error.attribute.to_s }
          .transform_values { |errs| errs.map(&:full_message) }
  end
end
