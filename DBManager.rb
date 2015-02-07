require 'sqlite3'

class DBManager
	
	def initialize
		@db = SQLite3::Database.new("test.db")
		self.create_table
	end

	def create_table
		create_table_sql = <<SQL
CREATE TABLE test_table(
  event_url text,
  title text,
  description text);
SQL
		@db.execute(create_table_sql)
	end

	def insert_table(event_url, title, description)
		@db.execute("INSERT INTO test_table(event_url, title, description) VALUES('#{event_url}', '#{title}','#{description}');")
	end

	def transaction
		@db.transaction
	end

	def commit
		@db.commit
	end
end