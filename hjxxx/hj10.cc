#include <iostream>
#include <string>
#include <algorithm>

int main() {
	std::string input;

	std::cin >> input;

	std::sort(input.begin(), input.end());

	input.erase(std::unique(input.begin(), input.end()), input.end());

	std::cout << input.size();
}