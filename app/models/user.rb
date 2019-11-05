require_relative '../../config/environment'
class User < ActiveRecord::Base
    has_secure_password
    has_many :messages
end