class ChangeStatusTypeInPayments < ActiveRecord::Migration[7.1]
  def up
    change_column :payments, :status, :string
  end

  def down
    change_column :payments, :status, :integer
  end
end
