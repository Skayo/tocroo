require "db"
require "sqlite3"
require "colorize"

require "../utils"

class Add
  def self.cmd(additional_args : Array(String))
    if additional_args.empty?
      STDERR.puts "#{"[ERROR]".colorize.red} Must set task title."
      exit(1)
    end

    unless dbExists()
      STDERR.puts "#{"[ERROR]".colorize.red} Run 'tocroo init' first!"
      exit(1)
    end

    title = additional_args.join(" ")

    DB.open "sqlite3://#{dbPath()}" do |db|
      db.exec "INSERT INTO todos(title, is_done) values(?, ?)", title, 0
      puts "#{"[SUCCESS]".colorize.green} Task added."
    end
  end
end
