# frozen_string_literal: true

class Object
  def safe_strip
    return self if self.nil? || !self.is_a?(String)
    self.strip
  end
end
