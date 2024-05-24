VERSION ?= test
NAME ?= kinect
build:
	sudo docker build --no-cache -t $(NAME):$(VERSION) .
run:
	sudo docker run --rm $(NAME):$(VERSION)
start:
	sudo docker start -t $(NAME):$(VERSION) .
stop:
	sudo docker start -t $(NAME):$(VERSION) .