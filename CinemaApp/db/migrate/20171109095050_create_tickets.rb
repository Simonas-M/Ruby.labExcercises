# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.decimal :price
      t.integer :seat_no
      t.references :screening, foreign_key: true

      t.timestamps
    end
  end
end
