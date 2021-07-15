find . -name '*.pem' | xargs -i sh -c "echo -- {} ; openssl x509 -in {}  -text | sed \"s,^,{} : ,\"" | tee /dev/shm/pem-$(basename $(pwd)) | less
