package main

type Configuration struct {
	DbDialect string `mapstructure: "db_dialect"`
	DbSource string `mapstructure: "db_source"`
}