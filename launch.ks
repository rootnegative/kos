//launch.ks
//This is a simple program to launch a rocket into a set orbit.

//Setup known ship config.
sas off
rcs on
lights off
lock throttle to 0
gear off

clearscreen.

//not sure if this is a good idea to explicitly declare variables.
declare targetapoapsis      //the target apoapsis for the flight
declare targetperiapsis     //the target periapsis for the flight
declare throttlevalue       //modification of throttle power
declare scriptphase         //variable for controlling where the program is up to in the launch.

//set initial conditions
set targetapoapsis to 100000
set targetperiapsis to 100000
set scriptphase to "Initializing"
set Boosters to 0

//Throttle Control
      //Ensure speed doesn't exceed terminal velocity
      //Include throttle modification to fine tune apoapsis.
      
//pseudocode for what i want to do. need to code properly      
If Velocity > TerminalVelocity
      Set throttlevalue to throttlevalue - 0.1
      Lock throttle to throttlevalue
      
If throttlevalue = 1 and timetoapo is increasing
      set throttlevalue to throttlevalue - 0.1 //need to ensure throttle value can't be less than 0.
      
If throttlevalue < 1 and timetoapo is decreasing
      set throttlevalue to throttlevalue + 0.1 //need to ensure throttle value can't be more than 1.

      
//Stage Control.
If Stage:LiquidFuel < 0.001
  lock throttle to 0
  wait 1
  stage
  print "Staging"
  wait 1
  lock throttle to throttlevalue

//need to figure out how to make sure this is checked once at the start of the script and never again.
If Vessel:SolidFuel > 1                 //Work out if we have boosters
  set boosters to 1                     //We have boosters.
  print "Boosters Detected"

IF vessel:solidfuel < 0.01
    set boosters to 0                   //we don't have or no longer have boosters
    print "no boosters detected"

If boosters = 1 and Stage:Solidfuel < 0.01 //we have boosters and they're empty
  wait 1
  stage
  print "Booster Separation"
  wait 1
  If stage:solidfuel > 1                    //figure out if there are any other solid rockets
  print "Moar boosterz detected"
  Set Boosters to 1                         //continue to check for empty solid rockets
ELSE
  set boosters to 0                         //stop checking for empty solid rockets
  
  
//Script Phases

//Ready for Launch

  //Vertical Ascent
Until Altitude > 8000
  lock steering to heading(90,90)
  lock throttle to throttlevalue
  
  If altitude > 100                     //need to make sure this triggers only once.
      print vessel:name + "has cleared the tower"
      print "initiating roll program"
  
    //Set rotation to be a negative g turn
  
  //Gravity Turn
  
//pseudocode
  if timetoapo is increasing
  
  
  
  //kk4tee's gravity turn code
  // set targetPitch to max( 5, 90 * (1 - ALT:RADAR / 50000)). 
  //          //Pitch over gradually until levelling out to 5 degrees at 50km
  //  lock steering to heading ( 90, targetPitch). //Heading 90' (East), then target pitch

  //Circularization


  //Completion

//Display of Data

print "Script Phase:" + scriptphase + "    " at (5,4)
print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,6).
print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "      " at (5,7).
print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,8).
