class AddEnddateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :enddate, :date
  end
end
