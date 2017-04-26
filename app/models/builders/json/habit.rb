# frozen_string_literal: true

module Builders
  module Json
    # builder json message for habit
    class Habit
      include Builders::Json::Helpers::Habit

      attr_accessor :habit

      def initialize(habit)
        self.habit = habit
      end

      def build
        Jbuilder.encode do |json|
          json.errors []

          build_habit(json, habit)
        end
      end
    end
  end
end
