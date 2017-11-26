# frozen_string_literal: true

# class Crew model
class Crew < ApplicationRecord
  belongs_to :info
  has_many :directors
  has_many :writers
  has_many :actors
end
