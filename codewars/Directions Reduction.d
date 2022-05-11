
//
//
import std.stdio;
import std.string : format;
import std.algorithm;

import fluent.asserts;

void dotest(const string[] arr, string[] exp)
{
    string[] actual = dirReduc(arr);
    expect(actual).to.equal(exp).because("dirReduc(%s)".format(arr));
}

@("fixed tests")
unittest {
    dotest(["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"], ["WEST"]);
    dotest(["NORTH", "WEST", "SOUTH", "EAST"], ["NORTH", "WEST", "SOUTH", "EAST"]);
    dotest(["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "NORTH"], ["NORTH"]);
    dotest(["EAST", "EAST", "WEST", "NORTH", "WEST", "EAST", "EAST", "SOUTH", "NORTH", "WEST"], ["EAST", "NORTH"]);
    dotest(["NORTH", "EAST", "NORTH", "EAST", "WEST", "WEST", "EAST", "EAST", "WEST", "SOUTH"], ["NORTH", "EAST"]);

}

bool ismatch(string lhs, string rhs) {
    if (lhs == "NORTH")
        return rhs == "SOUTH";
    if (lhs == "SOUTH")
        return rhs == "NORTH";
    if (lhs == "EAST")
        return rhs == "WEST";
    if (lhs == "WEST")
        return rhs == "EAST";
    return false;  // impossible!
}

import std.stdio, std.string;

export string[] dirReduc(const string[] arr)
{
    string[] stack;
    foreach (dir; arr) {
        if (!stack.empty) {
            if (ismatch(stack[$-1], dir)) {
                stack = stack[0..$-1];
            } else {
                stack ~= dir;
            }
        } else {
            stack ~= dir;
        }
    }
    writeln(stack);
    return stack;
}

/*
void main(string[] args) {
    dirReduc(["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"]);
    dirReduc(["NORTH", "WEST", "SOUTH", "EAST"]);
    dirReduc(["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "NORTH"]);
    dirReduc(["EAST", "EAST", "WEST", "NORTH", "WEST", "EAST", "EAST", "SOUTH", "NORTH", "WEST"]);
    dirReduc(["NORTH", "EAST", "NORTH", "EAST", "WEST", "WEST", "EAST", "EAST", "WEST", "SOUTH"]);
}

*/
