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

- **Plan / Architecture / Pre-build design**: `/waza:think`
- **Code review / Release gates / Audit**: `/waza:check`
- **Root cause diagnosis / Bug fix / Regression**: `/waza:hunt`
- **UI/UX design / Visual polish / Styling**: `/waza:ui`
- **Writing prose / Release notes / Copywriting**: `/waza:write`
- **Research / Synthesis / Material compilation**: `/waza:learn`
- **Fetching URLs / Reading PDFs**: `/waza:read`
- **Engineering health audit / Config check**: `/waza:health`
- **Code refactoring for clarity & simplicity**: `simplify`
- **Terse token-saving response mode**: `caveman`

## Red Flags

| Thought (The Rationalization) | Reality (The Rule) |
|---|---|
| "This is just a simple question" | Questions are tasks. Check for skills. |
| "I need more context first" | Skill check comes BEFORE clarifying questions. |
| "Let me explore the codebase first" | Skills tell you HOW to explore. Check first. |
| "I can check git/files quickly" | Files lack conversation context. Check for skills. |
