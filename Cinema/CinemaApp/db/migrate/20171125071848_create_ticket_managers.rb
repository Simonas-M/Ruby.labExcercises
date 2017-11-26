# frozen_string_literal: true

class CreateTicketManagers < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_managers do |t|
      t.references :cinema, foreign_key: true

      t.timestamps
    end
  end
end
