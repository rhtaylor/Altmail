require_relative '../../config/environment' 
require_relative './userc'
class BlogController < UserController
    get '/blog' do 
        
        @messages = Message.all.sort{ |x,y| x.created_at <=> y.created_at }

        @all = User.all 
        erb :'/blog/all'
    end
end   