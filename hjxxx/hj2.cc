#include <iostream>
#include <string>
#include <algorithm>

int main() {
	std::string origin;
	std::getline(std::cin, origin);

	char compared;
	std::cin >> compared;

	const int detla = 32;

	std::cout << std::count_if(origin.cbegin(), origin.cend(), [&](const char curr) {	
			return (compared == curr) ||
				(std::isupper(compared) && (curr - detla == compared)) ||
				(std::islower(compared) && (curr + detla == compared));
		});
}