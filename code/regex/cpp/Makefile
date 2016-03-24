GCC := g++ -Wall -std=c++14 -g -O2

all:	main.cpp regex.cpp
	$(GCC) -o regex main.cpp regex.cpp

clean:
	rm ./regex

test:	regex
	./regex
