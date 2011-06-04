every 5.minutes do
  rake "bitcoin:udpate_blocks"
  rake "bitcoin:pay_users"
end
