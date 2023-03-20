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

mint:
	git clone --branch 0.16.0 https://github.com/yonaskolb/Mint
	cd Mint
	make
	cd ..
	rm -rf Mint
