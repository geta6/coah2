PID = tmp/.pid
PORT = 3000

NODE = node
GRUNT = ./node_modules/.bin/grunt
MOCHA = ./node_modules/.bin/mocha
BOWER = ./node_modules/.bin/bower
FOREMAN = bundle exec foreman

REPORTER = dot
MOCHA_OPTS = --colors --growl --bail --check-leaks

debug:
	@$(FOREMAN) start -p $(PORT) -f Procfile

start:
	@[[ ! -f $(PID) ]] && NODE_PID=$(PID) NODE_ENV=production  $(NODE) ./bin/www

start-dev:
	@[[ ! -f $(PID) ]] && NODE_PID=$(PID) NODE_ENV=development $(NODE) ./bin/www

quit:
	@[[ -f $(PID) ]] && kill -s QUIT `cat $(PID)` && sleep 1

stop:
	@[[ -f $(PID) ]] && kill -s TERM `cat $(PID)`

reload:
	@[[ -f $(PID) ]] && kill -s WINCH `cat $(PID)`

restart: quit start

build:
	@GRUNT_ENV=production  $(GRUNT)

build-dev:
	@GRUNT_ENV=development $(GRUNT)

test:
	@./node_modules/.bin/mocha \
		--compilers coffee:coffee-script/register \
		--reporter $(REPORTER) \
		--recursive test \
		$(MOCHA_OPTS)

setup:
	@bundle install --path=vendor/bundle && bundle update && bundle clean
	@npm install && npm prune && npm dedupe
	@$(BOWER) install && $(BOWER) prune

.PHONY: debug start start-dev quit stop reload restart build build-dev test setup

