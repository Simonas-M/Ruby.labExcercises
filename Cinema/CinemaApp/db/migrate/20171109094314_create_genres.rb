class CreateGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :genres do |t|
      t.string :name, limit: 30

      t.timestamps
    end
  end
end
