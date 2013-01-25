require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'test'
require File.join(File.dirname(__FILE__), '../environment.rb')
require "#{File.dirname(__FILE__)}/../lib/clog_api.rb"

class ClogAPITest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Clog::API::App
  end

  def setup
    MongoMapper.database.command(:dropDatabase => 1)
    # Create a sample project
    project_1 = Hash.new
    project_1["name"] = "test-project-1"
    project_1["user"] = "test-user"
    MongoMapper.database.collection("projects").insert(project_1)

    # Create another sample project
    project_2 = Hash.new
    project_2["name"] = "test-project-2"
    project_2["user"] = "test-user"
    project_2["tags"] = {"project-tag-1" => "project-tag-value-1", "project-tag-2" => "project-tag-value-2"}
    MongoMapper.database.collection("projects").insert(project_2)

  end

  def test_basic_log_message
    post '/users/test-user/projects/test-project-1/logs', :message => "log message"
    assert last_response.ok?
    message_hash =  MongoMapper.database.collection("test-user.test-project-1.logs").find_one
    assert_equal 'log message', message_hash["message"]
    assert_not_nil message_hash["created_at"]
  end
end