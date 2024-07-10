class AddTenancyToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :tenancies, foreign_key: true
  end
end
