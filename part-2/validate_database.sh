#!/bin/bash
set -euo pipefail

PSQL_USER="${PSQL_USER:-freecodecamp}"
PSQL_DB="${PSQL_DB:-students}"

if ! command -v psql >/dev/null 2>&1; then
  echo "Error: psql is required but was not found in PATH." >&2
  exit 1
fi

PSQL=(psql -X --username="$PSQL_USER" --dbname="$PSQL_DB" --no-align --tuples-only -c)
required_tables=(courses majors majors_courses students)

for table in "${required_tables[@]}"; do
  exists="$("${PSQL[@]}" "SELECT to_regclass('public.$table') IS NOT NULL")"
  if [[ "$exists" != "t" ]]; then
    echo "Error: required table '$table' was not found in database '$PSQL_DB'." >&2
    exit 1
  fi
done

student_count="$("${PSQL[@]}" "SELECT COUNT(*) FROM students")"
course_count="$("${PSQL[@]}" "SELECT COUNT(*) FROM courses")"
major_count="$("${PSQL[@]}" "SELECT COUNT(*) FROM majors")"

if (( student_count == 0 || course_count == 0 || major_count == 0 )); then
  echo "Error: the database tables exist, but required data is missing." >&2
  exit 1
fi

printf 'Database validation passed: %s students, %s courses, %s majors.\n' \
  "$student_count" "$course_count" "$major_count"
