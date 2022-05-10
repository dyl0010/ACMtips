#include <iostream>
#include <string>
#include <vector>
#include <stack>
#include <map>
#include <cctype>
#include <cstdlib>

// 3+2*{1+2*[-4/(8-6)+7]}

bool is_left(char c) {return std::isdigit(c) || c == ')' || c == ']' || c == '}';}

void parse_expr(const std::string &expr, std::vector<std::string> &res) {
    auto iter_prev = expr.cbegin();
    auto iter_curr = expr.cbegin();
    bool is_negative = false;

    while (iter_curr != expr.cend()) {
        if (!std::isdigit(*iter_curr)) {
            if (*iter_curr == '-' && (iter_curr == expr.cbegin() || !is_left(*(iter_curr - 1)))) {
                // 是个负号,而非二元减号
                is_negative = true;
            }
            res.push_back(std::string(1, *iter_curr));
            ++iter_curr;
            continue;
        }

        iter_prev = iter_curr;

        while (std::isdigit(*iter_curr)) {
            ++iter_curr;
        }

        std::string num = std::string(iter_prev, iter_curr);

        if (is_negative) {
            *(res.end() - 1) += num;
            is_negative = false;
        } else {
            res.push_back(num);
        }
    }
}

bool isnum(const std::string &sym) {
    return sym != "+" && sym != "-" && sym != "*" && sym != "/"
    && sym != "(" && sym != ")"
    && sym != "[" && sym != "]"
    && sym != "{" && sym != "}";
}

void to_postfix(const std::vector<std::string> &expr, std::vector<std::string> &res) {
    static const std::map<std::string, int> sym_priority = {
            {"+", 0}, {"-", 1}, {"*", 2}, {"/", 3},
            {"(", 4}, {"[", 4}, {"{", 4},
    };
    std::stack<std::string> pf_stack;

    for (const std::string &sym : expr) {
        std::string curr;
        if (isnum(sym)) {  // sym不应该是0
            res.push_back(sym);
        } else if (sym == ")") {
            while ((curr = pf_stack.top()) != "(") {
                res.push_back(curr);
                pf_stack.pop();
            }
            pf_stack.pop();

        } else if (sym == "]") {
            while ((curr = pf_stack.top()) != "[") {
                res.push_back(curr);
                pf_stack.pop();
            }
            pf_stack.pop();
        } else if (sym == "}") {
            while ((curr = pf_stack.top()) != "{") {
                res.push_back(curr);
                pf_stack.pop();
            }
            pf_stack.pop();
        } else {
            while (!pf_stack.empty()
            && pf_stack.top() != "(" && pf_stack.top() != "[" && pf_stack.top() != "{"
            && (sym_priority.at(sym) <= sym_priority.at(pf_stack.top()))) {
                res.push_back(pf_stack.top());
                pf_stack.pop();
            }
            pf_stack.push(sym);
        }
    }

    // 将栈内剩余符号取出
    while (!pf_stack.empty()) {
        res.push_back(pf_stack.top());
        pf_stack.pop();
    }
}

int evaluate(const std::vector<std::string> &postfx_expr) {
    int res;
    std::stack<int> eval_stack;

    for (const std::string &sym : postfx_expr) {
        int num;
        if (isnum(sym)) {
            eval_stack.push(std::atoi(sym.c_str()));
        } else if (sym == "+") {
            int rnum = eval_stack.top(); eval_stack.pop();
            int lnum = eval_stack.top(); eval_stack.pop();
            eval_stack.push(lnum + rnum);
        } else if (sym == "-") {
            int rnum = eval_stack.top(); eval_stack.pop();
            int lnum = eval_stack.top(); eval_stack.pop();
            eval_stack.push(lnum - rnum);
        } else if (sym == "*") {
            int rnum = eval_stack.top(); eval_stack.pop();
            int lnum = eval_stack.top(); eval_stack.pop();
            eval_stack.push(lnum * rnum);
        } else if (sym == "/") {
            int rnum = eval_stack.top(); eval_stack.pop();
            int lnum = eval_stack.top(); eval_stack.pop();
            eval_stack.push(lnum / rnum);
        } else {
            std::cerr << "impossible!!!";
        }
    }
    return eval_stack.top();
}

void print(const std::vector<std::string> &res) {
    for (const std::string &str : res) {
        std::cout << str << ", ";
    }
}

int main() {
    std::string expr;
    while (std::cin >> expr) {
        std::vector<std::string> pr_expr;
        parse_expr(expr, pr_expr);
        //print(pr_expr); std::cout << std::endl;

        std::vector<std::string> pf_expr;
        to_postfix(pr_expr, pf_expr);
        //print(pf_expr); std::cout << std::endl;

        std::cout << evaluate(pf_expr);

        //
        // test.
        //std::vector<std::string> test = {"-4", "8", "6", "-", "/", "7", "+", };
        //std::cout << std::endl << evaluate(test);
        // eval_stack:
        // 6
        // 8       2               7
        //-4      -4      -2      -2      5
        //... -进     /进      7进     +进
    }
    return 0;
}
