# frozen_string_literal: true

module Builders
  module Json
    # builder json message for habit records
    class HabitRecords
      include Builders::Json::Helpers::Habit

      attr_accessor :habit_records

      def initialize(habit_records)
        self.habit_records = habit_records
      end

      def build
        Jbuilder.encode do |json|
          json.errors []

          json.habit_records habit_records do |habit_record|
            build_habit_record(json, habit_record)
          end
        end
      end
    end
  end
end
