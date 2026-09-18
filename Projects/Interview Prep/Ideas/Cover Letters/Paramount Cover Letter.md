# Paramount — AI Tooling & Quality Engineering Platforms, Software Engineer

*Tailored from [[AI Engineer]]. Retuned against the posted JD (Global Quality Engineering org).*

---

Dear Hiring Manager,

I am writing this letter to express my strong interest in joining the Global Quality Engineering team as a Software Engineer at Paramount Skydance. What drew me to this company is that it is explicitly not an "in test" role: the work is production software that other engineers rely on. The chance for me to combine my expertise in RAG pipelines, ML analysis, and DevOps to help Paramount’s renowned platforms continue presenting the stories and live moments its audiences depend on is an opportunity I will not miss on.

While pursuing my degree in Computer Science and Mathematics, I participated in technically rich courses such as Fundamentals of Machine Learning, as well as a two-month summer internship with Barclays. I arrived at Barclays having none of the bank's available NLP models, and shipped a meeting and video knowledge search chatbot regardless. Getting there meant first earning access to those models, then learning how to use them from scratch. I studied OpenAI Whisper to generate subtitles, Qdrant to perform vector retrieval, and Llama for text generation. Built alongside app support managers and fellow engineers, the finished tool was projected to save 200–300 hours of employee downtime per week. It was internal tooling in the truest sense.

The main inspiration of this project was a RAG document analysis platform I built with Next.js, Firebase, and LangChain. I sharpened my model's semantic retrieval through techniques such as HyDE, VoyageAI rerankers and embedding models, as well as intelligent chunking, increasing the accuracy of answers by 50%, a number I trust only because I built the evaluation harness to measure it. To accommodate the resource-intensive backend and its data security requirements, I decided to build this app on a microservice architecture, connected by RESTful APIs and RabbitMQ. Shipping it involved building efficient Docker containers, orchestrating them in a blue-green pattern with Kubernetes, and deploying them to AWS EKS: releases that could go out, and roll back, without a user noticing.

My interest in AI followed my most recent project, a platform that ranks 71 NYC neighborhoods against a prospective business's description, combining embedding relevance and business lifespan regression with a competitive-saturation score across 72 demographic and commercial features. Deployed on Vercel and Railway, it is a small decision-support engine: take messy, real-world data and turn it into a score someone can actually act on, which is, at bottom, what defect triage asks of a system too.

What particularly draws me to this role at Paramount is the scale of impact my work will have. Tooling and quality platforms are force multipliers: an AI-assisted test or a faster, more resilient release pipeline pays out across every engineer and every beloved service behind it. I am also genuinely a fan of the medium. CBS's Champions League coverage is a legendary viewing I rarely skip. Finally, I am very eager to grow within Paramount’s supportive environment. I am at the point in my career where I improve fastest around senior engineers who hold a high standard for the platforms everyone else builds on, and that is exactly the room Paramount offers.

Sincerely,  
Thomas Wang

  


---

## Notes before sending
- Confirm the entity name on the posting — "Paramount Skydance Corp" in the JD, so the letter uses **Paramount Skydance**. Match whatever the application portal says.
- Barclays paragraph stays generic on purpose — no internal system names, per vault rule.
- If you get an interview, the log-summarization → Whisper/Qdrant parallel is your strongest story. Have the retrieval-quality details ready (why HyDE, why a reranker, how you measured the 50%).
- You dropped the "recent NYU grad with a double major in Computer Science and Mathematics" line from ¶1. The degree still surfaces in ¶2, but the letter no longer states you are a new grad up front. Deliberate or not, worth a second look.

## JD → evidence map
| JD responsibility                      | Where the letter answers it                                |
| -------------------------------------- | ---------------------------------------------------------- |
| Backend services, CLIs, internal tools | Barclays chatbot; microservices + REST + RabbitMQ          |
| AI-assisted test generation            | Eval-harness sentence (¶3)                                 |
| Log summarization                      | Whisper → searchable recordings (¶2)                       |
| Defect triage                          | Messy data → actionable score (¶4)                         |
| RAG pipelines, embeddings workflows    | HyDE, rerankers, chunking (¶3)                             |
| AI tooling into CI/CD                  | Docker → K8s blue-green → EKS (¶3)                         |
| Cross-team collaboration               | "alongside app support managers and fellow engineers" (¶2) |
| Under senior guidance                  | "joining to learn" close (¶5)                              |
