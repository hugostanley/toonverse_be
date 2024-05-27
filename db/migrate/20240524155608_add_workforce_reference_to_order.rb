class AddWorkforceReferenceToOrder < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :workforce, foreign_key: true
  end
end
