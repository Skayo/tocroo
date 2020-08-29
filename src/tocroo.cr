require "option_parser"
require "colorize"

require "./commands/*"
require "./utils"

enum Command : UInt8
  None
  Init
  Add
  Update
  List
  Done
  Delete
end

action = Command::None
force = false
all = false
additional_args = [] of String

parser = OptionParser.new do |parser|
  parser.banner = "tocroo - A simple CLI Todo List, built with Crystal and SQLite."

  parser.on "-h", "--help", "Show this help message and exit." do
    puts parser
    exit
  end

  parser.on "init", "Initialize SQLite database" do
    action = Command::Init
    parser.on("-f", "--force", "Force initialize even if database already existed.") { force = true }
  end

  parser.on "add", "Add task" do
    action = Command::Add
  end

  parser.on "update", "Update task" do
    action = Command::Update
  end

  parser.on "list", "Show all tasks" do
    action = Command::List
    parser.on("-a", "--all", "List all tasks.") { all = true }
  end

  parser.on "done", "Mark a task as done" do
    action = Command::Done
  end

  parser.on "delete", "Delete task" do
    action = Command::Delete
    parser.on("-a", "--all", "Delete all tasks.") { all = true }
  end

  parser.invalid_option do |option_flag|
    STDERR.puts "#{"[ERROR]".colorize.red} Invalid Option: #{option_flag}"
    STDERR.puts parser
    exit(1)
  end

  parser.unknown_args do |unknown_args|
    additional_args = unknown_args
  end
end

parser.parse

case action
when Command::Init
  Init.cmd(force)
when Command::Add
  Add.cmd(additional_args)
when Command::Update
  Update.cmd(additional_args)
when Command::List
  List.cmd(all)
when Command::Done
  Done.cmd(additional_args)
when Command::Delete
  Delete.cmd(additional_args, all)
else
  puts parser
  exit(1)
end
