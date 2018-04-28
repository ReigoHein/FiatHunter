class CreateExchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|
      t.string :base
      t.string :target
      t.integer :amount
      t.integer :weeks

      t.timestamps
    end
  end
end
