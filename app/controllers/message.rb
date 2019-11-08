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
      @packed_id = @users_ids.join("-") 
      @new_params = {:message => params["message"], 
                   :author => params["author"],
                   :sent_to => @packed_id }
      @message = Message.create(@new_params)
    
      packed_ids = @message.sent_to 
      ids = packed_ids.split("-") 
      @sent_to_users = ids.map{ |x| User.find_by(id: x)} 
      @user = User.find_by(username: @message.author) 
    
    erb :"/user/sent"
  end
    


    patch "/message/:id" do  
      
      id = params["id"]
      new_params = {}
      old_message = Message.find(id)
      new_params[:message] = params["message"]
      
      @message = Message.find(params["id"])
      old_message.update(new_params)
      redirect "/message/#{id}"
     
   end
 
   get '/message/:id' do  
    id = params[:id]
    @message = Message.find(params[:id]) 
    ids = @message.sent_to.split("-")
    @sent_to_users = ids.map{ |x| User.find_by(id: x)} 
    
    @user = User.find_by(username: @message.author)  
    id = params[:id]
    erb :"user/id"
  end 
  
   delete '/message/:id/delete' do 
    
    @message = Message.find(params["id"]) 
    author = @message.author 
    @user = User.find_by("author" ==  author)
    @message.destroy
    id = @user.id
    
    redirect "/user/#{id}"
  end  
end