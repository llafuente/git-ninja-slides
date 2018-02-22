git bisect start
git bisect good <sha1>
git bisect bad <sha1>

# shortcut: git bisect start ${LAST} ${FIRST}

# use script to automate the process
git bisect run ./script.sh

# mark current step
git bisect good|bad
