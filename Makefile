# Compiler settings
CXX = clang++
OBJC = clang
SWIFTC = swiftc

# Compiler flags
CXXFLAGS = -std=c++17 -fobjc-arc -framework Foundation
OBJCFLAGS = -fobjc-arc
SWIFTFLAGS = -sdk $(shell xcrun --show-sdk-path) -target x86_64-apple-macos11.0

# Directories
SOURCE_DIR = Source
APP_DIR = Application/macosapp
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj

# Source files
CXX_SOURCES = $(wildcard $(SOURCE_DIR)/*.mm)
OBJC_SOURCES = $(wildcard $(SOURCE_DIR)/*.m)
SWIFT_SOURCES = $(wildcard $(APP_DIR)/*.swift) $(wildcard $(APP_DIR)/Views/*.swift)

# Object files
CXX_OBJECTS = $(patsubst $(SOURCE_DIR)/%.mm,$(OBJ_DIR)/%.o,$(CXX_SOURCES))
OBJC_OBJECTS = $(patsubst $(SOURCE_DIR)/%.m,$(OBJ_DIR)/%.o,$(OBJC_SOURCES))

# Output files
FS_LIB = $(BUILD_DIR)/libmcofs.dylib
APP_BUNDLE = $(BUILD_DIR)/MCOStandardFS.app

# Default target
all: filesystem app

# Create build directories
$(BUILD_DIR) $(OBJ_DIR):
	mkdir -p $@
	mkdir -p $(OBJ_DIR)
	mkdir -p $(BUILD_DIR)/MCOStandardFS.app/Contents/MacOS
	mkdir -p $(BUILD_DIR)/MCOStandardFS.app/Contents/Resources

# Compile Objective-C++ files
$(OBJ_DIR)/%.o: $(SOURCE_DIR)/%.mm | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Compile Objective-C files
$(OBJ_DIR)/%.o: $(SOURCE_DIR)/%.m | $(OBJ_DIR)
	$(OBJC) $(OBJCFLAGS) -c $< -o $@

# Build filesystem library
filesystem: $(CXX_OBJECTS) $(OBJC_OBJECTS) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -shared -o $(FS_LIB) $^

# Build macOS app
app: filesystem
	# Compile Swift files
	$(SWIFTC) $(SWIFTFLAGS) \
		-import-objc-header $(APP_DIR)/MCOStandardFS-Bridging-Header.h \
		-L$(BUILD_DIR) -lmcofs \
		-emit-executable \
		$(SWIFT_SOURCES) \
		-o $(BUILD_DIR)/MCOStandardFS.app/Contents/MacOS/MCOStandardFS

	# Copy library to app bundle
	cp $(FS_LIB) $(BUILD_DIR)/MCOStandardFS.app/Contents/MacOS/

	# Create Info.plist
	echo '<?xml version="1.0" encoding="UTF-8"?>' > $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '<plist version="1.0">' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '<dict>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '    <key>CFBundleIdentifier</key>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '    <string>com.mco.standardfs</string>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '    <key>CFBundleName</key>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '    <string>MCO StandardFS</string>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '    <key>CFBundlePackageType</key>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '    <string>APPL</string>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '    <key>CFBundleShortVersionString</key>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '    <string>1.0</string>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '    <key>LSMinimumSystemVersion</key>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '    <string>11.0</string>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '</dict>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist
	echo '</plist>' >> $(BUILD_DIR)/MCOStandardFS.app/Contents/Info.plist

# Clean build files
clean:
	rm -rf $(BUILD_DIR)

# Install (copy to Applications folder)
install: app
	cp -r $(BUILD_DIR)/MCOStandardFS.app /Applications/

.PHONY: all filesystem app clean install
