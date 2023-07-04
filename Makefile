up:
	docker-compose up -d

down:
	docker-compose down

build:
	docker-compose build

db-create:
	docker-compose run --rm web bundle exec rails db:create

migrate:
	docker-compose run --rm web bundle exec rails db:migrate

seed:
	docker-compose run --rm web bundle exec rails db:seed

migrate-reset:
	docker-compose run --rm web bundle exec rails db:migrate:reset

migration:
	docker-compose run --rm web bundle exec rails g migration $(name)

console:
	docker-compose run --rm web bundle exec rails c

routes:
	docker-compose run --rm web bundle exec rails routes
