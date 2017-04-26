# frozen_string_literal: true

module Builders
  module Json
    # builder json message for errors
    class Errors
      attr_accessor :errors

      def initialize(model)
        self.errors = model.errors
      end

      def build
        Jbuilder.encode do |json|
          json.errors errors
        end
      end
    end
  end
end
