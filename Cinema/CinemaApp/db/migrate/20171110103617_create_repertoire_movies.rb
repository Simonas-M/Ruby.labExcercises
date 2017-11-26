# frozen_string_literal: true

class CreateRepertoireMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :repertoire_movies do |t|
      t.references :repertoire, foreign_key: true
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
