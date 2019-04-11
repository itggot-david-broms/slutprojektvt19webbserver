require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'

db = SQLite3::Database.new('db/db.db')
db.results_as_hash = true

def create()
    db = SQLite3::Database.new('db/db.db')
    db.results_as_hash = true
    name = params["name"]
    email = params["email"]
    password = BCrypt::Password.create(params["pass"])
    db.execute('INSERT INTO users(Username, Password) VALUES(?, ?)', name, password) 
    redirect('/')
end

def login()
    db = SQLite3::Database.new('db/db.db')
    result = db.execute("SELECT Password FROM users WHERE Username =(?)", params["name"])
    if result[0] == nil
        redirect('/lolno')
    end
    not_password = result[0][0]
    if BCrypt::Password.new(not_password) == params["pass"]
        session[:loggedin] = true
        session[:user] = params["name"]
        redirect('/')
    else
        session[:loginfail] = true
        redirect('/')
    end
end

def new_thread()
    db = SQLite3::Database.new('db/db.db')
    opid = db.execute("SELECT UserId FROM users WHERE Username=(?)", session[:user])
    db.execute("INSERT INTO threads(Title, Description, OpId) VALUES(?, ?, ?)", params["title"], params["description"], opid)
    redirect('/')
end

# def posts()
#     db = SQLite3::Database.new('db/db.db')
#     db.results_as_hash = true
#     posts = db.execute()