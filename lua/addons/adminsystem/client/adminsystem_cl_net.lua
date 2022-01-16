adminsystem = adminsystem or {}
adminsystem.client = adminsystem.client or {}
adminsystem.client.menus = adminsystem.client.menus or {}
adminsystem.client.menus.main = adminsystem.client.menus.main or {}
adminsystem.client.data = adminsystem.client.data or {}

net.Receive("AdminSystem:Net:Menus:Main", function(len, ply)
    adminsystem.client.menus.main.open()
end)
net.Receive("AdminSystem:Net:ClientSync", function(len, ply)
    local groups = net.ReadTable()
    local clients = net.ReadTable()

    adminsystem.client.data.groups = groups
    adminsystem.client.data.clients = clients

end)