# frozen_string_literal: true

# spec/factories/habit.rb
FactoryGirl.define do
  factory :habit do
    title 'Wake up early'
    question 'Did you wake up before 6?'
    color 'green'
    tz 'America/Los_Angeles'
    remind_at Time.now.utc.change(hour: 7, min: 0, sec: 0)

    monday true
    tuesday true
    wednesday true
    thursday false
    friday true
    saturday false
    sunday false

    deleted false

    association :user
  end
end
