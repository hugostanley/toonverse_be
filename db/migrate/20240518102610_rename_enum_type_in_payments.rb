class RenameEnumTypeInPayments < ActiveRecord::Migration[7.1]
  def change
    # Rename the enum type associated with payment_status column
    execute <<-SQL
      ALTER TYPE status RENAME TO payment_status;
    SQL
  end
end
