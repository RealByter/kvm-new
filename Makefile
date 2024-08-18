CC = gcc
CFLAGS = -Wall -g -Iinclude
LDFLAGS = 

SRCS = $(wildcard src/*.c)
OBJS = $(SRCS:src/%.c=build/%.o)

DISK_IMAGE = os.iso
TARGET = vmm

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(LDFLAGS)

build/%.o: src/%.c
	@mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@

all: $(TARGET)	

run: $(DISK_IMAGE) $(TARGET)
	(cd kernel && make all)
	./$(TARGET) kernel.elf

clean:
	rm -rf build $(TARGET)