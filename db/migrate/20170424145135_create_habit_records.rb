# frozen_string_literal: true

# creates habits records table
class CreateHabitRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :habit_records do |t|
      t.string :tz
      t.datetime :completed_at
      t.timestamps
      t.references :habit, index: true
    end
  end
end
