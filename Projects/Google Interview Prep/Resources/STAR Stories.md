# Most Difficult Project
My most challenging project was undoubtably the AI-powered document analysis tool.

After getting an introduction to implementing microservices with my Golang project, I wanted to push myself further and gain experience building an application that can handle resilience issues, integrate generative AI models, and scalability. Thus, I set out to research more about building a context-aware system.

My first and hardest challenge was tackling the AI implementation. Instead of relying on pure LLMs, I wanted to design a mechanism that can store meaningful text as context and perform actions in a controlled environment. This involved deep diving into vector embeddings, how they store semantic meaning using sentenceTransformers. (cosine similarity). confguring a vector database such as ChromaDB, intelligent vector storage, and improved retrieval algorithms. To simplify programming, I learned the LangChain framework, which provides proprietary Transformer models, LLMs, chunking algorithms, retrieval strategies, and prompt design. Everything one needs for RAG.

Another challenge was the infrastructure and CI/CD development. I wanted to move away from a monolithic deployment to a fully containerized microservices architecture. I wrote efficient dockerfiles to keep image sizes low and ensure consistent environments between the Python AI FastAPI backend, the Express.js API gateways, and the React frontend. Furthermore, I taught myself how to incorporate message brokers such as RabbitMQ into my architecture to loosely couple my programs. Next, I taught myself Kubernetes concepts such as creating and managing pods, services, and NGINX Ingress controllers. One of my main challenges here was with service discovery. It took many hours of debugging for me to successfully connect the Python AI backend to the User Access API. Furthermore, I taught myself how design a declarative pipeline in Jenkins that triggers on Github actions, and lints, tests, and builds my code.

In the end, I successfully deployed a system where users can upload documents and receive accurate AI-generated summaries in real-time. But, most important was the experience of learning everything from scratch.


# Have you ever used a Design Pattern?
**Singleton Pattern** for sure. Every instance of a database connection I established within a project, whether it be MongoDB, PostgreSQL, or Qdrant follows this apttern. In my Express.js or Python FastAPI backends, I utilized the Singleton pattern to create database clients. This ensured that each program would reuse the same connection rather than opening a new connection for every single request.

**Observer Pattern**: RabbitMQ message queuing in my AI Document Analysis Platform. RabbitMQ operates as an observer pattern by notifying the LangChain pipeline to execute whenever a new document is uploaded.
Firebase also supports state observers for auth. I used this to change the UI based on if the user is logged in or not.

import heapq
li = [25, 20, 15, 30, 40]
heapq.heapify(li)
print("Heap queue:", li)