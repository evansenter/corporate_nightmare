class AddCountToContentDownloadJoinTable < ActiveRecord::Migration
  def self.up
    add_column :contents_download_codes, :count, :integer, :default => 1
  end

  def self.down
    remove_column :contents_download_codes, :count
  end
end
