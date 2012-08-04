require 'test/unit'
require 'modeleevee'

class CoreFunctionalitiesTest < Test::Unit::TestCase

  def setup
    @memo = Memo.extend(Includer).do_include(Modeleevee)
    @open_memo = @memo.do_include(Exposer)
  end

  def test_preperatory_includer_module
    assert(
      Memo.extend(Includer).respond_to?(:do_include), 
      'Where is the Includer?.'
    )
  end

  def test_existence_of_memo_model_getters
    assert(@memo.new.respond_to? :id)
    assert(@memo.new.respond_to? :note)
  end

  def test_saving_of_modeleevee_objects
    old_count = @memo.count

    new_memo = assert_nothing_raised do
      new_memo = @memo.new(:note => 'Write modeleevee!')
      new_memo.save!
      assert_equal(new_memo.id.to_s.length, 32, 'Default id-length should be 32.')
    end

    assert_equal(old_count+1, @memo.count, 'There should be one more memo!')

  end

  def test_generate_unique_id_method
    # these methods should not be accessible as class methods
    assert !@memo.respond_to?(:generate_unique_id)
    assert !@memo.respond_to?(:id_already_exists?)
    assert !@memo.respond_to?(:seed_which)
    assert !@memo.respond_to?(:seed_time)
    assert !@memo.respond_to?(:digest)

    # methods are private and should not be accessible as instance methods
    assert !@memo.new.respond_to?(:generate_unique_id)
    assert !@memo.new.respond_to?(:id_already_exists?)
    assert !@memo.new.respond_to?(:seed_which)
    assert !@memo.new.respond_to?(:seed_time)
    assert !@memo.new.respond_to?(:digest)

    # should not be accessible as class methods
    assert !@open_memo.respond_to?(:do_generate_unique_id)
    assert !@open_memo.respond_to?(:does_id_exist?)
    assert !@open_memo.respond_to?(:get_which)
    assert !@open_memo.respond_to?(:get_time)
    assert !@open_memo.respond_to?(:do_digest)
    # should be accessible as instance methods
    assert @open_memo.new.respond_to?(:do_generate_unique_id)
    assert @open_memo.new.respond_to?(:does_id_exist?)
    assert @open_memo.new.respond_to?(:get_which)
    assert @open_memo.new.respond_to?(:get_time)
    assert @open_memo.new.respond_to?(:do_digest)
  end

  def test_generating_id_for_invalid_memo
    # test invalid memo
    invalid_memo = @open_memo.new
    # prove invalidity of memo
    assert !invalid_memo.valid?, 'Id and note-less memos are worthless.'
    # id-generation should return false on invalid memo
    assert !invalid_memo.do_generate_unique_id, 'Skip invalid records.'
  end

  def test_generating_id_for_valid_memo
    old_count = @open_memo.count
    # test valid memo
    valid_memo = @open_memo.new(:note => 'Get validated!')
    # prove validity
    assert valid_memo.valid?, 'This memo should pass validations'
    # id should be blank to get id-generation going
    assert valid_memo.id.blank?, 'Id of the new memo should be blank'
    # check that id doesn't exist
    assert !valid_memo.does_id_exist?('nonexistent'), 'That never existed!'
    # generation of id should return true
    assert valid_memo.do_generate_unique_id, 'id generation should succeed.'
    assert valid_memo.save, 'A valid memo deserves to be be saved. ;)'
    assert_equal valid_memo.id.length, 32, 'Default ids are 32 chars long'
    assert valid_memo.does_id_exist?(valid_memo.id.to_s), 'id exists, we just generated it'
    assert !valid_memo.do_generate_unique_id, 'If I already have an id, why bother?'
    assert_equal old_count+1, @open_memo.count, 'there should be one more element'
  end

  def test_check_whether_a_id_exists
    assert Memo.count > 0, 'there should be memos in the db to begin with.'
    # test existing memo
    existing_memo = @open_memo.first
    existing_id = existing_memo.id
    test_memo = @open_memo.new(:note => 'Let us check the id');
    # should return true as the id exists
    assert test_memo.does_id_exist?(existing_id), 'we both know it does exist'
  end

  def test_generating_id_for_a_id_holding_memo
    memo = @open_memo.first
    assert !memo.do_generate_unique_id, 'should return false as it does not qualify for id-generation'
  end
end
