# frozen_string_literal: true

class AddClientRefToTickets < ActiveRecord::Migration[5.1]
  def change
    add_reference :tickets, :client, foreign_key: true
  end
end
