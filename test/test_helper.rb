ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'mocha'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
end
