.DEFAULT_GOAL := test

.PHONY: test
test:
	@if grep -e '[”“]' devops >/dev/null 2>&1; then \
		echo "Error: smart quotes detected.  Convert to normal with make cleanfile"; \
		exit 1; \
	fi
	@if cat devops | grep -v '%' | sort | uniq -c | sort -n | grep -v -e ' 1 "' | grep -e '.'; then \
		echo "Error: we have duplicates! Use grep/sort/uniq to find!"; \
		exit 1; \
	fi
	@echo "Everything looks good!"
.PHONY: cleanfile
cleanfile:
	# Clean out any smart quotes
	sed -i.bak s/[”“]/'"'/g devops
	@echo "File is clean"
