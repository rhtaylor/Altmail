require_relative '../../config/environment' 
require_relative './userc'
class BlogController < UserController
    get '/blog' do 
        @messages = params.has_key?("filtered") ?  Message.all.sort{ |x,y| y.created_at <=> x.created_at } : Message.all.sort{ |x,y| x.created_at <=> y.created_at }
        @all = User.all 
        erb :'/blog/all'
    end
end   