PACKAGES := $(filter-out fonts/,$(wildcard */))

.PHONY: all delete

all:
	stow --no-folding --verbose --target=$$HOME --restow $(PACKAGES)

delete:
	stow --no-folding --verbose --target=$$HOME --delete $(PACKAGES)
