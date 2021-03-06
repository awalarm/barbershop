require 'rubygems'
require 'sinatra'
require 'sqlite3'

def is_barber_exists? db, name
  db.execute('select * from Barbers where name=?', [name]).length > 0
end

def seed_db db, barbers
  barbers.each do |barber|
    if !is_barber_exists? db, barber
      db.execute 'insert into Barbers (name) values (?)', [barber]
    end
  end
end

def get_db
  db = SQLite3::Database.new 'barbershop.db'
  db.results_as_hash = true
  return db
end

before do
  db = get_db
  @barbers = db.execute 'select * from Barbers'
end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT  EXISTS "Users"
  ("id" INTEGER PRIMARY KEY AUTOINCREMENT, 
   "username" TEXT,  
   "phone" TEXT,
   "date_time" TEXT, 
   "barber" TEXT, 
   "color" TEXT )'

   db.execute 'CREATE TABLE IF NOT  EXISTS "Barbers"
  ("id" INTEGER PRIMARY KEY AUTOINCREMENT, 
   "name" TEXT)'

   seed_db db, ['Иванова Анна', 'Караськана Людмила', 'Кулаков Петр'] 
end


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
  @datetime = params[:datetime]
  @color = params[:color]

  hh = {:username => 'Введите ваше имя.', :phone => 'Введите ваш телефон', :datetime => 'Ведите время записи'}

   # @error = hh.select {|key,_| params[key] == ''}.values.join(", ") это тоже самое что внизу
   # if @error != ''
   # return erb :visit
   # end

  hh.each do |key, value|

    if params[key] == '' #если параметр пустой
      # переменной error присвоит vulue по ключу key из хэша
      # т.е переменной error присвоить сообщение об ошибке
      # @error = hh.select {|key,_| params[key] == ''}.values.join(", ")
      @error = hh[key]
      return erb :visit
    end
  end

   db = get_db
   db.execute 'insert into 
   Users
   (username, 
      phone, 
      date_time,
      barber, 
      color
    ) 
    values (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]

  @message = "#{@username}, мы перезвоним вам для уточнения времени по телефону #{@phone}."
  erb :message
end

post '/contacts' do
  @email = params[:email]
  @message_contacts = params[:message_contacts]

  f = File.open("./public/contacts.txt", "a")
  f.write "e-mail клиента: #{@email},Сообщение: #{@message_contacts}\n"
  f.close

  @message = "Мы ответим Вам в ближайшее время."
  erb :message
end

get '/showusers' do
  db = get_db
  @results = db.execute 'select * from Users order by id desc'
  erb :showusers
end
