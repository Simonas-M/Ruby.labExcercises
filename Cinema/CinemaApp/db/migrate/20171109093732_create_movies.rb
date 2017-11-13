class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.references :repertoire, foreign_key: true

      t.timestamps
    end
  end
end
