roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}

-- THIS CODE DEALS WITH STARTING THE ADDON, JUST
-- INCLUDE FILES LIKE YOU WOULD NORMALLY!
local function load()
    chatcommands = chatcommands or {}
    if SERVER then
        include("addons/chatcommands/server/cc_sv_chat.lua")

        MsgC(Color(255, 0, 0), "[ROOF]", Color(255, 255, 255), " Chat Commands Have Loaded! \n")
    end
    if CLIENT then
        
    end
end

-- THIS CODE DEALS WITH SHUTTING DOWN THE ADDON, JUST
-- INCLUDE THE METHOD YOU WOULD NORMALLY USE TO SHUTDOWN
local function disable()

end

-- DO NOT TOUCH THIS OR THE ADDON WILL NOT RUN!
return load, disable