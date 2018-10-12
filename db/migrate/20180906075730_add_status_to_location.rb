class AddStatusToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :status, :string
  end
end
