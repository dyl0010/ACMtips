

//
// summation.d.

//void main(string[] args) {}

version(unittest) import fluent.asserts;

@("sample tests")
unittest {
    expect(summation(1)).to.equal(1);
    expect(summation(8)).to.equal(36);
    expect(summation(22)).to.equal(253);
    expect(summation(100)).to.equal(5050);
    expect(summation(213)).to.equal(22791);
}

//
// summation.
int summation(int num) {
    int sum;
    foreach (i; 1..num + 1) {
        sum += i;
    }
    return sum;
}
