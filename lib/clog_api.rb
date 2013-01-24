# If you're using bundler, you will need to add this
require 'sinatra'

Dir["#{File.dirname(__FILE__)}/../models/*.rb"].each {|f| require f }

module Clog
	module API
		class App < Sinatra::Base

			before do
			  if request.request_method == "POST" and request.content_type=="application/json"
			    body_parameters = request.body.read
			    parsed = body_parameters && body_parameters.length >= 2 ? JSON.parse(body_parameters) : nil
			    params.merge!(parsed)
			  end
			end

			# === LOGS ===
			post '/users/:user/projects/:project/logs' do

				project = Project.first(:name => params[:project], :user => params[:user])
				return 404 unless project
				project_hash= project.serializable_hash
				puts ""
				puts ""
				puts request.inspect
				project_tags = project_hash["tags"]

				message = LogMessage.new(params)
				message_hash = message.serializable_hash
				message_hash["tags"] = project_tags.merge(message_hash["tags"]) unless project_tags.nil?
				col = MongoMapper.database.collection("#{params[:user]}.#{params[:project]}.logs")
				col.insert(message_hash)
				#message.save!
			end

			# get '/users/:user/projects/:project/logs' do
				
			# end
			# === END LOGS ===

			# === PROJECTS ===
			post '/users/:user/projects' do
				project = Project.create(params)
				project.save!
			end

			put '/users/:user/projects/:project' do

			end

			get '/users/:user/projects' do
				projects = Project.all(:user => params[:user])
				projects.to_json
			end

			get '/users/:user/projects/:project' do
				project = Project.first(:user => params[:user], :name => params[:project])
				return 404 unless project

				project.to_json
			end

			# === END PROJECTS ===
		end
	end
end
