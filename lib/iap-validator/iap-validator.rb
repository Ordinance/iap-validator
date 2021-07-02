# frozen_string_literal: true

module IAPValidator
  class IAPValidator
    class << self
      def validate(data, sandbox = false, options = {})
        ActiveSupport::Deprecation.warn("Please use IAPValidator::Client")
        Client.validate(data, sandbox, options)
      end
    end
  end
end