.PHONY: xcodegen
xcodegen:
	mint run xcodegen

.PHONY: open
open:
	open DJSystemiOS.xcodeproj

.PHONY: setup
setup:
	mint bootstrap
	make xcodegen
	make open

