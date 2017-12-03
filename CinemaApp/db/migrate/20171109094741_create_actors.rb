# frozen_string_literal: true

class CreateActors < ActiveRecord::Migration[5.1]
  def change
    create_table :actors do |t|
      t.string :name, limit: 30
      t.string :surname, limit: 30
      t.references :crew, foreign_key: true

      t.timestamps
    end
  end
end
