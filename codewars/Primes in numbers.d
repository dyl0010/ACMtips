

//
// Primers in numbers.
import std.stdio;
import std.string : format;

import fluent.asserts;

void dotest(long n, string exp)
{
    string actual = primeFactors(n);
    expect(actual).to.equal(exp).because("primeFactors(%d)".format(n));
}

@("fixed tests")
unittest {
    dotest(7775460, "(2**2)(3**3)(5)(7)(11**2)(17)");
    dotest(7919, "(7919)");
    dotest(17*17*93*677, "(3)(17**2)(31)(677)");
    dotest(933555431, "(7537)(123863)");
    
}

import std.format, std.algorithm;

export string primeFactors(long n)
{
    // n如果是质数，跳过迭代
    if (is_primer(n)) {
        return format("(%d)", n);
    }

    int[long] res;
    long end = cast(int) n^^(1.0/2);
    int i = 2;
    while (i <= end) {
        if (n % i == 0) {
            ++res[i];
            if ((n / i > end) && is_primer(n / i)) {
                ++res[n/i];
            }
            n /= i;
        } else {
            ++i;
        }
    }

    //
    // generator output string.
    string str;
    foreach (primer; sort(keys(res))) {
        string curr;
        int counter = res[primer];
        if (counter == 1) {
            curr = format("(%d)", primer);
        } else {
            curr = format("(%d**%d)", primer, counter);
        }
        str ~= curr;
    }
    return str;
}

bool is_primer(long num) {
    int end = cast(int)num^^(1.0/2);
    for (int i = 2; i <= end; ++i) {
        if (num % i == 0)
            return false;
    }
    return true;
}

/*
void main(string[] args) {
    writeln(primeFactors(7775460));
    writeln(primeFactors(7919));
    writeln(primeFactors(17*17*93*677));
    writeln(primeFactors(933555431));
}
*/
