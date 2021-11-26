#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <cmath>

const std::map<char, unsigned> HexCodeTable = {
	{ '0', 0 },  // 0 ~ 9
	{ '1', 1 },
	{ '2', 2 },
	{ '3', 3 },
	{ '4', 4 },
	{ '5', 5 },
	{ '6', 6 },
	{ '7', 7 },
	{ '8', 8 },
	{ '9', 9 },
	{ 'A', 10},  // A ~ F
	{ 'B', 11},
	{ 'C', 12},
	{ 'D', 13},
	{ 'E', 14},
	{ 'F', 15},
	{ 'a', 10},  // a ~ f
	{ 'b', 11},
	{ 'c', 12},
	{ 'd', 13},
	{ 'e', 14},
	{ 'f', 15},
};

inline int str2hex(const std::string &hexstr) {
	unsigned hex = 0;
	auto len = hexstr.size();
	for (int i = len - 1; i > 1; --i) {
		hex += HexCodeTable.at(hexstr.at(i)) * std::pow(16, (len - 1) - i);
	}
	
	return hex;
}

int main() {
	std::string hexstr;
	std::vector<unsigned> results;

	while (std::getline(std::cin, hexstr)) {
		results.push_back(str2hex(hexstr));
	}

	// 输出 
	for (int i = 0; i < results.size(); ++i) {
		std::cout << results.at(i);
		if (i != results.size() - 1)
			std::cout << '\n';
	}
}