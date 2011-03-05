require 'test/unit'
require 'whiny_hash'

class TestWhinyHash < Test::Unit::TestCase
  def test_create
    wh = WhinyHash.new :a => 1, :b => 2, :c => 3
    assert_equal( wh.count, 3)
  end
  
  def test_read_normal
    wh = WhinyHash.new :a => 1, :b => 2, :c => 3
    assert_equal(wh[:a], 1)
    assert_equal(wh[:b], 2)
    assert_equal(wh[:c], 3)
   end

   def test_read_string_keys
     wh = WhinyHash.new :a => 1, :b => 2, :c => 3
     assert_equal(wh["a"], 1)
     assert_equal(wh["b"], 2)
     assert_equal(wh["c"], 3)
    end
    
    def test_override_normal
      wh = WhinyHash.new :a => 1, :b => 2, :c => 3
      wh[:a] = 9
      wh[:b] = 8
      wh[:c] = 7
      assert_equal(wh[:a], 9)
      assert_equal(wh[:b], 8)
      assert_equal(wh[:c], 7)
    end

    def test_override_string_keys
      wh = WhinyHash.new :a => 1, :b => 2, :c => 3
      wh["a"] = 9
      wh["b"] = 8
      wh["c"] = 7
      assert_equal(wh[:a], 9)
      assert_equal(wh[:b], 8)
      assert_equal(wh[:c], 7)
    end
    
    def test_spit_read_unset
      wh = WhinyHash.new :a => 1, :b => 2, :c => 3
      assert_raise(RuntimeError) { wh[:d] }
      assert_raise(RuntimeError) { wh["d"] }
    end

    def test_spit_set_unset
      wh = WhinyHash.new :a => 1, :b => 2, :c => 3
      assert_raise(RuntimeError) { wh[:d] = 4 }
      assert_raise(RuntimeError) { wh["d"] = 4 }
    end
    
    def test_merge_normal
      wh = WhinyHash.new :a => 1, :b => 2, :c => 3
      ww = wh.merge :a => 9, :b => 8, :c => 7
      assert_equal(ww[:a], 9)
      assert_equal(ww[:b], 8)
      assert_equal(ww[:c], 7)
    end

    def test_merge_string_keys
      wh = WhinyHash.new :a => 1, :b => 2, :c => 3
      ww = wh.merge "a" => 9, "b" => 8, "c" => 7
      assert_equal(ww[:a], 9)
      assert_equal(ww[:b], 8)
      assert_equal(ww[:c], 7)
      assert_equal(ww["a"], 9)
      assert_equal(ww["b"], 8)
      assert_equal(ww["c"], 7)
    end

    def test_spit_merge_unset
      wh = WhinyHash.new :a => 1, :b => 2, :c => 3
      assert_raise(RuntimeError) { wh.merge :d => 1, :a => 2 }
      assert_raise(RuntimeError) { wh.merge "d" => 1 }
    end
    
    def test_class
      wh = WhinyHash.new :a => 1, :b => 2, :c => 3
      ww = wh.merge :a => 9, :b => 8, :c => 7
      assert(ww.is_a?(Hash))
      assert(ww.is_a?(ActiveSupport::HashWithIndifferentAccess))
      assert(ww.is_a?(WhinyHash))
    end
 end
