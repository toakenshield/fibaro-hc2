--[[
%% autostart
%% properties
115 value
styringLadingStue
statusLadingStue
%% globals
--]]

-- SCENE FUNCTION
-- This is a basic scene that turns device(s) on or off on a schedule. 
-- If CONTROL is "Off" then this scene is not active till CONTROL is "On"
-- When device turns on then STATUS variable changes to "On"
-- When device turns off then STATUS variable changes to "Off"

-- CONTROL OPTION
-- I like to have the option to turn this timer on or off. 
-- The control global value helps me do that. 

-- STATUS OPTION
-- I like to know if device is turned ON / OFF by this scene.

-- CONTROL PANEL
-- I have a "Control Panel" device that tells me if CONTROL is active
-- and the STATUS of device. This can be found on my GITHUB page.

-- TIME NOTES
-- You can use up to 10 variables in timeoff and timeon (5 timeslots).
-- It works in pairs. {1,2,3,4} means between hour 1-2 and between hour 3-4.
-- Note: You cannot have time window over midnight (like 22-01).
-- You have to have 22-24 and 0-1 for that to work

-- CHANGELOG
-- 1.0 - Scene is brand new

-------------------- USER SETTINGS -----------------------
-- GLOBAL VARIABLES
-- You need to create two variables in order for this scene to work
-- CONTROL variable needs to have two settings, "On" and "Off" 
-- STATUS variable needs to have three settings, "On", "Off" and "Running"

pluggID = {115};			-- ID of device controlled
control = "styringLadingStue"	-- Name of your CONTROL variable
status = "statusLadingStue"		-- Name of your STATUS variable
timeoff = {8,14,21,24,0,6};	-- Time the device is turned off between. Here it is between 6 and 12 and between 15 and 18. 
timeoffnr = 6			-- Insert how many times you have in timeoff
timeon = {6,8,15,21};	-- Time the device is turned on between. Here it is between 18 and 20 and between 3 and 6. 
timeonnr = 4			-- Insert how many times you have in timeon
sleeptime = 60*1000 	-- Time untill next check (60*1000 = 1 minutte)
debug = true			-- Set true if you want debug, if not set false

--CHANGE IN HEADER (TOP OF SCRIPT)
-- For this scene to work you need to change these things in top of this scene
-- 1) Change number 115 to your device ID
-- 2) Change styringLadingStue to your control variable name
-- 3) Change statusLadingStue  to your status variable name
-----------------------------------------------------------



------------- DO NOT CHANGE LINES BELOW -------------------
startSource = fibaro:getSourceTrigger();

-- Give debug different colors
Debug = function ( color, message )
  fibaro:debug(string.format('<%s style="color:%s;">%s</%s>', "span", color, message, "span")); 
end

-- Kill new instance of this scene
if (fibaro:countScenes() > 1) then
  if debug == true then Debug( "red", "Abort, count scene = "..fibaro:countScenes()) end;
  fibaro:abort();
end

-- Scene triggered, funtion
SceneTriggered = function()
  if fibaro:getGlobalValue(control) == "On" then 					-- CONTROL -- 
    Timer()
  elseif fibaro:getGlobalValue(control) == "Off" then 				-- CONTROL -- 
    if debug == true then Debug( "red", "CONTROL is OFF, timer is deavtivated") end; 	-- CONTROL -- 
  end																-- CONTROL --   
end

-- Timer, function
Timer = function ()
  if debug == true then Debug( "green", "Checks if device should be turned on or off") end;
  local currentDate = os.date("*t");
  -- Checks if it should be turned off
  if tonumber(timeoffnr) >= 2 then 
    if ((currentDate.hour >= timeoff[1] and currentDate.hour < timeoff[2])) then
      turnOff()
    end
    
  end
  if tonumber(timeoffnr) >= 4 then 
    if ((currentDate.hour >= timeoff[3] and currentDate.hour < timeoff[4])) then
      turnOff()
    end
  end
  if tonumber(timeoffnr) >= 6 then 
    if ((currentDate.hour >= timeoff[5] and currentDate.hour < timeoff[6])) then
      turnOff()
    end
  end
  if tonumber(timeoffnr) >= 8 then 
    if ((currentDate.hour >= timeoff[7] and currentDate.hour < timeoff[8])) then
      turnOff()
    end
  end
  if tonumber(timeoffnr) >= 10 then
    if ((currentDate.hour >= timeoff[9] and currentDate.hour < timeoff[10])) then
      turnOff()
    end
  end
  
  -- Checks if it should be turned on
  if tonumber(timeonnr) >= 2 then 
    if ((currentDate.hour >= timeon[1] and currentDate.hour < timeon[2])) then
      turnOn()
    end
  end
  if tonumber(timeonnr) >= 4 then 
    if ((currentDate.hour >= timeon[3] and currentDate.hour < timeon[4])) then
      turnOn()
    end
  end
  if tonumber(timeonnr) >= 6 then 
    if ((currentDate.hour >= timeon[5] and currentDate.hour < timeon[6])) then
      turnOn()
    end
  end
  if tonumber(timeonnr) >= 8 then 
    if ((currentDate.hour >= timeon[7] and currentDate.hour < timeon[8])) then
      turnOn()
    end
  end
  if tonumber(timeonnr) >= 10 then
    if ((currentDate.hour >= timeoff[9] and currentDate.hour < timeoff[10])) then
      turnOn()
    end
  end
end
  
-- TurnOn, functions
turnOn = function()
  for i = 1,#pluggID do
    pluggID2 = pluggID[i];
    local status2 = fibaro:getValue(pluggID2, "value")
    if (status2 == "1") then
      -- Device is on, nothing to do...
    elseif (status2 == "0") then
      fibaro:call(pluggID2, "turnOn");
      fibaro:setGlobal(status, "On");
      if debug == true then Debug( "green", "Device turn on") end;
      credits();
    end
  end
end

-- TurnOff, functions
turnOff = function()
  for i = 1,#pluggID do
    pluggID2 = pluggID[i];
    local status2 = fibaro:getValue(pluggID2, "value")
    if (status2 == "0") then
      -- Device is off, nothing to do...
    elseif (status2 == "1") then
      fibaro:call(pluggID2, "turnOff");
      fibaro:setGlobal(status, "Off");
      if debug == true then Debug( "green", "Device turn off") end;
      credits();
    end
  end
end

-- Credits
credits = function()
  version = "1.0"
  Debug( "orange", "Simple LUA Scheduler - LUA Scripting by Tor Gaute Lien - 2018" );
  Debug( "orange", "Version: "..version);
end


------------------ START OF SCENE ----------------------
if ( startSource["type"] == "other" ) then
    SceneTriggered();
end

while true do
  SceneTriggered();
  fibaro:sleep(sleeptime);
end
