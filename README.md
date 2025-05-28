# AI Assisted Development

![Screenshot 2025-05-19 at 16 18 02](https://github.com/user-attachments/assets/885d196b-e9b8-47ee-84de-d4533c42f3b7)

## Table of Contents

- [Workshop](#workshop)
  - [Overview](#overview)
  - [What to Expect](#what-to-expect)
  - [Getting Started](#getting-started)
- [Task](#task)
- [Human-AI Pair-Programming: A Rough Guide](#human-ai-pair-programming-a-rough-guide)
  - [IQRE Process](#iqre-process)
  - [Workshop Phases](#workshop-phases)
    - [Conception](#conception)
    - [Environment & Tasks](#environment--tasks)
    - [Implementation](#implementation)
    - [Context Management](#context-management)
    - [Presentation](#presentation)
  - [Key Guidelines](#key-guidelines)
    - [AI Collaboration](#ai-collaboration)
    - [Quality Assurance](#quality-assurance)
    - [Success Criteria](#success-criteria)

## Workshop

### Overview

In this workshop, you'll work in human-AI pairs to build a travel planning application using Claude Code as your AI partner. The focus is on practicing effective AI-assisted development, improving prompt hygiene, and fostering human oversight while collaborating with AI.

### Getting Started

Create a new repository [using this repository as a template](https://github.com/new?template_name=fac-ws_ai_assisted_development&template_owner=TandemCreativeDev).

## Task

Details of the task are contained in the [brief](BRIEF.md).

## Human-AI Pair-Programming: A Rough Guide

### IQRE Process

Follow these four steps consistently throughout the workshop:

1. **Iterate**: Share ideas/request code from AI and develop specifications or features through iteration.
2. **Question**: Review AI proposal, identify gaps, and refine through follow-up questions.
3. **Accept**: If AI proposal is acceptable, allow it to generate the code or specs.
4. **Review/Create**: Understand generated code/specs. If inspired, create a new, enhanced solution based on AI's output.
5. **Explain**: Present outputs to teammates, emphasising clear foundations and alignment.

---

### Workshop Phases

> [!NOTE]
> All prompts referred to in the below section are available [here](PROMPTS.md).

#### CONCEPTION

- **Pair Formation**: Form teams (1 frontend + 1 backend developer)
- **Repository Setup**: Following [Getting Started](#getting-started)
- **Specification Development**:
  - Initialise a new instance of Claude Code. Use the GENERATE SPECS prompt to have a conversation with Claude and determine the specifications of your project.
  - Use SPEC WRAP-UP prompt - this should create `FUNCTIONAL.md`, `ARCHITECTURE.md`, and `CLAUDE.md` files.

> **Output**: Initial documentation pushed to repo

#### ENVIRONMENT & TASKS

> [!WARNING]  
> Set up your environment, install your dependencies etc. **manually**. AI can be terrible at this and using AI for setup could add a lot of config issues to your project before you can even get started.

- Use the GENERATE TO-DO prompt to create `TO-DO.md`. Remember to follow the IQRE methodology! Check that your tasks actually make sense so that you don't end up with a lot of vague, impossibly scoped tasks that no one could follow!
- Set up environment, frameworks, folder structure, install dependencies

- Review tasks for dependencies and overlaps

> **Output**: Ready-to-code environment with structured to-do list

#### IMPLEMENTATION

**Per Task Process**:

1. Use KICKOFF/REFRESH MEMORY prompt
2. Implement features
3. Make sure to review constantly
4. Use CONTEXT RESET after task completion

**Between Sessions**:

- Coordinate dependencies with teammate
- Update `CLAUDE.md` with learned standards

> **Output**: Incremental feature completion

#### CONTEXT MANAGEMENT

- Use `HISTORY.md` for context summaries
- Reset Claude's context window after each task
- Maintain clean workspace

> **Output**: Archived context for reference, clean workspace

#### PRESENTATION

- Demo your project
- Show AI collaboration examples
- Present evolved standards
- Reflect on deliberate architectural decisions

> **Output**: 5-minute presentation with examples and demo

---

### Key Guidelines

#### AI Collaboration

- **Explicit Prompting**: Always tell Claude which files to reference (it won't do this automatically)
- **Context Management**: Use CONTEXT RESET prompt to maintain clarity
- **Standards Evolution**: Update `CLAUDE.md` when discovering new patterns

#### Quality Assurance

- **Follow IQRE**: Apply the four steps consistently
- **Review Obsessively**: You need to know everything the AI is generating
- **Maintain Standards**: Keep `CLAUDE.md` current and concise

#### Success Criteria

- Effective AI collaboration patterns
- Evolved standards documented in `CLAUDE.md`
- Clear architectural decisions

#### Common Pitfalls

AI code generators often struggle with:
- Anything to do with setting up projects, installing dependencies
- Being too ambitious, agreeing to everything
- Staying inside the scope when working on a task
- Using outdated tech stack, outdated versions of dependencies

**Remember**: You're the human-in-the-loop. Guide the AI, don't just accept its output.
