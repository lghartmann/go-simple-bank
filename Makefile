postgres:
	docker run --name go-simple-bank -p 5432:5432 -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=root -d postgres

createdb:
	docker exec -it go-simple-bank createdb --username=root --owner=root simple_bank

dropdb: 
	docker exec -it go-simple-bank dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

server:
	go run main.go

.PHONY:
	postgres createdb dropdb migrateup migratedown