#!/usr/bin/env bash
# Netlify build script: the Netlify build image has no JDK 25, so download
# Temurin JDK 25 from Adoptium, then run the JBake build through Gradle.
set -euo pipefail

JDK_MAJOR=25
JDK_DIR="${NETLIFY_BUILD_BASE:-/opt/buildhome}/jdk${JDK_MAJOR}"

if [ ! -x "${JDK_DIR}/bin/java" ]; then
  echo "Downloading Temurin JDK ${JDK_MAJOR}..."
  mkdir -p "${JDK_DIR}"
  curl -fsSL "https://api.adoptium.net/v3/binary/latest/${JDK_MAJOR}/ga/linux/x64/jdk/hotspot/normal/eclipse" \
    | tar -xz --strip-components=1 -C "${JDK_DIR}"
fi

export JAVA_HOME="${JDK_DIR}"
export PATH="${JAVA_HOME}/bin:${PATH}"
java -version

./gradlew bake --no-daemon --console=plain
