require "./config/environment"
require "./app/models/user"
class UserC < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

end
