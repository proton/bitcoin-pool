class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user!
end
