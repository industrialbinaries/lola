install:
	swift package update
	swift build -c release
	install .build/release/lola /usr/local/bin/lola
