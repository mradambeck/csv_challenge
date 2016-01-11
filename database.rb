require 'pg'

# To setup database, from command line run:
# $ psql
# > DROP DATABASE IF EXISTS csv_challenge_sql_default;
# > CREATE DATABASE csv_challenge_sql_default;

# Environment Setup
ENV['DATABASE_URL'] = "csv_challenge_sql_default"

# Database Schema
conn = PG.connect(dbname: ENV['DATABASE_URL'])

# See postgresql column datatypes:
# http://www.postgresql.org/docs/9.5/static/datatype.html
conn.exec(
  "DROP TABLE IF EXISTS people;
   CREATE TABLE people (
      id                serial,
      first_name        varchar(40),
      last_name         varchar(40),
      middle_initial    varchar(1),
      gender            varchar(6),
      date_of_birth     date,
      favorite_color    varchar(40)
  )"
)

