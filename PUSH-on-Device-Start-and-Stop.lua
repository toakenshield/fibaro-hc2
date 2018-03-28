--[[
%% autostart
%% properties
68 power
68 value
statusOppvask
%% globals
--]]

-- SCENE FUNCTION
-- This is a basic scene that sends a PUSH notification when a device is 
-- using more than X watt and sends another when the device have been using less
-- than X watt for a period of time. 
-- Very usefull on dishwasher, washing machine +++

-- STATUS OPTION
-- You must have a global variable that tells you if the device is On, Off or Running
-- You may use this variable in other scenes or devices like my CONTROL PANEL

-- CONTROL PANEL
-- I have a "Control Panel" device that tells me the STATUS of this device. 
-- This can be found on my GITHUB page

-- TIME FUNCTIONS
-- Different appliances use different time to finish tasks.
-- Dishwashers use a lot of energy from the moment they start, but not so much in the end
-- Washing machines is the excact opposite
-- The values I use are theese:
-- Dishwashers - time1 = 80 time2 = 80
-- Waching machines - time1 = 160, time2 = 60

-- CHANGELOG
-- 1.0 - Scene is brand new

-------------------- USER SETTINGS -----------------------
-- GLOBAL VARIABLES
-- You need to create one variables in order for this scene to work
-- STATUS variable needs to have three settings, "On", "Off" and "Running"

pluggID = 68;	-- ID for device
phone = {6,32};	-- ID for phone. If more than one phone use , as seperator 6,32
time1 = 80;		-- Time that the device have to be active (+10 watts) before we announce that it's running
time2 = 80;		-- Time that the device have to be dormant (>10 watts) before we announce that it's not running
status = "statusOppvask";	-- Name of your STATUS variable
textstart = "Oppvaskmaskinen går. Flink!";	-- Text you want PUSHED when device have started
textstop = "Oppvaskmaskinen er ferdig";		-- Text you want PUSHED when device have stopped
sleeptime = 20*1000 	-- Time untill next check (20*1000 = 20 seconds)
debug = false			-- Set true if you want debug, if not set false

--CHANGE IN HEADER (TOP OF SCRIPT)
-- For this scene to work you need to change these things in top of this scene
-- 1) Change number 68 to your device ID (2 places)
-- 2) Change statusOppvask to your status variable name
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

-- Credits
credits = function()
  version = "1.0"
  if debug == true then Debug( "orange", "PUSH on Device Start and Stop - LUA Scripting by Tor Gaute Lien - 2018" ) end;
  if debug == true then Debug( "orange", "Version: "..version) end;
end

-- Scene triggered, funtion
SceneTriggered = function()
  local Wallplug = (tonumber(fibaro:getValue(pluggID, "value")) > 0 );	-- Check if plug is on
  if (Wallplug) 
    then 
    while true do
      if debug == true then Debug( "green", "Start scene") end;
      
      local tempDeviceState0, deviceLastModification0 = fibaro:get(pluggID, "power");
      if debug == true then Debug( "grey", 'Last change: ' .. deviceLastModification0) end;
      
      if debug == true then Debug( "grey", "Checking status of device...") end;
      if (( tonumber(fibaro:getValue(pluggID, "power")) < 10 ) and (os.time() - deviceLastModification0) >= time1) then
        if 
          ( fibaro:getGlobalValue(status) == "Running" )
          then if debug == true then Debug( "grey", "Device is still RUNNING...") end;
          
          Debug( "green", "Device is done!");
          for i = 1,#phone do
            phones = phone[i];
            fibaro:call(phones, "sendPush", textstop);
          end
          fibaro:setGlobal(status, "On");
          credits();
        end
      end
      
      if debug == true then Debug( "grey", "Checking if device is running...") end;
      if 
        ( fibaro:getGlobalValue(status) ~= "Running" )
        then if debug == true then Debug( "green", "Device is not RUNNING...") end;
        
        if (( tonumber(fibaro:getValue(pluggID, "power")) > 10 ) and (os.time() - deviceLastModification0) >= time2) then
          Debug( "green", "Device is running");
          for i = 1,#phone do
            phones = phone[i];
            fibaro:call(phones, "sendPush", textstart);
          end
          fibaro:setGlobal(status, "Running");
          credits();
        end
      end
      fibaro:sleep(sleeptime);
    end
  end
end

------------------ START OF SCENE ----------------------
if ( startSource["type"] == "other" ) then
    SceneTriggered();
end

while true do
  SceneTriggered();
  fibaro:sleep(sleeptime);
end