CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET ?= main

all: $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) $(CFLAGS) $^ -o $@
	rm -f $(TARGET).o
	./$(TARGET)
	rm -f $(TARGET)

$(TARGET).o: $(TARGET).c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean