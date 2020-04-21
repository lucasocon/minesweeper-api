# frozen_string_literal: true

# ApplicationService
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
