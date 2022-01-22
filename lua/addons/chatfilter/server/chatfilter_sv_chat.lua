chatfilter = chatfilter or {}
chatfilter.server = chatfilter.server or {}
chatfilter.server.data = chatfilter.server.data or {}
chatfilter.server.data.blacklist = chatfilter.server.data.blacklist or {}
chatfilter.server.blacklist = chatfilter.server.blacklist or {}

hook.Add("PlayerSay", "ChatFilterCommands", function(ply, txt)
    if txt == "!filter" then
        roof.server.errors.debug("Admin system has been enabled for " .. ply:Nick())
        roof.server.net.loadClientFiles(ply, {
            [1] = "addons/chatfilter/client/chatfilter_ui_net.lua",
            [2] = "addons/chatfilter/client/chatfilter_ui_main.lua",
        })

        net.Start("ChatFilter:Net:OpenMenu")
        net.WriteTable(chatfilter.server.data.blacklist)
        net.Send(ply)
    end
end)
hook.Add("PlayerSay", "ChatFilter", function(ply, txt)
    local str = string.Explode(" ", txt)
    for k,v in pairs(str) do
        if chatfilter.server.blacklist.exists(v) then
            PrintMessage(HUD_PRINTTALK, ply:Nick() .. ": " .. "You can't say that dude!")
            return ""
        end
    end
end)