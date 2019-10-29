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
