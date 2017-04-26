# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'
require 'kp_jwt_client'

RSpec.describe HabitRecordsController, type: :controller do
  include GenericSupport

  let!(:user) { FactoryGirl.create(:user) }
  let!(:habit) { FactoryGirl.create(:habit, user: user) }
  let!(:habit_record) { FactoryGirl.create(:habit_record, habit: habit) }
  let!(:auth_token) { KpJwtClient::JsonWebToken.encode(entity_id: user.id, entity: 'user', token_type: 'regular') }
  let!(:invalid_auth_token) { KpJwtClient::JsonWebToken.encode(entity_id: user.id, entity: 'user', token_type: 'invalid') }

  describe '#index' do
    describe 'valid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        get :index, params: { habit_id: habit.id }
      end

      it { expect(response).to be_success }
      it { expect(body_as_json(response)[:errors]).to be_empty }
      it { expect(body_as_json(response)[:habit_records].length).to eq(1) }
      it { expect(habit.reload.habit_records.count).to eq(1) }
    end

    describe 'invalid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{invalid_auth_token}"
        get :index, params: { habit_id: habit.id }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:habit_records]).to be_nil }
    end
  end

  describe '#create' do
    describe 'valid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        post :create, params: { habit_id: habit.id, habit_record: FactoryGirl.attributes_for(:habit_record) }
      end

      it { expect(response).to be_success }
      it { expect(body_as_json(response)[:errors]).to be_empty }
      it { expect(body_as_json(response)[:title]).to_not be_nil }
      it { expect(habit.reload.habit_records.count).to eq(2) }
    end

    describe 'invalid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{invalid_auth_token}"
        post :create, params: { habit_id: habit.id, habit_record: FactoryGirl.attributes_for(:habit_record) }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:title]).to be_nil }
    end
  end

  describe '#create' do
    describe 'valid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        delete :destroy, params: { habit_id: habit.id, id: habit_record.id }
      end

      it { expect(response).to be_success }
      it { expect(body_as_json(response)[:errors]).to be_empty }
      it { expect(body_as_json(response)[:title]).to_not be_nil }
      it { expect(habit.reload.habit_records.count).to eq(0) }
    end

    describe 'invalid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{invalid_auth_token}"
        delete :destroy, params: { habit_id: habit.id, id: habit_record.id }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:title]).to be_nil }
    end
  end
end
