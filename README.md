# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version
  2.6.6

- Setup

  - bundle install
  - rails db:create db:migrate OR make start_db
  - rails s (it will start with port 3001) OR make run

- Run react app from makefile
  - in another tab run
    - make run_react_yarn_with_clone (1st time)
      - this command will clone the repo to dir ~/mariacastro_frontend
      - AND will run yarn install
      - AND will run yarn start (start server)
    - make run_react_yarn_after_clone (after 1st time)
      - this command will run yarn start (start server)
