User.create!({
    :email => 'david@bitcoin-central.net' ,
    :nick => 'davout',
    :password => 'password',
    :password_confirmation => 'password'
  }
)

User.find_by_nick("davout").update_attribute(:confirmed_at, DateTime.now)