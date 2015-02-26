require 'sqlite3'

class DBManager
	
	def initialize
			@db = SQLite3::Database.new("test.db")
     table_count =  @db.execute("SELECT count(*) From sqlite_master WHERE type == 'table' AND tbl_name == 'test_table'").flatten
     create_table if table_count.first == 0
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

  #TODO 件数が増えた時に全部取得していたら問題があるので修正する必要がある
  def record?(url)
    all_record = @db.execute("SELECT event_url from test_table;")
    return all_record.flatten.include?(url)
	end

  def transaction
		@db.transaction
	end

	def commit
		@db.commit
	end
end
