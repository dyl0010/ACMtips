#include <iostream>

int main() {
	int input;
	int ones = 0;

	std::cin >> input;

	while (input) {
		ones += (input % 2);
		input /= 2;
	}

	std::cout << ones;
}