class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.integer :points
      t.float :order_amount
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
