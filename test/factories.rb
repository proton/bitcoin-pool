Factory.define :block do |b|
  b.checksum "000000000055825d01acc3dcc80d02671c2e75ab5b692940446e9b8615ea3824"
end

Factory.define :share do |s|
  s.our_result "Y"
  s.upstream_result "Y"
  s.association :worker

  # We just change the version field in each subsequent block header
  s.sequence(:solution) { |n| "0000000#{n}50c549978a44e3ef671a4ed3f5b922195ebde0fbbccfdb5900e6827000000000c8a03dfb42fa04d47e9fbfd3e6afcb3d0df2b516eb86f4e64d09fe53cc397b6c4de61f4c1c069652a228e13d000000800000000000000000000000000000000000000000000000000000000000000000000000000000000080020000" }
end

Factory.define :worker do |w|
  w.association :user
  w.pps false
  w.sequence(:suffix) { |n| "w#{n}" }
  w.password "pass"
end

Factory.define :user do |u|
  u.sequence(:nick) { |n| "user#{n}" }
  u.sequence(:email) { |n| "user@example#{n}.com" }
  u.password "password"
  u.sequence(:address) { |n| "#{n}FXWhKPChEcUnSEoFQ3DGzxKe44MDbatz#" }
  u.payment_treshold 1.2
  u.password_confirmation { |u| u.password }
end
