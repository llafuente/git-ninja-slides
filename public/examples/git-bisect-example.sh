#!bin/sh

cd $(mktemp -d)

# script to test if version is good-or-bad
cat <<DELIM | tee bisect-test.sh
#!/bin/sh

if [[ \$(< test.txt) == "KO" ]]; then
    # send e-mail
    echo "TEST FAIL"
    exit 125
else
    echo "TEST OK"
    exit 0
fi
DELIM

chmod +x bisect-test.sh

git init

echo "OK" > test.txt
git add test.txt
git commit -m "OK 1"

echo "STEP 1" > change.txt
git add change.txt
git commit -m "OK 2"

echo "STEP 2" > change.txt
git commit -a -m "OK 3"

echo "STEP 3" > change.txt
git commit -a -m "OK 4"

echo "KO" > test.txt
git commit -a -m "KO 1"

echo "STEP 4" > change.txt
git commit -a -m "KO 2"

echo "STEP 5" > change.txt
git commit -a -m "KO 3"

LAST=$(git log --oneline | head -n 1 | awk '{print $1}')
FIRST=$(git log --oneline | tail -n 1 | awk '{print $1}')

# shortcut: git bisect start ${LAST} ${FIRST}
git bisect start
git bisect good ${FIRST}
git bisect bad ${LAST}

git bisect run ./bisect-test.sh

git lg
git bisect reset
git lg
