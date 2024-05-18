class RenameStatusColumnsInPaymentsAndOrders < ActiveRecord::Migration[7.1]
  def change
    # Rename status column to payment_status in payments table
    rename_column :payments, :status, :payment_status

    # Rename status column to order_status in orders table
    rename_column :orders, :status, :order_status
  end
end
