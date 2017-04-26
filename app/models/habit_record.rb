# frozen_string_literal: true

# habit record model
class HabitRecord < ApplicationRecord
  belongs_to :habit
end
