# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'

RSpec.describe 'Builders::Json::Errors' do
  include GenericSupport

  describe 'no errors' do
    describe 'valid' do
      let!(:habit) { FactoryGirl.create(:habit) }

      it { expect(json_str_to_hash(Builders::Json::Errors.new(habit).build)['errors']).to be_empty }
    end

    describe 'invalid' do
      let!(:habit) { Habit.create(FactoryGirl.attributes_for(:habit, title: '')) }

      it { expect(json_str_to_hash(Builders::Json::Errors.new(habit).build)['errors']).to_not be_empty }
    end
  end
end
