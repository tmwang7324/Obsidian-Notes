# (C) Portfolio Manager

> BlackRock OA problem — 小红书 report ("OA+三轮Onsite", Portfolio Manager). Source embedded below.

#### Programming Challenge Description:
As a Portfolio Manager, you recently came across a hot new technology startup. You're confident that this is a great opportunity and want all of the portfolios you manage to have a stake in this startup. To reduce the risk of this venture, you must find a way to invest the maximum possible amount of money in the new company for as many of your portfolios as possible without violating any of your company's risk tolerance rules.

The set of Portfolios you manage are organized in a binary tree structure, where each portfolio is associated with at most two other child portfolios and each portfolio has at most one parent portfolio. A portfolio also has an integer attribute, A, that denotes the amount of funds the portfolio currently has available for making new investments.

When selecting portfolios for your new investment idea, a **risk violation** is triggered if
you select 2 portfolios that are directly related to each other. Given your client
portfolios as a serialized binary tree, find and print the maximum amount of money you can
invest in this tech stock without violating the risk tolerance rule.

### Input:
Input is in the form of a serialized binary tree representing the portfolios. Assume the
cash available for each portfolio is an integer. The serialization follows a **level-order
traversal**, where `#` signifies a path terminator where no node exists below. For example:

```text
    1
   / \
  2   3
     /
    4
     \
      5
```

The binary tree above is serialized as `1 2 3 # # 4 # # 5` (each value delimited by a single
whitespace character). Observe that, for the deepest level of the tree, there will not be
any `#` for the leaf nodes at the end. The integer value of each node denotes its quantity
of investable cash, A.

### Output:
The maximum amount of money you can invest without selecting two directly-related
(parent–child) portfolios.

![[BlackRock OA+三轮Onsite，难度比较高_3_数据Gold矿工咨询_来自小红书网页版 (1).jpg]]

## Pattern / Hint
- **Pattern:** this is **House Robber III** (LC 337) — max-weight independent set on a tree,
  where no chosen node may be adjacent (parent–child) to another chosen node.
- **Two sub-problems:** (1) rebuild the tree from the level-order `#`-terminated
  serialization (a queue-based deserialize), then (2) post-order DP returning a pair per
  node — `(best_if_rob_this, best_if_skip_this)`:
  - `rob = node.val + left.skip + right.skip`
  - `skip = max(left.rob, left.skip) + max(right.rob, right.skip)`
  - answer = `max(root.rob, root.skip)`.
- **Watch out:** the deserialization is the fiddly part — trailing leaves may omit their
  `#` children, so guard your queue against running out of tokens.

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
