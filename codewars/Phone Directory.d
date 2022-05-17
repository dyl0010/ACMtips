import std.stdio;
import std.string : format;

version(unittest) import fluent.asserts;
    
// small dr

string dr = "/+1-541-754-3010; 156 Alphand_St.; *<J Steeve>\n 133, Green, Rd. <E Kustur> /NY-56423 ;+1-541-914-3010;\n
+1-111-544-8973 <Peter Pan> LA\n +1-921-512-2222 <Wilfrid Stevens> Wild Street AA-67209\n
<Anastasia> +48-421-674-8974 Via Quirinal Roma\n <P Salinger> Main Street, +1-098-512-2222, Denver\n
<C Powel> +19-421-674-8974 Chateau des Fosses Strasbourg F-68000\n <Bernard Deltheil> +1-498-512-2222; Mount Av.  Eldorado\n
<John Freeland> Mantow ?+2-121-544-8974 \n <Robert Mitch> Eleonore Street QB-87209 +2-481-512-2222?\n
<Arthur Paternos> San Antonio +7-121-504-8974 TT-45121\n <Ray Charles> Stevenson Pk. !+7-681-512-2222! CB-47209,\n
<JP Gorce> +9-421-674-8974 New-Bern TP-16017\n <P McDon> Revolution Street +2-908-512-2222; PP-47209\n
<Elizabeth Corber> +8-421-674-8974 Via Papa Roma\n <C Saborn> Main Street, +15-098-512-2222, Boulder\n
<Colin Marshall> +9-421-674-8974 Edinburgh UK\n <Bernard Povit> +3-498-512-2222; Hill Av.  Cameron\n
<Donald Drinkaw> Moon Street, +3-098-512-2222, Peterville\n";
    
version(unittest) void testing(string s, string num, string exp)
{
    string actual = phone(s, num);
    expect(actual).to.equal(exp).because("'Small data: dr', %s".format(num));
}

@("fixed tests")
unittest {
    testing(dr, "8-421-674-8974", "Phone => 8-421-674-8974, Name => Elizabeth Corber, Address => Via Papa Roma");
    testing(dr, "48-421-674-8974", "Phone => 48-421-674-8974, Name => Anastasia, Address => Via Quirinal Roma");
    testing(dr, "19-421-674-8974", "Phone => 19-421-674-8974, Name => C Powel, Address => Chateau des Fosses Strasbourg F-68000");
    testing(dr, "1-921-512-2222", "Phone => 1-921-512-2222, Name => Wilfrid Stevens, Address => Wild Street AA-67209");

}

import std.format, std.string, std.ascii;

bool matched(immutable string line, immutable string num, ref ulong beg, ref ulong end) {
    if (line.empty)
        return false;

    auto numlen = num.length;
    for (int i = 0; i < line.length; ++i) {
        if (line[i] == '+' && line[i+1..i+numlen+1] == num) {
            //writeln('\t', line[i+1..i+numlen]);
            beg = i;
            end = i + numlen;
            return true;
        }
    }
    return false;
}

string extract_name(in string line, ref ulong beg, ref ulong end) {
    for (int i = 0; i < line.length; ++i) {
        if (line[i] == '<')
            beg = i;
        if (line[i] == '>')
            end = i;
    }
    return line[beg+1..end];
}

string extract_address(in string line, ulong numbeg, ulong numend, ulong namebeg, ulong nameend) {
    string address;
    for (int i = 0; i < line.length; ++i) {
        if (!((i >= numbeg && i <= numend) || (i >= namebeg && i <= nameend))) {
            if (line[i] == ' ' || line[i] == '-' || line[i] == '.' || line[i] == '_' || isDigit(line[i]) || isAlpha(line[i])) {
                address ~= line[i];
            }
        }
    }
    
    address = strip(address);

    string address_;
    for (int i = 0; i < address.length; ++i) {
        if (address[i] == ' ' && address[i+1] == ' ')
            continue;
        if (address[i] == '_') {
            address_ ~= ' ';
            continue;
        }
        address_ ~= address[i];
    }

    return strip(address_);
}

export string phone(string s, string num)
{
    string name, address;
    auto lines = splitLines(s);

    int count = 0;

    foreach (string line; lines) {
        ulong numbeg, numend;
        if (matched(line, num, numbeg, numend)) {
            ++count;
            ulong namebeg, nameend;
            name = extract_name(line, namebeg, nameend);
            address = extract_address(line, numbeg, numend, namebeg, nameend);
        }
    }

    if (count == 0) {
        return format("Error => Not found: %s", num);
    }
    
    if (count > 1) {
        return format("Error => Too many people: %s", num);
    }

    return format("Phone => %s, Name => %s, Address => %s", num, name, address);
}

/*
void main() {
    writeln(phone(dr, "8-421-674-8974"));
    writeln(phone(dr, "48-421-674-8974"));
    writeln(phone(dr, "19-421-674-8974"));
    writeln(phone(dr, "1-921-512-2222"));
}
*/
