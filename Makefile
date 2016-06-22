docker:
	sudo docker build --rm --tag workout .


# Install does not rebuild the docker image
install:
	sudo cp etc/cron /etc/cron.d/workout-bot
	sudo cp bin/* /opt/workout/bin

