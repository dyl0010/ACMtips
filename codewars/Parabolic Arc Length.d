import std.stdio;
import std.string : format;
import std.math : fabs;

void assertFuzzy(int n, real exp)
{
    enum tolerance = 1e-6;
    double result = lenCurve(n);
    double diff = fabs(result - exp);
    if (diff > tolerance) 
    {
        writeln(format("n %d; expected -> %2.6f, actual %2.6f", n, exp, result));
        writeln(format("Error: Difference is -> %2.6f", diff));
    }
    assert(diff <= tolerance);
}

//@("fixed tests")
unittest 
{
    assertFuzzy(1, 1.414213562);
    assertFuzzy(10, 1.478197397);
    assertFuzzy(40, 1.478896272);
}

import std.format;
/*
void main(string[] args) {
    lenCurve(1);
    lenCurve(10);
    lenCurve(40);
}
*/
//
// lenCurve.
import std.stdio, std.math;
double lenCurve(int n) {
    double fragment = 1.0/n;
    double len = 0;
    for (double i = fragment; i <= 1.0 + 1e-6; i += fragment) {
        len += (fragment^^2 + (i*i - (i-fragment)^^2)^^2)^^(1.0/2);
        //writeln('\t',fragment, '\t', i, '\t', (fragment^^2 + (i*i - (i-fragment)^^2)^^2)^^(1.0/2));
    }
    //writeln(format("%.9f", len));
    return len;
}
