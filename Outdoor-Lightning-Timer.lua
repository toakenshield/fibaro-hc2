--[[
%% autostart
%% properties
%% weather
189 value
%% events
%% globals
--]]

-- SCENE FUNCTION
-- This is a basic scene that turns outdoor lightning on 15 minutes before 
-- sunset and off 15 minutes after sunrise. 

-- GPS POSITION
-- For this scene to work you have to have set your GPS-position in HC2

-- CHANGELOG
-- 1.0 - Scene is brand new

-------------------- USER SETTINGS -----------------------
lights = {189};	-- Change to ID of your outdoor lightning. (ID1,ID2,ID3)
debug = true	-- Set true if you want debug, if not set false

--CHANGE IN HEADER (TOP OF SCRIPT)
-- For this scene to work you need to change these things in top of this scene
-- 1) Change number 189 to your LIGHT ID (and add "ID value" on other light IDs)
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
  if debug == true then Debug( "orange", "Outdoor Lightning Timer - LUA Scripting by Tor Gaute Lien - 2018" ) end;
  if debug == true then Debug( "orange", "Version: "..version) end;
end

-- Scene triggered, funtion
SceneTriggered = function()
    turnLightOn();
    startTimer();
end

-- TurnOn, functions
turnOn = function()
  for i = 1,#lights do
    lights2 = lights[i];
    local status2 = fibaro:getValue(lights2, "value")
    if (status2 == "1") then
      -- Device is on, nothing to do...
    elseif (status2 == "0") then
      fibaro:call(lights2, "turnOn");
      if debug == true then Debug( "green", "Device turn on") end;
      credits();
    end
  end
end

-- TurnOff, functions
turnOff = function()
  for i = 1,#lights do
    lights2 = lights[i];
    local status2 = fibaro:getValue(lights2, "value")
    if (status2 == "0") then
      -- Device is off, nothing to do...
    elseif (status2 == "1") then
      fibaro:call(lights2, "turnOff");
      if debug == true then Debug( "green", "Device turn off") end;
      credits();
    end
  end
end

-- tempFunc function
function tempFunc()
  local currentDate = os.date("*t");
  if (
      ( (os.date("%H:%M", os.time()+15*60) == fibaro:getValue(1, "sunsetHour")) )
    )
    then
    turnOn();
  end
  
  if (
      ( (os.date("%H:%M", os.time()-15*60) == fibaro:getValue(1, "sunriseHour")) ) 
    )
    then
    turnOff();
  end
    
  setTimeout(tempFunc, 60*1000)
end


------------------ START OF SCENE ----------------------
if (startSource["type"] == "autostart" or "other") then
  tempFunc()  
end
