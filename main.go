package main

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"

	"github.com/lghartmann/go-simple-bank/api"
	db "github.com/lghartmann/go-simple-bank/db/sqlc"
	"github.com/lghartmann/go-simple-bank/util"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("Unable to load config:", err)
	}

	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Cannot connect to DB:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("Unable to start server:", err)
	}
}
