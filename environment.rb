require 'mongo_mapper'

# Setup the connection to the db
environment = ENV["RACK_ENV"] || 'development'
config = YAML.load_file("#{File.dirname(__FILE__)}/config/mongodb.yml")
host = config[environment]["host"] || "127.0.0.1"
port = config[environment]["port"] || 27017
MongoMapper.connection = Mongo::Connection.new(host, port)

database = config[environment]["database"] || "clog"
MongoMapper.database = database

username = config[environment]["username"]
password = config[environment]["password"]
if username && password
	MongoMapper.database.authenticate(username, password)
end