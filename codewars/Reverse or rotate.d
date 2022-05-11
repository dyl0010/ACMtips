

// 
//
import std.stdio;
import std.string : format;

import fluent.asserts;

void testing(const string s, int sz, string exp)
{
    string actual = revrot(s, sz);
    expect(actual).to.equal(exp).because("revrot(%s, %d)".format(s, sz));
}

@("fixed tests")
unittest {
    testing("1234", 0, "");
    testing("", 0, "");
    testing("1234", 5, "");
    string s = "733049910872815764";
    testing(s, 5, "330479108928157");
    s = "73304991087281576455176044327690580265896";
    testing(s, 8, "1994033775182780067155464327690480265895");
    
}

import std.range, std.algorithm, std.stdio;

export string revrot(const string s, int sz)
{
    if (sz <= 0 || s.empty || sz > s.length) {
        //writeln("--");
        return "";
    }

    int beg, end = beg + sz;
    string rnt;

    while (end <= s.length) {
        if (cubesum(s[beg..end]) % 2 == 0) {
            for (int i = end - 1; i >= beg; --i) {
                rnt ~= s[i];
            }
        } else {
            foreach (i; beg+1..end) {
                rnt ~= s[i];
            }
            rnt ~= s[beg];
        }

        //writeln(s[beg..end], " -> ", rnt);

        // update 
        beg = end;
        end = beg + sz;
    }
    //writeln(rnt);
    return rnt;
}

import std.conv;

int cubesum(string serial) {
    int sum = 0;
    foreach (c; serial) {
        sum += (to!int(to!string(c)))^^3;
    }
    return sum;
}

/*
void main(string[] args) {
    revrot("1234", 0);
    revrot("", 0);
    revrot("1234", 5);
    string s = "733049910872815764";
    revrot(s, 5);
    s = "73304991087281576455176044327690580265896";
    revrot(s, 8);
}
*/
