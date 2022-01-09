roof = roof or {}
roof.server = roof.server or {}

if SERVER then
   msg1 = [[
                      _____ 
_______  ____   _____/ ____\
\_  __ \/  _ \ /  _ \   __\ 
 |  | \(  <_> |  <_> )  |   
 |__|   \____/ \____/|__|   

-     Version 1.0    -
- Created By Justice -

]]
msg2 = [[
- Roof is a TTT base for creating custom content seamlessly, and designed to be
better than MOAT and other open source TTT bases out there currently!

- This Version of the base is not compatible with MOAT! -
- This Version of the base is also not finished, and is very buggy! Be Careful! -

ROOF WILL NOW START ITS LOADING PROCESS!
   ]]
   MsgC(Color(255,0,0), msg1, Color(255,255,255), msg2, "\n")

   AddCSLuaFile("base/net/roof_cl_net.lua")

   include("base/net/roof_sv_net.lua")
   include("base/config/roof_main_config.lua")
   include("base/addons/roof_addon_tools.lua") 
   include("base/config/roof_addon_config.lua")
   include("base/player/roof_sv_player_auth.lua")
   include("base/debug/roof_sv_console.lua")
end

if CLIENT then
   include("base/net/roof_cl_net.lua")
end