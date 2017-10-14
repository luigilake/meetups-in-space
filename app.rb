require 'sinatra'
require 'sinatra/activerecord'
require 'pry'
require_relative 'config/application'
require_relative 'app/models/meetup'
require_relative 'app/models/attendee'
require_relative 'app/models/user'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all
  # list of meetups must be shown ALPHABETICALLY, all link to an individual show page
  # button to create a new meetups page that has a form.
  erb :'meetups/index'
end

get '/meetups/new' do
  # form to create a new meetup.
  # requires a name, location, and description (and timestamp?)
  # user must be signed in to create meetup
  erb :'meetups/new'
end


get '/meetups/:id' do
  # includes the name, description, location, and creator of the meetup. attendees must also be shown, with their avatar and username
  @id = params[:id]
  @current_meetup = Meetup.find(@id)
  @host = User.find(@current_meetup.host)
  meetup = Meetup.find(@id)
  @attendees = meetup.users
  # if signed in, user should be able to click 'join' else, warning to sign in
  # notification to say if user has joined or not
  erb :'meetups/show'
end

post '/meetups/join_meetup' do
  if !current_user
    @id = params[:id]
    @current_meetup = Meetup.find(@id)
    @host = User.find(@current_meetup.host)
    meetup = Meetup.find(@id)
    @attendees = meetup.users
    @error = "PLEASE SIGN IN"
    erb :"/meetups/show"
  else
    @id = params[:id]
    @current_meetup = Meetup.find(@id)
    Attendee.create(user: current_user, meetup: @current_meetup)
    redirect "/meetups/#{@id}"
  end
end

post '/meetups/new' do
  @meetup_name = params[:name]
  @meetup_description = params[:description]
  @meetup_location = params[:location]
  @error

  if current_user == nil
    @error = "PLEASE SIGN IN"
    erb :'meetups/new'
  elsif @meetup_name == '' || @meetup_description == '' || @meetup_location == ''
    @error = "Please fill out all fields"
    erb :'meetups/new'
  else
  # else, remain on the form page with errors and pre-filled inputs.
  new_meetup = Meetup.create(name: @meetup_name, description: @meetup_description, location: @meetup_location, host: current_user.id.to_i)
  # if created meetup is successful, should redirect to the new meetup's showpage
  redirect "/meetups/#{new_meetup.id}"
  end
end
