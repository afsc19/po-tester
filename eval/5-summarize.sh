#!/bin/bash

error_exit() {
    echo "Error: $1" >&2
    echo "Usage: $0 DELIVERY" >&2
    echo "          DELIVERY is one of 'e0', 'ei', or 'ef'" >&2
    exit 1
}

[[ $# -ne 2 ]] && error_exit "argument expected"

# one of "e0", "ei", "ef"
DELIVERY=$1
LOGSDIR=logs/$DELIVERY

  GROUP=$2
  RESFILE=$LOGSDIR/$GROUP.res.html
  LOGFILE=$LOGSDIR/$GROUP.log.html

  RES=$(grep "Bad project" $RESFILE)
  if [ "$RES" != "" ]; then
    echo -n "* $GROUP [res]($RESFILE) [log]($LOGFILE) " >> GLOBAL-REPORT.md
    echo "❌ **NO DELIVERY**"                           >> GLOBAL-REPORT.md
  fi

  if [ "$DELIVERY" = "e0" ]; then

    RES=$(grep "!! uml" $RESFILE | awk -F/ '{print $2}' | awk -F: '{print $1}')
    if [ "$RES" != "" ]; then
      MISSING_FILES=$(grep -e "!! uml" $RESFILE | sed -e 's=!! uml/==g' | sed -e 's/ invalid or empty\.//g' | tr '\n' ' ' | sed -e 's/ *$//g' )
      echo -n "* $GROUP [res]($RESFILE) [log]($LOGFILE) " >> GLOBAL-REPORT.md
      if [[ $MISSING_FILES == *core* ]]; then
          echo "❌ **UML MISSING: $MISSING_FILES**" >> GLOBAL-REPORT.md
      else
          echo "⚠ **UML MISSING: $MISSING_FILES**" >> GLOBAL-REPORT.md
      fi
    fi
  
    RES=$(grep "generated" $RESFILE)
    if [ "$RES" != "" ]; then
      GENERATED_JAR1=$(grep "generated" $RESFILE | grep core | sed -e "s=^[^']*'==g" | sed -e "s/'.*$//g")
      GENERATED_JAR2=$(grep "generated" $RESFILE | grep app  | sed -e "s=^[^']*'==g" | sed -e "s/'.*$//g")
      echo -n "* $GROUP [res]($RESFILE) [log]($LOGFILE) " >> GLOBAL-REPORT.md
      echo "✅ **UML PRESENT. BUILD SUCCESSFUL.**"        >> GLOBAL-REPORT.md
    fi
  
  fi

  RES=$(grep "successfully" $RESFILE)
  if [ "$RES" != "" ]; then
    PC=$(grep Total $RESFILE | awk '{print $2}' | sed -e 's/\.\([0-9]\)\([0-9]\)[0-9]*/.\1\2/g')
    echo -n "* $GROUP [res]($RESFILE) [log]($LOGFILE) " >> GLOBAL-REPORT.md
    echo "✅ **SUCCESS: $PC%**"                         >> GLOBAL-REPORT.md
  fi

  # default
  echo -n "* $GROUP [res]($RESFILE) [log]($LOGFILE) "   >> GLOBAL-REPORT.md

  if [ "$DELIVERY" = "e0" ]; then
    echo "⚠ **UML PRESENT. BUILD FAILED.**"             >> GLOBAL-REPORT.md
  else
    echo "⚠ **BUILD FAILED.**"                          >> GLOBAL-REPORT.md
  fi

