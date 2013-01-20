require 'mongo_mapper'

# Setup the connection to the db
config = YAML.load_file("#{File.dirname(__FILE__)}/config/config.yml")
host = config["mongodb"]["host"] || "127.0.0.1"
port = config["mongodb"]["port"] || 27017
MongoMapper.connection = Mongo::Connection.new(host, port)

database = config["mongodb"]["database"] || "clog"
MongoMapper.database = database

username = config["mongodb"]["username"]
password = config["mongodb"]["password"]
if username && password
	MongoMapper.database.authenticate(username, password)
end