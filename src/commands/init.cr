require "db"
require "sqlite3"

require "../utils"

class Init
  def self.cmd(force = false)
    databaseExists = dbExists()

    if !force && databaseExists
      STDERR.puts "#{"[ERROR]".colorize.red} Database file already exists! Use --force to force a recreation of the database."
      exit(1)
    end

    File.delete(dbPath()) if databaseExists

    DB.open "sqlite3://#{dbPath()}" do |db|
      db.exec "
        CREATE TABLE todos (
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          is_done INTEGER NOT NULL,
          created_at INTEGER DEFAULT (strftime('%s', 'now'))
        );
      "

      puts "#{"[SUCCESS]".colorize.green} Database created."
    end
  end
end
