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
 - 🔹HJ1  字符串最后一个单词的长度 <br>
 擅用`std::getline`函数，可以帮助我们灵活地处理各种方式的程序输入。
 - 🔹HJ2	计算某字符出现次数 <br>
 程序中尽量使用`std::isupper`、`std::isalpha`这些标准库提供的设施，减少算法实现上的漏洞。
 - 🔹HJ3	明明的随机数 <br>	
 此处使用的去重逻辑必须在排序之后，这与`std::unique`算法的原理密切相关，不熟悉的同学回去背课本！另外注意这里将一个容器(即将出`scope`被销毁)所有元素追加到另一容器后所使用的方法`std::move(curr.begin(), curr.end(), std::back_inserter(all));`。使用`std::move`可以提高程序的性能，`std::back_inserter`(插入迭代器)的加入提供了极大的方便。
 - 🔹HJ4	字符串分隔 <br>
 - 🔹HJ5	进制转换 <br>
 注意约定中提到的**多组输入**和**输出时格式问题**。
 - 🔹HJ6	质数因子 <br>
 这里实际要解决一个数的质数分解式(唯一)，最开始使用朴素的短除法(如下代码)，提示超时，于是我们采取了一点小手段：**每个合数至少有一个小于或等于其平方根的质因数**，利用这个结论，我们可以只将迭代进行到`sqrt(input)`处。
 ```cpp
 {
    // ...

    //
    // 直接使用短除法 => 超时
    while (input > 1) {
        if (input % curr == 0) {
            input /= curr;
            std::cout << curr << ' ';
        } else {
            ++curr;
        }
    }
 }
 ```
 - 🔹HJ7	取近似值 <br>
 使用`std::round(double)`
 - 🔹HJ8	合并表记录 <br>
 使用`std::map`
 - 🔹HJ9	提取不重复的整数 <br>
 `std::reverse`可以逆置一个迭代器区间
 - 🔹HJ10	字符个数统计 <br>
 我们又用了之前使用过的一个去重技巧`input.erase(std::unique(input.begin(), input.end()), input.end());`
 - 🔹HJ11	数字颠倒 <br>
 - 🔹HJ12	字符串反转 <br>
 - 🔹HJ13	句子逆序 <br>
 **正序进 逆序出**，是用`std::stack`的绝佳时机！
 - 🔹HJ14	字符串排序 <br>
 `std::sort`对字符串的默认排序策略便是**字典顺序**
 - 🔹HJ15	求int型正整数在内存中存储时1的个数 <br>
 到二进制的转换，本质上就是**模2运算**(`mod 2`)
 - 🔹HJ50 四则运算 <br>
```c++
//
// 划分成三个处理过程
// [1] parse_expr <- user.input
// [2] to_postfix <- parse_expr.result
// [3] evaluate   <- to_postfix.result
```

 ## .\leetcode
此目录是**LeetCode**专题 [https://leetcode.com/problemset/all/](https://leetcode.com/problemset/all/)
 - 🔸lc1. Two Sum <br>
 当前方案的时间复杂度是`O(n^2)`！<bar>

## .\codewars(Dlang)
此目录是**CodeWars**专题[https://www.codewars.com/](https://www.codewars.com/)
- 🔹Ball Upwards
- 🔹Bouncing Balls
- 🔹Buddy Pairs
- 🔹Directions Reduction
- 🔹Disease Spread
- 🔹Easy Diagonal
- 🔹Grasshopper - Summation
- 🔹How Much
- 🔹Moves in squared strings (II)
- 🔹Parabolic Arc Length
- 🔹Positions Average
- 🔹Primes in numbers
- 🔹Reverse or rotate
- 🔹Second Variation on Caesar Cipher
- 🔹Perimeter of squares in a rectangle.d <br>
实际上是一个斐波那契数列求前n项和问题.
- 🔹Phone Directory.d <br>
使用`matched()`函数来匹配号码，使用`extract_name()`来提取文本行中的人名，使用e`extract_address()`来提取文本行中的地址。其中地址的格式不太明显，
可以根据测试用例来确定：地址中除了有`字母`和`数字`外还可以有`空格`、`.`和`-`，另外`_`需要使用空格来替换，最后注意去掉前导和后导空白。
真实过滤数据中的确不会有完全格式良好的数据，都需要进行一定的清洗.
- 🔹Sum_by_Factors.d <br>
是时候更新一下所有D文件的文件名了.
