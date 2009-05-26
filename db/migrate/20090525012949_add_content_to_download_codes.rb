class AddContentToDownloadCodes < ActiveRecord::Migration
  def self.up
    create_table :contents_download_codes do |table|
      table.integer :content_id
      table.integer :download_code_id
      table.timestamps
    end
  end

  def self.down
    drop_table :contents_download_codes
  end
end
