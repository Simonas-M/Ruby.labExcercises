class CreateCrews < ActiveRecord::Migration[5.1]
  def change
    create_table :crews do |t|
      t.references :info, foreign_key: true

      t.timestamps
    end
  end
end
