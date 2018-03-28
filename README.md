# fibaro-hc2
LUA scripts for Fibaro HC2

Welcome to my GitHub page. Here are some of my LUA scenes and virtual devices used in Fibaro HC2.

In advance, I'm sorry for my poor English, I'm Norwegian...

If you have any questions, just ask (and I'l try to help you). If you have any tips, trics or requests please tell me!

I'm sharing theese freely because there was very few scenes that fitted me. 


OUTDOOR LIGHTNING TIMER

-- SCENE FUNCTION
-- This is a basic scene that turns outdoor lightning on 15 minutes before 
-- sunset and off 15 minutes after sunrise. 

-- GPS POSITION
-- For this scene to work you have to have set your GPS-position in HC2

-- CHANGELOG
-- 1.0 - Scene is brand new


PUSH ON DEVICE START AND STOP

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


SIMPLE LUA SCHEDULER WITH POWER CHECK

-- SCENE FUNCTION
-- This is a basic scene that turns device(s) on or off on a schedule. 
-- If CONTROL is "Off" then this scene is not active till CONTROL is "On"
-- When device turns on then STATUS variable changes to "On"
-- When device turns off then STATUS variable changes to "Off"
-- When device use more than powerlimit then STATUS variable changes to "Running"

-- CONTROL OPTION
-- I like to have the option to turn this timer on or off. 
-- The control global value helps me do that. 

-- STATUS OPTION
-- I like to know if device is ON / OFF or if it's using more watt than 
-- I have set in powerlimit to use in other scenes  or devices.

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


SIMPLE LUA SCHEDULER

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
