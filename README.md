
<br/>
<div align="center">
    <a href="https://www.payeet.xyz/" target="_blank">
        <img width="15%" src="https://cdn.discordapp.com/attachments/588014716144713739/824213026545991720/logo.svg" alt="Payeet logo">
        <img width="25%" src="https://cdn.discordapp.com/attachments/588014716144713739/824215178471407646/payeet-full.png" alt="Payeet logo">
    </a>
</div>

<br/>


<div align="center">
At the core Payeet is a system for transferring points made as Magsihim project.
<br>
but as the project grew we have added more and more features.
</div>


## ✨ Features

* authentication and authorization system built with gRPC and JWT with mail verfication.
* login from a new deivce alert 
* transfring points 
* friends/followers 
* TLS/SSL encryption 
* and more.. 

## 🖥 Technology stack

### made using

* Go
* MongoDB
* gRPC
* Flutter

## 📱 App screen flow
* The app is made to look like a mix between a social network and a bank. 
<br>
<img width="30%" src="https://cdn.discordapp.com/attachments/588014716144713739/824256107631214652/screen_flow2.svg" alt="screen flow"> <br> click to view in full </br> </img>








## 🚀 Setup:

* create a config file


#### run these commands:
###### In the server folder run:
```
go run server.go
```

or run `go build`
and run it with pm2

###### In the app folder run
```
flutter run
```

<img width="60%" src="https://cdn.discordapp.com/attachments/588014716144713739/824266399391285348/running_the_server.png" alt="running the server">


## 🛠 Config:

the port that the server is running on.
```
PORT=6969
```
the port and server ip should also be changed in `globals.dart`.


Validation of tokens:

```
ACCESS_TOKEN_KEY= <SECRET>
REFRESH_TOKEN_KEY= <SECRET>
ACCESS_TOKEN_DURATION= 10m
REFRESH_TOKEN_DURATION= 24h
```


Database setup:
```
CONNECTION_STRING=
DB_NAME=<name>
USER_COLLECTION=<name>
TRANSACTION_COLLECTION=<name>
LOGS_COLLECTION=<name>
```


Email and password for the mailing service
```
SYSTEM_EMAIL= <SECRET>
SYSTEM_EMAIL_PASSWORD= <SECRET>
```

Karma and point calcuation:
```
BASE_DAILY_BONUS= 100
STREAK_DAILY_BONUS= 0.1
KARMA_MINIMUM_REQUIRED_TRANSFER_DAYS= 3
KARMA_MINIMUM_REQUIRED_TRANSFER_AMOUNT= 1500
KARMA_MULTIPLIER_FACTOR= 0.1
KARMA_MINIMUM_REQUIRED_UNIQUE_USERS= 3
KARMA_MAXIMUM_TRANSFERS_TO_SAME_USER= 3
```



Full config:
```
PORT=6969
ACCESS_TOKEN_KEY=<SECRET>
REFRESH_TOKEN_KEY=<SECRET>
ACCESS_TOKEN_DURATION=10m
REFRESH_TOKEN_DURATION=24h
CONNECTION_STRING=
DB_NAME=<name>
USER_COLLECTION=<name>
TRANSACTION_COLLECTION=<name>
LOGS_COLLECTION=<name>
BASE_DAILY_BONUS= 100
STREAK_DAILY_BONUS= 0.1
KARMA_MINIMUM_REQUIRED_TRANSFER_DAYS= 3
KARMA_MINIMUM_REQUIRED_TRANSFER_AMOUNT= 1500
KARMA_MULTIPLIER_FACTOR= 0.1
KARMA_MINIMUM_REQUIRED_UNIQUE_USERS= 3
KARMA_MAXIMUM_TRANSFERS_TO_SAME_USER= 3
SYSTEM_EMAIL= <SECRET>
SYSTEM_EMAIL_PASSWORD= <SECRET>
```




