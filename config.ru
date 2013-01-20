require 'rubygems'
require 'bundler/setup'

require File.join(File.dirname(__FILE__), 'environment')

require File.join(File.dirname(__FILE__), 'lib', 'clog_auth')
use Clog::Auth::Token

require File.join(File.dirname(__FILE__), 'lib', 'clog_api')
run Clog::API::App
