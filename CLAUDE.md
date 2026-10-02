# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

English-language static tech blog ("Benelog Tech Notes") by Sanghyuk Jung (benelog), served at https://tech.benelog.net/.
Built with JBake 2.6.7 via the `org.jbake.site` Gradle plugin 5.5.0. The toolchain and templates are shared with the
Korean blog in `../blog` (https://blog.benelog.net/); articles here are English rewrites or originals.

## Build Commands

```bash
# Build the site (generates into output/)
./gradlew bake

# Clean and rebuild
./gradlew clean bake
```

Requires JDK 25 (configured via `.sdkmanrc` as `25-tem`). Use `sdk env` if using SDKMAN.

## Architecture

- **Content**: `src/content/` — AsciiDoc (`.adoc`) files. Types: `post`, `page`, `alltags`.
- **Templates**: `src/templates/` — FreeMarker (`.ftl`). Theme derived from "Future Imperfect" (HTML5 UP, ported by manikmagar) and restyled.
- **Assets**: `src/assets/` — CSS, JS, images served as-is.
- **Config**: `src/jbake.properties` — site metadata, menus, giscus, GA, rendering options.
- **Output**: `output/` (gitignored).
- **Fact checks**: `fact-checks/` — per-article verification records (`<slug>-<YYYY-MM-DD>.md`) written by the `/fact-check` skill.

## Language

All site content, templates, and asset comments are in English (`<html lang="en">`, RSS `<language>en</language>`).
Repository docs for the maintainer (this file, skills) may be in Korean or English.

## Commit Conventions

Commit subject lines stay within 50 characters, describe what changed, and carry no type prefix.
Reasons and details go in the body after a blank line.

## Content Conventions

New posts go in `src/content/` as `.adoc` files with this header:

```adoc
= Post Title
Sanghyuk Jung
2026-10-03
:jbake-type: post
:jbake-status: published
:jbake-tags: tag1, tag2
:description: One-sentence summary
:idprefix:
```

Fields that are added only on revision (`:jbake-last_updated:`) and per-field rules are in the `create-post` skill.
Post images go in `src/content/img/<topic-slug>/`.

The file name is the URL (`/<slug>.html`). Renaming a published post requires a redirect at the hosting layer;
record the old and new paths in the commit message.

## Template Structure

Layout chain: `header.ftl` → `menu.ftl` → page-specific template → `footer.ftl`

- `post.ftl` / `page.ftl` — main content layouts; `post.ftl` appends `commons/giscus.ftl`
- `index.ftl` — homepage with pagination (3 posts per page)
- `post/` — post partials (header, content, prev/next navigation)
- `commons/` — shared partials (giscus comments, google-analytics, social links, share buttons)

## Key Config Notes

- Comments: giscus (GitHub Discussions). Rendered only when `site.giscus.repo` is set; `repo_id` and `category_id` come from https://giscus.app.
- Analytics: GA4 via `site.google.trackingid`; empty value disables the tag.
- Menu items are `site.menus.main` entries in `jbake.properties`.
