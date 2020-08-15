

# Remove prefix

for file in TODO-*.template; do
  mv ${file} ${file/#TODO-/}
done