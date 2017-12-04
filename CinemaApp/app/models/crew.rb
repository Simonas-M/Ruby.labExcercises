# frozen_string_literal: true

# class Crew model
class Crew < ApplicationRecord
  belongs_to :info
  has_many :directors, dependent: :destroy
  has_many :writers, dependent: :destroy
  has_many :actors, dependent: :destroy
end
