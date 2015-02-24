require 'sqlite3'

class DBManager
	
	def initialize
		begin
			@db = SQLite3::Database.new("test.db")
			self.create_table
		rescue# TODO テーブルの存在チェックを行ってあったら処理しない
			puts "すでにテーブルが存在します"
		end
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
