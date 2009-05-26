# == Schema Information
# Schema version: 20090525002647
#
# Table name: contents
#
#  id                :integer         not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  title             :string(255)
#

class Content < ActiveRecord::Base
  has_and_belongs_to_many :download_codes
  
  has_attached_file :file,
                    :url  => ":rails_root/assets/contents/:id/:style/:basename.:extension",
                    :path => ":rails_root/assets/contents/:id/:style/:basename.:extension"
                    
  validates_attachment_presence :file
  validates_presence_of   :title
  validates_uniqueness_of :title
end