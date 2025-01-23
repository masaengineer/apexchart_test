class CreateEbayOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :ebay_orders do |t|
      t.string :order_id
      t.jsonb :order_data

      t.timestamps
    end
    add_index :ebay_orders, :order_id, unique: true
  end
end
