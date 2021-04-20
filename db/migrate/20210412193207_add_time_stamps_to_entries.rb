class AddTimeStampsToEntries < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :entries
  end
end
