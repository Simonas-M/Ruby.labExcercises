# frozen_string_literal: true

# movie info model
class Info < ApplicationRecord
  belongs_to :rating
  belongs_to :movie
  has_one :crew, dependent: :destroy
end
