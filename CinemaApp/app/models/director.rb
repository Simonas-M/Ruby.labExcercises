# frozen_string_literal: true

# Director model
class Director < ApplicationRecord
  belongs_to :crew
end
