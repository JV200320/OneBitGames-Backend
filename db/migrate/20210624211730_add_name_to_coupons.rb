class AddNameToCoupons < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :name, :string
  end
end
