class Room
  attr_accessor :id, :title, :date_created, :price, :url
  @@rooms = []

  def self.all
    sql = <<-SQL
    SELECT * FROM rooms;
    SQL

    rows = DB[:connection].execute(sql)

    self.new_from_rows(rows)
  end

  def self.create_from_hash(hash)
    new_from_hash(hash).insert
  end

  def self.new_from_rows(rows)
    rows.collect do |row|
      self.new_from_db(row)
    end
  end

  def self.new_from_hash(hash)
    self.create_table
    room = self.new
    room.title = hash[:title]
    room.date_created = hash[:date_created]
    room.price = hash[:price]
    room.url = hash[:url]

    room
  end

  def insert
    @@rooms << self
    sql = <<-SQL
    INSERT INTO rooms (title, date_created, price, url) VALUES (?,?,?,?)
    SQL

    DB[:connection].execute(sql, self.title, self.date_created, self.price, self.url)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS rooms (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      date_created DATETIME,
      price TEXT,
      url TEXT
    )
    SQL

    DB[:connection].execute(sql)
  end

  def self.new_from_db(row)
    self.new.tap do |room|
      room.id = row[0]
      room.title = row[1]
      room.date_created =row[2]
      room.price =row[3]
      room.url =row[4]

      puts "#{row[0]}. #{row[1]},
      Price: #{row[3]}
      Find here: #{row[4]}
      Since: #{row[2]}"
    end
  end

  def self.by_price(order = "ASC")
    sql = <<-SQL
    SELECT * FROM rooms ORDER BY price #{order}
    SQL

    DB[:connection].execute(sql)
  end
end
