class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.integer :bonuses
      t.references :user, null: false, index: true, foreign_key: true
      t.references :shop, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
