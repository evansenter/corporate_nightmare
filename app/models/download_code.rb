# == Schema Information
# Schema version: 20090525002647
#
# Table name: download_codes
#
#  id         :integer         not null, primary key
#  key        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  count      :integer
#  batch_id   :integer
#

class DownloadCode < ActiveRecord::Base
  has_and_belongs_to_many :contents
  belongs_to :batch
  
  validates_presence_of :key, :count, :batch
  validates_uniqueness_of :key
  validates_numericality_of :count, :greater_than_or_equal_to => 0, :unless => proc { |download_code| download_code.count.blank? }
  
  def self.create_in_bulk!(batch)
    batch.number_of_codes.times do
      DownloadCode.create!(:key => generate_key, :count => batch.number_of_downloads, :batch => batch)
    end
  end
  
  def self.generate_key(length = 20)
    possible_characters = ("A".."Z").to_a + (0..9).to_a.map(&:to_s)
    (0..length).inject("") { |string, index| string << possible_characters[rand(possible_characters.length)] }
  end
  
  def self.use_download_code!(key_provided)
    download_code = DownloadCode.find_by_key(key_provided.gsub(/[^\w]/, "").upcase)
    
    if download_code && download_code.count > 0
      download_code.count -= 1
      download_code.save ? download_code : false
    end
  end
  
  def content_downloaded
    sql = <<-SQL
      SELECT content_id, count
      FROM   contents_download_codes
      WHERE  download_code_id = #{id}
    SQL
    
    results = ActiveRecord::Base.connection.execute(sql)
    results.inject([]) do |array, result|
      content = Content.find_by_id(result["content_id"])
      content ? array << [content, result["count"]] : array
    end
  end
end