class AddReadToReports < ActiveRecord::Migration
  def change
    add_column :reports, :read, :boolean
  end
end
