+ prerequisites:
    + how linux commands work
    + using the man command for finding documentation to quickly learn about a command


+ you can call bash directly in command line to execute the script, OR have the script use bash to execute itself. either way works


+ if you want the script to choose a specific shell:
    + #!/path/to/shell (the shebang. yes thats its name)
    + e.g. #!/bin/bash


+ BASH SCRIPT EXAMPLE
+ just know that bash scripts use literally the same structure as you would in command line bash. so much so that you would get more comfortable with the commandline with this
-----------
fig. 1
-----------
echo hello
cat file.md

sudo dnf upgrade

## by the way you can use comments here. just like programming languages!
## holy shit i typed a comment in commandline and it didn't throw errors. it worked?
-----------

+ VARIABLES
+ what we don't say is that variables can be used in commandline or in scripting
-----------
fig. 2
-----------
DOWNLOADS=~/Downdloads

cd $DOWNLOADS

## new keyword: read
read MY_NAME
echo $MY_NAME

## ask the user to define value of variable MY_NAME, and then print said variable out
## did you know that you've likely already worked with variables before? remember typing a word with all caps prefixed with a dollar sign? like $SHELL by any chance? yes SHELL is a variable- whose value is the path to the system's shell

-----------

+ POSITIONAL ARGUMENTS
+ using positional arguments in your script are basically like how commands are structured

+ they are ordered like array variable indices -> 0,1,2,3,4...
+ these arguments can be accessed by the variable named after the position, but 0 is not accessible to the user
+ it is best to reference arguments by adding ${N}. where N is the position referencing to the argument

-----------
fig. 3
-----------
ls [OPTION]... [FILE]....
dnf [options] <command> [<args...>]
cat [OPTION]... [FILE]...

## provided by man pages

-----------


+ Q: how does this work?
-----------
fig. 4
-----------
## test.sh
echo hello $2 $1

## define the command such that the script outputs: hello michael afton

-----------

+ OUTPUT REDIRECTION
+ you can send outputs to a file
    + >  -> write to file [data loss risk]
    + >> -> append to file
(this really useful if you want to copy results to a file)
+ want to use output of one command as an input of another?
    + command 1 | command 2
    + basically, command 2 takes the output of command 1 as input
-----------
fig. 5
-----------
dnf list | grep bash > current_python_packages.txt
## use left command as input for second command

echo $SHELL >> all_my_shells.txt

-----------


+ PIPING
+ you can filter command outputs with the | grep <keyword> after a command statement
-----------
fig. 6
-----------
## output all lines containing "bash"

dnf list | grep bash

-----------


+ TEST COMMANDS
+ we can compare things to see if they equal with this syntax:
    + [ value1 <operator> value2 ]
    + use "=" as operator to compare as strings
    + use "-eq" as operator to compare as integers
+ echo $? -> check return value of last command
-----------
fig. 7
-----------
## Q: which of these would return a non-zero value, when checked with echo $? (false)?

## Q: what does the third test command return if you switch the operator with -eq? why?

[ 1 = 0 ]

[ 1 -eq 1 ]  

[ $SHELL = /bin/bash ]

-----------


+ CONDITIONALS
-----------
fig. 8
-----------
if [ <condition> ]; then
    <code block>
elif [<condition>]; then
    <code block>
else
    <code block>
fi

## <condition> is a text command. if it returns 1 the code nested under it executes, else it goes to the next condition to check
## usually conditions are an if, elif, else chain of conditions, with "fi" written last to end it


## Q: what does ",," mean in ${2,,}?

-----------


+ CASE STATEMENTS
-----------
fig. 9
-----------
case <value> in 
    value_1)
        <block>
        ;;
    value_2)
        <block>
        ;;
    value_x)
        <block>
        ;;
    *)
        <block>
        ;;
esac

## <value> is compared to value_1, value_2, etc...
## ")" is used to terminate the comparison
## ";;" terminates the block code
## "*" is a catch all condition if nothing is true
## "esac" terminates the case statement

-----------

+ ARRAYS

-----------
fig. 10
-----------
ARRAY=(a b c d e f)

## echo-ing $ARRAY gives you first element, but echo-ing ${ARRAY[@]} gives you all elements. the [] determines what value is being referenced.it can be an index or @ to describe all of them

-----------


+ FOR LOOPS
-----------
how do for loops work???
-----------

+ FUNCTIONS
+ looks similar to normal python functions

-----------
## declaration with args
install_tools() {
    echo $1
    <code>
}

## calling it with parameter
install_tools "hello!"
