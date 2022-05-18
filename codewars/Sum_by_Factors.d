import std.stdio;
import std.string : format;

version(unittest) import fluent.asserts;

version(unittest) void dotest(long[] ls, long[2][] exp)
{
    long[2][] actual = sumOfDivided(ls);
    expect(actual).to.equal(exp).because("sumOfDivided(%s)".format(ls));
}

@("fixed tests")
unittest {
    dotest([15,21,24,30,45], [[2, 54],[3, 135],[5, 90],[7, 21]]);
    dotest([-29804, -4209, -28265, -72769, -31744], 
           [[2, -61548],[3, -4209],[5, -28265],[23, -4209],[31, -31744],[53, -72769],[61, -4209],[1373, -72769],[5653, -28265],[7451, -29804]]);
    dotest([173471], [[41, 173471],[4231, 173471]]);
}


bool is_prime(long num) {
    if (num == 1)
        return false;
    if (num == 2 || num == 3) 
        return true;
    foreach (long i; 2..cast(long)(num^^.5)+1) {
        if (num % i == 0)
            return false;
    }
    return true;
}

bool is_factor(long fac, long num) {
    return (num % fac == 0);
}
 
long signed_num(long num, bool isnegative) {
    if (isnegative)
        num *= -1;
    return num;
}

import std.math, std.algorithm;

export long[2][] sumOfDivided(long[] lst)
{
    long[long] sum_of_ftors;
    foreach (long num; lst) {
        bool isnegative = num < 0 ? true : false;
        num = abs(num);
        if (num == 1)
            continue;
        if (num == 2 || num == 3) {
            sum_of_ftors[num] += signed_num(num, isnegative);
            continue;
        }
        foreach (long i; 2..cast(long)(num^^.5)+1) {
            if (is_factor(i, num)) {
                if (is_prime(i)) {
                    sum_of_ftors[i] += signed_num(num, isnegative);
                }
                if (num / i != i && is_prime(num / i)) {
                    sum_of_ftors[num/i] += signed_num(num, isnegative);
                }
            }
        }
        // check self.
        if (is_prime(num)) {
            sum_of_ftors[num] += signed_num(num, isnegative);
        }
    }
    //writeln(sum_of_ftors);
    long[2][] res;
    foreach (long k; sort(keys(sum_of_ftors))) {
        res ~= [k, sum_of_ftors[k]];
    }
    return res;
}

/*
void main(string[] args) {
    writeln(sumOfDivided([611953, 1223906]));
}
*/
