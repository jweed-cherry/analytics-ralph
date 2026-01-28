## Ralph Loop (Creator/Evaluator Feedback Loop)

When the user asks to "use ralph" or "ralph loop" for any task, run a creator/evaluator feedback loop:

### How it works:
1. **Requirements Spec phase**: Write a spec based on the user's task before any work begins
2. **Creator phase**: Complete the task based on the spec + any previous feedback
3. **Evaluator phase**: Check work against the spec (not just quality - does it match requirements?)
4. **Loop**: If not approved, feed evaluation back to creator and repeat
5. **Exit**: When evaluator approves OR max iterations reached (default: 5)

### Implementation:
```
STEP 0 - REQUIREMENTS SPEC (before any iterations):
  Write a requirements spec that includes:
  - Objective: What question are we answering / what are we building?
  - Methodology: How will we approach this? What techniques/controls?
  - Confounders/Controls: (for analysis) Exact list of variables to control for
  - Success Criteria: What makes this "done" and "correct"?
  - Out of Scope: What are we explicitly NOT doing?

  IMPORTANT: Save the spec to a file (e.g., /Users/jasper/{task_name}_spec.md)
  This ensures the spec persists through context compacting.

  Show the spec to the user before proceeding.

For iteration 1 to max_iterations:

  FIRST: Re-read the spec file to ensure you have the full requirements.
  (Context compacting may have dropped details from conversation history.)

  CREATOR: Do the task per the spec. Document explicitly:
    - What was implemented from the spec
    - What was NOT implemented (and why, if intentional)

  EVALUATOR: Judge the output against THE SPEC. Check:
    1. Does implementation match the spec? (methodology, controls, etc.)
    2. Is the work technically correct?
    3. Are there gaps between spec and implementation?

  Output one of:
    - <verdict>APPROVED</verdict> + brief explanation
    - <verdict>NEEDS_REVISION</verdict> + numbered list of specific fixes needed

  If APPROVED: Stop and present final output
  If NEEDS_REVISION: Save feedback, continue loop
```

### Usage examples:
- "Use ralph to write a SQL query for X"
- "Ralph loop this analysis with 3 iterations max"
- "Use the creator/evaluator loop to refine this code"

### Key behaviors:
- Write the requirements spec FIRST - this is the source of truth
- Be rigorous in evaluation - don't rubber stamp
- Evaluator checks SPEC COMPLIANCE, not just output quality
- Creator must explicitly document what was/wasn't implemented from spec
- Evaluator feedback must be specific and actionable
- Creator must address ALL feedback points in next iteration
- Show the user which iteration you're on
- At the end, show the final output and how many iterations it took
