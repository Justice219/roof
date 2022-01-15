roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}
roof.server.data = roof.server.data or {}
roof.server.data.addons = roof.server.data.addons or {}
roof.server.data.settings = roof.server.data.settings or {}
roof.server.settings = roof.server.settings or {}
roof.server.errors = roof.server.errors or {}
roof.server.db = roof.server.db or {}

roof.server.db.create("roof_settings", {
    [1] = {
        name = "settings_tbl",
        type = "TEXT",
    }
})

function roof.server.settings.create(name, tbl)
    if roof.server.data.settings[name] then
        roof.server.errors.severe("Setting '" .. name .. "' already exists. This should not happen, but is not fatal.")
    return end

    roof.server.data.settings[name] = {
        var = name,
        desc = tbl.desc,
        value = tbl.default,
        category = tbl.category,

    }    
    roof.server.errors.change("Setting '" .. name .. "' created.")
end

function roof.server.settings.createInternal(name, tbl)
    -- This function should only be called if you are making a setting with a panel or console, etc
    -- This function saves the setting to a db file, and then creates the setting in the settings table

    local val = roof.server.db.loadAll("roof_settings", "settings_tbl")
    if val then
        val = util.JSONToTable(val)
        if val[name] then
            roof.server.errors.severe("Setting '" .. name .. "' already exists. This should not happen, but is not fatal.")
        return end

        val[name] = {
            var = name,
            desc = tbl.desc,
            value = tbl.default,
            category = tbl.category,
        }

        roof.server.settings.create(val[name].var, val[name])
        val = util.TableToJSON(val)
        roof.server.db.updateAll("roof_settings", "settings_tbl", val)
    else
        local tbl = {}
        tbl[name] = {
            var = name,
            desc = tbl.desc,
            value = tbl.default,
            category = tbl.category,
        }
        roof.server.settings.create(tbl[name].var, tbl[name])
        val = util.TableToJSON(tbl)
        roof.server.db.updateAll("roof_settings", "settings_tbl", val)
    end
    roof.server.errors.change("Setting '" .. name .. "' created INTERNALLY!")
end

function roof.server.settings.loadInternal()
    roof.server.errors.normal("Loading internal settings...")
    local val = roof.server.db.loadAll("roof_settings", "settings_tbl")
    if val then
        val = util.JSONToTable(val)
        for k, v in pairs(val) do
            tbl = {
                default = v.value,
                desc = v.desc,
                category = v.category,
            }
            roof.server.settings.create(v.var, tbl)
        end
    end
end

function roof.server.db.removeInternal(setting)
    local data = roof.server.db.loadAll("roof_settings", "settings_tbl")
    if !data then 
        roof.server.errors.severe("Somehow this function was called even though there are no settings in the DB. Whatever the fuck your doing calm down!") 
    return end

    tbl = util.JSONToTable(data)
    for k,v in pairs(tbl) do
        if v.var == setting then
           print("match found")
           tbl[k] = nil
           if table.maxn == 0 then
                roof.server.db.updateAll("roof_settings", "settings_tbl", NULL)
           else
                roof.server.db.updateAll("roof_settings", "settings_tbl", util.TableToJSON(tbl))
                roof.server.errors.change("Removed setting: " .. setting) 
                roof.server.settings.remove(setting)
            end      
        end
    end
end

function roof.server.settings.remove(name)
    if not roof.server.data.settings[name] then
        roof.server.errors.severe("Setting '" .. name .. "' does not exist. This should not happen, but is not fatal.")
    return end

    roof.server.data.settings[name] = nil
    roof.server.errors.change("Setting '" .. name .. "' removed.")
end

function roof.server.settings.find(name)
    if not roof.server.data.settings[name] then
        roof.server.errors.severe("Setting '" .. name .. "' does not exist. This should not happen, but is not fatal.")
    return end

    return roof.server.data.settings[name]
end

function roof.server.settings.clear()
    roof.server.data.settings = {}
    roof.server.errors.severe("ALL SETTINGS REMOVED. THIS IS VERY DANGEROUS. THE BASE IS PROBABLY BROKEN. SORRY!")
end

function roof.server.settings.reload()
    roof.server.settings.load()
    roof.server.errors.change("Settings reloaded.")
end