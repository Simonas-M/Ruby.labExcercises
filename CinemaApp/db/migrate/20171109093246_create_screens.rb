# frozen_string_literal: true

class CreateScreens < ActiveRecord::Migration[5.1]
  def change
    create_table :screens do |t|
      t.string :title, limit: 20
      t.integer :seat_count, limit: 500
      t.references :cinema, foreign_key: true

      t.timestamps
    end
  end
end
