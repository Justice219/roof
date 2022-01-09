roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}
roof.server.errors = roof.server.errors or {}

-- THIS CODE DEALS WITH STARTING THE ADDON, JUST
-- INCLUDE FILES LIKE YOU WOULD NORMALLY!
local function load()
    if SERVER then
        print("server")
        include("addons/roofconfig/server/roofconfig_sv_chat.lua")
        include("addons/roofconfig/server/roofconfig_sv_net.lua")
        
    end
end

-- THIS CODE DEALS WITH SHUTTING DOWN THE ADDON, JUST
-- INCLUDE THE METHOD YOU WOULD NORMALLY USE TO SHUTDOWN
local function disable()
    roof.server.errors.severe("RoofConfig is being disabled!")
end

-- DO NOT TOUCH THIS OR THE ADDON WILL NOT RUN!
return load, disable