module Bitcoin
  module ActiveRecordHelper
    def bitcoin
      Bitcoin::Client.instance
    end
  end
end