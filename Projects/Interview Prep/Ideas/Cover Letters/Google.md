# Overview
Built from [[SWE]]. Four paragraphs: hook → credentials+project → adaptability → why Google.

PROJECTS
NYC Neighborhood Recommendation Platform - Typescript, Python, PostgreSQL Link/github
● Built and deployed a full-stack AI application that ranks 71 NYC neighborhoods by demographic and
competitive fit for a user’s prospective business, with a Next.js frontend on Vercel and a FastAPI backend on
Railway, connected via typed REST API with environment-based CORS and health-check monitoring.
● Engineered unsupervised K-means clustering pipeline over 72 features spanning demographics, foot traffic,
business density, safety metrics, and transit access, with interactive K-selection and feature-range controls across
CDTA geographies, displayed as an interactive GeoJSON map.
● Developed a semantic ranking engine that scores neighborhoods against a business profile using vector
embeddings, with HyDE and Supabase-backed retrieval, business survival rate inference, as well as a
competitive-saturation ratio, with an Anthropic Claude agent generating natural-language rationale.● 
## Cover Letter
**  

Dear Hiring Manager,

I am writing to express my strong interest in the Early Career Software Engineer role at Google. The first time Firebase turned thirty lines of auth code into three, I stopped thinking of Google as a product company, but rather a toolmaker that reshapes how millions of engineers build. Instead of simply using these tools, I want to be on the side that forges them using my expertise in embedding pipelines, machine learning, and microservice architecture to contribute at scale.

While I studied Computer Science and Mathematics at NYU, my interests converged on AI-driven systems. My capstone was Doculyze, a RAG document assistant where the core challenge was retrieval accuracy. Base embeddings retrieved relevant chunks roughly half the time which is enough to demo, not to trust. I built an eval harness, then improved in stages: reranking to surface better results from the same set, NER-based cross-document filtering so a query requiring reasoning across multiple documents is possible, and finally adding a query decomposition layer to handle multi-part questions. Each layer was added because the harness proved the gap, yielding a ~50% accuracy gain over baseline. Making the pipeline production-ready meant moving embedding onto an async RabbitMQ queue behind its own containerized service and streaming chat over WebSockets with Redis caching. It’s a small system, but it’s what inspired me to work where scale makes these problems unforgiving rather than merely inconvenient.

What sets me apart from other candidates is my ability to adapt quickly. Last summer, I arrived as a Technology Analyst Intern at Barclays with no knowledge of the bank’s NLP stack and shipped a meeting knowledge search chatbot projected to save 200–300 hours of employee downtime per week. I’ve since applied the same instinct to a different shape of problem: my NYC platform ranks 71 neighborhoods for commercial viability, where static demographic data such as income and population can’t capture whether a market can absorb another business. The nuance was engineering dynamic friction metrics: a saturation index rating each business type against localized demand, anchor proximity, and category synergy. Moving from static features to these derived signals is what made supervised business survival inference viable across neighborhoods.

What particularly draws me to Google is the breadth of its engineering surface. Google doesn't just ship consumer products, it builds the infrastructure of AI research, allowing systems like Gemini and AlphaFold to become tools that reshape entire fields. Having built retrieval and inference pipelines at a small scale, as well as enterprise service health management pipelines, I am very interested in engineering challenges presented in this job's responsibilities, which focus on improving accuracy, latency, and reliability. Finally, there is nothing I would want more than to participate in the collaborative and transparent culture at Google. As the Events Lead at the Google Developer’s Group at NYU, I saw this firsthand: Google Software Engineers volunteered their time not to recruit, but to genuinely mentor students. This willingness to lift others is the kind of culture I aspire to contribute to.

Thank you for considering my application. I am eager to discuss how my skills and experiences align with Google’s needs in more detail.


