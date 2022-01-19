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
adminsystem.server.data.permissions = adminsystem.server.data.permissions or {}
adminsystem.server.permissions = adminsystem.server.permissions or {}

function adminsystem.server.permissions.register(permission)
    if adminsystem.server.data.permissions[permission] then return false end
    adminsystem.server.data.permissions[permission] = true

    roof.server.errors.change("Permission registered: " .. permission)
end