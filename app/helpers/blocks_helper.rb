module BlocksHelper
  def confirmation_string_for(confirmations, msg)
    (confirmations >= 120) ? msg : confirmations
  end

  def hash_string_for(checksum)
    content_tag :a,
      :title => checksum,
      :target => "_blank",
      :href => "http://blockexplorer.com/testnet/block/#{checksum}" do
      content_tag :span, :class => "hash" do
        checksum[0, 26]
      end
    end
  end
end