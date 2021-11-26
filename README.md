# ACMtips
刷过的一些ACM题解和思路

> ![test](./misc/tips.png) **提交题目前注意一些编程约定**
> - **多组输入**表示一次测试中使用多个测试用例，这些测试用例彼此独立，通常每个测试用例占据一行(或多行)，所以往往会影响数据的读取方式，和结果的展示方式。比如，一个将十六进制字符串转成十进制整数的题目，多组输入意味着一次测试中会输入多个十六进制字符串，每个串占一行，输出展示多个测试结果时同样也是每个占一行 (这种情况下，我们往往也需要一个容器来暂存每个测试用例的结果) <br>
> ```cpp
> // 输入：
> //      0xA 
> //      0xAA 
> // 输出：
> //      10 
> //      170 
> ```
> - **输出时格式**，在输出多个数据时为了减少麻烦，最好将末尾的分隔(逗号、换行等)删掉。比如，1，2，3，4 <s>逗号</s>，我们采取的输出办法一般是对容器的最后一个元素特殊处理，就像下面代码展示的那样
> ```cpp
> {
> 	// ...
> 
> 	// 输出逻辑
> 	for (int i = 0; i < results.size(); ++i) {
> 		std::cout << results.at(i);
> 		//
> 		// 如果上面输出的不是最后一个元素，正常打印分隔符
> 		if (i != results.size() - 1)
> 			std::cout << '\n';
> 	}
> }	
> ```

## .\hjxxx
此目录是**华为机试**专题 [https://www.nowcoder.com/ta/huawei](https://www.nowcoder.com/ta/huawei)
 - <font color=#1DA1F2>HJ1	字符串最后一个单词的长度</font> <br>
 擅用`std::getline`函数，可以帮助我们灵活地处理各种方式的程序输入。
 - <font color=#1DA1F2>HJ2	计算某字符出现次数</font> <br>
 程序中尽量使用`std::isupper`、`std::isalpha`这些标准库提供的设施，减少算法实现上的漏洞。
 - <font color=#1DA1F2>HJ3	明明的随机数</font> <br>	
 此处使用的去重逻辑必须在排序之后，这与`std::unique`算法的原理密切相关，不熟悉的同学回去背课本！另外注意这里将一个容器(即将出`scope`被销毁)所有元素追加到另一容器后所使用的方法`std::move(curr.begin(), curr.end(), std::back_inserter(all));`。使用`std::move`可以提高程序的性能，`std::back_inserter`(插入迭代器)的加入提供了极大的方便。
 - <font color=#1DA1F2>HJ4	字符串分隔</font> <br>
 - <font color=#1DA1F2>HJ5	进制转换</font> <br>
 注意约定中提到的**多组输入**和**输出时格式问题**。