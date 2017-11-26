# frozen_string_literal: true

# movie ticket model
class Ticket < ApplicationRecord
  belongs_to :screening
  belongs_to :ticket_manager
  belongs_to :client, optional: true

  def assign_to(client:)
    raise 'cannot reassign ticket' if self.client
    self.client = client
    save
  end

  def unassign
    self.client = nil
    save
  end

  def change_price(new_price)
    self.price = new_price
    save
  end
end
