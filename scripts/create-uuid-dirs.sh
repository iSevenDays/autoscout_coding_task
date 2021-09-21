#!/bin/bash

# Find all executables embedded in our built XCFrameworks
executable_paths=`ls -l ../Carthage/Build/*xcframework/*/*.framework/* | grep -Ev '\.h$' | grep "\-rwx" | awk '{print $NF}'`

for executable_path in $executable_paths
do
	# $executable_path will resemble something like Carthage/Build/Hopoate.xcframework/ios-arm64/Hopoate.framework/Hopoate

	# Get the executable name from the last path component
	executable_name=$(echo $executable_path | cut -d'/' -f 6)

	# Get the path to the framework architecture directory inside the parent xcframework directory, relative to the Carthage root directory
	architecture_directory_path=$(echo $executable_path | cut -d'/' -f 2,3,4)

	# Create the path to the architecture's dSYM file that was created when the XCFramework was built
	dSYM_path=$architecture_directory_path/dSYMS/$executable_name.framework.dSYM/Contents/Resources/DWARF/$executable_name

	# Extract the UUID from the executable.
	dwarf_dump=`xcrun dwarfdump --uuid $executable_path`
	UUID=${dwarf_dump:6:36}

	# Create the UUID directory structure required by LLDB's File Mapped UUID Directories
	directory_path=../Carthage/dSYMs/UUIDs/${UUID:0:4}/${UUID:4:4}/${UUID:9:4}/${UUID:14:4}/${UUID:19:4}

	# Create the directories
	mkdir -p $directory_path

	# The final leaf node to be sym-linked to the dSYM file
	final_node=${UUID:24:12}

	# Sym-link back to the executable's dSYM
	ln -s ../../../../../../../$dSYM_path $directory_path/$final_node
done