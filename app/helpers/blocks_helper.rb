module BlocksHelper
  def confirmation_string_for(block, msg)
    if block.orphan?
      I18n.t("activerecord.attributes.block.orphan")
    else
      (block.confirmations >= 120) ? msg : block.confirmations
    end
  end

  def hash_string_for_block(checksum)
    stripped_hash = checksum.gsub(/^0*/, "")[0,26]

    content_tag :a,
      :title => checksum,
      :target => "_blank",
      :href => "http://blockexplorer.com/testnet/block/#{checksum}" do
      content_tag :span, :class => "hash" do
        stripped_hash
      end
    end
  end

  def orphan_class_for(block)
    "orphan" if block.orphan?
  end
end