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

   
    
  post '/message/sent' do  
        
      if params["message"] == "\r\n" && params["title"] == ""
        @user =   User.find_by(username: params["author"])
        session["message"] = "Fill out message section" 
        @session = session
        id = @user.id
        redirect "/user/#{id}"
      elsif params["title"] == ""
        @user =   User.find_by(username: params["author"])
        id = @user.id
        session["message"] = "Write a Title"
        @session = session 
        id = @user.id
        redirect "/user/#{id}"

      elsif
      
        @message = Message.create(params)
      @user = User.find_by(username: @message.author) 
      erb :"/user/sent" 
      
      end 
    end

    


  patch "/message/:id" do  
      @all = User.all
      id = params["id"]
      new_params = {}
      old_message = Message.find(id)
      new_params[:message] = params["message"]
      new_params[:title] = params["title"]
      @message = Message.find(params["id"])
      old_message.update(new_params) 
      
      redirect "/message/#{id}"
     
   end
 
   get '/message/:id' do   
    @session = session
    id = params[:id]
    @message = Message.find(params[:id]) 
    
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