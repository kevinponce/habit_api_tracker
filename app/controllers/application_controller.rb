# frozen_string_literal: true

# base class for controllers
class ApplicationController < ActionController::API
  include KpJwtClient::Auth
end
