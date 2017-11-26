# frozen_string_literal: true

class CreateWriters < ActiveRecord::Migration[5.1]
  def change
    create_table :writers do |t|
      t.string :name, limit: 30
      t.string :surname, limit: 30
      t.references :crew, foreign_key: true

      t.timestamps
    end
  end
end
