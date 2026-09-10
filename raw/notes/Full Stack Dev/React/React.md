# Overview
Created 



## How it Works
Modular libraries such as **React** don't interact with the DOM *directly* in the way I'd write `document.getElementById()`. It uses a **Virtual DOM**, a lightweight in-memory representation of the real DOM. React diffs the virtual tree against the previous version and **batch-applies** the minimum set of real DOM updates. So, it actually *does* touch the real DOM, just through an abstraction layer.

### Why the Virtual DOM is More Efficient

1. **Batching** — Raw DOM calls trigger the browser to recalculate layout and repaint on every mutation. Ten changes = ten reflows. The Virtual DOM collects all changes in memory, diffs against the previous state, and applies the minimal set of real DOM updates in one batch. Ten changes might collapse into two actual DOM writes.

2. **Declarative vs. imperative** — With raw DOM code, *you* have to figure out what changed and what to update. Get it wrong and you either update too much (slow) or too little (bugs). The Virtual DOM shifts that burden to the framework — you describe what the UI *should* look like given the current state, and React figures out the cheapest way to get there. You stop thinking about transitions ("change X to Y") and start thinking about snapshots ("given this state, render this").

The Virtual DOM isn't inherently faster than a single, perfectly-targeted `getElementById` call — a hand-written surgical DOM update will always be faster in isolation. The win is that at scale, humans write bad imperative DOM code, and the Virtual DOM's diffing algorithm consistently produces near-optimal batched updates without you thinking about it.