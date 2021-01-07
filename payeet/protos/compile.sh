echo Compiling go
echo ----------------

protoc --go_out=plugins=grpc:go payeet.proto

echo Compiling dart
echo ----------------
protoc --dart_out=grpc:dart  --proto_path=. -I . payeet.proto