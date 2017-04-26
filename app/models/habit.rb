# frozen_string_literal: true

# habit model
class Habit < ApplicationRecord
  belongs_to :user

  has_many :habit_records, dependent: :delete_all

  validates :title, length: { minimum: 1, maximum: 20 }
  validates :question, length: { minimum: 1, maximum: 50 }
end
