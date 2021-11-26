#include <iostream>
#include <vector>
#include <algorithm>

int main() {
	short cnt;
	std::vector<short> all;

	while (std::cin >> cnt) {   
		short num;
		std::vector<short> curr;
		while (cnt--) {
			std::cin >> num;
			curr.push_back(num);
		}
		// 排序
		std::sort(curr.begin(), curr.end());

		// 去重
		curr.erase(std::unique(curr.begin(), curr.end()), curr.end());

		// 记录
		std::move(curr.begin(), curr.end(), std::back_inserter(all));
	}

	// 输出
	for (int i = 0; i < all.size(); ++i) {
		std::cout << all.at(i);
		if (i != all.size() - 1)
			std::cout << '\n';
	}
}