class AddSentdateToReports < ActiveRecord::Migration
  def change
    add_column :reports, :sentdate, :datetime
  end
end
