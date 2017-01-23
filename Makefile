
default: sign-file

sign-file: sign-file.c
	clang -lcrypto -lssl -o sign-file -O3 sign-file.c

clean: 
	rm sign-file
