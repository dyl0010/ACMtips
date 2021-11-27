#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

int main() {
	short groups;
	std::vector<int> indexs;
	std::map<int, int> values;

	std::cin >> groups;

	while (groups--) {
		int index, value;
		std::cin >> index >> value;
		if (std::find(indexs.cbegin(), indexs.cend(), index) == indexs.cend()) 
			indexs.push_back(index);
		values[index] += value;
	}

	std::sort(indexs.begin(), indexs.end());

	// 输出
	for (int i = 0; i < indexs.size(); ++i) {
		std::cout << indexs.at(i) << ' ' << values[indexs.at(i)];
		if (i != indexs.size() - 1)
			std::cout << '\n';
	}
}