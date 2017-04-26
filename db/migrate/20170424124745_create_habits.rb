# frozen_string_literal: true

# creates habits table
class CreateHabits < ActiveRecord::Migration[5.0]
  def change
    create_table :habits do |t|
      t.string :title
      t.string :color
      t.text :question
      t.string :tz
      t.datetime :remind_at

      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday

      t.boolean :deleted, default: false

      t.references :user, index: true
      t.timestamps
    end
  end
end
