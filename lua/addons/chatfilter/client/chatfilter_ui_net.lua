chatfilter = chatfilter or {}
chatfilter.client = chatfilter.client or {}
chatfilter.client.menus = chatfilter.client.menus or {}
chatfilter.client.menus.main = chatfilter.client.menus.main or {}
chatfilter.client.data = chatfilter.client.data or {}

net.Receive("ChatFilter:Net:OpenMenu", function()
    chatfilter.client.data.blacklist = net.ReadTable()

    chatfilter.client.menus.main.open()
end)