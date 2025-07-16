# bin/bash

rm -rf src/data/editions && mkdir src/data/editions
rm -rf src/data/meta && mkdir src/data/meta
rm imprint.xml
curl -LO https://github.com/acdh-oeaw/bruckner-kopisten-data/archive/refs/heads/main.tar.gz
tar -xzvf main.tar.gz
mv ./bruckner-kopisten-data-main/data/editions/*.xml ./src/data/editions
rm -rf bruckner-kopisten-data-main
rm main.tar.gz
