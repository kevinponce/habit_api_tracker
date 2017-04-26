# frozen_string_literal: true

module Builders
  module Json
    module Helpers
      # helper is used to keep habits json builders dry
      module Habit
        def build_habit(json, habit)
          json.id        habit.id
          json.title     habit.title
          json.color     habit.color
          json.question  habit.question
          json.remind_at habit.remind_at
          json.tz        habit.tz
          json.deleted   habit.deleted

          build_habit_day_of_week(json, habit)

          json.created_at habit.created_at
          json.updated_at habit.updated_at
        end

        def build_habit_day_of_week(json, habit)
          json.monday    habit.monday
          json.tuesday   habit.tuesday
          json.wednesday habit.wednesday
          json.thursday  habit.thursday
          json.friday    habit.friday
          json.saturday  habit.saturday
          json.sunday    habit.sunday
        end

        def build_habit_record(json, habit_record)
          json.completed_at habit_record.completed_at
          json.tz           habit_record.tz
        end
      end
    end
  end
end
