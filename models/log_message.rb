class LogMessage
	include MongoMapper::Document

	attr_accessible :message, :ts, :tags

	#key :user,     String
	#key :project,  String
	key :message,  String
	key :ts,       Integer

	timestamps!
end