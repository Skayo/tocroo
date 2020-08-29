require "db"
require "sqlite3"
require "colorize"

require "../utils"

class Update
  def self.cmd(additional_args : Array(String))
    if additional_args.size < 2
      STDERR.puts "#{"[ERROR]".colorize.red} Must set task id and title."
      exit(1)
    end

    unless dbExists()
      STDERR.puts "#{"[ERROR]".colorize.red} Run 'tocroo init' first!"
      exit(1)
    end

    id = additional_args[0]
    title = additional_args[1..].join(" ")

    unless taskExists(id)
      STDERR.puts "#{"[ERROR]".colorize.red} Task #{"##{id}".colorize.yellow} not found!"
      exit(1)
    end

    DB.open "sqlite3://#{dbPath()}" do |db|
      db.exec "UPDATE todos SET title = ? WHERE id = ?", title, id
      puts "#{"[SUCCESS]".colorize.green} Task #{"##{id}".colorize.yellow} updated."
    end
  end
end
