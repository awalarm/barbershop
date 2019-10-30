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
  @color = params[:color]

  hh = {:username => 'Введите ваше имя.', :phone => 'Введите ваш телефон'}

  hh.each do |key, value|

    if params[key] == '' #если параметр пустой
      # переменной error присвоит vulue по ключу key из хэша
      # т.е переменной error присвоить сообщение об ошибке
      @error = hh[key]
      return erb :visit
    end
  end

  f = File.open("./public/users.txt", "a")
  f.write "Имя клиента: #{@username},Телефон: #{@phone}, Мастер: #{@barber}, Цает краски: #{@color}\n"
  f.close

  @message = "#{@username}, мы перезвоним вам для уточнения времени по телефону #{@phone}."
  erb :message
end

# get '/public/users.txt' do
#   @message = "Кто хочет записаться на стрижку."
#   f = File.foreach("./public/users.txt") { |line|  }
#   puts line
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


