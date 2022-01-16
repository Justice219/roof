adminsystem = adminsystem or {}
adminsystem.client = adminsystem.client or {}
adminsystem.client.menus = adminsystem.client.menus or {}
adminsystem.client.menus.main = adminsystem.client.menus.main or {}

net.Receive("AdminSystem:Net:Menus:Main", function(len, ply)
    PrintTable(adminsystem)
end)