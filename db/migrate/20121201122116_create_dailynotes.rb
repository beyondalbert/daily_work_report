class CreateDailynotes < ActiveRecord::Migration
  def self.up
    create_table :dailynotes do |t|
      t.column :user_id, :integer, :null => false
      t.column :note, :text
      t.column :date, :datetime, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :dailynotes
  end
end
