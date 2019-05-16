require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'
require_relative 'db_saker.rb'

enable :sessions

db = SQLite3::Database.new('db/db.db')
db.results_as_hash = true

get('/') do
    index()
end

get('/register') do
    slim(:register)
end

post('/create') do
   create()
end

post('/login') do
    login()    
end

post('/logout') do
    session.destroy
    redirect('/')
end

post('/new_thread') do
    new_thread()
end

post('/reply/:threadId') do
    reply()
end

post('/delete_thread') do
    delete_thread()
end