#!/usr/bin/expect

set PWD  "Yellowstem1####"
set PWD2 "q6coHjd7P"
set SCP440 "scp cordic.exe renakollmannsuhr@seng440.ece.uvic.ca:/home/renakollmannsuhr/Users/renakollmannsuhr"

set timeout 20
eval spawn "scp CORDIC.c  renakollmannsuhr@ugls.ece.uvic.ca:Users/renakollmannsuhr"
expect "password:"
send "$PWD\r"
expect eof



spawn ssh renakollmannsuhr@ugls.ece.uvic.ca

expect_before timeout {
    exit 1  ;# Exit the script with an error code (1)
}

expect "password:"
send "$PWD\r"

expect "$ "
send "mv Users/renakollmannsuhr/CORDIC.c /tmp/CORDIC.c\r"
send "cd /tmp\r"
expect "tmp]$ "
send "arm-linux-gcc -static -S -fverbose-asm -marm CORDIC.c -o cordic.s\n"
send "arm-linux-gcc -static -marm -o cordic.exe cordic.s\n"
send "mv cordic.s ~/\n"
send "mv cordic.exe ~/\n"
send "cd\n"

send "$SCP440\r"
expect "password:"
send "$PWD\r"
expect "$ "
send "rm cordic.exe\n"
send "rm cordic.o\n"
send "rm CORDIC.c\n"
send "logout\r"

expect eof

spawn ssh renakollmannsuhr@seng440.ece.uvic.ca

expect_before timeout {
    exit 1  ;# Exit the script with an error code (1)
}

expect "password:"
send "$PWD\r"

expect "$ "
send "cd Users/renakollmannsuhr\r"
send "lftp user1@arm\r"
expect "Password:"
send "$PWD2\r"

expect "~> "
send "put cordic.exe\r"
sleep 20
send "quit\r"

expect "$ "
send "rm cordic.exe\n"
send "telnet arm\r"
expect "login:"
send "user1\r"
expect "Password:"
send "$PWD2\r"

expect "# "
send "chmod +x cordic.exe && ./cordic.exe\r"
sleep 5
send "\x1d\n"

expect "> "
send "quit\n"

expect "$ "
send "exit\n"

expect "$ "
eval spawn "scp renakollmannsuhr@ugls.ece.uvic.ca:~/cordic.s  cordic.s\n"

interact
