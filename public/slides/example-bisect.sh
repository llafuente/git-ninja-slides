#!bin/sh

cd $(mktemp -d)

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

echo "OK" > change.txt
git add change.txt
git commit -m "OK 2"

echo "OKX" > change.txt
git commit -a -m "OK 3"

#git br develop
#git co develop
echo "CHANGE" > change.txt
git commit -a -m "OK 3"

echo "KO" > test.txt
git commit -a -m "KO 1"


#git co master
echo "CHANGE2" > change.txt
git commit -a -m "KO 2"

echo "CHANGE2" > change.txt
git commit -a -m "KO 3"

#git merge master develop --no-ff
#git co --theirs change.txt
#git add change.txt
#git commit # TODO non vi!

LAST=$(git log --oneline | head -n 1 | awk '{print $1}')
FIRST=$(git log --oneline | tail -n 1 | awk '{print $1}')

#git bisect start ${LAST} ${FIRST}
git bisect start
git bisect good ${FIRST}
git bisect bad ${LAST}

git bisect run ./bisect-test.sh

git  lg
git bisect reset
git  lg
