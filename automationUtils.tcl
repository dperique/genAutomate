# Author: F. Dennis Periquet Jan 15, 2017
# Some common utilities for networking automation.
#

# Just a log message with a date string attached.
#
proc log_msg {aLevel aMsg} {
  set systemTime [clock seconds]
  set dateStr [clock format $systemTime -format %H:%M:%S]
  puts " "
  puts "$dateStr $aLevel $aMsg"
}

# Check for presence of a pattern anywhere in a string.
#
proc isPresent {aStr aPattern} {
  if {[string match "*$aPattern*" $aStr]} {
    return 1
  } else {
    return 0
  }
}

# Sleep and put a log messages saying so.
#
proc doSleep {aSec} {
  log_msg INFO "Sleeping $aSec seconds ..."
  sleep $aSec

# Run ping and see if an IP address is reachable.
#
proc isReach {id anIPaddr} {
 exp_send -i $id "ping -c 3 -i .5 $anIPaddr\r"  
 expect -i $id "#"

 if {[isPresent $expect_out(buffer) " 0% packet loss"]} {
    log_msg INFO "Address $anIPaddr is reachable"
    return 1
  } else {
    log_msg INFO "Address $anIPaddr not reachable"
    return 0
  }
}

