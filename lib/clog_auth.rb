module Clog
	module Auth
		class Token

		  def initialize(app)  
		    @app = app  
		  end  
		    
		  def call(env)
		  	
		  	return [401, {"Content-Type" => "text/html"}, ["Authorization token missing"]] if env["HTTP_AUTHORIZATION"].nil?
		  	return [401, {"Content-Type" => "text/html"}, ["Invalid authorization token"]] unless env["HTTP_AUTHORIZATION"].length == 33
		  	token = env["HTTP_AUTHORIZATION"][6..32]

		  	cursor = MongoMapper.database.collection("users").find(:tokens => {'$elemMatch' => {:value => token}})
		  	return [403, {"Content-Type" => "text/html"}, ["Unknown token"]] unless cursor.has_next?

		  	user = cursor.next
		  	return [500, {"Content-Type" => "text/html"}, ["Malformed user"]] if user["name"].nil?

		  	name = user["name"]
		  	env["PATH_INFO"] = "/users/#{name}"+env["PATH_INFO"]

		    @app.call(env)  
		  end  
		end
	end
end
