# frozen_string_literal: true

module Builders
  module Json
    # builder json message for habits
    class Habits
      include Builders::Json::Helpers::Habit

      attr_accessor :habits

      def initialize(habits)
        self.habits = habits
      end

      def build
        Jbuilder.encode do |json|
          json.errors []

          json.habits habits do |habit|
            build_habit(json, habit)
          end
        end
      end
    end
  end
end
