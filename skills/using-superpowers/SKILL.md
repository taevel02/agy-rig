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

## Available Skills & Intent Mapping

Process skills set the approach; execution skills carry out specific tasks. Always invoke matching skills from your environment:

- **Plan / Architecture / Feature Design**: `/waza:think`
- **Code Review / PR / Release Gate / Audit**: `/waza:check`
- **Root Cause Diagnosis / Bug Fix / Regression**: `/waza:hunt`
- **UI/UX Design / Visual Polish / Component Styling**: `/waza:ui`
- **Writing Prose / Documentation / Release Notes / Social Copy**: `/waza:write`
- **Deep Research / Synthesis / Material Compilation**: `/waza:learn`
- **Reading Web URLs / Extracting PDFs**: `/waza:read`
- **Engineering Health Audit / Config Check**: `/waza:health`
- **Code Refactoring for Readability & Simplicity**: `simplify`
- **Terse Token-Saving Response Mode**: `caveman`

## Red Flags (Anti-Rationalization Gate)

| Thought (The Rationalization) | Reality (The Rule) |
|---|---|
| "This is just a simple question or quick lookup" | Questions are tasks. Check for skills BEFORE answering. |
| "I need to ask clarifying questions before invoking skills" | Skill check MUST occur BEFORE asking clarifying questions. |
| "Let me explore the codebase or view files first" | Skills specify HOW to explore context safely. Invoke skill first. |
| "I can jump straight to writing code without a plan" | Architectural or feature builds require `/waza:think` planning first. |
| "The bug fix is obvious, no need for diagnostic hunting" | Failing tests/bugs require `/waza:hunt` root-cause analysis before editing. |
| "I will do a quick manual code review" | Code review, diff inspection, and release gates require `/waza:check`. |
| "I will write long polite intro paragraphs" | `caveman full` mode is default. Omit filler; state facts tersely in Korean. |

<CRITICAL-DIRECTIVE>
If any thought in the Red Flags table enters your reasoning process, STOP IMMEDIATELY. Re-evaluate your approach, invoke the appropriate skill, and follow its protocol.
</CRITICAL-DIRECTIVE>
