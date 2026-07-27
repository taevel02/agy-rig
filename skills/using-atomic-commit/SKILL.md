---
name: using-atomic-commit
description: Enforces fast, 1-line atomic git commits conforming strictly to Conventional Commits v1.0.0 upon completing verified units of work.
---

<EXTREMELY-IMPORTANT>
Whenever a discrete feature, bug fix, refactoring, or documentation task is verified and completed, you MUST execute an atomic git commit conforming strictly to Conventional Commits v1.0.0 immediately.

Do NOT wait for the session to end. Do NOT waste tokens outputting multi-paragraph commit summaries in chat.
</EXTREMELY-IMPORTANT>

## Conventional Commits v1.0.0 Complete Specification

Commit messages MUST strictly conform to the 16 rules of Conventional Commits v1.0.0:

### Structure Format
`<type>[optional scope][!]: <description>`

`[optional body]`

`[optional footer(s)]`

---

### Specification Rules (1 to 16)

1. **Type Prefix**: Commits MUST be prefixed with a type consisting of a noun (e.g. `feat`, `fix`), followed by OPTIONAL scope, OPTIONAL `!`, and REQUIRED terminal colon and space (`: `).
2. **Feature Type (`feat`)**: The type `feat` MUST be used when a commit adds a new feature to your application or library (corresponds to SemVer `MINOR`).
3. **Fix Type (`fix`)**: The type `fix` MUST be used when a commit represents a bug fix for your application (corresponds to SemVer `PATCH`).
4. **Optional Scope**: An OPTIONAL scope MAY be provided after a type. Scope MUST consist of a noun describing a section of the codebase surrounded by parenthesis, e.g. `fix(parser):` or `feat(auth):`.
5. **Description**: A description MUST immediately follow the colon and space after the type/scope prefix. The description is a short summary of the code changes, written in imperative mood, lower-case, with no trailing period.
6. **Optional Body**: A longer commit body MAY be provided after the short description, providing additional contextual information. The body MUST begin one blank line after the description.
7. **Body Format**: A commit body is free-form and MAY consist of any number of newline separated paragraphs.
8. **Optional Footers**: One or more footers MAY be provided one blank line after the body or description. Each footer MUST consist of a word token, followed by either a `:<space>` or `<space>#` separator, followed by a string value.
9. **Footer Tokens**: A footer token MUST use `-` in place of whitespace characters, e.g., `Reviewed-by` or `BREAKING-CHANGE`. (Exception: `BREAKING CHANGE` MAY also be used as a token).
10. **Footer Values**: A footer value MAY contain whitespace and newlines, and parsing MUST terminate when the next valid footer token/separator pair is observed.
11. **Breaking Changes**: Breaking changes MUST be indicated in the type/scope prefix of a commit, or as an entry in the footer.
12. **Breaking Change Footer**: If included as a footer, a breaking change MUST consist of the uppercase text `BREAKING CHANGE`, followed by a colon, space, and description (e.g. `BREAKING CHANGE: environment variables now take precedence over config files`).
13. **Breaking Change Exclamation (`!`)**: If included in the type/scope prefix, breaking changes MUST be indicated by a `!` immediately before the `:` (e.g. `feat(api)!: change user model primary key schema`).
14. **Additional Types**: Types other than `feat` and `fix` MAY be used in commit messages:
    - `docs`: Documentation changes
    - `style`: Changes that do not affect code meaning (white-space, formatting, etc.)
    - `refactor`: Code change that neither fixes a bug nor adds a feature
    - `perf`: Code change that improves performance
    - `test`: Adding missing tests or correcting existing tests
    - `build`: Changes that affect the build system or external dependencies
    - `ci`: Changes to CI configuration scripts and workflows
    - `chore`: Maintenance changes that do not modify src or test files
15. **Case Sensitivity**: The units of information that make up Conventional Commits MUST NOT be treated as case-sensitive by implementors, with the exception of `BREAKING CHANGE` which MUST be uppercase.
16. **Synonymity**: `BREAKING-CHANGE` MUST be synonymous with `BREAKING CHANGE` when used as a token in a footer.

---

### Terminal Execution Directive
- Execute `git commit -m "<type>[scope]: <description>"` directly via terminal.
- Do NOT output conversational commit explanations in chat text unless explicitly asked.
