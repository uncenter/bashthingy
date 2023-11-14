
if [[ ! -f data/question_index ]]; then
  echo "0" > data/question_index
fi

QUESTION_INDEX=$(cat data/question_index)
QUESTION=$(sed -n "$(($QUESTION_INDEX+1))p" pages/questions.txt)

if [[ "$REQUEST_METHOD" == "POST" ]]; then
  QUESTION_INDEX=$(( COUNT + 1 ))
  echo "$QUESTION_INDEX" > data/question_index
fi

old_IFS=$IFS
IFS=','
read -ra QUESTION_PARTS <<< "$QUESTION"
IFS=$old_IFS

QUESTION_PROMPT=${QUESTION_PARTS[0]}
QUESTION_ANSWER_A=${QUESTION_PARTS[1]}
QUESTION_ANSWER_B=${QUESTION_PARTS[2]}

htmx_page << EOF
  <p>$QUESTION_PROMPT</p>
  <button hx-post="/save?question=$QUESTION_INDEX&answer=$QUESTION_ANSWER_A" hx-swap="none">$QUESTION_ANSWER_A</button>
  <button hx-post="/save?question=$QUESTION_INDEX&answer=$QUESTION_ANSWER_B" hx-swap="none">$QUESTION_ANSWER_B</button>
EOF
