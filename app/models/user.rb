class User < ApplicationRecord
  has_secure_password :password, validations: false 
   
  def self.create_core_user
    create(name: "core", password: "")
  end
end