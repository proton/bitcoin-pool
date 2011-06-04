# Create a first admin user
User.create!({
    :email => 'david@bitcoin-central.net' ,
    :nick => 'davout',
    :password => 'password',
    :password_confirmation => 'password',
    :address => "1FXWhKPChEcUnSEoFQ3DGzxKe44MDbatz"
  }
)

User.find_by_nick("davout").update_attribute(:confirmed_at, DateTime.now)

# Create a few basic settings
Setting.create!({
    :key => "pooling_fee",
    :value => "0.08"
  }
)

Setting.create!({
    :key => "pps_fee",
    :value => "0.02"
  }
)