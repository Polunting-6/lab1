CC = gcc
CFLAGS = -Wall -Wextra -O2 -Iinclude

SRCS = src/main.c src/add.c src/sub.c src/utility/stats.c
OBJS = build/main.o build/add.o build/sub.o build/utility/stats.o

all: build/prog

build/prog: $(OBJS)
	@mkdir -p build
	$(CC) $(CFLAGS) $^ -o $@

build/%.o: src/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf build
