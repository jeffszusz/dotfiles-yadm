# Prompt Engineering Techniques: A Practical Analysis

Based on *The Prompt Report: A Systematic Survey of Prompting Techniques* (Schulhoff et al., arXiv:2406.06608v6)

---

## Quick Start: Highest ROI Techniques

Six techniques deliver the most consistent value with the least setup:

| Technique | One-line trigger |
|---|---|
| **Chain-of-Thought (CoT)** | *"Think through this step by step before answering."* |
| **Role Prompting** | *"Act as a senior [role] with expertise in [domain]."* |
| **Few-Shot Prompting** | *"Here are 3 examples: [examples]. Now do it for: [your case]."* |
| **Output Formatting** | *"Respond as JSON with keys: summary, action_items, risks."* |
| **Self-Refine** | *"Review your answer for errors and improve it."* |
| **Plan-and-Solve** | *"First devise a plan, then carry it out step by step."* |

These techniques compound well — the real power comes from combining them. The scenarios below show how.

---

### Scenario 1: Investigating an unfamiliar bug or system

**Techniques:** Role Prompting + CoT + Self-Refine

Start by framing who you need the model to be, then ask it to reason openly, then have it challenge its own conclusion:

> *"Act as a senior backend engineer experienced with distributed systems. I'm seeing intermittent 503s from our auth service only under high load. Here's the relevant log output: [paste logs]. Think through what could cause this step by step, considering both the application layer and infrastructure. After you've given your diagnosis, review it: what are you least confident about, and what would you check to rule that out?"*

**Why it works:** The role anchors the expertise level. CoT prevents the model from jumping to the most obvious answer. Self-Refine forces it to surface its own uncertainty, which is often where the real answer lives.

---

### Scenario 2: Generating structured, repeatable output

**Techniques:** Few-Shot Prompting + Output Formatting + Role Prompting

When you need output in a specific format — e.g. release notes, ticket descriptions, commit messages — give examples and lock the format:

> *"Act as a technical writer. I'm going to give you git commit messages and you will turn them into user-facing release note entries. Here are 2 examples:*
>
> *Commit: `fix: prevent race condition in session handler`*
> *Release note: Fixed an issue that could cause users to be unexpectedly logged out under heavy load.*
>
> *Commit: `feat: add CSV export to reports page`*
> *Release note: You can now export any report as a CSV file from the Reports page.*
>
> *Now write a release note for: `fix: correct timezone offset in scheduled job runner`*
> *Respond with only the release note text, no preamble."*

**Why it works:** The examples eliminate ambiguity about tone and format. The output constraint ("only the release note text") prevents padding. The role keeps the register consistent.

---

### Scenario 3: Making a difficult architectural or design decision

**Techniques:** Step-Back Prompting + Plan-and-Solve + Self-Refine

For high-stakes decisions where you don't want a snap answer:

> *"I need to decide whether to introduce an event queue between our API and our database writes, or keep direct synchronous writes. Before giving me a recommendation, first answer a more general question: what are the established principles for deciding when to introduce async messaging in a service architecture? Then, apply those principles to my specific situation: [describe your system, load, consistency requirements]. Give me a structured recommendation with tradeoffs. Finally, steelman the opposite choice — what's the strongest argument for the option you didn't recommend?"*

**Why it works:** Step-Back forces the model to reason from first principles rather than jumping to a fashionable answer. Plan-and-Solve structures the output. The steelman at the end (a variant of Self-Refine) ensures you're getting the real tradeoffs, not a one-sided answer.

---

### Scenario 4: Reviewing a document, PR, or piece of writing

**Techniques:** Role Prompting + S2A (System 2 Attention) + Chain-of-Verification

When you have a large body of text and want targeted, trustworthy feedback:

> *"Act as a principal engineer doing a code review. Before reviewing, identify which parts of this PR are highest risk and most worth your attention — skip any boilerplate or mechanical changes. Then review those sections carefully. For each concern you raise, state: the issue, why it matters, and what you'd want to see instead. After your review, list any factual claims you made (e.g. about performance, correctness, or security) and verify each one against the code I've shared."*

**Why it works:** S2A ("identify which parts are highest risk first") prevents shallow feedback spread evenly across trivial and critical changes. Chain-of-Verification at the end catches confident-sounding mistakes in the review itself.

---

### Scenario 5: Learning or explaining something complex

**Techniques:** Role Prompting + Style Prompting + Skeleton-of-Thought + Self-Ask

When you want to deeply understand a new concept:

> *"Act as an expert in [topic] explaining to a senior engineer who is new to this area — no need to explain basic programming concepts, but do explain domain-specific ideas from scratch. First, give me a skeleton of the key ideas I need to understand, in the order I should learn them. Then, for each item in the skeleton, anticipate what questions someone coming from a software background would ask, answer those questions, and explain the idea fully."*

**Why it works:** The role + style calibrates depth precisely. Skeleton-of-Thought gives you a map before you get lost in detail. Self-Ask (asking the model to anticipate your questions) surfaces the non-obvious parts that a textbook would gloss over.

---

### The General Pattern

Most high-quality prompts follow a simple three-part structure combining these techniques:

```
[Role] + [Task with context] + [Output format or self-criticism instruction]
```

For example:
> *"Act as a [role]. [Task description, with relevant context pasted in]. Think step by step. Respond as [format]. After answering, review your response and flag anything you're uncertain about."*

Even this minimal template — role, CoT, format, self-refine — will outperform an unstructured request significantly on almost any task.

---

## 🟢 High-Value: Directly Usable Techniques

These are techniques you can deploy right now in any conversation, requiring nothing more than a sentence or two added to your prompt.

### In-Context Learning & Few-Shot

| Technique | What it is | How to use it |
|---|---|---|
| **Few-Shot Prompting** | Provide 2–5 examples of input→output pairs before your actual request | *"Here are 3 examples of the format I want: [examples]. Now do it for: [your case]."* Good for structured tasks, code generation, classification. |

### Zero-Shot Reasoning

| Technique | What it is | How to use it |
|---|---|---|
| **Role Prompting** | Ask the AI to act as a persona with specific expertise | *"Act as a senior TypeScript engineer reviewing this for security issues."* or *"You are a UX researcher analyzing user feedback."* |
| **Style Prompting** | Specify tone, register, or format of the response | *"Explain this at a high school level,"* *"Reply in the style of a terse code review comment,"* or *"Write this in a professional but friendly tone."* |
| **Emotion Prompting** | Add stakes or emotional urgency | *"This is critical to my project deadline — please be thorough."* Documented mild positive effect on output quality and care. |
| **System 2 Attention (S2A)** | Ask the model to first identify what context is relevant, then re-answer | *"First, identify which parts of the context are actually relevant to my question. Then answer using only those."* Cuts through noisy, long, or multi-topic contexts. |
| **SimToM** | For perspective-taking tasks, simulate what different actors know/see | *"Reason from [Person A]'s point of view given only what they know."* Useful in design, UX, and conflict analysis. |
| **Rephrase and Respond (RaR)** | Ask the model to rephrase your question before answering | *"Before answering, restate the question in your own words, then answer."* Catches misinterpretations, especially on complex asks. |
| **Re-reading (RE2)** | Instruct the model to re-read the prompt before answering | *"Read the following carefully, then re-read it, then answer."* Helps with complex or ambiguous inputs. |
| **Self-Ask** | Ask the model to generate sub-questions it needs to answer, then answer them | *"What questions would you need to answer to solve this? Answer each one, then give me the final answer."* |

### Thought Generation (Chain-of-Thought & Variants)

| Technique | What it is | How to use it |
|---|---|---|
| **Chain-of-Thought (CoT) Prompting** | Ask the model to reason step by step before answering | *"Think through this step by step before giving me the answer."* Works on math, logic, coding, analysis. Massive improvement over direct answers. |
| **Zero-Shot CoT** | A shorthand trigger for CoT without examples | *"Let's think step by step."* Surprisingly effective even without explicit prompting. |
| **Step-Back Prompting** | Ask a more general/abstract version of the question first, then apply to your case | *"First, what are the general principles of X? Now apply those to my specific situation."* Good for domain-specific reasoning. |
| **Analogical Prompting** | Ask the model to generate analogous examples or problems first, then solve yours | *"Think of analogous problems you've seen. How were those solved? Apply that reasoning here."* Activates transfer learning. |
| **Thread-of-Thought (ThoT) Prompting** | For chaotic/long contexts, walk through segment by segment | *"Walk through this document section by section, noting what's relevant and what you learn, then answer my question."* Good for long documents or scattered context. |
| **Tabular Chain-of-Thought (Tab-CoT)** | Ask reasoning to be structured as a table/grid | *"Reason through this in a table with columns: step, action, result, confidence."* Useful for comparisons and analysis. |

### Decomposition (Breaking Problems Down)

| Technique | What it is | How to use it |
|---|---|---|
| **Least-to-Most Prompting** | Break a hard problem into simpler sub-problems explicitly | *"First solve the simpler case of X, then use that to solve Y."* Good for progressive problem-solving. |
| **Decomposed Prompting (DECOMP)** | Ask the model to break the problem into independent sub-tasks | *"Break this into the smallest independent tasks, solve each, then combine."* |
| **Plan-and-Solve Prompting** | Ask for an explicit plan before execution | *"First, devise a plan for how you'll approach this. Then carry it out, step by step."* Prevents rushed answers. |
| **Skeleton-of-Thought** | Ask for an outline/skeleton first, then fill it in | *"Give me a skeleton/outline for [X], then flesh it out with details."* Great for long documents, proposals, or presentations. |
| **Metacognitive Prompting** | Ask the model to reflect on its own reasoning process and assumptions | *"After answering, tell me: what assumptions did you make? Where might you be wrong? What would change your mind?"* |

### Self-Criticism (Improving Your Own Output)

| Technique | What it is | How to use it |
|---|---|---|
| **Self-Calibration** | Ask the model to state its confidence in its answer | *"After answering, rate your confidence 1–10 and explain why."* Helps you assess reliability. |
| **Self-Refine** | Ask the model to critique and improve its own output | *"Now review your answer for errors, logical gaps, tone issues, and ways to improve it."* One of the highest-ROI techniques — cheap to implement, big payoff. |
| **Reversing Chain-of-Thought (RCoT)** | Ask the model to work backwards from the desired outcome to verify feasibility | *"Work backwards: if [outcome] is true, what would need to be true? Does that hold?"* Good for verification. |
| **Self-Verification** | Ask the model to verify its own claims against logic or provided facts | *"Verify each factual claim in your answer against the provided context."* |
| **Chain-of-Verification (CoVE)** | Ask the model to generate verification questions about its answer and check them | *"List the top factual claims in your answer. Now generate verification questions for each. Answer those questions."* Powerful for fact-sensitive tasks. |
| **Cumulative Reasoning** | Build up a chain of verified propositions one at a time | For complex logic problems, ask to build evidence incrementally: *"State claim 1 and verify it. Then, given claim 1, state claim 2 and verify it. Continue…"* |

### Output Formatting & Answer Engineering

| Technique | What it is | How to use it |
|---|---|---|
| **Output Formatting / Answer Engineering** | Specify the exact shape, format, or constraints of the answer | *"Respond only in JSON with keys: summary, action_items, risks, next_steps."* or *"Use a bulleted list with no more than 5 items."* Always include format specs. |
| **Answer Shape** | Control whether the answer is a single word, sentence, paragraph, or code block | *"Answer in a single sentence."* or *"Provide your answer as valid Python code."* |
| **Answer Space** | Restrict the vocabulary/options the model can choose from | *"Answer must be one of: 'yes', 'no', 'maybe'."* or *"Choose from this list: [options]."* |
| **Verbalizer** | Specify how to map model predictions to human-readable labels | *"If the sentiment is positive, say 'POSITIVE'. If negative, say 'NEGATIVE'."* |

### Ensembling & Multiple Perspectives

| Technique | What it is | How to use it |
|---|---|---|
| **Prompt Paraphrasing** | Try multiple phrasings of your question | If you get a poor answer, rephrase and ask again — the framing genuinely changes outputs. *"Let me rephrase that: …"* |
| **Memory-of-Thought** | In a long conversation, reference and build on earlier conclusions | Paste back a summary: *"Earlier we established that X and Y are true. Given that, how does Z change?"* Useful for continuity across long conversations. |

---

## 🟡 Situationally Useful: Conditional or Effort-Heavy

These techniques work but require more deliberate setup or apply only to specific problem types.

| Technique | What it is | When to use it |
|---|---|---|
| **Contrastive CoT** | Provide examples of *both correct and incorrect* reasoning patterns | If you want me to avoid a known failure pattern. Show a bad example and a good one side by side. Requires prior knowledge of the failure mode. |
| **Uncertainty-Routed CoT Prompting** | Use model's uncertainty to decide which examples to show | Not directly usable in chat — requires pipeline infrastructure. |
| **Active Prompting** | Select examples based on model uncertainty on unlabeled data | Research-level; requires data infrastructure. |
| **Complexity-based Prompting** | Route to different prompting strategies based on task complexity | Requires analyzing task difficulty programmatically. |

---

## 🔴 Not Directly Usable: Infrastructure/Research Tools

These techniques require programmatic control, API orchestration, embeddings, or multi-call infrastructure you cannot implement by hand in a chat interface.

### Automated Exemplar Selection

- **K-Nearest Neighbor (KNN)** — Algorithmic search over embeddings for best exemplars
- **Vote-K** — Voting-based exemplar selection
- **Self-Generated In-Context Learning (SG-ICL)** — Model generates its own exemplars via prior calls
- **Prompt Mining** — Corpus search for prompt templates

### Multi-Call Ensembling & Aggregation

- **Self-Consistency** — Sample multiple responses, take majority vote
- **Universal Self-Consistency (USC)** — Ensemble with format abstraction
- **Mixture of Reasoning Experts (MoRE)** — Ensemble specialized reasoning experts
- **Max Mutual Information Method** — Statistical calibration
- **Demonstration Ensembling (DENSE)** — Select best exemplars via ensemble
- **DiVeRSe, COSP, USP** — Various consistency-based ensemble variants
- **Meta-Reasoning over Multiple CoTs** — Reason about multiple reasoning chains

### Automated Prompt Optimization

- **AutoPrompt** — Gradient-based prompt search
- **Automatic Prompt Engineer (APE)** — Evolutionary search for good prompts
- **Gradient-Free Instructional Prompt Search (GrIPS)** — Gradient-free optimization
- **Prompt Optimization with Textual Gradients (ProTeGi)** — Text-based gradients
- **RLPrompt** — Reinforcement learning for prompt optimization
- **DP2O** — Policy-gradient optimization
- **Meta Prompting** — Prompts that optimize other prompts

### Agent & Tool Use Frameworks

- **ReAct** — Reasoning + Acting in loops
- **Reflexion** — Agent learns from feedback across episodes
- **Voyager, GITM** — Lifelong learning agents
- **MRKL Systems** — Modular tool-use agents
- **Program-Aided Language Models (PAL)** — Code generation + execution
- **Tool-Integrated Reasoning Agent (ToRA)** — Code execution for math
- **TaskWeaver** — Multi-step task decomposition with code

### Search & Planning Over Multiple Calls

- **Tree-of-Thought (ToT)** — Explores branching search trees
- **Recursion-of-Thought** — Recursive decomposition trees
- **Program-of-Thoughts** — Code-based thought generation
- **Faithful Chain-of-Thought** — Faithful intermediate reasoning steps

### Retrieval & Context Augmentation

- **Retrieval Augmented Generation (RAG)** — Retrieve external context
- **Verify-and-Edit** — Retrieve + verify against sources
- **Demonstrate-Search-Predict** — Retrieval guided by demonstrations
- **Interleaved Retrieval guided by CoT (IRCoT)** — Retrieval during reasoning
- **Iterative Retrieval Augmentation** — Multi-round retrieval

### Specialized/Multimodal/Multilingual

- **Auto-CoT** — Automatically generate chain-of-thought exemplars
- **Automatic Prompt Optimization frameworks** — DSPy, LLaMA-Index, LangChain tools
- **Multilingual techniques** (XLT, CLSP, PARC, X-InSTA, In-CLT, etc.) — Cross-lingual transfer
- **Machine Translation variants** (MAPS, CoD, DiPMT, DecoMT) — Translation-specific
- **Interactive-Chain-Prompting (ICP)** — Human-in-the-loop iterative refinement
- **Multimodal techniques** (Image, Audio, Video, Segmentation, 3D prompting) — Vision/audio model features
- **Evaluation frameworks** (LLM-EVAL, G-EVAL, ChatEval) — Benchmark evaluation

---

## Implementation Checklist

Start with these 5 steps:

- [ ] **Every request:** Use output formatting to specify format/structure
- [ ] **Complex reasoning:** Add CoT ("Let's think step by step")
- [ ] **Tasks with expertise needed:** Use role prompting ("Act as a [role]")
- [ ] **Unsure of answer quality:** Ask for self-refinement ("Review and improve your answer")
- [ ] **Long/complex context:** Use S2A or Thread-of-Thought to identify relevance first

---

## Source

**Schulhoff et al., "The Prompt Report: A Systematic Survey of Prompt Engineering Techniques," arXiv:2406.06608v6** (February 2025)

- Published by researchers at University of Maryland, OpenAI, Stanford, Microsoft, and Princeton
- Systematic literature review of 4,797 papers, extracting 1,565 relevant papers via PRISMA process
- Comprehensive taxonomy of 58 LLM prompting techniques, plus 40 multimodal/multilingual techniques
- [Full paper](https://arxiv.org/abs/2406.06608) | [Paper website](https://trigaten.github.io/Prompt_Survey_Site/)

---

## Notes

- Most of the 58 techniques are research constructs evaluated on benchmarks with thousands of API calls and automated evaluation metrics.
- The techniques listed under 🟢 (High-Value) are the ones you can actually use in a conversational workflow.
- The 🟡 (Situationally Useful) are real but require knowing when to apply them or accepting some setup overhead.
- The 🔴 (Not Directly Usable) are not "bad" — they're infrastructure-level and appropriate for teams building AI systems, but not for end-user prompting.
- **Highest empirical ROI:** CoT, Few-Shot, Role Prompting, and Self-Refine. Use these first.
