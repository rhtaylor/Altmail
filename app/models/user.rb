require_relative '../../config/environment'
class User < ActiveRecord::Base
    validates :username, presence: true, uniqueness: true
    has_secure_password
    has_many :messages
end