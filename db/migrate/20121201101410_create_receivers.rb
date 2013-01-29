class CreateReceivers < ActiveRecord::Migration
  def self.up
    create_table :receivers do |t|
      t.column :email, :string
      t.column :user_id, :integer, :null => false
      t.column :contact_type, :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :receivers
  end
end
