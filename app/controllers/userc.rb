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
        session["message"] = ''
        session[:page] = "signin"
        @session = session      
        erb :'user/signin'
       
    end  
    get '/user/signup' do
      session[:page] = "signup"
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
      
     
      @user = User.find_by(id: session["user_id"])
       
      @messages = Message.all.where(user_id: session["user_id"])

         
      @all = User.all 
      erb :"/user/id"
    end
  get '/user/:id/sent_all' do 
        session["page"] = "all"
        @user = User.find(params[:id])
        @user.id 
        @messages = Message.where(user_id: @user.id) 
        
        @session = session
        erb :"/user/sent_all" 
  end
      
  post  '/user/signup' do 
        
          
      if params[:password] == "" || params[:username] == "" || params[:email] == ""
         session["message"] = "try again" 
         @session = session
        erb :"user/signup" 
      elsif User.find_by(username: params["username"], email: params["email"])   
        
            @user = User.find_by(username: params["username"], email: params["email"]) 
            @user.authenticate(params["password"]) 
            session["error"] = "user already exists, sign in"
            @session = session
            erb :"/user/signin"  
      
      elsif  User.find_by(email: params[:email]) 
            session["message"] = "email already used"
            @session = session 
            redirect 'user/signup'
      elsif  User.find_by(username: params[:username]) 
              
               session["message"] = "username already taken" 
              @session = session
              erb :'user/signup'
      elsif
              new_params = {username: params["username"], email: params["email"], password: params["password"], password_confirmation: params["password_confirmation"] }
          
              @user = User.create(new_params) 
              if @user.try(:id) == nil 
                  session['message'] = "passwords don't match"
                  session['page'] = 'signup'
                  @session = session
                  erb :'user/signup'
              else
              @yes = @user.try(:id) 
           
              session[:user_id] = @user.id
              redirect "user/#{@user.id}"  
              end
      end     
  end
    get   "/user/:id" do 
            session["page"] = "id" 
            session.delete(:message)
            @session = session
            @all = User.all 
          
             @user = User.find(params[:id])
          erb :"/user/id"
    end  
  post '/user/signin' do   
         params["username"] == "" || params["password"] == '' ? (redirect '/user/signin') : 
         user_package = User.where(username: params["username"])
     if user_package == [] 
          session["error"] = "try again" 
          @session = session
          
          redirect "/user/signin" 
        else user = user_package.first 
             if user.authenticate(params["password"]) 
          
      
              @user = user
              session[:user_id] = @user.id
              redirect "/user/#{@user.id}"
             else  
              session["error"] = "incorrect password"
              @session = session
              erb :'/user/signin'
             end
    end 
  end 
end