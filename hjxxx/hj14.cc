#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

int main() {
	std::vector<std::string> words;
	int count;
	std::string word;

	std::cin >> count;

	while (count--) {
		std::cin >> word;
		words.push_back(word);
	}

	std::sort(words.begin(), words.end());

	for (int i = 0; i < words.size(); ++i) {
		std::cout << words.at(i);
		if (i != words.size() - 1)
			std::cout << '\n';
	}
}