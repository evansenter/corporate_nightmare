# == Schema Information
# Schema version: 20090525002647
#
# Table name: batches
#
#  id                  :integer         not null, primary key
#  number_of_codes     :integer
#  number_of_downloads :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class Batch < ActiveRecord::Base
  has_many :download_codes, :dependent => :destroy
  
  validates_presence_of :number_of_codes, :number_of_downloads
  validates_numericality_of :number_of_codes, :greater_than_or_equal_to => 0, :unless => proc { |batch| batch.number_of_codes.blank? }
  validates_numericality_of :number_of_downloads, :greater_than_or_equal_to => 0, :unless => proc { |batch| batch.number_of_downloads.blank? }
end
