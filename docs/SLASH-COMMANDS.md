# Claude Code Slash Command Guide

- [1. Slash Command Basics](#1-slash-command-basics)
  - [1.1. What is a Good Slash Command?](#11-what-is-a-good-slash-command)
  - [1.2. Arguments in Slash Commands](#12-arguments-in-slash-commands)
- [2. Creating Commands](#2-creating-commands)
  - [2.1. Markdown: From Idea to Plan](#21-markdown-from-idea-to-plan)
  - [2.2. Bash: From Plan to Script](#22-bash-from-plan-to-script)
- [3. Example Commands](#3-example-commands)
  - [3.1. Commit Message Generator](#31-commit-message-generator)
  - [3.2. Style Unifier](#32-style-unifier)
  - [3.3. Task Suggester](#33-task-suggester)
  - [3.4. Lie Creation Tool](#34-lie-creation-tool)

---

Custom slash commands are simply aliases for prompts. When you type or select a slash command, you are sending the preprogrammed prompt to the model as if you had typed it into the terminal.

> [!IMPORTANT]
> **What About Codex?**
> At the moment, you can't create programmatic commands for Codex[^1].

[^1]: Jaz did discover a workaround... •• <|1|> Create a wrapper around codex with an alias prefix (*a la* `npm`) •• <|2|> Script it so that it falls back on "if you don't recognise the command, just pass it verbatim to codex" •• <|3|> Create custom commands for that wrapper.

---

## 1. Slash Command Basics

### 1.1. What is a Good Slash Command?

They're best used for tasks that meet the following criteria.

<details><summary>Repetitive in Nature</summary>

  You'll want to target prompts that always use the same structure, with little/no need for nuance in how they're phrased.

  > [!TIP]
  > **Example**
  > [Commit Message Generator](#41-commit-message-generator)

</details>

<details><summary>Requires Specificity or Complexity</summary>

  You can set a command to just answer "yes", but... what's the point? The benefits come from establishing a consistent approach to tasks that require multi-word prompts

  > [!TIP]
  > **Example**
  > [Style Unifier](#42-style-unifier)

</details>

<details><summary>Low-Impact Arguments</summary>

  Many commands [work well](#41-commit-message-generator) without [arguments](#2-passing-arguments).
  
  If a command *does* need to take arguments, these should be something that can be pasted in the middle of a prompt. See the next section for details.

</details>

### 1.2. Arguments in Slash Commands

Sometimes you want to run a command that meets most of the criteria but needs just a tiny bit of tuning. This could be targeting a particular file, referencing an issue, etc etc.

<details><summary>Passing Arguments</summary>

Any text you type after the slash command itself is passed as a single string argument.

```bash
/task auth, layout or docs
# passed "auth, layout or docs" to /task
```

These arguments are planted into a predfined slot in the prompt. This can be anywhere within the predefined text.

</details>

<details><summary>Creating Argument Slots</summary>

When you [create your command](#3-creating-commands), you can designate the argument slot by typing `$ARGUMENTS` in your prompt body.

This means that you need to phrase the prompt in a way that makes Claude handle `null` arguments too!

</details>

---

## 2. Creating Commands

> [!NOTE]
> **`.xml` Formatting**
> I'll play around soon with best practice for using `xml`.
> I would assume the same general semantic rules apply

### 2.1. Markdown: From Idea to Plan[^2]

[^2]: I'm still figuring out which, if any, of these are most effective. These are just my vague observations so far.

<details><summary>2.1.1. Assorted Notes</summary>

  This works pretty well. You can add sections if you like, but try to preserve the hierarchy. Having 3 `##` headers rather than 2 increases the amount of top priority context by 50%, which makes it harder to regulate.

  The `-` character is semantically significant in `bash`, so remember to `\` escape them[^3].

  [^3]: Except, weirdly, for the `<!-- -->` syntax for a comment. *Don't* escape those.

  There's some debate about whether separating elements with a blank line helps preserve information structure, so you do you, but I do it anyway as most markdown linters will have a tantrum otherwise
  
</details>

<details><summary>2.1.2. Markdown Template</summary>

  ```markdown
  # [[ Command Name ]]

  Brief task description, including how and where to use $ARGUMENTS

  ## Steps

  These should be itemised.

  ## Rules

  Still trying to figure out whether/when it's better to write these...
  
  - imperatively: "Always make sure your code is blah blah"
  - declaratively: "Your code is always blah blah"
  ```

</details>

<details><summary>2.1.3. How to Sequence Steps</summary>

  | Symbol   | Name        | Benefit                                               |
  | -------- | ----------- | ----------------------------------------------------- |
  | `-`      | Unordered   | quick steps, most flexible                            |
  | `1.`     | Ordered     | quick steps, exact order                              |
  | `- [ ]`  | Task        | enforce self-regulation                               |
  | `###`    | H3          | add detail while preserving step separation           |
  | `### 1.` | Numbered H3 | combine detail and facilitate referencing other steps |

</details>

### 2.2. Bash: From Plan to Script

<details><summary>2.2.1. Reformatting for Bash</summary>

  1. Add `\` before any backticks (\`, \`\`\`, etc)
  2. Replace every line break with `\n` (e.g. )

</details>

<details><summary>2.2.2. Bash Template</summary>

  ```bash
  echo "[[ name ]] prompt (inc. $ARGUMENTS)" > .claude/commands/`this-will-be-the-actual-command`.md
  ```

</details>

<details><summary>2.2.3. Project/Team-Wide Commands</summary>

  ```bash
  echo "prompt" > .claude/commands/`command-name`.md`
  ```

</details>

<details><summary>2.2.4. User/Private Commands</summary>

  ```bash
  echo "prompt" > .claude/commands/user:`command-name`.md`
  ```

</details>

---

## 3. Example Commands

### 3.1. Commit Message Generator

<details><summary>3.1.1. Markdown Plan</summary>

  ```markdown
  # [[Commit Message Generator]]

  Using the rules listed below, generate a commit message for the currently staged files, and wait for my approval. Once I have approved it, apply the message, commit the changes and push to the remote.

  ## Rules

  \- [ ] If no files are staged, stage all changes.
  \- [ ] Generate a commit message. Use conventional commit format as follows: `type(scope): emoji message`
  \- [ ] Check the value of `inbox` in [PigNotes](#pignotes).
  \- [ ] If `"inbox" == ""`, omit the entire `pig` codeblock from the commit message.
  \- [ ] If `"inbox" != ""`, include the `pig` codeblock (including the comment syntax).

  ## PigNotes

  <!--

  \`\`\`pig
  {
    "inbox": ""
  }
  \`\`\`

  -->
  ```

</details>

<details><summary>3.1.2. Bash Script</summary>

  ```bash
  echo "# [[Commit Message Generator]]\n\nUsing the rules listed below, generate a commit message for the currently staged files, and wait for my approval. Once I have approved it, apply the message, commit the changes and push to the remote.\n\n## Rules\n\n\- [ ] If no files are staged, stage all changes.\n\- [ ] Generate a commit message. Use conventional commit format as follows: \`type(scope): emoji message\`\n\- [ ] Check the value of \`inbox\` in [PigNotes](#pignotes).\n\- [ ] If \`\"inbox\" == \"\"\`, omit the entire \`pig\` codeblock from the commit message.\n\- [ ] If \`\"inbox\" != \"\"\`, include the \`pig\` codeblock (including the comment syntax).\n\n## PigNotes\n\n<\!--\n\n\`\`\`pig\n{\n  \"inbox\": \"$ARGUMENTS\"\n}\n\`\`\`\n\n-->" > .claude/commands/user:commit.md
  ```

</details>

### 3.2. Style Unifier

<details><summary>3.2.1. Markdown Plan</summary>

  ```markdown
  # [[Style Unifier]]

  Analyse the styling of this component (and its children): .

  ## Steps

  \- [ ] Provide an analysis of how well the approach used is consistent with the rest of the codebase.
  \- [ ] Provide a list of suggestions for how to maintain the exact same styling outcomes in this component whilst using the codebase' established approach.
  \- [ ] Once you receive approval, apply the changes to the component and its children.

  ## Rules

  \- If editing multiple components, check for permission before each file is edited.
  \- Proceed in a logical order, starting with `*.css` files, proceeding through child components and ending with the parent component.
  ```

</details>

<details><summary>3.2.2. Bash Script</summary>

  ```bash
  echo "# [[Style Unifier]]\n\nAnalyse the styling of this component (and its children): $ARGUMENTS.\n\n## Steps\n\n\- [ ] Provide an analysis of how well the approach used is consistent with the rest of the codebase.\n\- [ ] Provide a list of suggestions for how to maintain the exact same styling outcomes in this component whilst using the codebase' established approach.\n\- [ ] Once you receive approval, apply the changes to the component and its children.\n\n## Rules\n\n\- If editing multiple components, check for permission before each file is edited.\n\- Proceed in a logical order, starting with \`*.css\` files, proceeding through child components and ending with the parent component." > .claude/commands/style.md
  ```

</details>

### 3.3. Task Suggester

<details><summary>3.3.1. Markdown Plan</summary>

  ```markdown
  # [[ Task Suggester ]]

Analyse the current state of the codebase, then compare it to the project documentation. Once done, suggest the next logical task I can complete.

## Rules

1. If the task will take longer than 45 minutes, subdivide it into subtasks and suggest the first of these.
2. If the "topic" code block contains text content, give me a task that focusses on that area
3. Conserve tokens by being selective in which files you read
4. Where possible, use the dev scripts in `./package.json` & `./scripts` to retrieve information rather than passing file content into your context window

## Arguments

\`\`\`json
{
  "topic": " "
}
\`\`\`
```

</details>

<details><summary>3.3.2. Bash Script</summary>

  ```bash
  echo "# [[ Task Suggester ]]\n\nAnalyse the current state of the codebase, then compare it to the project documentation. Once done, suggest the next logical task I can complete.\n\n## Rules\n\n1. If the task will take longer than 45 minutes, subdivide it into subtasks and suggest the first of these.\n2. If the \"topic\" code block contains text content, give me a task that focusses on that area\n3. Conserve tokens by being selective in which files you read\n4. Where possible, use the dev scripts in \`./package.json\` & \`./scripts\` to retrieve information rather than passing file content into your context window\n\n## Arguments\n\n\`\`\`json\n{\n  \"topic\": \" $ARGUMENTS\"\n}\n\`\`\`" > .claude/commands/task.md
  ```

</details>

### 3.4. Lie Creation Tool

<details><summary>3.4.1. Markdown Plan</summary>

  ```markdown
  # [[Lie Creation Tool]]
  Use my commit history to create a self\-aggrandising lie about the my contribution to the codebase that I can tell my boss.

  ## Rules

  1. If I have not made any commits, use the commits made by Alex.
  2. Check the codeblock in [Focus](#focus). If `"focus" != ""`, make the lie conform to the value of `"focus"`

  ## Focus

  \`\`\`json
  {
    "focus": ""
  }
  \`\`\`
  ```

</details>

<details><summary>3.4.2. Bash Script</summary>

  ```bash
  echo "# [[Lie Creation Tool]]\nUse my commit history to create a self\-aggrandising lie about the my contribution to the codebase that I can tell my boss.\n\n## Rules\n\n1. If I have not made any commits, use the commits made by Alex.\n2. Check the codeblock in [Focus](#focus). If \`\"focus\" != \"\"\`, make the lie conform to the value of \`\"focus\"\`\n\n## Focus\n\n\`\`\`json\n{\n  \"focus\": \"$ARGUMENTS\"\n}\n\`\`\`" > .claude/commands/lie.md
  ```

</details>
