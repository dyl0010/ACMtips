

//
// 
import std.stdio;
import std.string : format;
import std.math;

version(unittest) import fluent.asserts;

void assertFuzzy(string s, double exp)
{
    enum tolerance = 1e-9;
    double result = posAverage(s);
    double diff = abs(result - exp);
    if (diff > tolerance) {
        writeln(format("s: %s\nexpected -> %.9f, actual %.9f", s, exp, result));
        writeln(format("Error: Difference is -> %.9f", diff));
    }
    assert(diff <= tolerance);
}

@("fixed tests")
unittest
{
    assertFuzzy("466960, 069060, 494940, 060069, 060090, 640009, 496464, 606900, 004000, 944096", 26.6666666667);
    assertFuzzy("444996, 699990, 666690, 096904, 600644, 640646, 606469, 409694, 666094, 606490", 29.2592592593);
    assertFuzzy("449404, 099090, 600999, 694460, 996066, 906406, 644994, 699094, 064990, 696046", 24.4444444444);
    assertFuzzy("660999, 969060, 044604, 009494, 609009, 640090, 994446, 949940, 046999, 609444", 22.9629629630);
    
}

//
// posAverage.
import std.algorithm, std.format, std.conv;
double posAverage(string str) {
    auto serial = str.splitter(", ");
    string[] serials;
    foreach (s; serial)
        serials ~= s;
    int seriallen = cast(int)serials[0].length;
    int comptotal = 0;
    int nsame = 0;
    for (int i = 0; i < serials.length; ++i) {
        for (int j = i + 1; j < serials.length; ++j) {
            ++comptotal;
            foreach (k; 0..serials[i].length)
                if (serials[i][k] == serials[j][k])
                    ++nsame;
        }
    }
    double rnt = cast(double)nsame/(comptotal * seriallen) * 100;
    //writeln(format("%d\t%d\t%.10f", comptotal, nsame, rnt));
    return rnt;
}

/*
void main(string[] args) {
    posAverage("466960, 069060, 494940, 060069, 060090, 640009, 496464, 606900, 004000, 944096");
    writeln("----");
    posAverage("444996, 699990, 666690, 096904, 600644, 640646, 606469, 409694, 666094, 606490");
    writeln("----");
    posAverage("449404, 099090, 600999, 694460, 996066, 906406, 644994, 699094, 064990, 696046");
    writeln("----");
    posAverage("660999, 969060, 044604, 009494, 609009, 640090, 994446, 949940, 046999, 609444");
}
*/
