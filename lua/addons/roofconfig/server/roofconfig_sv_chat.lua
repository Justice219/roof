roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}
roof.server.data = roof.server.data or {}
roof.server.data.addons = roof.server.data.addons or {}

hook.Add("PlayerSay", "RoofConfigCommands", function(ply, txt)
    if txt == "!roof_config" then
        ply.RoofConfigClient = ply.RoofConfigClient or false 
        if !ply.RoofConfigClient then
            roof.server.net.loadClientFiles(ply, {
                [1] = "addons/roofconfig/client/roofconfig_cl_net.lua",
                [2] = "addons/roofconfig/client/roofconfig_ui_menu.lua",
                [3] = "addons/roofconfig/client/roofconfig_ui_popup.lua",
            })
        end

        local tbl = {}
        for k,v in pairs(roof.server.data.addons) do
            tbl[k] = {
                name = v.name,
                description = v.description,
                author = v.author,
                version = v.version,
                enabled = v.enabled
            }
        end
        net.Start("RoofConfig:Net:SyncClient")
        net.WriteTable(tbl)
        net.WriteTable(roof.server.data.settings)
        net.Send(ply)
        print(" all ran")
    
        net.Start("RoofConfig:Net:Menus:Main")
        net.Send(ply)
        print(" all ran")
    end
end)