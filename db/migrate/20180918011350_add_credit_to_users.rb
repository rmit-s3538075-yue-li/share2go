class AddCreditToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :credit_card_no
    add_column :users, :credit, :integer
  end
end
