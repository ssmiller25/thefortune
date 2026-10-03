.DEFAULT_GOAL := test

.PHONY: test
# Duplicate detection is per line, and entries in devops may span several lines.
# Do not anchor the filter below to a leading quote: continuation lines of a
# multi-line entry do not begin with one, so doing so flags them as duplicates
# even though uniq counts them once. Match on the count instead.
test:
	@if grep -e '[”“]' devops >/dev/null 2>&1; then \
		echo "Error: smart quotes detected.  Convert to normal with make cleanfile"; \
		exit 1; \
	fi
	@if cat devops | grep -v '%' | sort | uniq -c | awk '$$1 > 1' | grep -e '.'; then \
		echo "Error: we have duplicates! Use grep/sort/uniq to find!"; \
		exit 1; \
	fi
	@echo "Everything looks good!"
.PHONY: cleanfile
cleanfile:
	# Clean out any smart quotes
	sed -i.bak s/[”“]/'"'/g devops
	@echo "File is clean"
