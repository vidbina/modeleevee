require 'active_record'
require 'modeleevee/version'

module Modeleevee
  extend ActiveSupport::Concern

  included do
    before_save :generate_unique_id
    self.primary_key = :id
  end

  def self.origin
    'madeliefje'
  end
  
  private

  # helper method for determining a unique name for the model
  # rather than just doing a time-based hash we generate a
  # has based on a property of the model and time of creation
  # Override to make id generation behaviour unique for your app
  def which?
    to_s
  end

  def id_already_exists? me
    false
  end

  def generate_unique_id
    false
    if self.valid? && self.id.blank?
      # FIX: what if we continuously fail to generate a unique id?!?
      begin
        uid = Digest::MD5.hexdigest(which? + Time.now().to_s)
      end while id_already_exists?(uid)
      write_attribute :id, uid
      true
    end
  end

end
