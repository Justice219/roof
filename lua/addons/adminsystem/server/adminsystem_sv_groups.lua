roof = roof or {}
roof.server = roof.server or {}
roof.server.db = roof.server.db or {}
roof.server.errors = roof.server.errors or {}

adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.net = adminsystem.server.net or {}
adminsystem.server.chat = adminsystem.server.chat or {}
adminsystem.server.data = adminsystem.server.data or {}
adminsystem.server.groups = adminsystem.server.groups or {}
adminsystem.server.data.groups = adminsystem.server.data.groups or {}


--[[
  ___                            _              _   
 |_ _|_ __ ___  _ __   ___  _ __| |_ __ _ _ __ | |_ 
  | || '_ ` _ \| '_ \ / _ \| '__| __/ _` | '_ \| __|
  | || | | | | | |_) | (_) | |  | || (_| | | | | |_ 
 |___|_| |_| |_| .__/ \___/|_|   \__\__,_|_| |_|\__|
               |_|                                  
DO NOT TRY TO ACCESS A PLAYERS GROUP ON THE CLIENT WITHOUT PROPER
NETWORKING OTHERWISE IT WILL NOT WORK! 

PLEASE ACCESS DATA ONLY ON THE SERVERSIDE

]]--

roof.server.db.create("adminsystem_groups", {
    [1] = {
        name = "groups_tbl",
        type = "TEXT",
    },
})

function adminsystem.server.groups.create(name)
    if adminsystem.server.data.groups[name] then
        roof.server.errors.severe("The group  "..name.." already exists! please choose another name!")
    return end

    local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
    if val then
        tbl = util.JSONToTable(val)
        tbl[name] = {
            name = name,
            permissions = {},
        }

        roof.server.db.updateAll("adminsystem_groups", "groups_tbl", util.TableToJSON(tbl))
        adminsystem.server.data.groups[name] = tbl[name]
        roof.server.errors.change("The group "..name.." has been created!")
    else
        tbl = {}
        tbl[name] = {
            name = name,
            permissions = {},
        }

        roof.server.db.updateAll("adminsystem_groups", "groups_tbl", util.TableToJSON(tbl))
        adminsystem.server.data.groups[name] = tbl[name]
        roof.server.errors.change("The group "..name.." has been created!")
    end
end

function adminsystem.server.groups.remove(name)
    if not adminsystem.server.data.groups[name] then
        roof.server.errors.severe("The group  "..name.." does not exist! please choose another name!")
    return end

    local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
    if val then
        tbl = util.JSONToTable(val)
        tbl[name] = nil
        roof.server.db.updateAll("adminsystem_groups", "groups_tbl", util.TableToJSON(tbl))
        adminsystem.server.data.groups[name] = nil
        roof.server.errors.change("The group  "..name.." has been removed!")
    end

end

function adminsystem.server.groups.load()
    roof.server.errors.severe("Loading groups...")
    -- We always need a user table to store the users data
     -- WE also always need a superadmin table to store the superadmins data
    adminsystem.server.data.groups["Superadmin"] = {
    name = "Superadmin",
        permissions = {}   
    }
    roof.server.errors.change("The group  Superadmin has been loaded!")
    adminsystem.server.data.groups["User"] = {
        name = "User",
        permissions = {}   
    }
    roof.server.errors.change("The group  User has been loaded!")
    local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
    if val then
        tbl = util.JSONToTable(val)
        for k,v in pairs(tbl) do
            adminsystem.server.data.groups[v.name] = v
            roof.server.errors.change("The group  "..v.name.." has been loaded!")
        end
    end
end

function adminsystem.server.groups.find(name)
    local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
    if val then
        tbl = util.JSONToTable(val)
        if !tbl[name] then
            if !adminsystem.server.data.groups[name] then
                return false
            else
                return adminsystem.server.data.groups[name]
            end
        else
            return tbl[name]
        end
    end
end

function adminsystem.server.groups.clear()
    adminsystem.server.data.groups = {}
end

adminsystem.server.groups.load()