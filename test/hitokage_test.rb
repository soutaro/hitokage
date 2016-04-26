require 'test_helper'

class HitokageTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Hitokage::VERSION
  end

  def test_compatibility
    values = [Float::INFINITY, Float::NAN, +0.0, -0.0, 1e-5, 1e-6, 1e+14, 1e+15]
    to_s_results = values.map {|x| x.to_s.to_f }
    hitokage_results = values.map {|x| x.hitokage_to_s.to_f }

    assert_equal to_s_results, hitokage_results
  end
end
