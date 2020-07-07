if [ "${CONFIGURATION}" = "Debug" ]
then
echo "Copy Firmware To Demo Project"

# Set build directory
BUILD_DIR=${BUILD_DIR}/${CONFIGURATION}-${PLATFORM_NAME}
echo "Build Directory: $BUILD_DIR"

# Set Carthage build directory
CARTHAGE_BUILD_DIR=${PROJECT_DIR}/Demo/Carthage/Build/iOS
echo "Carthage Build Directory: $CARTHAGE_BUILD_DIR"

# Remove existing framework
echo "Remove Current Framework"
rm -rf "$CARTHAGE_BUILD_DIR/${PROJECT_NAME}.framework"

# Copy framework
echo "Copy Framework"
cp -R "$BUILD_DIR/${PROJECT_NAME}.framework" "$CARTHAGE_BUILD_DIR/${PROJECT_NAME}.framework"

# Install Cocoapods (ignored, no assets anyway)
#echo "Copy resources using Cocoapods"
#pod install --project-directory=${PROJECT_DIR}/Demo/

fi
