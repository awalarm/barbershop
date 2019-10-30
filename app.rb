require 'rubygems'
require 'sinatra'

get '/' do
  erb 'что писать?'
end

get '/contacts' do
  erb :contacts
end

get '/visit' do
  erb :visit
end

post '/visit' do
  @username = params[:username]
  @phone = params[:phone]

  f = File.open("./public/users.txt", "a")
  f.write "Имя клиента: #{@username},Телефон: #{@phone}\n"
  f.close

  @message = "#{@username}, мы перезвонил вам для уточнения времени по телефону #{@phone}."
  erb :message
end


