# frozen_string_literal: true

# movie ticket model
class Ticket < ApplicationRecord
  belongs_to :screening
  belongs_to :client, optional: true
end
