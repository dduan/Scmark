SHELL               = /bin/bash
export LANG         = en_US.UTF-8
export LC_CTYPE     = en_US.UTF-8

.DEFAULT_GOAL := build

.PHONY: test-SwiftPM
test-SwiftPM:
	@swift test -Xswiftc -warnings-as-errors

.PHONY: build
build:
	@swift build -c release -Xswiftc -warnings-as-errors > /dev/null

.PHONY: codegen
codegen: update-test-manifest

.PHONY: update-test-manifest
update-test-manifest:
	@echo "Updating SwiftPM test manifests"
ifeq ($(shell uname),Darwin)
	@rm Tests/ScmarkTests/XCTestManifests.swift
	@touch Tests/ScmarkTests/XCTestManifests.swift
	@swift test --generate-linuxmain
else
	@echo "Skiping test manifest update: only works on macOS."
endif

.PHONY: test-docker
test-docker:
	@Scripts/docker.sh Scmark 'swift test -Xswiftc -warnings-as-errors' 5.3 focal

test-codegen: codegen
	@git diff --exit-code

