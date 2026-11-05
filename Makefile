CC = gcc
CFLAGS = -Wall -Wextra -O2 -Iinclude -MMD -MP

SRCS = src/main.c src/add.c src/sub.c src/utility/stats.c
OBJS = build/main.o build/add.o build/sub.o build/utility/stats.o

.PHONY: all clean test

all: build/prog

build/prog: $(OBJS) | build
	$(CC) $(CFLAGS) $^ -o $@

build/%.o: src/%.c | build
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

build/utility/%.o: src/utility/%.c | build
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

build:
	mkdir -p build

-include $(OBJS:.o=.d)

test: build.prog
	./tests/test.sh

clean:
	rm -rf build
