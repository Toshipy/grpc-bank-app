postgres:
	docker run --name postgres-17 -p 5432:5432 -e POSTGRES_PASSWORD=password -d postgres:17-alpine

exec:
	docker exec -it postgres-17 psql -U postgres

createdb:
	docker exec -it postgres-17 createdb --username=postgres --owner=postgres grpc_bank

dropdb:
	docker exec -it postgres-17 dropdb --username=postgres grpc_bank

migrateup:
	migrate -path db/migration -database 'postgresql://postgres:password@localhost:5432/grpc_bank?sslmode=disable' -verbose up

migratedown:
	migrate -path db/migration -database 'postgresql://postgres:password@localhost:5432/grpc_bank?sslmode=disable' -verbose down

sqlc:
	sqlc generate

test:
	cd db/sqlc && go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test
