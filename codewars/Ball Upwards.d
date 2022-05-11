

//
//
import std.stdio;
import std.string : format;

import fluent.asserts;

void dotest(int v0, int exp)
{
    int actual = maxBall(v0);
    expect(actual).to.equal(exp).because("maxBall(%d)".format(v0));
}

@("fixed tests")
unittest {
    dotest(37, 10);
    dotest(45, 13);
    dotest(99, 28);
    dotest(85, 24);
    
}

import std.math;

immutable g = 9.81;

export int maxBall(int v0) 
{
    double vmps = v0 * 1000 / 3600.0;
    return cast(int)round(vmps / g / .1);
}

/*
void main(string[] args) {
    writeln(maxBall(37));
    writeln(maxBall(45));
    writeln(maxBall(99));
    writeln(maxBall(85));
}
*/
