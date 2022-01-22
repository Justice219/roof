roof = roof or {}
roof.server = roof.server or {}
roof.server.errors = roof.server.errors or {}

adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.permissions = adminsystem.server.permissions or {}
adminsystem.server.groups = adminsystem.servergroups or {}

chatfilter = chatfilter or {}
chatfilter.server = chatfilter.server or {}
chatfilter.server.blacklist = chatfilter.server.blacklist or {}

chatfilter.server.data = chatfilter.server.data or {}
chatfilter.server.data.blacklist = chatfilter.server.data.blacklist or {}

adminsystem.server.permissions.register("chatfilter.add")
adminsystem.server.permissions.register("chatfilter.remove")
roof.server.db.create("chatfilter_blacklist", {
    [1] = {
        name = "blacklist_tbl",
        type = "TEXT",
    }
})


function chatfilter.server.blacklist.add(word)
    if chatfilter.server.data.blacklist[word] then
        roof.server.errors.severe("Word: " .. word .. " already exists in the blacklist.")
    return end

    local val = roof.server.db.loadAll("chatfilter_blacklist", "blacklist_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl[word] = true
        
        chatfilter.server.data.blacklist[word] = true
        roof.server.db.updateAll("chatfilter_blacklist", "blacklist_tbl", util.TableToJSON(tbl))
    else
        local tbl = {}
        tbl[word] = true

        roof.server.db.updateAll("chatfilter_blacklist", "blacklist_tbl", util.TableToJSON(tbl))
    end
end

function chatfilter.server.blacklist.remove(word)
    if not chatfilter.server.data.blacklist[word] then
        roof.server.errors.severe("Word: " .. word .. " does not exist in the blacklist.")
    return end

    local val = roof.server.db.loadAll("chatfilter_blacklist", "blacklist_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl[word] = nil

        chatfilter.server.data.blacklist[word] = nil
        roof.server.db.updateAll("chatfilter_blacklist", "blacklist_tbl", util.TableToJSON(tbl))
    end
end

function chatfilter.server.blacklist.load()
    local val = roof.server.db.loadAll("chatfilter_blacklist", "blacklist_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        for k, v in pairs(tbl) do
            chatfilter.server.data.blacklist[k] = true
        end
    end
end

function chatfilter.server.blacklist.exists(word)
    for k,v in pairs(chatfilter.server.data.blacklist) do
        if k == word then
            return true
        end
    end
end

chatfilter.server.blacklist.load()