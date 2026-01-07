CC := gcc
CFLAGS := -std=c11 -Wall -Wextra -Wpedantic -O2 -Iinclude
LDFLAGS :=

BUILD_DIR := build
OBJ_DIR := $(BUILD_DIR)/obj
BIN_DIR := $(BUILD_DIR)/bin

TARGET := $(BIN_DIR)/tic_tac_toe

SRC := $(wildcard src/*.c)
OBJ := $(patsubst src/%.c,$(OBJ_DIR)/%.o,$(SRC))
DEP := $(OBJ:.o=.d)

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJ) | $(BIN_DIR)
	$(CC) $(OBJ) -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: src/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

-include $(DEP)

run: all
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)
