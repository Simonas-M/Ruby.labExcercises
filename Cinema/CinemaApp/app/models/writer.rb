# frozen_string_literal: true

# class Actor model
class Writer < ApplicationRecord
  belongs_to :crew
end
