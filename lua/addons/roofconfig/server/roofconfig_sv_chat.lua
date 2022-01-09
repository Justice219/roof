roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}

hook.Add("PlayerSay", "RoofConfigCommands", function(ply, txt)
    if txt == "!roof_config" then
        ply.RoofConfigClient = ply.RoofConfigClient or false 
        if !ply.RoofConfigClient then
            roof.server.net.loadClientFiles(ply, {
                [1] = "addons/roofconfig/client/roofconfig_cl_net.lua",
                [2] = "addons/roofconfig/client/roofconfig_ui_menu.lua"
            })
            net.Start("RoofConfig:Net:Menus:Main")
            net.Send(ply)
        else
            net.Start("RoofConfig:Net:Menus:Main")
            net.Send(ply)
        end
    end
end)