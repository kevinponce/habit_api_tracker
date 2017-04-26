# frozen_string_literal: true

# spec/factories/user.rb
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'example123'
  end
end
