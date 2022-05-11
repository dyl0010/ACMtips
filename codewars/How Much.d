

//
// 
import std.stdio;
import std.string : format;

/*
import fluent.asserts;

void dotest(int m, int n, string exp)
{
    string actual = howMuch(m, n);
    expect(actual).to.equal(exp).because("howMuch(%d, %d)".format(m, n));
}

@("fixed tests")
unittest {
    string sol1 = "[[M: 37 B: 5 C: 4][M: 100 B: 14 C: 11]]";
    dotest(1, 100, sol1);
    sol1 = "[[M: 37 B: 5 C: 4][M: 100 B: 14 C: 11][M: 163 B: 23 C: 18]]";
    dotest(0, 200, sol1);
    sol1 = "[[M: 1045 B: 149 C: 116]]";
    dotest(1000, 1100, sol1);
    
}
*/

import std.string, std.format;

export string howMuch(int m, int n) 
{
    int lower = m > n ? n : m;
    int upper = m > n ? m : n;

    string rnt = "[";

    int c = 1;
    while (true) {
        if (9 * c + 1 < lower) {
            ++c;
            continue;
        }

        if (9 * c + 1 > upper) 
            break;

        int isInt = (9 * c - 1) % 7;
        if (!isInt) {
            rnt ~= format("[M: %d B: %d C: %d]", 9 * c + 1, (9 * c - 1) / 7, c);
        }
        ++c;
    }
    rnt ~= "]";
    //writeln(rnt);
    return rnt;
}

/*
void main(string[] args) {
    howMuch(1, 100);
    howMuch(0, 200);
    howMuch(1000, 1100);
    howMuch(10000, 9950);
}
*/
