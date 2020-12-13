@echo off
echo Compiling go
echo ----------------
rem protoc --proto_path=. --proto_path=third_party --gogo_out=plugins=grpc:go payeet.proto

protoc --go_out=plugins=grpc:go payeet.proto

echo Compiling dart
echo ----------------
protoc --dart_out=grpc:dart  --proto_path=. -I . payeet.proto