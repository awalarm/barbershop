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
  @barber = params[:barber]

  f = File.open("./public/users.txt", "a")
  f.write "Имя клиента: #{@username},Телефон: #{@phone}, Мастер: #{@barber}\n"
  f.close

  @message = "#{@username}, мы перезвоним вам для уточнения времени по телефону #{@phone}."
  erb :message
end

# get '/public' do
#   erb :public
# end

post '/contacts' do
  @email = params[:email]
  @message_contacts = params[:message_contacts]

  f = File.open("./public/contacts.txt", "a")
  f.write "e-mail клиента: #{@email},Сообщение: #{@message_contacts}\n"
  f.close

  @message = "Мы ответим Вам в ближайшее время."
  erb :message
end


