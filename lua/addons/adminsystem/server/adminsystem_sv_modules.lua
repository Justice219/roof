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
adminsystem.server.data.modules = adminsystem.server.data.modules or {}
adminsystem.server.modules = adminsystem.server.modules or {}

function adminsystem.server.modules.create(name, tbl)
    if adminsystem.server.data.modules[name] then
        roof.server.errors.severe("Module " .. name .. " already exists!")
    return end

    adminsystem.server.data.modules[name] = {
        name = name,
        nick = tbl.name,
        description = tbl.description,
        usage = tbl.usage,
        permission = tbl.permission,
        args = tbl.args,
        run = tbl.run,

    }
    if tbl.args then
        adminsystem.server.data.modules[name].args = tbl.args
    end

    adminsystem.server.permissions.register(tbl.permission)
    roof.server.errors.change("Module " .. name .. " created!")
end

function adminsystem.server.modules.find(name)
    if !adminsystem.server.data.modules[name] then
        roof.server.errors.severe("Module " .. name .. " does not exist!")
    return end

    return adminsystem.server.data.modules[name]
end

function adminsystem.server.modules.clear()
    adminsystem.server.data.modules = {}
end

function adminsystem.server.modules.run(name, ply, args)
    if !adminsystem.server.data.modules[name] then
        roof.server.errors.severe("Module " .. name .. " does not exist!")
    return end

    if !args or args == nil then
        args = false
    end

    adminsystem.server.data.modules[name].run(ply, args)
end