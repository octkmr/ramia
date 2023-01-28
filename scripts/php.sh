#!/bin/sh

set -eu
#実行前にapiに移動する場合
#BASE_PATH=$(cd $(dirname $0)/../api && pwd)

# shellcheck disable=SC2086
# shellcheck disable=SC2046
cd $(dirname $(cd $(dirname $0); pwd))

CI_CMD=""
CONTAINER_CMD=""

# composer
if [ $1 = composer ]; then
  CONTAINER_CMD="cd /var/www && $*"

# artisan
elif [ $1 = artisan ]; then
  CONTAINER_CMD="cd /var/www && php $*"

# phpstan
elif [ $1 = phpstan ]; then
  if [ $# = 2 ] && [ $2 = --ci ]; then
    CI_CMD="vendor/bin/phpstan analyse --memory-limit=1G --configuration=phpstan.neon --error-format=checkstyle | cs2pr"
  else
    CONTAINER_CMD="cd /var/www && vendor/bin/phpstan analyse --memory-limit=1G --configuration=phpstan.neon"
  fi

# phpcs
elif [ $1 = phpcs ]; then
  if [ $# = 2 ] && [ $2 = --ci ]; then
    CI_CMD="vendor/bin/phpcs -q --standard=phpcs.xml --report=checkstyle | cs2pr"
  else
    CONTAINER_CMD="cd /var/www && vendor/bin/phpcs --standard=phpcs.xml"
  fi

# phpcbf
elif [ $1 = phpcbf ]; then
  CONTAINER_CMD="cd /var/www && vendor/bin/phpcbf"

# pint
elif [ $1 = pint ]; then
  CONTAINER_CMD="cd /var/www && vendor/bin/pint"

# phpunit
elif [ $1 = phpunit ]; then
  if [ $# = 2 ] && [ $2 = --ci ]; then
    CI_CMD="vendor/bin/phpunit --configuration=phpunit_ci.xml"
  else
    CONTAINER_CMD="cd /var/www && vendor/bin/phpunit --configuration=phpunit.xml"
  fi

# phpdbg
elif [ $1 = phpdbg ]; then
  if [ $# = 2 ] && [ $2 = --ci ]; then
    CI_CMD="phpdbg -qrr vendor/bin/phpunit --configuration=phpunit_ci.xml --coverage-html tests/coverage-result"
  else
    CONTAINER_CMD="cd /var/www && phpdbg -qrr vendor/bin/phpunit --configuration=phpunit.xml --coverage-html tests/coverage-result"
  fi

# coverage
elif [ $1 = coverage ]; then
    CONTAINER_CMD="cd /var/www && vendor/bin/phpunit --coverage-html coverage"
fi


# ローカルとCIで異なるコマンドを実行する
if [ -n "$CONTAINER_CMD" ]; then
  docker compose exec php bash -c "$CONTAINER_CMD"
elif [ -n "$CI_CMD" ]; then
  eval "$CI_CMD"
fi