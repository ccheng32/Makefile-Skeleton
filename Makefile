# name of compiled binary
BIN=hello
CODE_STYLE=google

# specify directories
LOCAL=$(HOME)/local/
SRC_DIR=src/
INC_DIR=include/
OBJ_DIR=.obj/

# some on-off flags
DEBUG=n
OPENMP=y

# libs and includes
INCLUDE=-I$(LOCAL)include/ -I$(INC_DIR)
LIB=-L$(LOCAL)lib/

# specify the objects required for building
OBJ_IDT=$(OBJ_DIR)/.idt
OBJ=$(OBJ_DIR)/main.o\
    $(OBJ_DIR)/print_hello.o

# specify compiler
CXX=g++-8

# construct flags based on options
ifeq ($(OPENMP), y)
	OMPFLAG=-fopenmp
endif

ifeq ($(DEBUG), n)
	DEBUGFLAG=-O3
else 
	DEBUGFLAG=-O0 -g
endif

CXXFLAGS= $(OMPFLAG) $(DEBUGFLAG) -Wall -std=c++11

# code formatter and its options
FORMAT=clang-format
FORMAT_FLAGS=-i --style=$(CODE_STYLE) 

# Makefile rules
all: $(BIN) 

$(BIN): $(OBJ)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(INCLUDE) $(LIB)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(OBJ_IDT)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCLUDE)

$(OBJ_IDT):
	mkdir -p $(OBJ_DIR)
	touch $@

clean:
	rm -rf $(OBJ_DIR) $(BIN) 

format:
	$(FORMAT) $(FORMAT_FLAGS)  \
		$(SRC_DIR)/*       \
		$(INC_DIR)/*
