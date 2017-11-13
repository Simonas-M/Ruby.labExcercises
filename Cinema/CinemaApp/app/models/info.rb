class Info < ApplicationRecord
  belongs_to :rating
  belongs_to :movie
  has_one :crew
end
