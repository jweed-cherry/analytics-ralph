#!/bin/bash
# Analytics Ralph - Analyst/Evaluator feedback loop
# Usage: ./analytics-ralph.sh <project_name> [max_iterations]
# Example: ./analytics-ralph.sh cured_delinquency 5

set -e

# Check for project name
if [ -z "$1" ]; then
  echo "Usage: ./analytics-ralph.sh <project_name> [max_iterations]"
  echo ""
  echo "Examples:"
  echo "  ./analytics-ralph.sh cured_delinquency 5"
  echo "  ./analytics-ralph.sh fraud_analysis"
  echo ""
  echo "This will create a project folder with question.md, analysis.md, feedback.md"
  exit 1
fi

PROJECT_NAME="$1"
MAX_ITERATIONS=${2:-5}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Project folder
PROJECT_DIR="$SCRIPT_DIR/projects/$PROJECT_NAME"

# Create project folder if it doesn't exist
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Creating new project: $PROJECT_NAME"
  mkdir -p "$PROJECT_DIR"

  # Copy template question file
  cat > "$PROJECT_DIR/question.md" << 'EOF'
# Analysis Question

## Question
[Your question here]

## Context
- [Relevant context]
- [Data sources to use]

## Controls Required
1. [Control variable 1]
2. [Control variable 2]

## Success Criteria
- [What makes a good answer]
EOF

  echo ""
  echo "Created project folder: $PROJECT_DIR"
  echo ""
  echo "Next steps:"
  echo "  1. Edit $PROJECT_DIR/question.md with your question"
  echo "  2. Run: ./analytics-ralph.sh $PROJECT_NAME $MAX_ITERATIONS"
  exit 0
fi

# File paths (within project folder)
QUESTION_FILE="$PROJECT_DIR/question.md"
ANALYSIS_FILE="$PROJECT_DIR/analysis.md"
FEEDBACK_FILE="$PROJECT_DIR/feedback.md"
HISTORY_FILE="$PROJECT_DIR/history.md"

# Shared prompts (in script directory)
ANALYST_PROMPT="$SCRIPT_DIR/ANALYST.md"
EVALUATOR_PROMPT="$SCRIPT_DIR/EVALUATOR.md"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Disallowed tools - block all write/delete/mutating operations
# This ensures the autonomous agents are READ-ONLY
DISALLOWED_TOOLS=(
  # Google Sheets - write operations
  "mcp__google-sheets__update_cells"
  "mcp__google-sheets__batch_update_cells"
  "mcp__google-sheets__add_rows"
  "mcp__google-sheets__add_columns"
  "mcp__google-sheets__copy_sheet"
  "mcp__google-sheets__rename_sheet"
  "mcp__google-sheets__create_spreadsheet"
  "mcp__google-sheets__create_sheet"
  "mcp__google-sheets__share_spreadsheet"
  "mcp__google-sheets__batch_update"
  # Google Docs - write operations
  "mcp__google-docs__appendToGoogleDoc"
  "mcp__google-docs__insertText"
  "mcp__google-docs__deleteRange"
  "mcp__google-docs__applyTextStyle"
  "mcp__google-docs__applyParagraphStyle"
  "mcp__google-docs__insertTable"
  "mcp__google-docs__editTableCell"
  "mcp__google-docs__batchEditTableCells"
  "mcp__google-docs__insertPageBreak"
  "mcp__google-docs__insertImageFromUrl"
  "mcp__google-docs__insertLocalImage"
  "mcp__google-docs__fixListFormatting"
  "mcp__google-docs__addComment"
  "mcp__google-docs__replyToComment"
  "mcp__google-docs__resolveComment"
  "mcp__google-docs__deleteComment"
  "mcp__google-docs__formatMatchingText"
  "mcp__google-docs__createFolder"
  "mcp__google-docs__moveFile"
  "mcp__google-docs__copyFile"
  "mcp__google-docs__renameFile"
  "mcp__google-docs__deleteFile"
  "mcp__google-docs__createDocument"
  "mcp__google-docs__createFromTemplate"
  "mcp__google-docs__createTab"
  "mcp__google-docs__deleteTab"
  "mcp__google-docs__updateTab"
  # Metabase - write operations
  "mcp__metabase__create_card"
  "mcp__metabase__update_card"
  "mcp__metabase__delete_card"
  "mcp__metabase__create_dashboard"
  "mcp__metabase__update_dashboard"
  "mcp__metabase__delete_dashboard"
  "mcp__metabase__add_card_to_dashboard"
  # Notion - write operations
  "mcp__notion__notion-create-pages"
  "mcp__notion__notion-update-page"
  "mcp__notion__notion-move-pages"
  "mcp__notion__notion-duplicate-page"
  "mcp__notion__notion-create-database"
  "mcp__notion__notion-update-database"
  "mcp__notion__notion-create-comment"
)

# Join array into comma-separated string
DISALLOWED_TOOLS_STR=$(IFS=','; echo "${DISALLOWED_TOOLS[*]}")

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  Analytics Ralph - Analyst/Evaluator Loop${NC}"
echo -e "${BLUE}  Project: $PROJECT_NAME${NC}"
echo -e "${BLUE}  Max iterations: $MAX_ITERATIONS${NC}"
echo -e "${BLUE}================================================${NC}"

# Check for question file
if [ ! -f "$QUESTION_FILE" ]; then
  echo -e "${RED}Error: question.md not found in $PROJECT_DIR${NC}"
  exit 1
fi

# Check if question is still template
if grep -q "\[Your question here\]" "$QUESTION_FILE"; then
  echo -e "${RED}Error: question.md still contains template text${NC}"
  echo "Edit $QUESTION_FILE with your actual question first."
  exit 1
fi

# Initialize history file
if [ ! -f "$HISTORY_FILE" ]; then
  echo "# Analytics Ralph History - $PROJECT_NAME" > "$HISTORY_FILE"
  echo "Started: $(date)" >> "$HISTORY_FILE"
  echo "" >> "$HISTORY_FILE"
  echo "## Question" >> "$HISTORY_FILE"
  cat "$QUESTION_FILE" >> "$HISTORY_FILE"
  echo "" >> "$HISTORY_FILE"
  echo "---" >> "$HISTORY_FILE"
fi

# Clear previous feedback for fresh start (keep analysis if exists for context)
if [ -f "$FEEDBACK_FILE" ]; then
  echo -e "${YELLOW}Clearing previous feedback file...${NC}"
  rm "$FEEDBACK_FILE"
fi

for i in $(seq 1 $MAX_ITERATIONS); do
  echo ""
  echo -e "${BLUE}===============================================================${NC}"
  echo -e "${BLUE}  Iteration $i of $MAX_ITERATIONS${NC}"
  echo -e "${BLUE}===============================================================${NC}"

  # ============================================
  # PHASE 1: ANALYST
  # ============================================
  echo ""
  echo -e "${GREEN}>>> PHASE 1: ANALYST${NC}"
  echo -e "${GREEN}    Running analysis...${NC}"
  echo ""

  # Build analyst context - tell it where to write files
  ANALYST_CONTEXT=$(cat "$ANALYST_PROMPT")
  ANALYST_CONTEXT+="\n\n---\n\n## PROJECT FOLDER\n\nWrite your analysis to: $ANALYSIS_FILE"
  ANALYST_CONTEXT+="\n\n---\n\n## Current Question\n\n"
  ANALYST_CONTEXT+=$(cat "$QUESTION_FILE")

  if [ -f "$FEEDBACK_FILE" ]; then
    ANALYST_CONTEXT+="\n\n---\n\n## Previous Feedback (YOU MUST ADDRESS ALL POINTS)\n\n"
    ANALYST_CONTEXT+=$(cat "$FEEDBACK_FILE")
  fi

  if [ -f "$ANALYSIS_FILE" ]; then
    ANALYST_CONTEXT+="\n\n---\n\n## Your Previous Analysis (revise based on feedback)\n\n"
    ANALYST_CONTEXT+=$(cat "$ANALYSIS_FILE")
  fi

  # Run analyst (with disallowed write tools for safety)
  echo -e "$ANALYST_CONTEXT" | claude --dangerously-skip-permissions --disallowedTools "$DISALLOWED_TOOLS_STR" --print 2>&1 | tee /tmp/analyst_output.txt

  # Log to history
  echo "" >> "$HISTORY_FILE"
  echo "## Iteration $i - Analyst" >> "$HISTORY_FILE"
  echo "Time: $(date)" >> "$HISTORY_FILE"
  echo "" >> "$HISTORY_FILE"

  # Check if analysis was created
  if [ ! -f "$ANALYSIS_FILE" ]; then
    echo -e "${RED}Error: Analyst did not create analysis.md${NC}"
    exit 1
  fi

  # ============================================
  # PHASE 2: EVALUATOR
  # ============================================
  echo ""
  echo -e "${YELLOW}>>> PHASE 2: EVALUATOR${NC}"
  echo -e "${YELLOW}    Evaluating analysis...${NC}"
  echo ""

  # Build evaluator context - tell it where to write files
  EVALUATOR_CONTEXT=$(cat "$EVALUATOR_PROMPT")
  EVALUATOR_CONTEXT+="\n\n---\n\n## PROJECT FOLDER\n\nWrite your evaluation to: $FEEDBACK_FILE"
  EVALUATOR_CONTEXT+="\n\n---\n\n## Original Question\n\n"
  EVALUATOR_CONTEXT+=$(cat "$QUESTION_FILE")
  EVALUATOR_CONTEXT+="\n\n---\n\n## Analysis to Evaluate\n\n"
  EVALUATOR_CONTEXT+=$(cat "$ANALYSIS_FILE")
  EVALUATOR_CONTEXT+="\n\n---\n\nThis is iteration $i of $MAX_ITERATIONS. Please evaluate and write your feedback to $FEEDBACK_FILE."

  # Run evaluator (with disallowed write tools for safety)
  EVAL_OUTPUT=$(echo -e "$EVALUATOR_CONTEXT" | claude --dangerously-skip-permissions --disallowedTools "$DISALLOWED_TOOLS_STR" --print 2>&1 | tee /tmp/evaluator_output.txt)

  # Log to history
  echo "" >> "$HISTORY_FILE"
  echo "## Iteration $i - Evaluator" >> "$HISTORY_FILE"
  echo "Time: $(date)" >> "$HISTORY_FILE"
  echo "" >> "$HISTORY_FILE"

  # Check for approval
  if [ -f "$FEEDBACK_FILE" ] && grep -q "<verdict>APPROVED</verdict>" "$FEEDBACK_FILE"; then
    echo ""
    echo -e "${GREEN}===============================================================${NC}"
    echo -e "${GREEN}  APPROVED! Analysis passed evaluation.${NC}"
    echo -e "${GREEN}  Completed at iteration $i of $MAX_ITERATIONS${NC}"
    echo -e "${GREEN}===============================================================${NC}"
    echo ""
    echo "Final analysis: $ANALYSIS_FILE"
    echo "Evaluation: $FEEDBACK_FILE"

    # Log completion
    echo "" >> "$HISTORY_FILE"
    echo "---" >> "$HISTORY_FILE"
    echo "## COMPLETED" >> "$HISTORY_FILE"
    echo "Approved at iteration $i" >> "$HISTORY_FILE"
    echo "Time: $(date)" >> "$HISTORY_FILE"

    exit 0
  fi

  echo -e "${YELLOW}    Needs revision. Continuing to next iteration...${NC}"
  sleep 2
done

echo ""
echo -e "${RED}===============================================================${NC}"
echo -e "${RED}  Max iterations ($MAX_ITERATIONS) reached without approval.${NC}"
echo -e "${RED}===============================================================${NC}"
echo ""
echo "Final analysis: $ANALYSIS_FILE"
echo "Last feedback: $FEEDBACK_FILE"
echo "History: $HISTORY_FILE"

exit 1
