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

function adminsystem.server.groups.create(name, priority)
    if !adminsystem.enabled then return end
    if adminsystem.server.data.groups[name] then
        roof.server.errors.severe("The group  "..name.." already exists! please choose another name!")
    return end

    local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
    if val then
        tbl = util.JSONToTable(val)
        tbl[name] = {
            name = name,
            permissions = {},
            priority = priority,
        }

        roof.server.db.updateAll("adminsystem_groups", "groups_tbl", util.TableToJSON(tbl))
        adminsystem.server.data.groups[name] = tbl[name]
        roof.server.errors.change("The group "..name.." has been created!")
    else
        tbl = {}
        tbl[name] = {
            name = name,
            permissions = {},
            priority = priority,
        }

        roof.server.db.updateAll("adminsystem_groups", "groups_tbl", util.TableToJSON(tbl))
        adminsystem.server.data.groups[name] = tbl[name]
        roof.server.errors.change("The group "..name.." has been created!")
    end
end

function adminsystem.server.groups.edit(name, newname, priority)
    if !adminsystem.enabled then return end
    if !adminsystem.server.data.groups[name] then
        roof.server.errors.severe("The group "..name.." does not exist!")
    return end

    local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
    if val then
        tbl = util.JSONToTable(val)
        temp = tbl[name]

        -- lets clear the table
        tbl[name] = nil
        tbl[newname] = {
            name = newname,
            permissions = temp.permissions,
            priority = priority,
        }

        adminsystem.server.data.groups[name] = nil
        adminsystem.server.data.groups[newname] = tbl[newname]

        roof.server.db.updateAll("adminsystem_groups", "groups_tbl", util.TableToJSON(tbl))
        roof.server.errors.change("The group "..name.." has been edited!")
    else
        roof.server.errors.severe("The group "..name.." does not exist!")
    end
end

function adminsystem.server.groups.remove(name)
    if !adminsystem.enabled then return end
    if not adminsystem.server.data.groups[name] then
        roof.server.errors.severe("The group  "..name.." does not exist! please choose another name!")
    return end
    if name == "Superadmin" then
        print(name)
        roof.server.errors.severe("You cannot remove the group "..name.."!")
    return end
    if name == "User" then
        roof.server.errors.severe("You cannot remove the group "..name.."!")
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
    if !adminsystem.enabled then return end
    roof.server.errors.severe("Loading groups...")
    -- We always need a user table to store the users data
     -- WE also always need a superadmin table to store the superadmins data
    adminsystem.server.permissions.register("adminsystem.groups.create")
    adminsystem.server.permissions.register("adminsystem.groups.edit")
    adminsystem.server.permissions.register("adminsystem.groups.remove")
    adminsystem.server.permissions.register("adminsystem.groups.perms")
    adminsystem.server.permissions.register("adminsystem.player.group.update")

    roof.server.errors.change("The group  User has been loaded!")
    local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
    if val then
        tbl = util.JSONToTable(val)
        for k,v in pairs(tbl) do
            local n = v.name
            adminsystem.server.data.groups[v.name] = v
            for k,v in pairs(v.permissions) do
                if !adminsystem.server.data.permissions[k] then
                    roof.server.errors.change("Group "..n.." has a permission that does not exist! "..k.." has been removed!")
                    adminsystem.server.data.groups[n].permissions[k] = nil
                end
            end
            if adminsystem.server.data.groups[v.name].priority == nil then
                adminsystem.server.data.groups[v.name].priority = 0
            end
            roof.server.errors.change("The group  "..v.name.." has been loaded!")
        end
    end

    if !adminsystem.server.data.groups["Superadmin"] then

        adminsystem.server.data.groups["Superadmin"] = {
            name = "Superadmin",
                permissions = {},
                priority = 0,  
            }
        roof.server.errors.change("The group  Superadmin has been loaded!")
    end
    if !adminsystem.server.data.groups["User"] then

        adminsystem.server.data.groups["User"] = {
            name = "User",
            permissions = {},
            priority = 1,   
        }
    end
end

function adminsystem.server.groups.find(name)
    if !adminsystem.enabled then return end
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

function adminsystem.server.groups.addPerm(name, perm)
    if !adminsystem.enabled then return end
    if not adminsystem.server.data.groups[name] then
        roof.server.errors.severe("The group  "..name.." does not exist! please choose another name!")
    return end
    if name == "Superadmin" or "User" then
        local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
        if !val then return end
        tbl = util.JSONToTable(val)
        tbl[name] = {
            name = name,
            permissions = adminsystem.server.data.groups[name].permissions,
            priority = adminsystem.server.data.groups[name].priority,
        }
        tbl[name].permissions[perm] = true
        roof.server.db.updateAll("adminsystem_groups", "groups_tbl", util.TableToJSON(tbl))
        adminsystem.server.data.groups[name] = tbl[name]
        roof.server.errors.change("The group  "..name.." has been edited!")

        roof.server.errors.severe("This group was created by the system, it has been overridden!")
    return end

    local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
    if val then
        tbl = util.JSONToTable(val)
        tbl[name].permissions[perm] = true
        roof.server.db.updateAll("adminsystem_groups", "groups_tbl", util.TableToJSON(tbl))
        adminsystem.server.data.groups[name] = tbl[name]
        roof.server.errors.change("The permission "..perm.." has been added to the group "..name.."!")
    end
end
function adminsystem.server.groups.removePerm(name, perm)
    if !adminsystem.enabled then return end
    if not adminsystem.server.data.groups[name] then
        roof.server.errors.severe("The group  "..name.." does not exist! please choose another name!")
    return end
    if name == "Superadmin" or "User" then
        local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
        if !val then return end
        tbl = util.JSONToTable(val)
        tbl[name] = {
            name = name,
            permissions = adminsystem.server.data.groups[name].permissions,
            priority = adminsystem.server.data.groups[name].priority,
        }
        tbl[name].permissions[perm] = nil
        roof.server.db.updateAll("adminsystem_groups", "groups_tbl", util.TableToJSON(tbl))
        adminsystem.server.data.groups[name] = tbl[name]
        roof.server.errors.change("The permission "..perm.." has been removed from the group "..name.."!")
    return end

    local val = roof.server.db.loadAll("adminsystem_groups", "groups_tbl")
    if val then
        tbl = util.JSONToTable(val)
        tbl[name].permissions[perm] = nil
        roof.server.db.updateAll("adminsystem_groups", "groups_tbl", util.TableToJSON(tbl))
        adminsystem.server.data.groups[name] = tbl[name]
        roof.server.errors.change("The permission "..perm.." has been removed from the group "..name.."!")
    end
end

function adminsystem.server.groups.clear()
    if !adminsystem.enabled then return end
    adminsystem.server.data.groups = {}
end

adminsystem.server.groups.load()