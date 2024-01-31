class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :product
      t.string :order_date

      t.timestamps
    end
  end
end
