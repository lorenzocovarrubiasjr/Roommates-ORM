require 'bundler'
Bundler.require
require 'active_record'

require_all 'lib'
require 'open-uri'
require 'active_support/core_ext/object/inclusion'

DB = {
  :connection => SQLite3::Database.new("db/rooms-development.sqlite")
}

#ActiveRecord::Base.establish_connection(
#  :adapter => "sqlite3",
#  :database => "db/rooms-development.sqlite"
#)
