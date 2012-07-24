require 'modeleevee'

# clear former remnants of database
if(File.exists?(File.dirname(__FILE__) + '/support/test.sqlite3')) then
  begin
    File.delete(File.dirname(__FILE__) + '/support/test.sqlite3')
  rescue
    abort "The database file exists but is not deletable by Ruby. See to it that the permissions on this file permit this operation?"
  end
end

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3', 
  :database => File.dirname(__FILE__) + '/support/test.sqlite3')

load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'
load File.dirname(__FILE__) + '/support/data.rb'
