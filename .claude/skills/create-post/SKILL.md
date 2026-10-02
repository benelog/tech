---
name: create-post
description: Writing guide for this English-language tech blog - post header fields, structure, tone, and AsciiDoc conventions. Consult it first for any work that creates or edits .adoc files under src/content/ (new posts, revisions, copy-editing, header fixes).
---

# Blog Post Writing Guide

Conventions for `src/content/*.adoc`. The site is served at https://tech.navercorp.com/ for an English-speaking
audience. Many articles are English rewrites of posts from the Korean blog https://blog.benelog.net/ ; when an
article has a Korean original, link to it in the References section.

## 1. Header

### Required fields

```adoc
= Post Title
Sanghyuk Jung
2026-10-03
:jbake-type: post
:jbake-status: published
:jbake-tags: tag1, tag2
:description: One-sentence summary used for search results and social previews
:idprefix:
```

### Optional fields

```adoc
:jbake-last_updated: 2026-10-03
:jbake-og: {"image": "img/topic/thumbnail.png"}
:toc:
:sectnums:
:toclevels: 1
:source-repo: https://github.com/benelog/example
:source-link-base: {source-repo}/tree/master
```

### Field notes

- **Author line**: `Sanghyuk Jung`. `site.author` in `jbake.properties` is the fallback.
- **Tags**: 3 to 5, lowercase, hyphenated (`mysql`, `jdbc`, `spring-batch`, `java`, `git`, `linux`, `claude-code`). Reuse existing tags before inventing one; check `output/tags/` after a build.
- **description**: 120 to 250 characters. Always set it on new posts. Keep the keywords consistent with the title.
- **jbake-last_updated**: add only when a published post is revised. Never change the original date.
- **jbake-og**: set when the post has a representative image.
- **toc**: recommended for technical posts with three or more sections. `:sectnums:` for step-by-step material.

The file name is the URL (`/<slug>.html`). Use short, hyphenated, descriptive slugs.
If a published post is renamed, add a redirect at the hosting layer and note it in the commit message.

## 2. Structure

### Opening

The first paragraph states the problem or motivation and what the article covers. No preamble about the author.

> Batch jobs stress a JDBC driver differently from a web application. ... This article walks through the options that matter most for batch work.

For a follow-up to an earlier post, summarize the previous conclusion in one line, link it, and narrow the scope in one sentence.

When claiming something is free or cheap, state the assumptions (traffic, free-tier limits, call frequency) in the next sentence.

### Body

- `==` (h2) for main sections, `===` (h3) only when subdivision is needed.
- Long articles follow: background, concept, concrete example, caveats.
- When several approaches exist, compare trade-offs rather than prescribing one.

### Section headings

- Noun phrases, not sentences. "Streaming Results One Row at a Time", not "How do we stream results?".
- Concrete words: technology names, option names, error messages. "Error caused by verifyCursorPosition=true" beats "A pitfall".
- Title Case for h2 and h3. Keep the spelling of technical terms identical to the body.

### Closing

- End with a `== References` section. A conclusion paragraph is optional.
- No calls to comment or share.

```adoc
== References

* https://example.com[Title or description]
* link:other-post.html[Related post on this blog]
* https://blog.benelog.net/slug.html[Korean original of this article]
```

Group references in a two-level list only when there are many; a group with one item stays at the top level.

### Attribution for AI-assisted writing

If an AI tool helped write the post, add a rule and one line after the References section:

```adoc
'''

This post was written by Sanghyuk Jung with help from Claude Code.
```

### Reproduction steps for setup articles

When an article wires several external systems together, include a numbered list of steps near the top or at the
start of the main section so that a reader can reproduce the result without following other articles.

## 3. Tone and Style

- Plain, direct technical English. Short sentences; one idea per sentence.
- First person singular ("I measured", "I recommend") is fine for opinions and experience. Mark opinions as such.
- Prefer concrete numbers, versions, and option names over vague adjectives ("faster", "a lot").
- Avoid filler ("it is worth noting that", "basically", "simply"), hedging stacks ("might possibly"), and marketing adjectives.
- Spell out acronyms on first use unless universally known (JDBC, SQL, JVM are fine; OOM, DBCP need expansion).
- Use US spelling. Serial comma. No em-dashes; split the sentence or use a colon.
- Product and API names keep their official casing: `PreparedStatement`, Connector/J, Spring Batch, MySQL.
- Version-specific behavior always names the version: "In Connector/J 8.0.30 and later".

## 4. AsciiDoc Conventions

### Code blocks

Always set the language, and give a block title (one leading dot) that names the file or describes the snippet:

```adoc
[source,java]
.JdbcCursorItemReader for streaming queries in MySQL
----
return new JdbcCursorItemReaderBuilder<T>()
  ...
----
```

When quoting a configuration file from an external repository, link the GitHub path in the prose and use the
file's basename as the block title.

### Tables

```adoc
[cols="1,2,2", options="header"]
|===
|Item |Description |Notes

|Value
|Text
|Text
|===
```

### Links

- Internal posts: `link:other-post.html[Title]` with the `.html` extension.
- External: bare URL with a bracketed label, `https://example.com[Label]`.

### Images

```adoc
image::img/topic-slug/filename.png[Alt text,width=600]
```

Images live in `src/content/img/<topic-slug>/`. Use `image::` for block images and `image:` for inline ones.
Credit the source of any image that is not yours.

### Quotes, admonitions, footnotes

```adoc
[quote, Author, Source]
____
Quoted text
____

[NOTE]
====
Side note.
====

Body text footnote:[Footnote text with a source URL.]
```

### Change log (long-lived posts)

```adoc
.Revision history
* 2026-10-03
** Description of the change
```

## 5. Checklist

- [ ] Header has type, status, tags, description, idprefix
- [ ] Title and description keywords agree with the body
- [ ] `:jbake-og:` set if the post has a representative image
- [ ] First paragraph states the purpose
- [ ] h2 and h3 are concrete noun phrases in Title Case
- [ ] Every code block has a language and a title
- [ ] Images are under `src/content/img/<topic-slug>/`
- [ ] References section exists; Korean original linked if there is one
- [ ] Tags reuse existing ones
- [ ] `./gradlew bake` succeeds and the post renders at `output/<slug>.html`
