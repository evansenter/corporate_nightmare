class AddCountToDownloadCodes < ActiveRecord::Migration
  def self.up
    add_column :download_codes, :count, :integer
  end

  def self.down
    remove_column :download_codes, :count
  end
end
