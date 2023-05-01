.DEFAULT_GOAL := setup

.PHONY: setup
setup: mint xcodegen open

.PHONY: xcodegen
xcodegen:
	mint run xcodegen

.PHONY: open
open:
	open DJSystemiOS.xcodeproj

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
