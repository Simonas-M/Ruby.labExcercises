# frozen_string_literal: true

class AddTicketManagerRefToTickets < ActiveRecord::Migration[5.1]
  def change
    add_reference :tickets, :ticket_manager, foreign_key: true
  end
end
