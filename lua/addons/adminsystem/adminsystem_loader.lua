roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}

-- THIS CODE DEALS WITH STARTING THE ADDON, JUST
-- INCLUDE FILES LIKE YOU WOULD NORMALLY!
local function load()
    if SERVER then


        MsgC(Color(255, 0, 0), "[ROOF]", Color(255, 255, 255), " Admin System has loaded! \n")
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