# frozen_string_literal: true

# spec/factories/habit_record.rb
FactoryGirl.define do
  factory :habit_record do
    tz 'America/Los_Angeles'
    completed_at Time.now.utc.change(hour: 7, min: 0, sec: 0)

    association :habit
  end
end
