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


## Create a few basic settings

# Fee taken on each generation using the classical pooling approach
Setting.create!({
    :key => "pooling_fee",
    :value => "0.02"
  }
)

# Used to compute PPS payout from average number of shares to find a block, protects
# the pool operator from variance when paying fixed amounts for each share
Setting.create!({
    :key => "pps_fee",
    :value => "0.08"
  }
)

# The scoring function enables the pool operator to define how share relative
# values should age. This helps protecting everyone from pool hopping but induces
# more variance on the user side, especially for slow miners.
# The value in a scoring function should be valid SQL in the context of a SUM
# on the 'shares' table.
# The default setting is "1" meaning that shares don't age
Setting.create!({
    :key => "scoring_function",
    :value => "1"
  }
)

# This example scoring function can be used to make share values decrease
# exponentially as time passes.
Setting.create!({
    :key => "example_scoring_function",
    :value => "1.0 / EXP((UNIX_TIMESTAMP(CURRENT_TIMESTAMP) - UNIX_TIMESTAMP(created_at)) / 600.0)	"
  }
)
