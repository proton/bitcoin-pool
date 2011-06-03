require 'test_helper'

class BlockTest < ActiveSupport::TestCase
  test "should update blocks" do
    assert_difference 'Block.count' do
      Block.update_new
    end
  end

  test "should correctly set pps flag on blocks" do
    flunk "implement me"
  end

  test "non_pps scope should report correctly" do
    flunk "implement me"
  end
end
