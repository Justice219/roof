chatfilter = chatfilter or {}
chatfilter.server = chatfilter.server or {}
chatfilter.server.data = chatfilter.server.data or {}
chatfilter.server.data.blacklist = chatfilter.server.data.blacklist or {}

hook.Add("PlayerSay", "ChatFilter", function(ply, txt)
    local str = string.Explode(" ", txt)
    for k,v in pairs(str) do
        
    end
end)