require 'test/unit'
require 'modeleevee'

class CoreFunctionalitiesTest < Test::Unit::TestCase

  def setup
    @memo = Memo.extend(Includer).do_include(Modeleevee)
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
    @open_memo = @memo.do_include(Internals)

    assert !@open_memo.respond_to?(:do_generate_unique_id)
    assert @open_memo.new.respond_to?(:do_generate_unique_id)

    invalid_memo = @open_memo.new
    assert !invalid_memo.valid?, 'Id and note-less memos are worthless.'
    assert !invalid_memo.do_generate_unique_id, 'Skip invalid records.'

    valid_memo = @open_memo.new(:note => 'Get validated!')
    assert valid_memo.valid?, 'This memo should pass validations'
    assert valid_memo.id.blank?, 'Id of the new memo should be blank'
    assert !valid_memo.does_id_exist?('nonexistent'), 'That never existed!'
    assert valid_memo.do_generate_unique_id, 'id generation should succeed.'
    assert valid_memo.save, 'A valid memo deserves to be be saved. ;)'
    assert_equal valid_memo.id.length, 32, 'Default ids are 32 chars long'
    assert !valid_memo.do_generate_unique_id, 'If I already have an id, why bother?'
  end

end
