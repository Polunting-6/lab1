CC = gcc
CFLAGS = -Wall -Wextra -O2 -Iinclude -MMD -MP

SRCS = src/main.c src/add.c src/sub.c src/utility/stats.c src/mul.c
OBJS = build/main.o build/add.o build/sub.o build/utility/stats.o build/mul.o

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

build/mul.o: src/mul.c include/mul.h

src/mul.c include/mul.h &: build/genmul
	./build/genmul

build/genmul: tools/genmul.c | build
	$(CC) $(CFLAGS) $< -o $@

build:
	mkdir -p build

-include $(OBJS:.o=.d)

test: build/prog
	./tests/test.sh

clean:
	rm -rf build
	rm -f src/mul.c include/mul.h
