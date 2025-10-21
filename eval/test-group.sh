#!/bin/zsh
unset HOME
PRJPACK=bci

###########################################################################
#
error_exit() {
    echo "Error: $1" >&2
    echo "Usage: $0 DELIVERY GROUP" >&2
    echo "          DELIVERY is one of 'e0', 'ei', or 'ef'" >&2
    echo "          GROUP must be a 3-digit number" >&2
    exit 1
}

[[ $# -ne 2 ]] && error_exit "two arguments are expected"

DELIVERY=$1
GROUP=$2

JAVADIR=/usr/share/java
BASE_DIR=`pwd`
EVAL_DIR=$BASE_DIR
LOGS_DIR=$EVAL_DIR/logs/$DELIVERY
TESTS_DIR=$EVAL_DIR/auto-tests
GROUP_RATE=1

###########################################################################
#
LOG_FILE=$LOGS_DIR/$GROUP.log.html
RESULTS_FILE=$LOGS_DIR/$GROUP.res.html

###########################################################################
#
PROJDIR=$BASE_DIR/checked-out/$GROUP
PROJDIR_REF=$BASE_DIR/checked-out-ref/$GROUP
PRJCORE=$PRJPACK-core
PRJAPP=$PRJPACK-app
PRJUML=uml
M_CLASSPATH=$BASE_DIR/po-uilib.jar:$PROJDIR/$PRJCORE/$PRJCORE.jar:$PROJDIR/$PRJAPP/$PRJAPP.jar
M_MAINCLASS=$PRJPACK.app.App


cp $BASE_DIR/AppMakefile $PROJDIR/$PRJAPP/Makefile

unset CLASSPATH

###########################################################################
#

function compile_project() {

  #------------------------------------------------------------------------

  #echo "<pre>" >> $RESULTS_FILE
  echo "#################### PROJECT STRUCTURE ####################" >> $RESULTS_FILE
  echo >> $RESULTS_FILE
  echo "$M_CLASSPATH" >> $RESULTS_FILE

  if [ "$DELIVERY" = "e0" ]; then
    DIFF=`diff -r $PROJDIR_REF $PROJDIR --exclude=.git | fgrep -v ist13500 | egrep -v -e '^[0-9]' | fgrep -v -e '---' | fgrep -v diff`
  else
    DIFF=`diff -r $PROJDIR_REF $PROJDIR --exclude=.git --exclude=uml | fgrep -v ist13500 | egrep -v -e '^[0-9]' | fgrep -v -e '---' | fgrep -v diff`
  fi
  if [ x$DIFF = "x" ]; then
    echo "!!! Bad project: repository does not contain the required delivery. !!!" >> $RESULTS_FILE
    echo >> $RESULTS_FILE
    echo
    exit
  fi
  
  #------------------------------------------------------------------------

  if [ "$DELIVERY" = "e0" ]; then

    echo "Checking for presence of UML diagrams..."
    cd $PROJDIR

    # check for "uml" directory
    if [ ! -d $PRJUML ]; then
      echo "!! $PRJUML missing." >> $RESULTS_FILE
      echo >> $RESULTS_FILE
      echo
      exit
    else
      echo "-- $PRJUML is present." >> $RESULTS_FILE
    fi
  
    cd $PRJUML
    for i in $(cat $BASE_DIR/files-list-uml.txt); do
      file $i | grep "PDF" > /dev/null
      #if [[ ! -s $i || ! -f $i  ]]; then
      if [[ "$?" = "1" ]]; then
        echo "!! $PRJUML/$i invalid or empty." >> $RESULTS_FILE
        #echo >> $RESULTS_FILE
        #echo
        #exit
      else
        echo "-- $PRJUML/$i is present." >> $RESULTS_FILE
      fi
    done
    echo >> $RESULTS_FILE
    
  fi # delivery is "e0"

  #------------------------------------------------------------------------

  echo "Checking core structure..."
  cd $PROJDIR
  rm *.in *.import

  # check for core lib
  if [ ! -d $PRJCORE ]; then
    echo "!! $PRJCORE does not exist." >> $RESULTS_FILE
    echo >> $RESULTS_FILE
    echo
    exit
  else
    echo "-- $PRJCORE is present." >> $RESULTS_FILE
  fi

  cd $PRJCORE
  if [ ! -f [Mm]akefile ]; then
    echo "!! $PRJCORE makefile does not exist." >> $RESULTS_FILE
    echo >> $RESULTS_FILE
    echo
    exit
  else
    echo "-- $PRJCORE makefile is present." >> $RESULTS_FILE
  fi

  for i in $(cat $BASE_DIR/files-list-core.txt); do
    if [ ! -f $i ]; then
      echo "!! $PRJCORE/$i does not exist." >> $RESULTS_FILE
      echo >> $RESULTS_FILE
      echo
      exit
    else
      echo "-- $PRJCORE/$i is present." >> $RESULTS_FILE
    fi
  done
  
  make clean
  (make JAVADIR=$JAVADIR 2>&1 | sed -e 's/</\&lt;/g' -e 's/>/\&gt;/g' -e 's#FIXME#<font color="red">FIXME</font>#g' -e 's#uses unchecked or unsafe operations#<font color="red">uses unchecked or unsafe operations</font>#g' -e 's#package ist.po.ui does not exist#<font color="red">package ist.po.ui does not exist (cannot be used in the core project)</font>#g' -e 's#no source files#<font color="red">no source files (core is empty)</font>#g' -e 's#unmappable character for encoding UTF-8#<font color="red">unmappable character for encoding UTF-8 (ensure correct encoding: check your editor settings)</font>#g' ) # trying 'make'

  if [ ! -f $PRJCORE.jar ]; then
    echo "!! default makefile rule did not produce '$PRJCORE.jar'." >> $RESULTS_FILE
    echo >> $RESULTS_FILE
    echo
    [ "$DELIVERY" != "e0" ] && exit
  else
    echo "-- generated '$PRJCORE.jar'."  >> $RESULTS_FILE
  fi

  echo >> $RESULTS_FILE
  
  #------------------------------------------------------------------------

  echo "Checking manager interface structure..."
  cd $PROJDIR

  # check for lib
  if [ ! -d $PRJAPP ]; then
    echo "!! $PRJAPP does not exist." >> $RESULTS_FILE
    echo >> $RESULTS_FILE
    echo
    exit
  else
    echo "-- $PRJAPP is present." >> $RESULTS_FILE
  fi

  cd $PRJAPP
  if [ ! -f [Mm]akefile ]; then
    echo "!! $PRJAPP makefile does not exist." >> $RESULTS_FILE
    echo >> $RESULTS_FILE
    echo
    exit
  else
    echo "-- $PRJAPP makefile is present." >> $RESULTS_FILE
  fi

  for i in $(cat $BASE_DIR/files-list-app.txt); do
    if [ ! -f $i ]; then
      echo "!! $PRJAPP/$i does not exist." >> $RESULTS_FILE
      echo >> $RESULTS_FILE
      echo
      exit
    else
      echo "-- $PRJAPP/$i is present." >> $RESULTS_FILE
    fi
  done

  make clean
  (make JAVADIR=$JAVADIR 2>&1 | sed -e 's/</\&lt;/g' -e 's/>/\&gt;/g' -e 's#FIXME#<font color="red">FIXME</font>#g' -e 's#uses unchecked or unsafe operations#<font color="red">uses unchecked or unsafe operations</font>#g' -e 's#unmappable character for encoding UTF-8#<font color="red">unmappable character for encoding UTF-8 (ensure correct encoding: check your editor settings)</font>#g' ) # trying 'make'

  if [ ! -f $PRJAPP.jar ]; then
    echo "!! default makefile rule did not produce '$PRJAPP.jar'." >> $RESULTS_FILE
    echo >> $RESULTS_FILE
    echo
    [ "$DELIVERY" != "e0" ] && exit
  else
    echo "-- generated '$PRJAPP.jar'."  >> $RESULTS_FILE
  fi

  echo >> $RESULTS_FILE
  if [ "$DELIVERY" = "e0" ]; then
    echo "-- analysis complete" >> $RESULTS_FILE
  else
    echo "-- successfully completed build" >> $RESULTS_FILE
  fi
  echo >> $RESULTS_FILE

  #------------------------------------------------------------------------

  cd $BASE_DIR # just to be more generic
}

###########################################################################
#
function copy_tests() {
  #\cp $TESTS_DIR/import $PROJDIR
  \cp $TESTS_DIR/*.in $PROJDIR
  \cp $TESTS_DIR/*.import $PROJDIR
}

###########################################################################
#
# $1 - a group number in the form NNN
# $2 - a source file to be tested
#
###########################################################################
function test_prog() {
  local DELIVERY=$1
  local GROUP=$2
  local TEST_FILE=$3:t
  local TEST_NAME=$TEST_FILE:r
  local TEST_IMPORT=$TEST_NAME.import
  local TEST_IN=$TEST_NAME.in
  local TEST_OUT=$TEST_NAME.out
  local TEST_HYP=$LOGS_DIR/$GROUP_$TEST_OUT

  # test characteristics
  local TEST_CLASS=$(echo "$TEST_NAME" | cut -d- -f 1)  # which test class it belongs
  local TEST_POINTS=$(echo "$TEST_NAME" | cut -d- -f 2) # value of this test
  local TEST_IDX=$(echo "$TEST_NAME" | cut -d- -f 3)    # index
  local TEST_SNAME=$(echo "$TEST_NAME" | cut -d- -f 4)  # short name
  local TEST_TYPE=$(echo "$TEST_NAME" | cut -d- -f 5)   # ok or err


  echo "<font color='white' style='background: blue;'>---------------------------"$TEST_FILE"---------------------------</font>"

  [ "$DELIVERY" != "e0" ] && echo "" >> $RESULTS_FILE

  PRETTY_PRINT=$TEST_NAME
  while [ ${#PRETTY_PRINT} -lt 30 ]; do
    PRETTY_PRINT=`echo $PRETTY_PRINT"."`
  done
  [ "$DELIVERY" != "e0" ] && echo -n $PRETTY_PRINT >> $RESULTS_FILE
  
  # try to run
  if [ "$DELIVERY" != "e0" ]; then

    prlimit --pid=0 --cpu=10 --as=1G --fsize=10M

    if [ "$TEST_SNAME" = "M" -o "$TEST_SNAME" = "R" ]; then

      #------ run $M_MAINCLASS

      
      print_classpath=`echo $M_CLASSPATH | sed -e 's-/usr/share/java-$JAVADIR-g' -e "s!$PROJDIR!\\$PROJDIR!g"`
      print_logsdir=`echo $LOGS_DIR | sed -e "s!$LOGS_DIR!\\$LOGS!g"`
      echo "CLASSPATH=$print_classpath"
      if [ -f $TEST_IMPORT ]; then
        echo "Running: java -Dimport=$TEST_IMPORT -Din=$TEST_IN -Dout=$print_logsdir/$GROUP_$TEST_NAME.out $M_MAINCLASS"
        (ulimit -f $((1*2*1024)); ulimit -t 5; java -cp $M_CLASSPATH -Dimport=$TEST_IMPORT -Din=$TEST_IN -Dout=$TEST_HYP $M_MAINCLASS)
      else
        echo "Running: java -Din=$TEST_IN -Dout=$print_logsdir/$GROUP_$TEST_NAME.out $M_MAINCLASS"
        (ulimit -f $((1*2*1024)); ulimit -t 5; java -cp $M_CLASSPATH -Din=$TEST_IN -Dout=$TEST_HYP $M_MAINCLASS)
      fi
  
      if [ "$TEST_SNAME" = "R" ]; then
        cp edt.dat SAFE_s_o_n_e_t.d_a_t_SAFE
      fi
  
    else

      # test failed
      false
  
    fi
  
    if [ $? -ne 0 ]; then
      echo "execution failed"
      echo -n " !" >> $RESULTS_FILE
      #return
    else
      echo -n " o" >> $RESULTS_FILE # execution ok
    fi

  fi # not "e0"

  # check output
  if [ -f $TEST_HYP ]; then
  
    # compare the output ignoring new lines
    cat $TESTS_DIR/expected/$TEST_OUT | tr '\n' ' ' | tr '	' ' ' | sed -e 's/[ ][ ]*/ /g' > expected
    cat $TEST_HYP        | tr '\n' ' ' | tr '	' ' ' | sed -e 's/[ ][ ]*/ /g' > obtained

    # fully compare the output
    diff -iwc $TESTS_DIR/expected/$TEST_OUT $TEST_HYP | sed -e "s=$BASE_DIR/==g" -e 's=auto-tests/==g' | awk 'BEGIN {zone=1} /^\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/ { print "<font style=\"background: brown;\" color=\"white\">----- ZONE ", zone++, " ----</font>"; next } /^--- [0-9]/ { printf("<font color=\"brown\">%s</font>\n", $0); next } /^\*\*\* [0-9]/ { printf("<font color=\"brown\">%s</font>\n", $0); next } {print}'
    diff -iwub -B expected obtained > /dev/null
  
    if [ $? -ne 0 ]; then
      echo "<font color='brown'>output differs from expected</font>"
      echo -n " !" >> $RESULTS_FILE # diff not ok
      return
    else
      echo "<font color='green'>TEST PASSED!</font>"
      echo -n " o" >> $RESULTS_FILE # diff ok (no diffs)
    fi

    rm expected obtained

  else

    echo "<font color='brown'>program did not produce any output</font>"
    return

  fi

  rm -f $TEST_HYP

}


###########################################################################
###########################################################################
#
# MAIN starts here
#
###########################################################################
#
# SANITY CHECK: logs dir exists?
#
if [ ! -d $LOGS_DIR ]; then
  echo "Creating logs dir"
  mkdir $LOGS_DIR
fi

###########################################################################
#
# checking existence of group to test. 
# For now looking for the module in the configuration dir is enough.
#
if [ ! -d $PROJDIR ]; then
  echo "I know nothing about '$GROUP'. Cannot proceed."
  exit
fi

###########################################################################
#
# per group log file
#
/bin/rm -f $LOG_FILE
# per group results file
/bin/rm -f $LOGS_DIR/$GROUP* 2>/dev/null

# backup stdout
exec 6>&1
# replace stdout
exec > $LOG_FILE
# Send stderr to the same place
exec 2>&1

###########################################################################

echo -n "[20D[0K"$GROUP" starting" > /dev/fd/6

###########################################################################
#
# test compilation (make)
#

echo -n "[20D[0K"$GROUP" compiling" > /dev/fd/6
compile_project $GROUP

###########################################################################
#
# now, for each test file test the following:
# * compile  test.src => test.asm
# * assemble test.asm => test.o
# * link test.o + librts > test executable
# * run test executable
# * check output diff
#
copy_tests $GROUP
cd $PROJDIR

echo "##################      TEST RESULTS      ###################" >> $RESULTS_FILE
[ "$DELIVERY" != "e0" ] && echo >> $RESULTS_FILE
[ "$DELIVERY" != "e0" ] && echo "                               R D" >> $RESULTS_FILE
for i in $TESTS_DIR/*.in; do
  echo -n "[50D[0K"$GROUP" "testing $i:t:r" " >> /dev/fd/6
  test_prog $DELIVERY $GROUP $i
done
echo "" >> $RESULTS_FILE
cd $BASE_DIR # just to be more generic

###########################################################################
#
# Now parse the results!
#
echo  >> $RESULTS_FILE
echo "#####################     SUMMARY     #####################" >> $RESULTS_FILE
echo >> $RESULTS_FILE
echo  "Group: Points (Point/Test)">> $RESULTS_FILE

TEST_CLASSES_LIST=`find $TESTS_DIR -type f -name \*.in -exec basename {} \\; |  cut -d- -f1 | sort -u`

TEST_GROUPS=`echo $TEST_CLASSES_LIST | wc -w`
PER_GROUP_VALUE=$[$GROUP_RATE*1.0/$TEST_GROUPS]

#echo "Ha "$TEST_GROUPS" grupos de testes" >> /dev/tty
#echo "Cada grupo vale "$PER_GROUP_VALUE >> /dev/tty

at_least_one_test_ok=0
total_points=0.0
## without 'echo' the variable would be taken as a whole
for i in $(echo $TEST_CLASSES_LIST); do
  TESTS_IN_CLASS=`find $TESTS_DIR -type f -name $i-\[^-\]\*-\*.in -exec basename {} \\; |  wc -l`
  PER_TEST_VALUE=`echo "scale=50; $PER_GROUP_VALUE/$TESTS_IN_CLASS" | bc`

#  echo "There are "$TESTS_IN_CLASS" tests in class "$i >> /dev/tty
#  echo "Cada teste do grupo "$i" vale "$PER_TEST_VALUE >> /dev/tty

  tests_ok=`grep ^$i $RESULTS_FILE | grep ^$i\\- | fgrep "o o" | wc -l`
  if [ $tests_ok -ne 0 ]; then
    at_least_one_test_ok=1
  fi

  class_points=$[$tests_ok * $PER_TEST_VALUE]
  total_points=$[$total_points + $class_points]
  print_class_points=`print -f "%.4f" $class_points`
  print_per_test_value=`print -f "%.4f" $PER_TEST_VALUE`
  echo -n "$i: "$print_class_points >> $RESULTS_FILE
  echo " ("$print_per_test_value")" >> $RESULTS_FILE
done

total_points=$[100.0*$total_points/$TEST_GROUPS]

###########################################################################

if [ $at_least_one_test_ok -ne 0 ]; then
  echo "Total: "$total_points" (max. 100%)" >> $RESULTS_FILE
else
  echo "Total: 0" >> $RESULTS_FILE  
fi

echo >> $RESULTS_FILE

echo "[50D[0K"$GROUP" "$total_points" %" > /dev/fd/6

echo "</pre>"

exit

###########################################################################
####                          T H E     E N D                          ####
###########################################################################
