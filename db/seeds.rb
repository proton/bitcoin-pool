User.create!({
    :email => 'david@bitcoin-central.net' ,
    :nick => 'davout',
    :password => 'password',
    :password_confirmation => 'password',
    :address => "1FXWhKPChEcUnSEoFQ3DGzxKe44MDbatz"
  }
)

User.find_by_nick("davout").update_attribute(:confirmed_at, DateTime.now)