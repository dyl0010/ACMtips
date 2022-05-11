import std.stdio;
import std.string : format;

import fluent.asserts;

void dotest1(string s, int shift, string[] exp)
{
    string[] actual = encode(s, shift);
    expect(actual).to.equal(exp).because("encode(%s, %d)".format(s, shift));
}
@("fixed tests 1")
unittest {
    string u = "I should have known that you would have a perfect answer for me!!!";
    string[] v = ["ijJ tipvme ibw", "f lopxo uibu z", "pv xpvme ibwf ", "b qfsgfdu botx", "fs gps nf!!!"];
    dotest1(u, 1, v);
    v = ["ikK ujqwnf jcx", "g mpqyp vjcv a", "qw yqwnf jcxg ", "c rgthgev cpuy", "gt hqt og!!!"];
    dotest1(u, 28, v);

    u = "abcdefghjuty12";
    v = ["abbc", "defg", "hikv", "uz12"];
    dotest1(u, 1, v);
    v = ["aeef", "ghij", "klny", "xc12"];
    dotest1(u, 30, v);

}

import std.ascii, std.range;

void main(string[] args) {
    string u = "I should have known that you would have a perfect answer for me!!!";
    writeln(u.length);
    writeln(u.length / 4);
    writeln(encode(u, 1));
    writeln(encode(u, 28));

    u = "abcdefghjuty12";
    writeln(encode(u, 1));
    writeln(encode(u, 30));

    u = "O CAPTAIN! my Captain! our fearful trip is done;";
    writeln(encode(u, 1));

    u = "I should have known that you would have a perfect answer for me!!!";
    writeln(encode(u, -36));
}

immutable ngroups = 5;

int calc_break(int len) {
    //
    // 计算前4部分的长度
    // 首先确定第五部分应该是多长，算法如下
    // 68 % 4 == 0 +4 +4 +4 +4 > (68-16)/4
    //                      ^^
    //                      16 > 13 -> 12(+4+4+4)
    // 17 % 4 == 1 +4 > (17-5)/4
    //             ^^
    //              5 > 3 -> 1
    // 16 % 4 == 0 +4 > (16-4)/4
    //             ^^
    //              4 > 3 -> 0
    len += 2;  // 加上额外的两个前缀码
    immutable step = (ngroups - 1);
    int len5 = len % step;
    int len1234 = len - len5;
    while (len5 + step <= (len1234 - step) / step) {
        len5 += step;
        len1234 -= step;
    }
    return len1234 / 4;
}

char shift_char(char c, int shift) {
    //
    // 返回字符c移动shift个位置后的字符,注意是循环移动
    shift %= 26;
    if (isUpper(c)) {
        if (c + shift > 'Z')
            return cast(char)(c + shift - 26);
        if (c + shift < 'A') 
            return cast(char)(c + shift - 'A' + 'Z' + 1);
    }
    if (isLower(c)) {
        if (c + shift > 'z')
            return cast(char)(c + shift - 26);
        if (c + shift < 'a') 
            return cast(char)(c + shift - 'a' + 'z' + 1);
    }
    return cast(char)(c + shift);
}

export string[] encode(string strng, int shift)
{
    if (strng.empty)
        return [];

    string[ngroups] res;

    immutable char a = toLower(strng[0]);
    immutable char b = shift_char(a, shift);
    res[0] ~= a;
    res[0] ~= b;

    string fixstr;
    fixstr ~= a;
    fixstr ~= b;
    fixstr ~= strng;

    int cnt = 0;
    int len1 = calc_break(cast(int)strng.length);

    for (int i = 2; i < fixstr.length; ++i) {
        if (i % len1 == 0 && cnt < ngroups - 1)
            ++cnt;
        if (!isAlpha(fixstr[i])) {
            res[cnt] ~= fixstr[i];
            continue;
        }
        res[cnt] ~= shift_char(fixstr[i], shift);
    }

    //
    // 如果最后一个为空，丢掉
    string[] dres = res.dup;
    if (res[ngroups - 1].empty)
        dres.length = ngroups - 1;

    return dres;
}

void dotest2(string[] s, string exp)
{
    string actual = decode(s);
    expect(actual).to.equal(exp).because("decode(%s)".format(s));
}
@("fixed tests 2")
unittest {
    string u = "I should have known that you would have a perfect answer for me!!!";
    string[] v = ["ijJ tipvme ibw", "f lopxo uibu z", "pv xpvme ibwf ", "b qfsgfdu botx", "fs gps nf!!!"];
    dotest2(v, u);
    v = ["ikK ujqwnf jcx", "g mpqyp vjcv a", "qw yqwnf jcxg ", "c rgthgev cpuy", "gt hqt og!!!"];
    dotest2(v, u);

    u = "abcdefghjuty12";
    v = ["abbc", "defg", "hikv", "uz12"];
    dotest2(v, u);
    v = ["aeef", "ghij", "klny", "xc12"];
    dotest2(v, u);

}

export string decode(string[] arr, )
{
    string res = join(arr);
    res = res[2..$];  // 去掉前两个编码

    //
    // TODO: 解码缺少shift必要条件.

    return res;
}

/*
void main(string[] args) {
    string[] v = ["abbc", "defg", "hikv", "uz12"];
    writeln(decode(v));
}
*/
