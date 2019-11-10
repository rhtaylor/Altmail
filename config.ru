require './config/environment'

use Rack::MethodOverride
#use Rack::Session::Cookie 
use MessageController
run UserController