

//
//
import std.stdio;
import std.string;

import fluent.asserts;

void testing(string name, string function(string) f, const string s, string exp)
{
    string actual = oper(f, s);
    expect(actual).to.equal(exp).because("oper(%s, %s)".format(name, s));
}
@("fixed tests")
unittest {
    testing("rot", &rot, "fijuoo\nCqYVct\nDrPmMJ\nerfpBA\nkWjFUG\nCVUfyL", 
        "LyfUVC\nGUFjWk\nABpfre\nJMmPrD\ntcVYqC\nooujif");
    testing("rot", &rot, "rkKv\ncofM\nzXkh\nflCB", "BClf\nhkXz\nMfoc\nvKkr");
    testing("rot", &rot, "lVHt\nJVhv\nCSbg\nyeCt", "tCey\ngbSC\nvhVJ\ntHVl");    
      
    testing("selfieAndRot", &selfieAndRot, "xZBV\njsbS\nJcpN\nfVnP", 
        "xZBV....\njsbS....\nJcpN....\nfVnP....\n....PnVf\n....NpcJ\n....Sbsj\n....VBZx");
    testing("selfieAndRot", &selfieAndRot, "uLcq\nJkuL\nYirX\nnwMB",
        "uLcq....\nJkuL....\nYirX....\nnwMB....\n....BMwn\n....XriY\n....LukJ\n....qcLu");
    testing("selfieAndRot", &selfieAndRot, "lVHt\nJVhv\nCSbg\nyeCt",
        "lVHt....\nJVhv....\nCSbg....\nyeCt....\n....tCey\n....gbSC\n....vhVJ\n....tHVl");
    
}

//
// sove.

/*
auto rot = (const string s) {
    string rnt;
    for (int i = cast(int)s.length - 1; i >= 0; --i)
        rnt ~= s[i];
    return rnt;
};
*/
export string rot(const string s)
{
    string rnt;
    for (int i = cast(int)s.length - 1; i >= 0; --i)
        rnt ~= s[i];
    return rnt;
}

string addots(const string s, out int ndots) {
    string rnt;
    int cnt = 0;
    foreach (c; s) {
        if (c == '\n') {
            foreach (i; 0..cnt)
                rnt ~= ".";
            ndots = cnt;
            cnt = -1;
        }
        ++cnt;
        rnt ~= c;
    }
    return rnt;
}

/*
auto selfieAndRot = (const string s) {
    string rnt = addots(s);
    string rnt0 = addots(s);
    rnt ~= "....\n....";
    rnt ~= rot(rnt0);
    return rnt;
};
*/
export string selfieAndRot(const string s)
{
    int ndots = 0;
    string rnt = addots(s, ndots);
    string rnt0 = addots(s, ndots);
    string dots;
    foreach (i; 0..ndots) {
        dots ~= '.';
    }
    rnt ~= dots ~ '\n' ~ dots;
    rnt ~= rot(rnt0);
    return rnt;
}

string oper(string function(const string) fun, const string s) {
    return fun(s);
}

//
// main.
/*
void main(string[] args) {
    testing("rot", &rot, "fijuoo\nCqYVct\nDrPmMJ\nerfpBA\nkWjFUG\nCVUfyL", 
        "LyfUVC\nGUFjWk\nABpfre\nJMmPrD\ntcVYqC\nooujif");
    testing("rot", &rot, "rkKv\ncofM\nzXkh\nflCB", "BClf\nhkXz\nMfoc\nvKkr");
    testing("rot", &rot, "lVHt\nJVhv\nCSbg\nyeCt", "tCey\ngbSC\nvhVJ\ntHVl");    
      
    testing("selfieAndRot", &selfieAndRot, "xZBV\njsbS\nJcpN\nfVnP", 
        "xZBV....\njsbS....\nJcpN....\nfVnP....\n....PnVf\n....NpcJ\n....Sbsj\n....VBZx");
    testing("selfieAndRot", &selfieAndRot, "uLcq\nJkuL\nYirX\nnwMB",
        "uLcq....\nJkuL....\nYirX....\nnwMB....\n....BMwn\n....XriY\n....LukJ\n....qcLu");
    testing("selfieAndRot", &selfieAndRot, "lVHt\nJVhv\nCSbg\nyeCt",
        "lVHt....\nJVhv....\nCSbg....\nyeCt....\n....tCey\n....gbSC\n....vhVJ\n....tHVl");
}
*/
