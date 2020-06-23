if [ "${CONFIGURATION}" = "Debug" ]
then
echo "Copy Firmware To Demo Project"

# Set build directory
BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-${PLATFORM_NAME}
echo "Build Directory: $BUILD_DIR"

# Set Carthage build directory
CARTHAGE_BUILD_DIR=${PROJECT_DIR}/${PROJECT_NAME}Demo/Carthage/Build/iOS
echo "Carthage Build Directory: $CARTHAGE_BUILD_DIR"

# Copy framework
echo "Copy Framework"
cp -R "$BUILD_DIR/${PROJECT_NAME}.framework" "$CARTHAGE_BUILD_DIR/${PROJECT_NAME}.framework"

# Install Cocoapods
echo "Copy resources using Cocoapods"
pod install --project-directory=${PROJECT_DIR}/${PROJECT_NAME}Demo/

fi
