

//
//
import std.stdio;
import std.string : format;

import fluent.asserts;

void testing(int start, int limit, int[2] exp)
{
    int[2] actual = buddy(start, limit);
    expect(actual).to.equal(exp).because("buddy(%d, %d)".format(start, limit));
}

@("fixed tests")
unittest {
    testing(910, 2755, [1050, 1925]);
    testing(1081180, 1103735, [1081184, 1331967]);
    testing(62700, 90061, [62744, 75495]);
    testing(62744, 75495, [62744, 75495]);
    
}

//
// sumds v1.
int sumds(int num) {
    int sum;
    foreach (i; 1..num)
        if (num % i == 0)
            sum += i;
    return sum;
}

//
// get sum of all divisors(num's).
int sumds_v2(int num) {
    int sum;
    int half = num / 2;
    foreach (i; 1..half+1)
        if (num % i == 0)
            sum += i;
    return sum;
}

int sumds_v3(int num) {
    int sum;
    int upper = cast(int)(cast(double)num).pow(0.5);
    foreach (i; 2..upper+1) 
        if (num % i == 0) {
            int dividi = num / i;
            sum += (i == dividi) ? i : (i + dividi);
        } 
    return sum + 1;  // 1 is always a divid.
}

//
// return all divids.
int[] listdivids(int num) {
    int[] rnt;
    int half = num / 2;
    foreach (i; 1..half+1)
        if (num % i == 0)
            rnt ~= i;
    return rnt;
}

export int[2] buddy(int start, int limit) 
{
    foreach (i; start..limit+1) {
        int other = sumds_v3(i) - 1;
        if (other > i && sumds_v3(other) - 1 == i) {
            return [i, other];
        }
    }
    return [-1, -1];
}

import std.format, std.datetime, std.conv, std.math;

/*
void main(string[] args) {
    immutable limit = 1000000000;
    immutable upper = 10000000;
    int[2] rnt = [0, 0];

    while (rnt[0] < upper) {
        auto before = MonoTime.currTime;
        rnt = buddy(rnt[0] + 1, limit);
        //rnt = buddy(9505, limit);
        auto timeElapsed = MonoTime.currTime - before;
        writeln(timeElapsed, ", ", rnt);
    }
}
*/
