CC=processing-java
TARGET=donut

all:
	$(CC) --sketch=$(shell pwd)/$(TARGET) --run
