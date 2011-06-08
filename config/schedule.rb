every 2.minutes do
  rake "bitcoin:update_blocks"
  rake "bitcoin:pay_users"
end

every 5.minutes do
  rake "bitcoin:record_stats"
end
