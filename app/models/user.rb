# frozen_string_literal: true

# user model
class User < ApplicationRecord
  has_secure_password

  has_many :habits, dependent: :delete_all
end
