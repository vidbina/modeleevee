require 'active_record'
require 'active_record/validations'
require 'modeleevee/version'
# TODO: require Digest::MD5

module Modeleevee
  extend ActiveSupport::Concern

  included do
    before_save :generate_unique_id
  end

  #class Modeleevee
    # Your code goes here...

  # TODO: require 'active_support' for these
  #included do
  #  before_save :generate_unique_id
  #  self.primary_key = :id
  #end

  def self.origin
    "madeliefje"
  end
  
  # helper method for determining a unique name for the model
  # rather than just doing a time-based hash we generate a
  # has based on a property of the model and time of creation
  def which?
    to_s
  end

  private

  def id_already_exists? me
    false
  end

  def generate_unique_id
    if !self.valid?
      # don't bother generating a id if the model is invalid
      false 
    else
      if self.id.blank?
        begin
          uid = Digest::MD5.hexdigest(which? + Time.now().to_s)
        end while id_already_exists?(uid)
        write_attribute :id, uid
        true
      end
    end
  end

    #def latest; end
    #def favorite; end
  #end
end
