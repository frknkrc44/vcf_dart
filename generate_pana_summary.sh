#!/bin/bash

OUTPUT_FILE="pana_result.log"
echo $JSON_OUTPUT > $OUTPUT_FILE

PANA_VERSION=$(jq -r '.runtimeInfo.panaVersion' $OUTPUT_FILE)
DART_VERSION=$(jq -r '.runtimeInfo.sdkVersion' $OUTPUT_FILE)
FLUTTER_VERSION=$(jq -r '.runtimeInfo.flutterVersions.flutterVersion' $OUTPUT_FILE)
FLUTTER_CHANNEL=$(jq -r '.runtimeInfo.flutterVersions.channel' $OUTPUT_FILE)
PACKAGE_NAME=$(jq -r '.packageName' $OUTPUT_FILE)
PACKAGE_VERSION=$(jq -r '.packageVersion' $OUTPUT_FILE)
GRANTED_TOTAL_POINTS=$(jq -r '.scores.grantedPoints' $OUTPUT_FILE)
MAX_TOTAL_POINTS=$(jq -r '.scores.maxPoints' $OUTPUT_FILE)

echo "# Analysis result of "$PACKAGE_NAME" v"$PACKAGE_VERSION
echo
echo "Analyzed with Pana "$PANA_VERSION" (Dart v"$DART_VERSION" - Flutter v"$FLUTTER_VERSION" ("$FLUTTER_CHANNEL"))"
echo
echo "Granted total points: "$GRANTED_TOTAL_POINTS"/"$MAX_TOTAL_POINTS

SECTION_LENGTH=$(jq -r '.report.sections | length' $OUTPUT_FILE)

for i in `seq 0 $(( SECTION_LENGTH - 1 ))`
do
    SECTION_TITLE=$(jq -r ".report.sections[$i].title" $OUTPUT_FILE)
    SECTION_POINTS=$(jq -r ".report.sections[$i].grantedPoints" $OUTPUT_FILE)
    SECTION_MAX_POINTS=$(jq -r ".report.sections[$i].grantedPoints" $OUTPUT_FILE)
    SECTION_STATUS=$(jq -r ".report.sections[$i].status" $OUTPUT_FILE)

    if [ $SECTION_STATUS == 'passed' ]
    then
        SECTION_STATUS='✅'
    else
        SECTION_STATUS='❌'
    fi

    SECTION_SUMMARY=$(jq ".report.sections[$i].summary" $OUTPUT_FILE | sed -e 's/\[\*\]/✅/g' -e 's/\[x\]/❌/g' -e 's/\[~\]/⚠/g' -e 's/^"//g' -e 's/"$//g' -e 's/\\n/\n/g')
    
    echo "## "$SECTION_STATUS" "$SECTION_TITLE" "$SECTION_POINTS"/"$SECTION_MAX_POINTS
    printf "%s\n" "$SECTION_SUMMARY"
done
