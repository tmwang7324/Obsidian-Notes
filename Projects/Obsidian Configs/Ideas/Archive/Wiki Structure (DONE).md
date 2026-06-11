# Important 
#### Should Wikis be Organized By Project?
>[!multi-column]
>
>> [!advantages]
>> * Simple folder structure for LLM to edit and read. Saves context
>> * User friendly as well.
>> * 
>
>> [!disadvantages]
>> * Issue when multiple projects share the same topics and approaches.
>> * The examples in conceptual notes are circular. For example, if a project uses Next.js, then its Next.js page shares progress from the project which is already in 

**DECISION:** Solution can be to have standalone note files for overarching topics and frameworks such as Next.js, Firebase, and design patterns. These standalone files should reference specific project files. However, significant design decisions, overviews, and architecture should be unique for each project.

Each Project folder in wiki should have an *Architecture.md.* If it's a programming project, then the file should be self-explanatory. If it's non-coding, then the file should contain a general plan I collaborate with AI to generate.

**Extra Important:** Every wiki file header should include a structured metadata section (2 lines). This ensures that even if an LLM retrieves jus
## Does Folder Organization Matter for RAG?
LLMs read the **content** of files, not their names or folder paths. An LLM will extract the same information from a document whether or not it is in a specific directory.

However, organizing files in properly categorized directories help reduce context sizes. Say, if I want to ask only about DocuLyze architecture, the LLM should ingest the *Tech Architecture* document only. Not *Progress*, *Important Decisions*, etc.

See more at [[Should Progress be Included in Wiki (DONE)]]

Use local LLMs to organize files cleanly into folders in wiki [[Integrate Local Models (IN PROGRESS)]]


