if [[ "$REQUEST_METHOD" != "POST" ]]; then
  return $(status_code 405)
fi

[ ! -d "data/answers/" ] && mkdir data/answers/

echo "${QUERY_PARAMS[answer]}" > "data/answers/${QUERY_PARAMS[question]}"

