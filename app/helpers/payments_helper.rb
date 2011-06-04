module PaymentsHelper
  def hash_string_for_transaction(transaction_id)
    content_tag :a,
      :title => transaction_id,
      :target => "_blank",
      :href => "http://blockexplorer.com/testnet/tx/#{transaction_id}" do
      content_tag :span, :class => "hash" do
        transaction_id[0, 26]
      end
    end
  end
end
