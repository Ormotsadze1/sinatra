class UsersController < ApplicationController

    get '/Register' do
      if !session[:id]
        erb :Register
      else
        erb :home
      end
    end
  
    post "/Register" do
      if params[:name] == "" || params[:email] =="" || params[:password] == ""
        redirect to "/Register"
      else
        @user = User.create(:name => params[:name], :email => params[:email], :password => params[:password])
        session[:user_id] = @user.id
        redirect to "/home"
      end
    end
    get '/log_in' do
        if logged_in?
          redirect '/todolist'
        else
          erb :home
        end
      end
    
      post '/log_in' do
        @user = User.find_by(:email => params[:email])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect '/todolist'
        else
          redirect '/log_in'
        end
      end
      get '/log_out' do
        session.destroy
        redirect to '/'
      end
  
    get '/home' do
      erb :home
    end
  end