import std.bigint;
import std.stdio;
import std.string : format;

version(unittest) import fluent.asserts;

version(unittest) void dotest(int n, BigInt exp)
{
    BigInt actual = perimeter(n);
    expect(actual).to.equal(exp).because("perimeter(%d)".format(n));
}

@("fixed tests")
unittest {
    dotest(0, BigInt("4"));
    dotest(1, BigInt("8"));
    dotest(5, BigInt("80"));
    dotest(7, BigInt("216"));
    
}

import std.bigint;
export BigInt perimeter(int n) 
{
    BigInt sum = "2";
    BigInt num1 = "1";
    BigInt num2 = "1";
    if (n == 0)
        return BigInt("1")*4;
    if (n == 1)
        return BigInt("2")*4;

    foreach (i; 0..n-1) {
        BigInt curr = num1 + num2;
        sum += curr;
        write(curr, ',');
        num1 = num2;
        num2 = curr;
    }
    return sum*4;
}

/*
void main(string[] args) {
    writeln(perimeter(0));
    writeln(perimeter(1));
    writeln(perimeter(5));
    writeln(perimeter(7));
}
*/
