

//
// 
import std.stdio;
import std.string : format;

import fluent.asserts;

void testequal(double h, double bounce, double window, int exp)
{
    int actual = bouncingBall(h, bounce, window);
    expect(actual).to.equal(exp).because("bouncingBall(%2.2f, %2.2f, %2.2f)".format(h, bounce, window));
}

@("fixed tests")
unittest {
    testequal(3.0, 0.66, 1.5, 3);
    testequal(30.0, 0.4, 10.0, 3);
    testequal(40.0, 0.4, 10.0, 3);
    testequal(10.0, 0.6, 10.0, -1);
    
}

export int bouncingBall(double h, double bounce, double window) 
{
    // check condition.
    if (h <= 0 || (bounce >= 1 || bounce <= 0) || window >= h)
        return -1;

    double currheight = h * bounce;
    int cnt;
    while (currheight > window) {
        //writeln('\t', currheight);
        ++cnt;
        currheight *= bounce;
    }
    return 2 * cnt + 1;  // frst and last.
}

/*
void main(string[] args) {
    //writeln(bouncingBall(3.0, 0.66, 1.5));
    //writeln(bouncingBall(30.0, 0.4, 10.0));
    //writeln(bouncingBall(40.0, 0.4, 10.0));
    //writeln(bouncingBall(10.0, 0.6, 10.0));
    writeln(bouncingBall(30.0, 0.66, 1.5));
}
*/
