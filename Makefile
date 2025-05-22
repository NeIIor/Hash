CXX = g++
NASM = nasm

COMMON_FLAGS = -g -std=c++17 -Wall -Wextra -Weffc++ -Wformat=2 -Wsign-conversion -Wno-missing-field-initializers
DEBUG_FLAGS = $(COMMON_FLAGS) -O0
OPTIMIZED_FLAGS = $(COMMON_FLAGS) -O3 -march=native -msse4.2 -mavx -mavx2 -march=native -Wa,-mtune=generic64

all: v1 v2 v3 v4

v1: bin/main.o bin/hashtable_v1.o
	$(CXX) $^ $(DEBUG_FLAGS) -o main_v1

bin/main.o: src/main.cpp
	$(CXX) -c src/main.cpp $(DEBUG_FLAGS) -o $@

bin/hashtable_v1.o: src/hashtable_v1.cpp hpp/hashtable_v1.hpp
	$(CXX) -c src/hashtable_v1.cpp $(DEBUG_FLAGS) -o $@

v2: bin/main.o bin/hashtable_v2.o
	$(CXX) $^ $(OPTIMIZED_FLAGS) -o main_v2

bin/hashtable_v2.o: src/hashtable_v2.cpp hpp/hashtable_v1.hpp
	$(CXX) -c src/hashtable_v2.cpp $(OPTIMIZED_FLAGS) -o $@

v3: bin/main.o bin/hashtable_v3.o bin/meowcmp.o
	$(CXX) $^ bin/meowcmp.o $(OPTIMIZED_FLAGS) -o main_v3

bin/hashtable_v3.o: src/hashtable_v3.cpp hpp/hashtable_v1.hpp
	$(CXX) -c src/hashtable_v3.cpp $(OPTIMIZED_FLAGS) -o $@

bin/meowcmp.o: src/meowcmp.s
	$(NASM) -f elf64 src/meowcmp.s -o $@

v4: bin/main.o bin/hashtable_v4.o bin/strlen_memcpy.o
	$(CXX) $^ bin/strlen_memcpy.o $(OPTIMIZED_FLAGS) -o main_v4

bin/hashtable_v4.o: src/hashtable_v4.cpp hpp/hashtable_v1.hpp
	$(CXX) -c src/hashtable_v4.cpp $(OPTIMIZED_FLAGS) -o $@

bin/strlen_memcpy.o: src/strlen_memcpy.s
	$(NASM) -f elf64 src/strlen_memcpy.s -o $@

clean:
	rm -f main_* bin/*.o