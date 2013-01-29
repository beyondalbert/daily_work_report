class CreateWeeklynotes < ActiveRecord::Migration
  def self.up
    create_table :weeklynotes do |t|
      t.column :user_id, :integer, :null => false
      t.column :note, :text
      t.column :start_date, :datetime, :null => false
      t.column :end_date, :datetime, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :weeklynotes
  end
end
