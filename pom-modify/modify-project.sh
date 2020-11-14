#!/bin/bash

ARTIFACT_ID="nondex-maven-plugin"
ARTIFACT_VERSION="1.1.2"
GROUP_ID="edu.illinois"

if [[ $1 == "" ]]; then
    echo "arg1 - the path to the project, where high-level pom.xml is"
    echo "arg2 - (Optional) Custom version for the artifact (e.g., 1.0.2, 1.0.3-SNAPSHOT). Default is $ARTIFACT_VERSION"
    exit
fi

if [[ ! $2 == "" ]]; then
    ARTIFACT_VERSION=$2
fi

crnt=`pwd`
working_dir=`dirname $0`
project_path=$1

cd ${project_path}
project_path=`pwd`
cd - > /dev/null

cd ${working_dir}

javac PomFile.java
find ${project_path} -name pom.xml | grep -v "src/" | java PomFile ${ARTIFACT_ID} ${ARTIFACT_VERSION} ${GROUP_ID}
rm -f PomFile.class

cd ${crnt}
