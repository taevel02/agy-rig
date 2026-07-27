---
name: using-superpowers
description: Use when starting any conversation - establishes how to find and use skills, requiring skill invocation before ANY response including clarifying questions
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, ignore this skill.
</SUBAGENT-STOP>

<EXTREMELY-IMPORTANT>
If you think there is even a 1% chance a skill might apply to what you are doing, you ABSOLUTELY MUST invoke the skill.

IF A SKILL APPLIES TO YOUR TASK, YOU DO NOT HAVE A CHOICE. YOU MUST USE IT.

This is not negotiable. You cannot rationalize your way out of this.
</EXTREMELY-IMPORTANT>

## The Rule

**Invoke relevant or requested skills BEFORE any response or action** — including clarifying questions, exploring the codebase, or checking files. If it turns out wrong for the situation, you don't have to use it.

Then announce "Using [skill] to [purpose]" and follow the skill exactly. If it has a checklist, create a todo per item.

## Available Skills & Mapping

Process skills set the approach; execution skills carry out specific tasks. Always invoke matching skills from your environment:

- **Plan / Architecture / Pre-build design**: `/think`
- **Code review / Release gates / Audit**: `/check`
- **Root cause diagnosis / Bug fix / Regression**: `/hunt`
- **UI/UX design / Visual polish / Styling**: `/ui`
- **Writing prose / Release notes / Copywriting**: `/write`
- **Research / Synthesis / Material compilation**: `/learn`
- **Fetching URLs / Reading PDFs**: `/read`
- **Engineering health audit / Config check**: `/health`
- **Code refactoring for clarity & simplicity**: `/simplify`
- **Terse token-saving response mode**: `/caveman`
- **Atomic 1-line git commits on work unit completion**: `/using-atomic-commit`

## Red Flags (Anti-Rationalization Gate)

| Thought (The Rationalization) | Reality (The Rule) |
|---|---|
| "This is just a simple question" | Questions are tasks. Check for skills BEFORE answering. |
| "I need more context first" | Skill check comes BEFORE clarifying questions. |
| "Let me explore the codebase or view files first" | Skills specify HOW to explore context. Invoke skill first. |
| "I can check git/files quickly" | Files lack conversation context. Check for skills first. |
| "This doesn't need a formal skill" | If a skill exists for the task, you MUST use it. |
| "I'll just do this one thing first" | Do not cut corners. Skill invocation comes first. |
| "Quick fix for now, investigate later" | Bugs require `/hunt` root-cause analysis before editing. |
| "I can write code without a plan" | Architectural or feature builds require `/think` planning first. |

<CRITICAL-DIRECTIVE>
If any thought in the Red Flags table enters your reasoning process, STOP IMMEDIATELY. Re-evaluate your approach, invoke the appropriate skill, and follow its protocol.
</CRITICAL-DIRECTIVE>
