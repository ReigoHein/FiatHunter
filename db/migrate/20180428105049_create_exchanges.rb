class CreateExchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|
      t.integer :user_id, null: false
      t.string :base
      t.string :target
      t.integer :amount
      t.integer :weeks

      t.timestamps
    end

    add_foreign_key :exchanges, :users

    add_index :exchanges, :user_id

  end
end
