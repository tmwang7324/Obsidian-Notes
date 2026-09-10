# Overview
A **MIME type** (now officially called a **Media Type**, but also known as a content type) is a standardized label used to dientify the format and nature of a file or data transmitted over the internet.

It stands for **Multipurpose Internet Mail Extensions** and is standardiszed in IETF's RFC 6838.

# MIME Structure
A MIME type most commonly consists of just two parts: a *type* and *subtype*, spearated by a slash (`/`) --- with no whitepsace between:  `type/subtype`

The **type** represents the general category into which the data type falls, such as `video` or `text.`

The **subtype** identifies the exact kind of data of the specified type the MIME type represents. For example, for the MIME type `text`, the subtype might be `plain` (plain text), `html` ([[HTML]] source code), or `calendar` (for iCalendar/`.ics`) files.

## Examples
`text/markdown`, `text/plain`, ``