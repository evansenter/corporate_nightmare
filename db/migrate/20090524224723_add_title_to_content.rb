class AddTitleToContent < ActiveRecord::Migration
  def self.up
    add_column :contents, :title, :string
  end

  def self.down
    remove_column :contents, :title
  end
end
