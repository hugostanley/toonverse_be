class ChangeStatusTypeInOrders < ActiveRecord::Migration[7.1]
  def up
    change_column :orders, :status, :string
  end

  def down
    change_column :orders, :status, :integer
  end
end
