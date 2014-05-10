PID = tmp/.pid
PORT = 3000
CLUSTER = auto

NODE = node
GRUNT = ./node_modules/.bin/grunt
MOCHA = ./node_modules/.bin/mocha
BOWER = ./node_modules/.bin/bower
FOREMAN = bundle exec foreman

REPORTER = dot
MOCHA_OPTS = --colors --growl --bail --check-leaks

development:
	@NODE_ENV=development $(FOREMAN) start

production:
	@NODE_ENV=production $(GRUNT)
	@NODE_ENV=production $(FOREMAN) start web

start:
	@[[ ! -f $(PID) ]] && NODE_PID=$(PID) NODE_CLUSTER=$(CLUSTER) $(NODE) ./bin/www

quit:
	@[[ -f $(PID) ]] && kill -s QUIT `cat $(PID)` && sleep 1

stop:
	@[[ -f $(PID) ]] && kill -s TERM `cat $(PID)`

reload:
	@[[ -f $(PID) ]] && kill -s WINCH `cat $(PID)`

restart: quit start

build:
	@$(GRUNT)

test:
	@$(BOWER) install && $(BOWER) prune
	@NODE_ENV=production $(GRUNT)
	@NODE_ENV=production NODE_LOG=off $(MOCHA) \
		--compilers coffee:coffee-script/register \
		--reporter $(REPORTER) \
		--recursive test \
		$(MOCHA_OPTS)

setup:
	@echo "\n===> bundle install\n"
	@bundle install --path=vendor/bundle && bundle update && bundle clean
	@echo "\n===> npm install\n"
	@npm install && npm prune
	@echo "\n===> bower install\n"
	@$(BOWER) install && $(BOWER) prune

.PHONY: development production start quit stop reload restart build test setup

