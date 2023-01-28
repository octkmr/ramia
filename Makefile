.DEFAULT_GOAL := help
# 2つ目以降のパラメータを引数として取得
RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

.PHONY: initialize
initialize:
	sh ./scripts/initialize.sh

.PHONY: up
up:
	docker compose up api nginx postgres pgadmin minio

.PHONY: build
build:
	docker compose build --no-cache

.PHONY: artisan
artisan:
	sh ./scripts/php.sh artisan $(RUN_ARGS)

.PHONY: composer
composer:
	sh ./scripts/php.sh composer $(RUN_ARGS)

.PHONY: phpstan
phpstan:
	sh ./scripts/php.sh phpstan

.PHONY: phpcs
phpcs:
	sh ./scripts/php.sh phpcs

.PHONY: phpcbf
phpcbf:
	sh ./scripts/php.sh phpcbf

.PHONY: pint
pint:
	sh ./scripts/php.sh pint

.PHONY: phpunit
phpunit:
	sh ./scripts/php.sh phpunit

.PHONY: phpdbg
phpdbg:
	sh ./scripts/php.sh phpdbg

.PHONY: coverage
coverage:
	sh ./scripts/php.sh coverage

.PHONY: php_ci
php_ci:
	sh ./scripts/php.sh phpstan --ci
	sh ./scripts/php.sh phpcs --ci
	sh ./scripts/php.sh phpunit --ci

.PHONY: yarn
yarn:
	docker compose run --rm yarn $(RUN_ARGS)

# https://twitter.com/campintheair/status/363264235343605760
.PHONY: balse
balse:
	docker compose down --rmi all --volumes --remove-orphans

.PHONY: help
help:
	cat Makefile