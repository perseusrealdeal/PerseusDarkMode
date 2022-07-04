#!/bin/sh

#  SucceedsPostAction.sh
#  PerseusDarkMode
#
#  Copied and edited by Mikhail Zhigulin in 2022.
#

#  The MIT License (MIT)

#  Copyright (c) 2021 Alexandre Colucci, geteimy.com
#  Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk

#  Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software and associated documentation files (the "Software"), to
#    deal in the Software without restriction, including without limitation the
#    rights to use, copy, modify, merge, publish, distribute, sublicense,
#    and/or sell copies of the Software, and to permit persons to whom the
#    Software is furnished to do so, subject to the following conditions:

#  The above copyright notices and this permission notice shall be included in
#    all copies or substantial portions of the Software.

#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
#    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#    DEALINGS IN THE SOFTWARE.

#-------------------------------------------------------------------------------
#
# Description
#
# Bash script to be used as a 'Succeeds' post action in Xcode.
# This script will trigger SwiftLint when you compile a Swift Package.
#
# Debugging scripts run from the Succeeds Behavior is complex.
# Logs, warnings and errors are not visible in the Build results.
# One solution is to write to a file or use the say command.
#-------------------------------------------------------------------------------
#
# Usage
#
# 1. Ensure that the script has the proper permissions, i.e. 
#    run chmod 755 SucceedsPostAction.sh
# 2. Launch Xcode 13.0 or later
# 3. Open Preferences > Locations and ensure that Command Line Tools
#    is set to an Xcode version
# 4. Open Preferences > Behaviors > Succeeds
# 5. Choose the script SucceedsPostAction.sh
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Check if swiftlint is installed and is an executable
#-------------------------------------------------------------------------------
SWIFTLINT_PATH="/usr/local/bin/swiftlint"
if ! [ -x "${SWIFTLINT_PATH}" ]
then
    SWIFTLINT_PATH="/opt/homebrew/bin/swiftlint"
    if ! [ -x "${SWIFTLINT_PATH}" ]
    then
        exit 0
    fi
fi

#-------------------------------------------------------------------------------
# Get useful paths
#-------------------------------------------------------------------------------
SCRIPT_FOLDER_PATH=`dirname "$0"`
cd "${SCRIPT_FOLDER_PATH}"
SCRIPT_FOLDER_PATH=`pwd -P`

#-------------------------------------------------------------------------------
# Check if the developer is compiling a Swift package
#-------------------------------------------------------------------------------
if [ "${XcodeWorkspace}" != "package.xcworkspace" ]
then
    exit 0
fi

#-------------------------------------------------------------------------------
# Find the root folder of the Swift package
#-------------------------------------------------------------------------------
PACKAGE_WORKSPACE_SUFFIX="/.swiftpm/xcode/package.xcworkspace"
PACKAGE_ROOT_FOLDER="${XcodeWorkspacePath}"
PACKAGE_ROOT_FOLDER=${PACKAGE_ROOT_FOLDER%"${PACKAGE_WORKSPACE_SUFFIX}"}

#-------------------------------------------------------------------------------
# Check if the root folder of the package exists
#-------------------------------------------------------------------------------
if [ ! -d "${PACKAGE_ROOT_FOLDER}" ]
then
    exit 0
fi

#-------------------------------------------------------------------------------
# Run swiftlint
#-------------------------------------------------------------------------------
OUTPUT="${SWIFTLINT_PATH} ${PACKAGE_ROOT_FOLDER}"
OUTPUT_FILE_PATH="${PACKAGE_ROOT_FOLDER}/swiftlint.txt"
${OUTPUT} > ${OUTPUT_FILE_PATH}

#-------------------------------------------------------------------------------
# Remove the lines containing /.build/
#-------------------------------------------------------------------------------
sed -i '' '/\/\.build\//d' ${OUTPUT_FILE_PATH}

#-------------------------------------------------------------------------------
# Check if the file is empty
#-------------------------------------------------------------------------------
if [ ! -s "${OUTPUT_FILE_PATH}" ]
then
    exit 0
fi

#-------------------------------------------------------------------------------
# Open result file in Xcode
#-------------------------------------------------------------------------------
xed ${OUTPUT_FILE_PATH}
