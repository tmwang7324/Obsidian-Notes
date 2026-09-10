# Roblox — Early Career Software Engineer

Built from [[SWE]]. Four paragraphs: hook → credentials+project → adaptability → why Roblox.

---

**

Dear Roblox Hiring Team,

I am writing to express my strong interest in the Early Career Software Engineer role at Roblox. It is one of the few places where the two things I love most as a software engineer intersect: thinking in terms of distributed systems, and experimenting with AI-driven workflows. While I studied Computer Science and Mathematics at NYU, my course work and personal projects converged around embedding pipelines, non-linear model training, as well as microservice architecture.

My favorite among these projects was Doculyze, a RAG document assistant and my first real cloud-native project, the first time a workload dictated my architecture rather than the other way around. Embedding is slow and bursty in a way ordinary requests are not, so it belonged on an asynchronous RabbitMQ queue behind its own containerized service rather than in the request path, where a large upload would stall a live conversation. Deploying it meant learning to orchestrate those containers on Kubernetes so a new version could roll out without taking the assistant offline, and improving answer quality meant experimenting my way through HyDE, reranking, and chunking strategies. It is a small system, but it is why I want to work where scale makes these problems unforgiving rather than merely inconvenient.

What sets me apart from other candidates is my ability to adapt quickly. Last summer I arrived at Barclays as a Technology Analyst Intern knowing nothing about the bank's internal NLP models, and shipped a video knowledge-search chatbot. Most of that summer went to learning rather than building: first earning access to the models, then chaining transcription in AWS Transcribe, vector retrieval in Qdrant, and generation with Llama into something a non-engineer would actually open. Built with IT service management staff, the finished tool was projected to save 200–300 hours of employee downtime per week by enabling semantic search on critical recorded meetings and training content. I have since applied the same instinct to a different shape of problem, ranking 71 NYC neighborhoods for commercial viability, where the hard part was not retrieval but reconciling conflicting and imperfect sources well enough to infer whether a business had closed.

What particularly draws me to apply for Roblox is the unifying environment the platform facilitates among both players and developers. My sister introduced me to Roblox through Adopt Me and parkour experiences, and I was skeptical at first as I could not find the gameplay in them. That changed when I started playing progressive boss fight experiences with my friends and caught myself marveling at the development effort behind them, which led me to the enormous developer community that builds them. Roblox does not only connect players; it also connects people who are passionate about building, allowing them to express themselves freely. That is what makes the team matching process so exciting: I want to be matched on genuine curiosity rather than assigned to fill a seat, whether that turns out to be Infra, Search & Discovery, or Foundational AI. Coupled with a renowned culture of innovation and the opportunity to collaborate with interdisciplinary teams such as Data and DevOps, that is the leverage I want at the start of a career. I would welcome the chance to talk about how I could contribute as an Early Career Software Engineer.

Sincerely,  
Thomas Wang

**

---

## Notes on this version

**Hook.** Quotes the ML/LLM bullet verbatim, then pairs it with the 2 trillion events figure from a different bullet. The point is not the quote — it's noticing the *relationship* between two bullets, which proves the posting was read rather than skimmed. It also sets up P2's closing inversion, which now has a real number behind it.

**NYC survived, Electron lost.** The JD names **Search & Discovery** as a team you can match into. NYC is a ranking and relevance system — it maps to a named team. Electron would also have been a second Barclays item inside a paragraph whose whole arc is *arrived somewhere unfamiliar*, which flattens it into a job summary. Reconsider only if you target a pure product/frontend req.

**Kubernetes stayed, but earned it.** The deployment claim now carries a *why* (roll out without taking the assistant offline) instead of naming a pattern. Blue-green-canary and EKS came out — naming deployment patterns is exactly the overclaim your own thesis note warns against for an early-career req. Retrieval tuning is framed as *experimenting my way through*, which mirrors the JD's own verb and stays honest about how it actually went.

**P4 is ported from [[(C) Roblox Cover Letter — User Frameworks]].** The Adopt Me → boss fights → developer community arc carries over unchanged; it is the most specific and least fakeable thing in the letter. Two changes: the Foundation Design System sentence became the team matching sentence (Infra / Search & Discovery / Foundational AI all reaching the same community), and the sign-off names the Early Career role. What was lost in the swap: the old P4 ended by echoing P2's "used by someone other than their author." Say the word if you want that echo worked back in.

**Length is now the problem** (~560 words; a cover letter should land 300–400). These cuts are no longer optional — take at least the first two:
1. The Kubernetes clause in P2 — the RabbitMQ decision already carries that paragraph.
2. "Built with IT service management staff" in P3.
3. Compress the P4 origin story from three sentences to two, keeping the boss-fight turn and dropping the setup.

**Open question — the Barclays specifics.** This file names internal tooling and a projected-savings figure, and the vault is a git repo. Sending it in a letter and committing it to version control are separate decisions.
