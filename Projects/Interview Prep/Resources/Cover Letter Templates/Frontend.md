
## Thesis
> I deliver UIs designed to help customers get the most out of my application, fulfill the mission I had when building the app, and are optimized for performance.

# Template

> Fill every **bold slot**. Bracketed `[optional]` sentences are the first things to cut if the letter runs past one page — trim paragraphs 2 and 3, never paragraph 4.

Dear Hiring Manager,

I am writing this letter to express my strong interest in joining the **Insert Position** at **Insert Company Name**. **Insert something that stood out to me in the job description.** *Insert follow up relating the responsibility to my technical skills.*

Your job posting states that you are looking for someone who is able to develop UI components with design and performance in mind. While pursuing my degree in Computer Science and Mathematics at NYU, I became very proficient in building responsive Typescript frontends through personal projects as well as courses such as Applied Internet Technology. 

My favorite project was undoubtedly Doculyze, an AI document analysis platform I first designed on Figma and then built component by component in Next.js. This way, the product shipped the way it was drawn rather than the way that was easiest to code. To keep each surface fast and discoverable, I held a strict Server and Client Component boundary — the marketing and auth routes stay server-rendered for SEO and first paint, while the client boundary sits as deep in the tree as possible so that only genuinely interactive components ship to client-side Typescript. I also kept as many routes statically generated as the data allowed, [and built the navbar on a Dynamic Island architecture so a single persistent shell morphs between states instead of remounting on every navigation.] For my chat service, possibly the most important component in the entire app, I streamlined it using Websockets with Redis caching behind it so responses stream instead of blocking and conversation context is saved. This allows users to receive responsive and context aware responses to any inquires answerable using their knowledge bases.

That same standard matters even more when the user is a colleague rather than a customer. As a Technology Analyst Intern at Barclays, I brought polished user accessibility to internal tools. I developed a cross-platform Electron desktop application in React that centralizes the resources my manager assigns for incident management in a two window split layout: a filterable resource tree on the left, navigable by click, and a right window that displays the selected resource as either an embedded browser or a file. An engineer working an incident never leaves the app to find what they need, and the tool was estimated to save roughly 140 hours per week across run-the-bank employees. I also built a single-page RAG alongside app support managers and fellow engineers — completely React and Webpack based, with files handled through presigned URLs — which was projected to save 200-300 hours of support time by enabling semantic search on critical recorded meetings and training content.

What particularly draws me to apply for **Insert Company Name** is **Why the company is special**.

Sincerely,
Thomas Wang


## Filling the Slots

#### Hook
Two sentences, no more. The first names a specific responsibility from the posting; the second connects it to a skill I can actually evidence in the paragraph that follows.

> Ex. The chance for me to combine my expertise in RAG pipelines, ML analysis, and DevOps to contribute to the company is something I will not miss on.

#### Second Paragraph
Ordered as **design fidelity → SEO boundary → static generation → interactivity → deploy**. Shift the weight to match the posting:
* **Design system / product role** — expand the Figma-to-Next.js translation, cut the Redis/Websockets sentence to a clause.
* **Performance role** — expand static generation and the Server/Client boundary, keep the Dynamic Island navbar sentence.
* **Realtime or infra-leaning role** — expand Websockets + Redis caching, compress the Figma sentence.

#### Third Paragraph
The point is not that I worked at a bank — it is that internal users deserve the same interface quality as customers. Lead with the Electron app for desktop, tooling, or platform roles; lead with the single-page RAG for AI-adjacent or search-heavy roles. Keep only one of the two if the letter is running long.

#### Why the Company is Special
Note down:
* Any interesting initiatives such as digitalization (AI adoption)
* Personal anecdotes with company services
* Technical projects aligning with my interests/expertise
* Supportive, innovative culture.
* Fun, rewarding proprietary events such as Hackathons

**Worked example — Google:**
> …the scale of impact my work will have on consumers. As a user of Google's NLP, API, and LLM services, I have experienced firsthand how much Google simplifies everyday tasks through its powerful search engine and its different resources such as HuggingFace. It excites me to apply my technical skills to perform maintenance and add features on pre-existing applications, and research new initiatives in geospatial mapping and the Universal Speech Model. Finally, there is nothing I would want more than to participate in the collaborative and innovative culture at Google. As an Events Lead at the Google Developer's Group at NYU, I greatly appreciate the willingness of countless Google Software Engineers to provide guidance to the young members of the club professionally and personally.


## Swap-in: NYC Neighborhood Recommendation Platform
Use in place of the Doculyze block when the posting is data, maps, or visualization heavy:

> My most recent project ranks 71 NYC neighborhoods against a prospective business's description, combining embedding relevance with a competitive-saturation score across 72 demographic and commercial features. The frontend is a Next.js application on Vercel talking to a FastAPI backend on Railway over a typed REST API, with interactive K-selection and feature-range controls rendered over a GeoJSON map. It is a small decision-support engine: take messy, real-world data and turn it into a score someone can actually act on.


## Before Sending
- [ ] One page. Paragraphs 2 and 3 are where it overruns.
- [ ] The company name appears at least twice, and paragraph 4 could not be sent to any other company.
- [ ] Addressed to a named person if one is findable; "Dear Hiring Manager" only as a fallback.
- [ ] Every number in the letter matches the resume.
- [ ] The language mirrors the posting's own terms for the skills it lists.
