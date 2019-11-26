require_relative '../../config/environment'
class Message < ActiveRecord::Base
   belongs_to :user

   def self.reverse_order 
        order(id: :desc)        
   end 
   def self.oldest 
        order(id: :asc)
   end 
end