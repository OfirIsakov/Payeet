

rm *.pem

# 1. Generate private key and self signed certificate for the authorization server
echo "❌NOTE! REMOVE THE -nodes OPTION IN PRODUCTION❌"
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=IL/ST=Israel/L=North/O=payeetMaster/OU=payeetMaster/CN=localhost/emailAddress=payeet@payeetMaster.com"


echo "Authorization server self signed cretificate generated:"
openssl x509 -in ca-cert.pem -noout -text # Line prints the certificate
echo "----------------------"

# 2. Generate web server's private key and certificate signing request (CSR)
echo "❌NOTE! REMOVE THE -nodes OPTION IN PRODUCTION❌"
openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C=IL/ST=Israel/L=North/O=payeet/OU=payeet/CN=localhost/emailAddress=payeet@payeet.com"

# 3. Use authorization server's private key to sign web server's CSR and get back the signed certificate
openssl x509 -req -in server-req.pem -days 60 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf


echo "Server signed cretificate generated:"
openssl x509 -in ca-cert.pem -noout -text # Line prints the certificate
echo "----------------------"