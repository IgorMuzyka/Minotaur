
build:
	swift build

run:
	swift run

update:
	swift package update

resolve:
	swift package resolve

cleanup:
	rm -rf .build

clean: cleanup update build

xcode:
	swift package generate-xcodeproj

edit:
	vim Package.swift

