# frozen_string_literal: true

# movie description model
class Description < ApplicationRecord
  belongs_to :genre
  belongs_to :movie, dependent: :destroy
end
