# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Habit, type: :model do
  it { expect(FactoryGirl.build(:habit)).to be_valid }

  it { expect(FactoryGirl.build(:habit, title: 'a')).to be_valid }
  it { expect(FactoryGirl.build(:habit, title: 'a' * 20)).to be_valid }
  it { expect(FactoryGirl.build(:habit, title: '')).to be_invalid }
  it { expect(FactoryGirl.build(:habit, title: 'a' * 21)).to be_invalid }

  it { expect(FactoryGirl.build(:habit, question: 'a')).to be_valid }
  it { expect(FactoryGirl.build(:habit, question: 'a' * 50)).to be_valid }
  it { expect(FactoryGirl.build(:habit, question: '')).to be_invalid }
  it { expect(FactoryGirl.build(:habit, question: 'a' * 51)).to be_invalid }
end
