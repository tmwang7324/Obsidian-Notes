# Overview
Server Actions are serverless functions that run on the server and can be directly called from both Client and Server components. They are designed for **mutations** --- form submissions, database writes, updating data.


Next.js has a default 1 MB **serversActions.bodySizeLimit.** So, **do not send entire files using server actions.**

