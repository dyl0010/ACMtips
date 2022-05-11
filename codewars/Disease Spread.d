

//
//
import std.string : format;

import fluent.asserts;

void dotest(int tm, int n, int s0, int i0, double b, double a, int exp)
{
    int actual = epidemic(tm, n, s0, i0, b, a);
    expect(actual).to.equal(exp).because("epidemic(%d, %d, %d, %d, %f, %f)".format(tm, n, s0, i0, b, a));
}

@("epidemic fixed tests")
unittest 
{
    int tm = 18 ;int n = 432 ;int s0 = 1004 ;int i0 = 1 ;double b = 0.00209 ;double a = 0.51;
	dotest(tm, n, s0, i0, b, a, 420);
	tm = 12 ;n = 288 ;s0 = 1007 ;i0 = 2 ;b = 0.00206 ;a = 0.45;
	dotest(tm, n, s0, i0, b, a, 461);
	tm = 13 ;n = 312 ;s0 = 999 ;i0 = 1 ;b = 0.00221 ;a = 0.55;
	dotest(tm, n, s0, i0, b, a, 409);
	
}

import std.stdio;

export int epidemic(int tm, int n, int s0, int i0, double b, double a)
{
    double Imax = i0;
    double Iprev = i0;
    double Sprev = s0;
    double dt = cast(double)tm / n;

    for (int i = 1; i < n; ++i) {
        double Scurr = Sprev - dt * b * Sprev * Iprev;
        double Icurr = Iprev + dt * (b * Sprev * Iprev - a * Iprev);
        if (Icurr > Imax) {
            Imax = Icurr;
        }
        Sprev = Scurr;
        Iprev = Icurr;
    }
    //writeln(Imax);
    return cast(int)Imax;
}

/*
void main(string[] args) {
    int tm = 18 ;int n = 432 ;int s0 = 1004 ;int i0 = 1 ;double b = 0.00209 ;double a = 0.51;
    epidemic(tm, n, s0, i0, b, a);

	tm = 12 ;n = 288 ;s0 = 1007 ;i0 = 2 ;b = 0.00206 ;a = 0.45;
    epidemic(tm, n, s0, i0, b, a);

	tm = 13 ;n = 312 ;s0 = 999 ;i0 = 1 ;b = 0.00221 ;a = 0.55;
    epidemic(tm, n, s0, i0, b, a);
}
*/
