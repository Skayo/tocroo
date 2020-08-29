# tocroo

> A simple CLI Todo List, built with Crystal and SQLite.

## Requirements
- libsqlite3-dev

> Versions used during development:
> - Crystal v0.35.1
> - Shards v0.11.1

## Installation

```console
foo@bar:~$ shards install
foo@bar:~$ shards build --release
```

After the build has *finished*, the binary can be found at `./bin/tocroo`.  
Add it to **PATH** to use it **globally**!

Before running the first time, you have to create the SQLite3 database.  
This can be achieved with:
```console
foo@bar:~$ tocroo init
[SUCCESS] Database created.
```

## Usage

```console
foo@bar:~$ tocroo add This is a task
[SUCCESS] Task added.

foo@bar:~$ tocroo list

TASKS
1       [ ]     This is a task  Sat Aug 29 00:58:51 2020

foo@bar:~$ tocroo update 1 This is a cool task
[SUCCESS] Task #1 updated.

foo@bar:~$ tocroo list

TASKS
1       [ ]     This is a cool task     Sat Aug 29 00:58:51 2020

foo@bar:~$ tocroo done 1
[SUCCESS] Task #1 completed.

foo@bar:~$ tocroo list --all

TASKS
1       [X]     This is a cool task     Sat Aug 29 00:58:51 2020

foo@bar:~$ tocroo delete 1
[SUCCESS] Task #1 deleted.
----- OR -----
foo@bar:~$ tocroo delete --all
[SUCCESS] All tasks deleted.

foo@bar:~$ tocroo list --all

TASKS
No tasks...
```


## Contributing

1. Fork it (<https://github.com/your-github-user/todolist/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Skayo](https://github.com/Skayo) - Creator and maintainer
