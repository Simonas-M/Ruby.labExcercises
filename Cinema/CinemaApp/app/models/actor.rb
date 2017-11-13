# frozen_string_literal: true

# class Actor model
class Actor < ApplicationRecord
  belongs_to :crew
end
