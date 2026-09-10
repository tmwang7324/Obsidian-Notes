# Client-Server Communication History

## Prehistory — HTML and the DOM

**HTML came first** (1991) — a markup language and document format. The browser parses HTML into an internal tree structure. The **DOM** (Document Object Model) came later (standardized ~1998 by the W3C) as a programming interface that exposes that tree to JavaScript, letting scripts interact with the already-rendered document. Before the DOM was standardized, there was no consistent way for scripts to manipulate the page — which is partly why the form-submit-and-reload model was the only game in town for so long.
Modular libraries such as **React (** don't interact with the DOM *directly* in the way I'd write `document.getElementById()`. It uses a **Virtual DOM**, a lightweight in-memory representation of the real DOM. React diffs the virtual tree against the previous version and **batch-applies** the minimum set of real DOM updates. So, it actually *does* touch the real DOM, just through an abstraction layer.

## Era 1 — HTML Forms (Pre-2005)

Originally, the only tools were the HTML page and the server. The sole mutation primitive was the **HTML `<form>` element**. A form submits data to an action URL that the server processes, then redirects the user to a result page.

This is why the default behavior of `<input type="submit">` is a **page refresh** — it's a holdover from this era.

**The problem:** every single mutation on the server involved a full page refresh. This completely nullifies the concept of client-side state and presents massive UX performance issues — any in-memory state is destroyed on every interaction.

**The benefit:** the UX and the server were tightly coupled. Sending data back and forth between client and server was trivially easy — submit a form, the server always acts on it, done. No serialization layer, no API contracts.

## Era 2 — AJAX and SPAs (2005+)

Jesse James Garrett coined the term **AJAX** in 2005, which enabled asynchronous communication between the client and server without full page reloads. This shift made **RESTful APIs** practical — instead of the server ***rendering*** and routing between full HTML pages, you could have a **SPA (Single Page Application)** that rewires the current page's DOM instead of loading entirely new pages.
