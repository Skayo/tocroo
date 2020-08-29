require "db"
require "sqlite3"

def dbPath : Path
  return Path.new(Path.home, ".tocroo.db")
end

def dbExists : Bool
  return File.exists?(dbPath())
end

def taskExists(id : String | Int64) : Bool
  DB.open "sqlite3://#{dbPath()}" do |db|
    results = db.scalar "SELECT COUNT(*) FROM todos WHERE id = ?", id

    return results != 0
  end
end
