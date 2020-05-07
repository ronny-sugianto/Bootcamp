package config

type Configurations struct {
	DbDialect string `mapstructure:"db_dialect"`
	DbSource  string `mapstructure:"db_source"`
}
