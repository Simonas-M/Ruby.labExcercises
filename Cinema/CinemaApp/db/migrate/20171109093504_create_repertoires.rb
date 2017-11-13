class CreateRepertoires < ActiveRecord::Migration[5.1]
  def change
    create_table :repertoires do |t|
      t.references :cinema, foreign_key: true

      t.timestamps
    end
  end
end
