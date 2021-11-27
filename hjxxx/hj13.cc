#include <iostream>
#include <string>
#include <strstream>
#include <vector>
#include <stack>

int main() {
	std::vector<std::stack<std::string> > lines;
	std::string line;

	while (std::getline(std::cin, line)) {
		std::istrstream strin(line.c_str());
		std::string word;
		std::stack<std::string> words;
		while (strin >> word)
			words.push(word);
		lines.push_back(words);
	}

	for (int i = 0; i < lines.size(); ++i) {
		while (!lines.at(i).empty()) {
			std::cout << lines.at(i).top();
			lines.at(i).pop();
			if (lines.at(i).size() != 0)
				std::cout << ' ';
		}
		if (i != lines.size() - 1) 
			std::cout << '\n';
	}
}