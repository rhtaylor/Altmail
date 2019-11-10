ENV["SINATRA_ENV"] ||= "development"
require_relative './config/environment' 
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake' 
require './app/controllers/userc'
task :console do
    Pry.start
  end 

task :delete do 
  User.delete_all 
  Message.delete_all
end 

task :muhaha do 
  unless ActiveRecord::Base.connection.table_exists?(:messages)
    ActiveRecord::Base.connection.create_table :messages do |t|
      # :id is created automatically
      t.string :message 
      t.string :author
      t.string :title
      
    end 
    
  end
end
task :bro do 
  unless ActiveRecord::Base.connection.table_exists?(:users)
    ActiveRecord::Base.connection.create_table :users do |t|
      # :id is created automatically
      t.string :username 
      t.string :email 
      t.string :password_digest
    end 
    
  end
end
