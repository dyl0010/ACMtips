#include <iostream>
#include <vector>
#include <cmath>

int main() {
	unsigned curr = 2;
	unsigned input;
	
	std::cin >> input;

	//
	// 改进后的短除法
	// https://www.geeksforgeeks.org/print-all-prime-factors-of-a-given-number/

	while (input % 2 == 0) {
		std::cout << 2 << ' ';
		input /= 2;
	}

	for (int i = 3; i <= std::sqrt(input); i += 2) {
		while (input % i == 0) {
			std::cout << i << ' ';
			input /= i;
		}
	}

	if (input > 2) 
		std::cout << input << ' ';
}