roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}

-- THIS CODE DEALS WITH STARTING THE ADDON, JUST
-- INCLUDE FILES LIKE YOU WOULD NORMALLY!
local function load()
    if SERVER then
        include("addons/chatfilter/server/chatfilter_sv_blacklist.lua")
        include("addons/chatfilter/server/chatfilter_sv_chat.lua")
        include("addons/chatfilter/server/chatfilter_sv_net.lua")

        roof.server.errors.normal("Chat Filter Has Loaded!")
    end
end

-- THIS CODE DEALS WITH SHUTTING DOWN THE ADDON, JUST
-- INCLUDE THE METHOD YOU WOULD NORMALLY USE TO SHUTDOWN
local function disable()

end

-- DO NOT TOUCH THIS OR THE ADDON WILL NOT RUN!
return load, disable