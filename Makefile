.PHONY: $(MAKECMDGOALS)

setup:
	bin/setup

server:
	bin/server

test:
	bin/verify
