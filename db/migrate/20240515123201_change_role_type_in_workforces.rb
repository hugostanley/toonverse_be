class ChangeRoleTypeInWorkforces < ActiveRecord::Migration[7.1]
  def up
    change_column :workforces, :role, :string, default: "illustrator"
  end

  def down
    change_column :workforces, :role, :integer
  end
end
