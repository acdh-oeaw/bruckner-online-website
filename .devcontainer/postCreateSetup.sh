#!/bin/bash

set -e

echo "🔧 Installing Java and Ant..."

# Update and install OpenJDK 11 + Ant
apt-get update && \
apt-get install -y --no-install-recommends \
    openjdk-17-jre-headless \
    ant \
    curl

# Install Ant-Contrib
ANT_CONTRIB_VERSION="1.0b3"
ANT_CONTRIB_JAR="ant-contrib-${ANT_CONTRIB_VERSION}.jar"
ANT_CONTRIB_URL="https://repo1.maven.org/maven2/ant-contrib/ant-contrib/${ANT_CONTRIB_VERSION}/${ANT_CONTRIB_JAR}"

echo "📦 Downloading Ant-Contrib..."
curl -L -o "/usr/share/ant/lib/${ANT_CONTRIB_JAR}" "${ANT_CONTRIB_URL}"

echo "✅ Java, Ant, and Ant-Contrib installed successfully"
