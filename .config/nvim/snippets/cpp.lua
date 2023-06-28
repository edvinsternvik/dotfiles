return {

s("cpInit",
fmt(
[[
#include <bits/stdc++.h>
using namespace std;

using ull = unsigned long long;
using ll = long long;
using llp = pair<ll,ll>;
using ullp = pair<ull,ull>;

void solveTestcase() {
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int t;
    cin >> t;

    for(int tc = 0; tc < t; ++tc) {
        solveTestcase();
    }

}
]], {}, { delimiters = "´" })),

s("cpInitNotTestcases",
fmt(
[[
#include <bits/stdc++.h>
using namespace std;

using ull = unsigned long long;
using ll = long long;
using llp = pair<ll,ll>;
using ullp = pair<ull,ull>;

void solveTestcase() {
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

	solveTestcase();
}
]], {}, { delimiters = "´" }))
}
