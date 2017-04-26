# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'
require 'kp_jwt_client'

RSpec.describe HabitsController, type: :controller do
  include GenericSupport

  let!(:user) { FactoryGirl.create(:user) }
  let!(:habit) { FactoryGirl.create(:habit, user: user) }
  let!(:auth_token) { KpJwtClient::JsonWebToken.encode(entity_id: user.id, entity: 'user', token_type: 'regular') }
  let!(:invalid_auth_token) { KpJwtClient::JsonWebToken.encode(entity_id: user.id, entity: 'user', token_type: 'invalid') }

  describe '#index' do
    describe 'valid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        get :index
      end

      it { expect(response).to be_success }
      it { expect(body_as_json(response)[:errors]).to be_empty }
      it { expect(body_as_json(response)[:habits].length).to eq(1) }
      it { expect(body_as_json(response)[:habits].first[:title]).to eq(habit.title) }
    end

    describe 'invalid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{invalid_auth_token}"
        get :index
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:habits]).to be_nil }
    end
  end

  describe '#create' do
    describe 'valid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        post :create, params: { habit: FactoryGirl.attributes_for(:habit) }
      end

      it { expect(response).to be_success }
      it { expect(body_as_json(response)[:errors]).to be_empty }
      it { expect(body_as_json(response)[:title]).to eq(habit.title) }
    end

    describe 'invalid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{invalid_auth_token}"
        post :create, params: { habit: FactoryGirl.attributes_for(:habit) }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:title]).to be_nil }
    end
  end

  describe '#update' do
    let(:title) { 'different title' }

    describe 'valid jwt token' do
      describe 'valid id' do
        before(:each) do
          request.headers['Authorization'] = "JWT #{auth_token}"
          put :update, params: { id: habit.id, habit: FactoryGirl.attributes_for(:habit).merge(title: title) }
        end

        it { expect(response).to be_success }
        it { expect(body_as_json(response)[:errors]).to be_empty }
        it { expect(body_as_json(response)[:title]).to_not eq(habit.title) }
        it { expect(body_as_json(response)[:title]).to eq(title) }
        it { expect(habit.reload.title).to eq(title) }
      end

      describe 'invalid id' do
        before(:each) do
          request.headers['Authorization'] = "JWT #{auth_token}"
          put :update, params: { id: habit.id + 1, habit: FactoryGirl.attributes_for(:habit).merge(title: title) }
        end

        it { expect(response).to_not be_success }
        it { expect(body_as_json(response)[:errors]).to_not be_empty }
        it { expect(body_as_json(response)[:title]).to be_nil }
      end
    end

    describe 'invalid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{invalid_auth_token}"
        put :update, params: { id: habit.id, habit: FactoryGirl.attributes_for(:habit).merge(title: title) }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:title]).to be_nil }
    end
  end

  describe '#show' do
    describe 'valid jwt token' do
      describe 'valid id' do
        before(:each) do
          request.headers['Authorization'] = "JWT #{auth_token}"
          get :show, params: { id: habit.id }
        end

        it { expect(response).to be_success }
        it { expect(body_as_json(response)[:errors]).to be_empty }
        it { expect(body_as_json(response)[:title]).to eq(habit.title) }
      end

      describe 'invalid id' do
        before(:each) do
          request.headers['Authorization'] = "JWT #{auth_token}"
          get :show, params: { id: habit.id + 1 }
        end

        it { expect(response).to_not be_success }
        it { expect(body_as_json(response)[:errors]).to_not be_empty }
        it { expect(body_as_json(response)[:title]).to be_nil }
      end
    end

    describe 'invalid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{invalid_auth_token}"
        get :show, params: { id: habit.id }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:title]).to be_nil }
    end
  end

  describe '#destroy' do
    describe 'valid jwt token' do
      describe 'valid id' do
        describe 'delete is false pre call' do
          before(:each) do
            request.headers['Authorization'] = "JWT #{auth_token}"
            delete :destroy, params: { id: habit.id }
          end

          it { expect(response).to be_success }
          it { expect(body_as_json(response)[:errors]).to be_empty }
          it { expect(body_as_json(response)[:title]).to eq(habit.title) }
          it { expect(body_as_json(response)[:title]).to eq(habit.title) }
          it { expect(body_as_json(response)[:deleted]).to eq(true) }
          it { expect(habit.reload.deleted).to eq(true) }
        end

        describe 'delete is true pre call' do
          before(:each) do
            habit.update_attributes(deleted: true)
            request.headers['Authorization'] = "JWT #{auth_token}"
            delete :destroy, params: { id: habit.id }
          end

          it { expect(response).to be_success }
          it { expect(body_as_json(response)[:errors]).to be_empty }
          it { expect(body_as_json(response)[:title]).to eq(habit.title) }
          it { expect(body_as_json(response)[:title]).to eq(habit.title) }
          it { expect(body_as_json(response)[:deleted]).to eq(false) }
          it { expect(habit.reload.deleted).to eq(false) }
        end
      end

      describe 'invalid id' do
        before(:each) do
          request.headers['Authorization'] = "JWT #{auth_token}"
          delete :destroy, params: { id: habit.id + 1 }
        end

        it { expect(response).to_not be_success }
        it { expect(body_as_json(response)[:errors]).to_not be_empty }
        it { expect(body_as_json(response)[:title]).to be_nil }
      end
    end

    describe 'invalid jwt token' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{invalid_auth_token}"
        delete :destroy, params: { id: habit.id }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:title]).to be_nil }
    end
  end
end
