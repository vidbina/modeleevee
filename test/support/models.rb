class Memo < ActiveRecord::Base
  attr_accessible :id, :note
  validates :note, :presence => true
end
