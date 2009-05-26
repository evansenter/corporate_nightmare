class AddBatchNumberToDownloadCode < ActiveRecord::Migration
  def self.up
    add_column :download_codes, :batch_id, :integer
  end

  def self.down
    remove_column :download_codes, :batch_id
  end
end
