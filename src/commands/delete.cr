require "db"
require "sqlite3"
require "colorize"

require "../utils"

class Delete
  def self.cmd(additional_args : Array(String), all = false)
    unless dbExists()
      STDERR.puts "#{"[ERROR]".colorize.red} Run 'tocroo init' first!"
      exit(1)
    end

    id = ""
    if additional_args.size == 1
      id = additional_args[0]

      unless taskExists(id)
        STDERR.puts "#{"[ERROR]".colorize.red} Task #{"##{id}".colorize.yellow} not found!"
        exit(1)
      end
    end

    DB.open "sqlite3://#{dbPath()}" do |db|
      if all
        db.exec "DELETE FROM todos"
        puts "#{"[SUCCESS]".colorize.green} All tasks deleted."
      else
        db.exec "DELETE FROM todos WHERE id = ?", id
        puts "#{"[SUCCESS]".colorize.green} Task #{"##{id}".colorize.yellow} deleted."
      end
    end
  end
end
