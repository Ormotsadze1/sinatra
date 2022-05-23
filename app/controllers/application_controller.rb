require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ToDo secret"

    get "/" do
        erb :home
    end
    get "/Register" do
        erb :Register
    end
    get "/todolist" do
      erb :todolist
    end
    get "/Settings" do
      erb :Settings
    end
    helpers do
      def logged_in?
        !!session[:user_id]
      end

      def redirect_if_not_logged_in
        if !logged_in?
          redirect "/login?error=You have to be logged in to do that"
        end
      end

      def current_user
        User.find(session[:user_id])
      end
    end
  end
end