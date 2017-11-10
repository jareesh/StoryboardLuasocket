
# Convert our library specified by SRC_JAR into a deployable 
# Android library that can be externally loaded.

# The full path to the library that you want to convert
SRC_JAR=/Users/thomas/workspaces/gde/AJavaLib/ajavalib.jar

# The base name of the library
JAR_NAME=$(notdir $(SRC_JAR))

$(JAR_NAME): classes.dex
	rm -f $(JAR_NAME)
	#cp -f $(SRC_JAR) $(JAR_NAME)
	aapt add -v $(JAR_NAME) classes.dex

classes.dex: $(SRC_JAR)
	dx --verbose --dex --output=classes.dex $(SRC_JAR)

clean:
	rm -fr *.dex *.jar
