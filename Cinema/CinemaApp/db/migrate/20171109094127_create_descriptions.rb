class CreateDescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :descriptions do |t|
      t.string :title, limit: 20
      t.string :summary, limit: 500
      t.references :genre, foreign_key: true
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
