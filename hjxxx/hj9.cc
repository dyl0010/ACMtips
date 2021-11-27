#include <iostream>
#include <string>
#include <algorithm>

int main() {
	std::string series;
	std::string store;

	std::cin >> series;

	std::reverse(series.begin(), series.end());

	for (char c : series) {
		if (std::find(store.cbegin(), store.cend(), c) == store.cend())
			store.push_back(c);
	}

	std::cout << store;
}