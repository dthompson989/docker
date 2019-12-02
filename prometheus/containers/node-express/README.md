# Commands to build:

$ docker run --rm -v $(pwd):/home/node -w /home/node node:11.1.0-alpine npm init -y 

$ docker run --rm -v $(pwd):/home/node -w /home/node node:11.1.0-alpine npm i -S express