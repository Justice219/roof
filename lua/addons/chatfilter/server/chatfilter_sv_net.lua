chatfilter = chatfilter or {}
chatfilter.server = chatfilter.server or {}
chatfilter.server.blacklist = chatfilter.server.blacklist or {}

adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.permissions = adminsystem.server.permissions or {}
adminsystem.server.groups = adminsystem.servergroups or {}
adminsystem.server.auth = adminsystem.server.auth or {}

util.AddNetworkString("ChatFilter:Net:OpenMenu")
util.AddNetworkString("ChatFilter:Net:Blacklist:Add")
util.AddNetworkString("ChatFilter:Net:Blacklist:Remove")

net.Receive("ChatFilter:Net:Blacklist:Add", function(len, ply)
    if !adminsystem.server.auth.checkPriv(ply, "chatfilter_add") then return end
    local w = net.ReadString()

    chatfilter.server.blacklist.add(w)
end)
net.Receive("ChatFilter:Net:Blacklist:Remove", function(len, ply)
    if !adminsystem.server.auth.checkPriv(ply, "chatfilter_remove") then return end
    local w = net.ReadString()

    chatfilter.server.blacklist.remove(w)
end)