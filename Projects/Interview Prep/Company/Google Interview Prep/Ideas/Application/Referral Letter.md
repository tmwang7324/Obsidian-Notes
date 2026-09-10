# (C) Referral Letter

Third-person version of the Google referral letter. Source: [[Google|Cover Letter Draft]].

---

Dear Hiring Manager,

I am writing to wholeheartedly recommend Thomas Wang for the 2026 Software Engineer New Graduate Program at Google. Having closely observed his academic and professional development, I am confident that his strong foundation in Computer Science and Mathematics, combined with his hands-on experience with embedding pipelines, non-linear model training, and microservices architecture makes him an excellent candidate for your technology team.

His most exceptional project is Doculyze, a Retrieval Augmented Generation document assistant built end-to-end with Next.js, Firebase, and LangChain. What impressed me most was how he let the workload dictate his architecture rather than the other way around. He determined that his embedding pipeline belonged as its own Docker containerized service served by an asynchronous RabbitMQ queue rather than in the request path, so a large upload would not stall a live conversation. Following this, the live chat component, streamlined with Websockets and Redis Cache, was also containerized. Deploying the project involved orchestrating the containers in a blue-green-canary pattern with Kubernetes, which ensures that a backup pod is always ready and new changes are routed to a non-production facing pod. He also tuned the retrieval layer through HyDE, reranking, metadata tag filtering, and structure aware chunking, verifying tangible improvements with an evaluation harness.

One of his most standout qualities is his remarkable ability to rapidly learn and apply new technologies. Last summer he arrived at Barclays as a Technology Analyst Intern knowing nothing about the bank's internal NLP models, yet shipped a video knowledge-search chatbot regardless. He overcame significant challenges: first earning access to the models, then chaining transcription in AWS Transcribe, vector retrieval in Qdrant, and generation with Llama into something a non-engineer would actually open. Built with IT service management staff, the finished tool was projected to save 200–300 hours of employee downtime per week by enabling semantic search on critical recorded meetings and training content. He has since applied the same instinct to a different shape of problem, ranking 71 NYC neighborhoods for commercial viability, where the hard part was not retrieval but reconciling conflicting and imperfect sources well enough to provide a solid dataset for a Survival Random Forest model on business survival rate.

What particularly motivates his interest in Google is the breadth of its engineering surface. As someone who actively builds on Google Cloud, Firebase, and TensorFlow, he understands firsthand that Google doesn't just ship consumer products — it builds the infrastructure other companies run on. He wants to work on and own improvements that ripple across millions of developers and billions of users. 

Finally, I have been consistently impressed by his collaborative spirit and leadership. As Events Lead for the Google Developer’s Group at NYU, he has worked closely with Google engineers who have generously offered mentorship, experiences that have reinforced his desire to contribute to Google’s transparent and team-oriented culture.

Thank you for considering his application. I am confident he would be a strong addition to Google's engineering team, and I encourage you to speak with him directly.



## <= 150 Words Version

Dear Hiring Manager,

I am writing to recommend Thomas Wang for the 2026 Software Engineer New Graduate Program at Google. As [his mentor at ___], I have watched him grow into an engineer whose judgment exceeds his experience level.

The clearest example is Doculyze, a RAG document assistant he built end-to-end. When he realized embedding was too slow for the request path, he broke it into its own containerized service behind an asynchronous RabbitMQ queue — a level of architectural ownership rare for someone without industry experience. He applied the same reasoning across the stack, orchestrating everything with Kubernetes and validating retrieval improvements against an evaluation harness he built himself.

He showed the same instinct at Barclays, arriving with zero knowledge of the bank's NLP stack and shipping a chatbot projected to save 200–300 hours of employee downtime per week.

I am confident he would be a strong addition to your engineering team.

Sincerely,
[Name]
