# frozen_string_literal: true

# base class for modeles
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
