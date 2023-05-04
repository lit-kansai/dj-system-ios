.DEFAULT_GOAL := setup
PRODUCT_NAME := DJSystemiOS
SCHEME_NAME := DJSystemiOS
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj
TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug
TEST_PLATFORM := iOS Simulator
TEST_DEVICE ?= iPhone 14
TEST_OS ?= 16.2
TEST_DESTINATION := 'platform=${TEST_PLATFORM},name=${TEST_DEVICE},OS=${TEST_OS}'

.PHONY: setup
setup: mint xcodegen open

.PHONY: xcodegen
xcodegen:
	mint run xcodegen

.PHONY: open
open:
	open ${PRODUCT_NAME}.xcodeproj

.PHONY: mint
mint:
	mint bootstrap

.PHONY: install-mint
install-mint:
	git clone --branch 0.16.0 https://github.com/yonaskolb/Mint
	cd Mint
	make
	cd ..
	rm -rf Mint

.PHONY: test
test:
	xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-project ${PROJECT_NAME} \
-scheme '${SCHEME_NAME}' \
-destination ${TEST_DESTINATION} \
-resultBundlePath TestResults \
test

.PHONY: build
build:
	xcodebuild \
-configuration ${TEST_CONFIGURATION} \
-project ${PROJECT_NAME} \
-scheme '${SCHEME_NAME}' \
-showBuildTimingSummary \
-destination ${TEST_DESTINATION} \
OTHER_SWIFT_FLAGS="-warnings-as-errors" \
| tee build$(date +%s).log \
| egrep '(swift:[0-9]+:[0-9]+: error:|cannot be found|BUILD SUCCEEDED|.swift.*warning.*Violation)' \
| sed 's/:/,/g'


.PHONY: packages
packages:
	xcodebuild -resolvePackageDependencies \
-project ${PROJECT_NAME} \
-scheme ${SCHEME_NAME} \
-clonedSourcePackagesDirPath ./SourcePackages

.PHONY: clean
clean:
	xcodebuild clean -project ${PROJECT_NAME}

