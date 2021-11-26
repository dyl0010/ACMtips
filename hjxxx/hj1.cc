#include <iostream>
#include <string>

int main() {
	std::string input;
	std::getline(std::cin, input);
	int cnt = 0;
	const int space = 32;
	for (int i = input.size() - 1; i != -1 && input.at(i) != space; --i) {
		++cnt;
	}
	std::cout << cnt;
}