start_db:
	rails db:create db:migrate

run:
	rails s

run_react_yarn_with_clone:
	git clone 'https://github.com/mariacastro96/contacts-react.git' ~/mariacastro_frontend
	yarn --cwd ~/mariacastro_frontend/ install
	yarn --cwd ~/mariacastro_frontend/ start

run_react_yarn_after_clone:
	yarn --cwd ~/mariacastro_frontend/ start
