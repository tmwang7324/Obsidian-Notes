---
title: "BlackRock | OA | 2023 - Discuss"
source: "https://leetcode.com/discuss/post/2648123/blackrock-oa-2023-by-anonymous_user-8v9u/"
author:
published:
created: 2026-07-06
description: "A friend of mine got 2 problems for his OA for BlackRock. The first problem was: 1. Similar to the valid parentheses. Here are the test cases: Test1"
tags:
  - "clippings"
---
A friend of mine got 2 problems for his OA for BlackRock. The first problem was:

1. Similar to the [**valid parentheses**](https://leetcode.com/problems/valid-parentheses/).  
	![image](https://assets.leetcode.com/users/images/be913ced-1ae0-42b5-97e4-edebea5a6db9_1666556414.8772023.png)

Here are the test cases:

```javascript
Test1
[
  {
    company_name: (BlackRock)
    ticker: (BLK)
    stack_price: {
      2022-04-03: ($930)
      2022-04-02: ($932)
    }
  },
  {
    company_name: (Apple)
    ticker: (APPL)
    stack_price: {
      2022-04-03: ($175))
      2022-04-02: ($178)
    }
  }
]

Test2
[
  {
    company_name: (BlackRock(
    ticker: (BLK{
    stack_price: {
      2022-04-03: ($930]
      2022-04-02: ($932}
    }
  }
]
```

2. Graph problem involves exchanging currency rate and finding the exchange that will give you the max rate. Similar to [**Evaluate Division**](https://leetcode.com/problems/evaluate-division/)  
	![image](https://assets.leetcode.com/users/images/6993ecfd-d2ae-4ee3-bcd9-23c39aa69c5e_1664655455.6993344.png)

And below is my solution using DFS. I tried BFS but I think it won't work with this problem because we need to check all the paths that lead to the final currency. If you have any questions, don't hesitate to reach out. Happy coding!

Here is a drawing using Excalidraw to see the whole picture. Hope it is helpful.  
![image](https://assets.leetcode.com/users/images/c62c4822-0449-40d6-9065-dfe8611eabec_1664655894.3837025.png)

```python
import sys 
from typing import List
from collections import defaultdict

data = []
for line in sys.stdin: 
    data.append(line.strip())

exchanges = []
for d in data[0].split(';'): 
    src, des, weight = d.split(',')
    exchanges.append((src, des, float(weight)))

# Compute the exchange rate
def maxAmountofExchange(exchanges: List[str], from_currency, to_currency):
    graph = defaultdict(list)
    for src, des, weight in exchanges:
        graph[src].append((des, float(weight)))
        graph[des].append((src, 1.0/float(weight)))
    
    rate = -1.0
    visited = set()
    
    # DFS recursive 
    def dfs(src, des, exch):
        nonlocal rate
        if src not in graph or des not in graph: 
            return
        if src == des:
            rate = max(rate, exch)
            return 
        visited.add(src)
        for neighbor, weight in graph[src]:
            if neighbor not in visited: 
                dfs(neighbor, des, exch * weight)

    # DFS Iterative 
    def dfs_iter(src, des):
        rate = -1.0
        if src not in graph or des not in graph:
            return rate 
        stack = [(src, 1.0)]
        visited = set()
        while stack: 
            currency, exch = stack.pop()
            if currency == des: 
                rate = max(rate, exch)
            if currency in visited:
                continue
            visited.add(currency)
            for neighbor, weight in graph[currency]:
                if neighbor not in visited: 
                    stack.append((neighbor, exch * weight))
        return rate
    
    # BFS doesn't work because it goes level by level and once we hit 
    # the currency we want to exchange the value to we can't go any further
    def bfs(src, des):
        rate = -1.0
        if src not in graph or des not in graph:
            return rate 
        queue = deque([(src, 1.0)])
        visited = set([src])
        while queue: 
            currency, exch = queue.popleft()
            if currency == des: 
                rate = max(rate, exch)
            for neighbor, weight in graph[currency]:
                if neighbor not in visited: 
                    print(neighbor, weight)
                    queue.append((neighbor, exch * weight))
                    visited.add(neighbor)
        return rate
    
    dfs(from_currency, to_currency, 1.0)
    reutrn rate 

maxAmountofExchange(exchanges, data[1], data[2])
```

Comments (8)

Thank you so much for posting these. Do you have the solution for question 1? Unsure about how to parse this!

8

Reply

```python
input1 = '''[
  {
    company_name: (BlackRock)
    ticker: (BLK)
    stack_price: {
      2022-04-03: ($930)
      2022-04-02: ($932)
    }
  },
  {
    company_name: (Apple)
    ticker: (APPL)
    stack_price: {
      2022-04-03: ($175))
      2022-04-02: ($178)
    }
  }
]'''

import re

def validParethesis(param):
    mapping = {')':'(',']':'[','}':'{'}
    new_param = re.sub(r'[\s\w:$,-]','',param)
    stack = []
    
    if len(new_param) <=1:
        return False
    
    for p in new_param:
        if stack and p in mapping:
            poped = stack.pop()
            if poped == mapping[p]:
                continue
            else:
                return False
        else:
            stack.append(p)
    
    if len(stack)==0:
        return True
    else:
        return False
  
validParethesis(input1)
```

4

Reply

For question 2, you should use Dijkstra. I don't think DFS or BFS is able to handle this.

1

Show 1 Replies

Reply

[vaari gupta](https://leetcode.com/u/vaarigupta/)

Aug 01, 2024

## Solution 1:

## Explanation

1. Stack Initialization: A stack is used to track the opening parentheses, brackets, and braces.
2. Matching Brackets Map: An unordered map is used to map each closing character to its corresponding opening character.
3. Processing Each Line: For each character in each line:
- If it's an opening character ((, \[, {), it is pushed onto the stack.
- If it's a closing character (), \], }), the stack is checked. If the stack is empty or the top of the stack does not match the corresponding opening character, the format is invalid.
- If a matching pair is found, the top of the stack is popped.
4. Final Check: After processing all lines, if the stack is empty, the format is valid. If the stack is not empty, the format is invalid.

```cpp
#include<iostream>
#include<stack>
#include<unordered_map>
#include<string>
#include<vector>

bool isValidFormat(const std::vector<std::string>& lines) {
    std::stack<char> stack;
    std::unordered_map<char, char> matchingBrackets = {{')', '('}, {']', '['}, {'}', '{'}};

    for (const auto& line : lines) {
        for (char ch : line) {
            if (ch == '(' || ch == '[' || ch == '{') {
                stack.push(ch);
            } else if (ch == ')' || ch == ']' || ch == '}') {
                if (stack.empty() || stack.top() != matchingBrackets[ch]) {
                    return false;
                }
                stack.pop();
            }
        }
    }

    return stack.empty();
}

int main() {
    std::vector<std::string> lines;
    std::string line;

    // Read lines from stdin
    while (std::getline(std::cin, line)) {
        lines.push_back(line);
    }

    if (isValidFormat(lines)) {
        std::cout << "Valid" << std::endl;
    } else {
        std::cout << "Invalid" << std::endl;
    }

    return 0;
}
```

## Solution 2:

## Explanation of Code

Note:

- Graph Representation: Each currency is a node, and each exchange rate is a directed edge with a weight representing the rate.
- Bellman-Ford Algorithm: This algorithm can handle graphs with negative weights, but in our case, all weights will be positive because they represent exchange rates. We will run the algorithm to find the maximum amount of the target currency.
1. Reading Input: The input is read line by line. The edges vector stores all the exchange rates.
2. Graph Representation: The graph is built using an unordered map where each currency maps to a list of pairs representing the destination currency and the exchange rate.
3. Bellman-Ford Algorithm: We initialize the distances to negative infinity (numeric\_limits::lowest()) and set the distance to the starting currency to 1.0. We then update the distances by iterating over the edges.
4. Result: After running the Bellman-Ford algorithm, the distance to the target currency is the maximum amount of the target currency obtainable from one unit of the starting currency.

```cpp
#include<iostream>
#include<vector>
#include<unordered_map>
#include<string>
#include<sstream>
#include<limits>
#include<queue>

using namespace std;

struct Edge {
    string from, to;
    double rate;
};

double maxCurrencyExchange(const vector<Edge>& edges, const string& start, const string& target) {
    // Build graph
    unordered_map<string, vector<pair<string, double>>> graph;
    for (const auto& edge : edges) {
        graph[edge.from].emplace_back(edge.to, edge.rate);
    }

    // Initialize distances with negative infinity
    unordered_map<string, double> dist;
    for (const auto& edge : edges) {
        dist[edge.from] = numeric_limits<double>::lowest();
        dist[edge.to] = numeric_limits<double>::lowest();
    }
    dist[start] = 1.0;

    // Bellman-Ford algorithm
    for (int i = 0; i < dist.size() - 1; ++i) {
        for (const auto& edge : edges) {
            if (dist[edge.from] != numeric_limits<double>::lowest()) {
                dist[edge.to] = max(dist[edge.to], dist[edge.from] * edge.rate);
            }
        }
    }

    return dist[target] == numeric_limits<double>::lowest() ? -1.0 : dist[target];
}

int main() {
    vector<Edge> edges;
    string line, original, target;

    // Read input
    while (getline(cin, line)) {
        if (line.empty()) break;
        stringstream ss(line);
        string from, to, rate;
        ss >> from >> to >> rate;
        from = from.substr(0, from.size() - 2);
        to = to.substr(0, to.size() - 1);
        double rateVal = stod(rate);
        edges.push_back({from, to, rateVal});
    }

    // Read original and target currencies
    getline(cin, original);
    original = original.substr(18); // Remove "Original currency: "
    getline(cin, target);
    target = target.substr(17); // Remove "Target currency: "

    double result = maxCurrencyExchange(edges, original, target);
    if (result == -1.0) {
        cout << "-1.0" << endl;
    } else {
        cout << result << endl;
    }

    return 0;
}
```

0

Reply

Thank you for sharing this! But IMHO the dfs you showed here might have some bugs. Essentially the dfs is backtracking, you should remove the src from the visited when you traverse all the neighbors of src. Let's say we have A->B->C->E, A->B->D->C->E. If we first do A->B->C first, the C will be marked as visited but A->B->D->C->E is also one possible way.

0

Reply

[Rajashekar Vennavelli](https://leetcode.com/u/rajashekarcs_2022/)

Nov 06, 2022

Does this solution work? can you please make it more understandable? there seems to be some issue in the code

0

Show 1 Replies

Reply

[Ankur Banerji](https://leetcode.com/u/ankurbanerji3/)

Oct 22, 2022

can you post the image of or at least the text of the 1st question?

0

Show 3 Replies

Reply

this algorithm is totally wrong lmao, worst dfs ever written, imagine 2 parallel route arriving at mid-point of original route, your algorithm wont go into that route because of marking as visited.

0

Reply

<iframe frameborder="0" allow="attribution-reporting; run-ad-auction" src="https://googleads.g.doubleclick.net/pagead/ads?client=ca-pub-3965754337269139&amp;output=html&amp;adk=1812271804&amp;adf=3025194257&amp;abgtt=6&amp;lmt=1783376693&amp;plaf=1%3A2%2C2%3A2%2C7%3A2&amp;plat=1%3A128%2C2%3A128%2C3%3A128%2C4%3A128%2C8%3A128%2C9%3A32776%2C16%3A8388608%2C17%3A32%2C24%3A32%2C25%3A32%2C30%3A1081344%2C32%3A32%2C41%3A32%2C42%3A32%2C43%3A32%2C44%3A32&amp;format=0x0&amp;url=https%3A%2F%2Fleetcode.com%2Fdiscuss%2F&amp;pra=5&amp;asro=0&amp;aimartd=4&amp;aieuf=1&amp;aicrs=1&amp;uach=WyJXaW5kb3dzIiwiMTkuMC4wIiwieDg2IiwiIiwiMTQ5LjAuNzgyNy4yMDEiLG51bGwsMCxudWxsLCI2NCIsW1siR29vZ2xlIENocm9tZSIsIjE0OS4wLjc4MjcuMjAxIl0sWyJDaHJvbWl1bSIsIjE0OS4wLjc4MjcuMjAxIl0sWyJOb3QpQTtCcmFuZCIsIjI0LjAuMC4wIl1dLDBd&amp;dt=1783376693187&amp;bpp=2&amp;bdt=29018&amp;idt=100&amp;shv=r20260701&amp;mjsv=m202606300101&amp;ptt=9&amp;saldr=aa&amp;abxe=1&amp;cookie=ID%3De50830e44224c594%3AT%3D1754951485%3ART%3D1782229753%3AS%3DALNI_MZIUHXDgBmi6-Ul9kV1KAPBeYLvtg&amp;gpic=UID%3D00000f1b39ca3434%3AT%3D1754951485%3ART%3D1782229753%3AS%3DALNI_MYA0hbYgdymXJ7OUcyp2YzSXaPn-g&amp;eo_id_str=ID%3D9b0dc56c3d9d3fc8%3AT%3D1781218171%3ART%3D1782229753%3AS%3DAA-AfjaCh7RTMWnMXDcBbQHtfPYP&amp;nras=1&amp;correlator=5983199755105&amp;frm=20&amp;pv=2&amp;u_tz=-240&amp;u_his=22&amp;u_h=1080&amp;u_w=1920&amp;u_ah=1032&amp;u_aw=1920&amp;u_cd=32&amp;u_sd=1&amp;dmc=16&amp;adx=-12245933&amp;ady=-12245933&amp;biw=1905&amp;bih=911&amp;scr_x=0&amp;scr_y=0&amp;eid=95395662%2C95393485&amp;oid=2&amp;pvsid=3473136330488084&amp;tmod=1287889648&amp;uas=3&amp;nvt=1&amp;fsapi=1&amp;ref=https%3A%2F%2Fwww.google.com%2F&amp;fc=1920&amp;brdim=0%2C0%2C0%2C0%2C1920%2C0%2C1920%2C1032%2C1920%2C911&amp;vis=1&amp;rsz=%7C%7Cs%7C&amp;abl=NS&amp;fu=32768&amp;bc=31&amp;bz=1&amp;pgls=CAk.&amp;ifi=1&amp;uci=a!1&amp;fsb=1&amp;dtd=117" title="Advertisement" aria-label="Advertisement"></iframe>