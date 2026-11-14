# Student Database

Projects completed for the freeCodeCamp Relational Database curriculum.

## Contents

- `part-1/` - Student database SQL dump
- `part-2/` - Student database SQL dump, query script, and validation script

The two supplied SQL exports are identical and are kept in both folders because
each project expects its own database dump. Part 2 also includes
`student_info.sh`, which runs the required PostgreSQL queries against the
`students` database.

## Requirements

- PostgreSQL with the `psql` command available in your `PATH`
- Bash
- A database restored from `part-2/students.sql`

The dump creates a database named `students` and expects the PostgreSQL role
`freecodecamp`. To restore it from a shell with permission to create databases:

```bash
psql --username=freecodecamp --file=part-2/students.sql
```

## Running Part 2

```bash
chmod +x part-2/student_info.sh part-2/validate_database.sh
./part-2/validate_database.sh
./part-2/student_info.sh
```

By default, the scripts connect as `freecodecamp` to the `students` database.
Use `PSQL_USER` and `PSQL_DB` when your local PostgreSQL setup uses different
names:

```bash
PSQL_USER=myuser PSQL_DB=students ./part-2/student_info.sh
```
