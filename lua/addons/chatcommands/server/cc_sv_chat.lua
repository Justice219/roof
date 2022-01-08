chatcommands = chatcommands or {}
chatcommands.server = chatcommands.server or {}
chatcommands.net = chatcommands.net or {}

local Commands = {
    ["!implode"] = function(ply, text, ...)
        print(...)
    end,
}

hook.Add("PlayerSay", "RoofChatCommands", function(ply, txt)

    local cmd = string.lower(args[1])
    table.remove(args, 1)

    local command = Commands[cmd]

    if command then
        command(ply, text)
    end
end)