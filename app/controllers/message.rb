require_relative '../../config/environment'
require_relative '../models/message'
class MessageController <  Sinatra::Base
  
    configure do  
      register Sinatra::ActiveRecordExtension
      enable :sessions
      set :session_secret, "secret"
      set :public_folder, 'public'
      set :views, 'app/views'
    end
  post '/message/send' do  
    @users_ids = params["user"]["id"] 
    @users = @users_ids.map{ |id| User.find_by(id: id )}
    @id = params["user"]["id"]
    @packed_id = @id.join("-")
    @new_params = {:message => params["message"], 
                   :author => params["author"],
                   :sent_to => @packed_id }
    
    
    @message = Message.create(@new_params)
    
    @user = User.find_by(username: @message.author)
    
    @messages = Message.all
    erb :"/user/sent"
  end
   get '/message/my_sent_messages' do  
    @messages = Message.order("created_at DESC")
     erb :'user/sent'
   end 

   get '/message/edit' do  
      
      erb :'message/edit'
   end

   patch '/message/:id/' do 
      binding.pry
    id = params["id"]
    new_params = {}
    old_message = Message.find(id)
    new_params[:message] = params["message"]
    new_params[:author] = params["author"]
    @article = Message.find(params["id"])
    old_article.update(new_params)
    redirect "/message/#{id}"
  end 
  
   delete '/message/:id/delete' do 
    
    @message = Message.find(params["id"])
    @message.destroy
    
    
    redirect '/'
  end  
end