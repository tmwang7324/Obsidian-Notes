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


I am writing to express my strong interest in the Early Career Software Engineer role at Google. The first time Firebase turned thirty lines of auth code into three, I stopped thinking of Google as a product company, but rather a toolmaker that reshapes how millions of engineers build. I aim to be on the side that forges these tools utilizing my expertise in embedding pipelines, non-linear model training, and microservice architecture to contribute at scale.  

My favorite project was Doculyze, a Retrieval Augmented Generation document assistant built end-to-end with Next.js, Firebase, and LangChain. The reason why I found this project so enjoyable was because it was my first cloud native project, and the first time a workload dictated my architecture rather than the other way around. Embedding is slow and bursty in a way ordinary requests aren't, so it belonged on an asynchronous RabbitMQ queue behind its own containerized service rather than in the request path, so a large upload would not stall a live conversation. Following this microservices architecture, the live chat component, built with Websockets combined with Redis, is also containerized.  Deploying the project involved orchestrating the containers in a blue-green-canary pattern with Kubernetes, which ensures that a backup pod is always ready and new changes are routed to a non-production facing pod. I also tuned the retrieval layer through HyDE, reranking, metadata tag filtering, and structure aware chunking, verifying tangible improvements with an evaluation harness.

What sets me apart from other candidates is my ability to adapt quickly. Last summer I arrived at Barclays as a Technology Analyst Intern knowing nothing about the bank's internal NLP models, yet shipped a video knowledge-search chatbot regardless. Most of that summer went to learning rather than building: first earning access to the models, then chaining transcription in AWS Transcribe, vector retrieval in Qdrant, and generation with Llama into something a non-engineer would actually open. Built with IT service management staff, the finished tool was projected to save 200–300 hours of employee downtime per week by enabling semantic search on critical recorded meetings and training content. I have since applied the same instinct to a different shape of problem, ranking 71 NYC neighborhoods for commercial viability, where the hard part was not retrieval but reconciling conflicting and imperfect sources well enough to provide a solid dataset for a Survival Random Forest model on business survival rate.

 What particularly draws me to Google is the breadth of its engineering surface. Google doesn't just ship consumer products, it builds the infrastructure other companies run on, from Kubernetes to TensorFlow to Cloud. I want to work on and own improvements that ripple across millions of developers and billions of users. Finally, there is nothing I would want more than to participate in the collaborative and transparent culture at Google. As the Events Lead at the Google Developer’s Group at NYU, I saw this firsthand: Google Software Engineers volunteered their time not to recruit, but to genuinely mentor students. This willingness to lift others is the kind of culture I aspire to to contribute to.

Thank you for considering my application. I am eager to discuss how my skills and experiences align with Google's needs in more detail.



**Finally, there is nothing I would want more than to participate in the collaborative and innovative culture at Google. As the Events Lead at the Google Developer’s Group at NYU, I got to see appreciate the willingness of countless Google Software Engineers to provide guidance to the young members of the club professionally and personally. the young members of the club professionally and personally. As the Events Lead for Google Developer Group at NYU, I saw thi ambition and the up close: Google engineers who volunteered their time to mentor students carried the same drive to lift others that I want to bring to the team.
 What particularly draws me to apply for Google’s New Graduate program is the scale of impact my work will have on consumers. Google not only simplifies everyday tasks through its powerful search engine and quintessential apps such as Gmail, but also runs many modern tech stacks through tools like Kubernetes. This raises the question: how It excites me to apply my technical skills to perform maintenance and add features on pre-existing applications, and research new initiatives in these areas,. Finally, there is nothing I would want more than to participate in the collaborative and innovative culture at Google. As the Events Lead at the Google Developer’s Group at NYU, I got to see appreciate the willingness of countless Google Software Engineers to provide guidance to the young members of the club professionally and personally.