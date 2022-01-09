roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}

-- THIS CODE DEALS WITH STARTING THE ADDON, JUST
-- INCLUDE FILES LIKE YOU WOULD NORMALLY!
local function load()
    if SERVER then
        print("server")
        include("addons/roofconfig/server/roofconfig_sv_chat.lua")
        include("addons/roofconfig/server/roofconfig_sv_net.lua")
        
        hook.Add("PlayerButtonDown", "RoofConfigSpawn",function(ply)
            ply.RoofConfigClientLoaded = ply.RoofConfigClientLoaded or false
            if !ply.RoofConfigClientLoaded then
                roof.server.net.loadClientFiles({
                    [1] = "addons/roofconfig/client/roofconfig_cl_net.lua",
                    [2] = "addons/roofconfig/client/roofconfig_ui_menu.lua"
                })
            end
        end)
    end
end

-- THIS CODE DEALS WITH SHUTTING DOWN THE ADDON, JUST
-- INCLUDE THE METHOD YOU WOULD NORMALLY USE TO SHUTDOWN
local function disable()

end

-- DO NOT TOUCH THIS OR THE ADDON WILL NOT RUN!
return load, disable