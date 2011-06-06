require 'test_helper'

class BlockTest < ActiveSupport::TestCase
  def setup
    Bitcoin::Util.stubs(:valid_bitcoin_address?).returns(true)

    Bitcoin::Client.instance.stubs(:get_block_by_hash).returns({
        "tx" => [{"hash" => "tx_hash"}]
      })

    Bitcoin::Client.instance.stubs(:get_transaction).returns({
        "confirmations" => 42,
        "amount" => "50.01"
      })
  end

  def teardown
    Block.delete_all
    Share.delete_all
    Worker.delete_all
  end

  test "should create a block from a successful share" do
    Factory(:share)

    assert_difference 'Block.count' do
      Block.fetch_new
    end

    assert !Block.last.pps?
  end

  test "should correctly set pps flag on blocks" do
    share = Factory.build(:share)
    share.worker = Factory(:worker, :pps => true)
    share.save

    assert share.worker.pps?

    assert_difference 'Block.count' do
      Block.fetch_new
    end

    assert Block.last.pps?
  end

  test "non_pps scope should report correctly" do
    # Successful PPS share
    share = Factory.build(:share)
    share.worker = Factory(:worker, :pps => true)
    share.save

    # Successful non-PPS share
    Factory(:share)

    assert_difference 'Block.count', 2 do
      Block.fetch_new
    end

    pps_blocks = Block.pps
    non_pps_blocks = Block.pps(false)

    assert_equal 1, pps_blocks.count
    assert_equal 1, non_pps_blocks.count

    assert !non_pps_blocks.first.worker.pps?
    assert pps_blocks.first.worker.pps?
  end

  test "should correctly report the first share relevant to a block" do
    # First round
    3.times { Factory(:share, :upstream_result => nil) }
    winning_1 = Factory(:share, :upstream_result => nil)
  
    Block.create!(
      :checksum => "abc",
      :found_at => DateTime.now.advance(:minutes => -5),
      :share => winning_1,
      :worker => winning_1.worker
    )


    # Second round
    first_of_second_round = Factory(:share, :upstream_result => nil)
    3.times { Factory(:share, :upstream_result => nil) }
    winning_2 = Factory(:share, :upstream_result => nil)

      end
#    Block.create!(
#      :checksum => "abcd",
#      :found_at => DateTime.now,
#      :share => winning_2,
#      :worker => winning_2.worker
#    )
#
#    assert_equal first_of_second_round.id,
#      Block.last.first_share_of_round_id
#  end
end
