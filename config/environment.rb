# require 'bundler'
# require 'rake'
# require 'active_record'
# Bundler.require

# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# require_all 'lib'

require 'bundler/setup'
require 'sinatra/activerecord'

Bundler.require

Dir[File.join(File.dirname(__FILE__), '../app/models', '*.rb')].each { |f| require f }

connection_details = YAML.safe_load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

# ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger = nil
require_all 'app'
