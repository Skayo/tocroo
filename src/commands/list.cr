require "db"
require "sqlite3"
require "colorize"

require "../utils"

class List
  private def self.checkbox(is_done : Int64) : String
    return is_done == 0 ? "[ ]".colorize.red.to_s : "[X]".colorize.green.to_s
  end

  private def self.date(timestamp : Int64) : String
    return Time.unix(timestamp).to_s("%c").colorize.blue.to_s
  end

  def self.cmd(all = false)
    unless dbExists()
      STDERR.puts "#{"[ERROR]".colorize.red} Run 'tocroo init' first!"
      exit(1)
    end

    listQuery = all ? "SELECT id, title, is_done, created_at FROM todos" : "SELECT id, title, is_done, created_at FROM todos WHERE is_done = 0"

    DB.open "sqlite3://#{dbPath()}" do |db|
      puts
      puts "TASKS".colorize.cyan

      count = 0
      db.query_each listQuery do |rs|
        count += 1
        id, title, is_done, created_at = rs.read(Int64, String, Int64, Int64)
        puts "#{id.colorize.yellow}\t#{checkbox(is_done)}\t#{title.colorize.white}\t#{date(created_at)}"
      end

      puts "No tasks..." if count == 0

      puts
    end
  end
end
