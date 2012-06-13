require "test/unit"
require "modeleevee"

class ModeleeveeTest < Test::Unit::TestCase
	def test_origin
		assert_equal "madeliefje", Modeleevee.origin
	end
end
