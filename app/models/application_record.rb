class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  auth = {
    secret: Doorkeeper::Application.first.secret,
    uid: Doorkeeper::Application.first.uid
  }

  p auth
end
