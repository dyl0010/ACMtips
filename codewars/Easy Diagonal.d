
//
//
import std.stdio;
import std.string : format;

import fluent.asserts;

void dotest(uint n, uint p, ulong exp)
{
    ulong actual = diagonal(n, p);
    expect(actual).to.equal(exp).because("diagonal(%d, %d)".format(n, p));
}

@("fixed tests")
unittest {
    dotest(20, 3, 5985);
    dotest(20, 4, 20349);
    dotest(20, 5, 54264);
    dotest(20, 15, 20349);
}

export ulong diagonal(uint n, uint p) 
{
    immutable total = 120*(120+1)/2;
    long[total + 1] pascal = -1;  // max layer is 100
    //writeln(pascal);
    for (int i = 1; i <= 120; ++i) {
        int index = s(i);
        pascal[index] = pascal[index-1] = 1;
    }
    for (int i = 0; i < total; ++i) {
        if (pascal[i] == -1) {
            auto last = layer_no(i);
            auto curr = i - s(last);
            auto left = curr - 1;
            auto right = curr;
            auto pivot = s(last - 1);
            pascal[i] = pascal[pivot + left] + pascal[pivot + right];
        }
    }
    //
    // output.
    /*
    int i, j, cnt = 1;
    while (i < total) {
        while (j < cnt) {
            write(pascal[i++], " ");
            ++j;
        }
        writeln(" ");
        j = 0;
        ++cnt;
    }
    */
    long sum;
    long start = s(p + 1) - 1;
    foreach (i; 0..n+1-p) {
        start += i;
        //write(format("%d(%d)", pascal[start], start), " ");
        sum += pascal[start];
        start += p;
    }
    //writeln("--------", sum);
    return sum;
}

import std.format;

int layer_no(int index) {return cast(int)((1 + 8 * index)^^(0.5) - 1) / 2;}
int s(int layer_no) {return layer_no * (layer_no + 1) / 2;}

/*
void main(string[] args) {
    diagonal(100, 10);
    diagonal(40, 11);
}
*/
