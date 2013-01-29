class AddDailynotesWeeklynoteId < ActiveRecord::Migration
  def self.up
    add_column :dailynotes, :weeklynote_id, :integer, :null => false
  end

  def self.down
    remove_column :dailynotes, :weeklynote_id, :integer, :null => false
  end
end
