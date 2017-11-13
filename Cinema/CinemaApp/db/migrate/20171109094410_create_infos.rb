class CreateInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :infos do |t|
      t.integer :duration
      t.datetime :release_date
      t.references :rating, foreign_key: true
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
