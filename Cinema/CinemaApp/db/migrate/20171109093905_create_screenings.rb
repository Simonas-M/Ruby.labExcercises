class CreateScreenings < ActiveRecord::Migration[5.1]
  def change
    create_table :screenings do |t|
      t.datetime :time
      t.integer :available_seat_count
      t.references :movie, foreign_key: true
      t.references :screen, foreign_key: true

      t.timestamps
    end
  end
end
