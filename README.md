# Payeet


## Setup:


* create a config file:

```
PORT= 6969
ACCESS_TOKEN_KEY= <SECRET>
REFRESH_TOKEN_KEY= <SECRET>
ACCESS_TOKEN_DURATION= 10m
REFRESH_TOKEN_DURATION = 24h 

CONNECTION_STRING= ''
DB_NAME= <name>
TRANSACTION_COLLECTION= <name>
USER_COLLECTION= <name>
```


## How to run:

```
go run server.go
```

```
evans -rp 6969
```