require 'test_helper'

class BlockTest < ActiveSupport::TestCase
  test "should update blocks" do
    assert_difference 'Block.count' do
      Block.update_new
    end
  end

  test "should correctly set pps flag on blocks" do
    flunk
  end

  test "non_pps scope should report correctly" do
    flunk
  end

  test "should correctly report the first share relevant to a block" do
    flunk
  end
end
