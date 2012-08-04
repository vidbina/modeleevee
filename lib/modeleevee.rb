require 'active_record'
require 'modeleevee/version'

module Modeleevee
  extend ActiveSupport::Concern

  included do
    before_save :generate_unique_id
    self.primary_key = :id
  end

  # just a little distraction
  def self.origin
    'madeliefje'
  end
  
  private

  # helper methods for generating a unique name for the model. Rather than just
  # doing a time-based hash, we generate a hash based on one or more properties
  # of the model (seed_which) and the time of creation of the id (seed_time).

  # Gets a model-specific string to enhance enthropy of id generation.
  # @return [String] a string 
  def seed_which
    to_s
  end

  # Gets the string representation of the time at which this method is called.
  # @return [String] the current time
  def seed_time
    Time.now().to_s
  end

  # Checks whether the generated id, if any, already exists in the database.
  # @param [String] string representation of the id to be checked for existence
  # @return [Boolean]
  def id_already_exists? me
    # TODO: test and write code
    self.class.exists?(me)
  end

  # Generates the id for the model
  # @return [String] string representation of the newly generated random value
  def digest
    Digest::MD5.hexdigest(seed_which + seed_time)
  end

  # Generates a unique id for the current model instance.
  # @return [Boolean] true on success, false on failure
  def generate_unique_id
    # return false by default
    false 

    # only generate ids for valid, id-less objects
    if self.valid? && self.id.blank? 
      # FIX: what if we continuously fail to generate a unique id?!? ∞-loop?
      begin
        uid = digest
      end while id_already_exists?(uid)
      write_attribute :id, uid
      # only return true after successful completion of generation and saving
      true
    end
  end

end
