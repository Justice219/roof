chatcommands = chatcommands or {}
chatcommands.server = chatcommands.server or {}
chatcommands.net = chatcommands.net or {}
roof = roof or {}
roof.server = roof.server or {}
roof.server.player = roof.server.player or {}

local Commands = {
    ["!implode"] = function(ply, text, args, ...)
        if !roof.server.player.auth(ply) then return end
        for k,v in pairs(player.GetAll()) do
            if v:Nick() == args[1] then
                v:Kill()
            end
        end
    end,
}

hook.Add("PlayerSay", "RoofChatCommands", function(ply, txt)
    local args = string.Explode(" ", txt)
    local cmd = string.lower(args[1])
    table.remove(args, 1)

    local command = Commands[cmd]

    if command then
        command(ply, txt, args)
    end
end)