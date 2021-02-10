run:
	rails s

run_react:
	git clone 'https://github.com/mariacastro96/contacts-react.git' ~/mariacastro_frontend
	yarn --cwd ~/mariacastro_frontend/ install
	yarn --cwd ~/mariacastro_frontend/ start