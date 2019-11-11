require_relative '../../config/environment'
class UserController <  Sinatra::Base
  
      configure do  
      register Sinatra::ActiveRecordExtension
      enable :sessions
      set :session_secret, "secret"
      set :public_folder, 'public'
      set :views, 'app/views'
      end
  
    get '/' do 
        session.clear
        session["state"] = "reset"
        @session = session
        erb :index 
    end 
    get '/user/signin' do
        session[:page] = "signin"
        @session = session      
        erb :'user/signin'
       
    end  
    get '/user/signup' do
      session[:page] = "signin"
      @session = session  
    erb :'user/signup' 

    end 
    get "/user/logout" do
      session.clear
      @session = session
      erb :index
    end 
    
    get '/user/:id/' do 
      session["page"] = "profile"
      @session = session
      @user = User.find_by(params)
      @messages = Message.all.map{ |unit| unit.author == @user.username ? unit : next }   
      @all = User.all 
      erb :"/user/id"
    end
    get '/user/:id/sent_all' do 
          session["page"] = "all"
        @user = User.find(params[:id])
        
        @messages = Message.all.map{ |unit| unit.author == @user.username ? unit : next }  
        @session = session
        erb :'/user/sent_all'
    end

       post '/user/signup' do 
       if params[:password_digest] == "" || params[:username] == "" || params[:email] == ""
         session["message"] = "try again" 
         @session = session
         redirect "user/signup" 
       elsif User.find_by(params)  
         @user = User.find_by(params) 
         session[:user_id] = @user.id
         redirect "user/#{@user.id}" 
       elsif  x = User.where(email: params[:email]) 
            unless x == [] 
            session.clear
            session["message"] = "email already used"
            @session = session
            redirect 'user/signup'
          else
          @user = User.create(params) 
          session[:user_id] = @user.id
          redirect "user/#{@user.id}" 
            end
    end
    end  
          get "/user/:id" do 
            session["page"] = "id"
          @session = session
          @all = User.all 
          
          @user = User.find(params[:id])
          erb :"/user/id"
    end  
          post '/user/signin' do  

          match = User.where(username: params["username"], password_digest: params["password_digest"])  
     if   match == []
          session["message"] = "try again" 
          @session = session
          redirect "/user/signin" 
     else  
          @user = match.first
          session[:user_id] = @user.id
          redirect "/user/#{@user.id}"
     end
     end
    
     
end