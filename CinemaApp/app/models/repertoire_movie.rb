# frozen_string_literal: true

# repertoire movie model
class RepertoireMovie < ApplicationRecord
  belongs_to :repertoire
  belongs_to :movie
end
