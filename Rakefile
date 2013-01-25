require 'rubygems'
require 'bundler/setup'
require 'rake'
require 'rake/testtask'

namespace "user" do

	desc "Create a user with a random access token"
	task :create, [:name] => [:environment] do |t, args|
		user = Hash.new
		user["name"] = args.name
		user["tokens"] = Array.new
		token_value = random_string(27)
		user["tokens"] << {:name => "admin", :value => token_value}
		MongoMapper.database.collection("users").insert(user)
		puts "Generated user #{args.name} with admin token: #{token_value}"
	end
end

desc "Run basic tests"
Rake::TestTask.new("test") { |t|
  t.pattern = 'test/*_test.rb'
}

task :environment do |t|
	require File.join(File.dirname(__FILE__), 'environment')
end

def random_string(length=10)
  chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+-=_'
  password = ''
  length.times { password << chars[rand(chars.size)] }
  password
end