.PHONY: all
all: docs

.PHONY: docs
docs:
	mume html docs/tutorial.md

# APIKit's podspec still declares iOS 9.0, which Xcode 27 refuses to build.
# Scripts/min_ios_15.rb clamps every pod's iOS deployment target to >= 15.0 for
# the duration of the CocoaPods run. See the comments in that file.
SHIM := RUBYOPT="-r$(CURDIR)/Scripts/min_ios_15.rb"

.PHONY: lint
lint:
	$(SHIM) pod lib lint --allow-warnings

.PHONY: release
release: lint
	$(SHIM) pod trunk push --allow-warnings
