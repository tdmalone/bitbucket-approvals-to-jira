
setup:
	python -m venv venv
	echo "\nA virtualenv has now been created. To install the app now, run 'make install'." && \
	echo "To cleanup, run 'make clean'."

check:
	if [ ! -f venv/bin/activate ]; then \
		echo "\nPlease run 'make setup' first, or otherwise create a virtualenv called 'venv'.\n" && exit 1; \
	fi

install: check
	. venv/bin/activate && \
	pip install -r requirements.txt -r requirements_dev.txt && \
	echo "\nApp installed. To run, execute 'make run'."

# :see: https://flask.palletsprojects.com/en/1.1.x/server
run: check
	. venv/bin/activate && \
	FLASK_APP=src/app.py \
	FLASK_ENV=develompent \
	FLASK_DEBUG=1 \
	flask run

lint: check
	. venv/bin/activate && \
	echo && \
	flake8 src --count --show-source

test: check
	. venv/bin/activate && \
	echo && \
	PYTHONPATH="$${PWD}/src:$${PYTHONPATH}" \
	pytest --verbose

coverage: check
	. venv/bin/activate && \
	echo && \
	PYTHONPATH="$${PWD}/src:$${PYTHONPATH}" \
	coverage run -m pytest && \
	coverage html && \
  open htmlcov/index.html

clean:
	rm -rf venv
