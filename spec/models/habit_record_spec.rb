# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HabitRecord, type: :model do
  it { expect(FactoryGirl.build(:habit_record)).to be_valid }
end
