class AddReceiversName < ActiveRecord::Migration
  def self.up
    add_column :receivers, :name, :string
  end

  def self.down
    remove_column :receivers, :name, :string
  end
end
