adminsystem = adminsystem or {}
adminsystem.client = adminsystem.client or {}
adminsystem.client.menus = adminsystem.client.menus or {}
adminsystem.client.menus.main = adminsystem.client.menus.main or {}
adminsystem.client.data = adminsystem.client.data or {}

function adminsystem.client.menus.main.open()
    local tabs = {}
    local data = {}
    local funcs = {}

    surface.CreateFont("RoofConfigMenuButton", {
        font = "Roboto",
        size = 30,
        weight = 500,
        antialias = true,
        shadow = false
    })
    surface.CreateFont("roofconfig_title", {
        font = "Roboto",
        size = 20,
        weight = 500,
        antialias = true
    })

    local panel = vgui.Create("DPanel")
    panel:TDLib()
    panel:SetSize(ScrW()/2, ScrH()/2)
    panel:Center()
    panel:MakePopup()
    panel:ClearPaint()
        :Background(Color(40, 41, 40), 6)
        :Text("Roof Admin Panel", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 400, -240)
        :Text("v1.0", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 5,250)
        :CircleHover(Color(59, 59, 59), 5, 20)

    local panel2 = panel:Add("DPanel")
    panel2:TDLib()
    panel2:SetPos(0, 60)
    panel2:SetSize(1920, 5)
    panel2:ClearPaint()
        :Background(Color(255, 255, 255), 0)

    local panel3 = panel:Add("DPanel")
    panel3:TDLib()
    panel3:SetPos(275, 60)
    panel3:SetSize(5, 1000)
    panel3:ClearPaint()
        :Background(Color(255, 255, 255), 0)


    local close = panel:Add("DImageButton")
    close:SetPos(925,10)
    close:SetSize(20,20)
    close:SetImage("icon16/cross.png")
    close.DoClick = function()
        panel:Remove()
    end

    local scroll = panel:Add("DScrollPanel")
    scroll:SetPos(17.5, 75)
    scroll:SetSize(240, 425)
    scroll:TDLib()
    scroll:ClearPaint()
        --:Background(Color(0, 26, 255), 6)
        :CircleHover(Color(59, 59, 59), 5, 20)

    local function ChangeTab(name)
        print("Changing Tab")
        for k,v in pairs(data) do
            table.RemoveByValue(data, v)
            v:Remove()
            print("Removed")
        end

        local tbl = tabs[name]
        tbl.change()

    end
    
    local function CreateTab(name, tbl)
        local scroll = scroll:Add( "DButton" )
        scroll:SetText( name)
        scroll:Dock( TOP )
        scroll:SetTall( 50 )
        scroll:DockMargin( 0, 5, 0, 5 )
        scroll:SetTextColor(Color(255,255,255))
        scroll:TDLib()
        scroll:SetFont("RoofConfigMenuButton")
        scroll:SetIcon(tbl.icon)
        scroll:ClearPaint()
            :Background(Color(59, 59, 59), 5)
            :BarHover(Color(255, 255, 255), 3)
            :CircleClick()
        scroll.DoClick = function()
            ChangeTab(name)
        end

        if tabs[name] then return end
        tabs[name] = tbl
    end

    CreateTab("Players", {
        icon = "icon16/user.png",
        change = function()
            local d = {}
            local p = nil
            players = panel:Add("DPanel")
            players:SetPos(290, 75)
            players:SetSize(660, 455)
            players:TDLib()
            players:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Player Management", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 230,-202.5)
            table.insert(d, #d, players)

            infop = players:Add("DPanel")
            infop:SetPos(225, 50)
            infop:SetSize(425,400)
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)

            scroll = players:Add("DScrollPanel")
            scroll:SetPos(10, 50)
            scroll:SetSize(200,400)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)

            local name = infop:Add("DLabel")
            name:SetPos(10, 10)
            name:SetSize(400, 20)
            name:SetText("Name: No User Selected")
            name:SetTextColor(Color(255,255,255))

            local steamid = infop:Add("DLabel")
            steamid:SetPos(10, 30)
            steamid:SetSize(400, 20)
            steamid:SetText("SteamID: No User Selected")
            steamid:SetTextColor(Color(255,255,255))

            local rank = infop:Add("DLabel")
            rank:SetPos(10, 50)
            rank:SetSize(400, 20)
            rank:SetText("Rank: No User Selected")
            rank:SetTextColor(Color(255,255,255))

            cr = players:Add("DButton")
            cr:SetText("Change Rank")
            cr:SetTextColor(Color(255,255,255))
            cr:SetPos(240, 410)
            cr:SetSize(150, 30)
            cr:TDLib()
            cr:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            cr.DoClick = function()
                if p == nil then return end
                local pop = vgui.Create("DFrame")
                pop:SetSize(500, 200)
                pop:Center()
                pop:SetTitle("Change: " .. p:Nick() .. "'s Rank")
                pop:MakePopup()
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)
                    :Text("Current Rank: " ..  adminsystem.client.data.clients[p:SteamID64()].group, "roofconfig_title", Color(255, 255, 255), TEXT_ALIGN_LEFT, 175,-50)

                local rank = pop:Add("DComboBox")
                rank:SetPos(175, 75)
                rank:SetSize(150, 20)
                rank:SetValue("Select A Rank")
                for k,v in pairs(adminsystem.client.data.groups) do
                    if v.name == adminsystem.client.data.clients[p:SteamID64()].group then continue end
                    rank:AddChoice(v.name)
                end

                create1 = pop:Add("DButton")
                create1:SetText("Finish")
                create1:SetTextColor(Color(255,255,255))
                create1:SetPos(175,140)
                create1:SetSize(150, 30)
                create1:TDLib()
                create1:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                create1.DoClick = function()
                    if rank:GetValue() == "Select A Rank" then return end
                    rank:SetText(rank:GetValue())

                    net.Start("AdminSystem:Net:UpdateRank")
                    net.WriteString(p:SteamID64())
                    net.WriteString(rank:GetValue())
                    net.SendToServer()

                    panel:Remove()
                    pop:Remove()
                end
            end
            
            
            for k,v in pairs(player.GetAll()) do
                --[[name = scroll:Add("DLabel")
                name:SetText(" Player: " .. v:Nick())
                name:SetTextColor(Color(255,255,255))
                name:Dock(TOP)
                name:DockMargin(5,0,5,0)
                name:SetTall(25)--]]

                local button = scroll:Add("DButton")
                button:SetText("Player: " .. v:Nick())
                button:Dock(TOP)
                button:SetTextColor(Color(255,255,255))
                button:DockMargin(5,5,5,5)
                button:SetTall(25)
                button:TDLib()
                button:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                button.DoClick = function()
                    name:SetText("Name: " .. v:Nick())
                    steamid:SetText("SteamID: " .. v:SteamID()) 
                    if IsValid(v) then
                        p = v
                    end
                    if adminsystem.client.data.clients[v:SteamID64()] then
                        rank:SetText("Rank: " .. adminsystem.client.data.clients[v:SteamID64()].group)
                    else
                        rank:SetText("Rank: Not a client")
                    end
                    
                    PrintTable(adminsystem.client.data)
                end

                
            
            end

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
        end
    })
    CreateTab("Groups", {
        icon = "icon16/group.png",
        change = function()
            local d = {}
            groups = panel:Add("DPanel")
            groups:SetPos(290, 75)
            groups:SetSize(660, 455)
            groups:TDLib()
            groups:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Group Management", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 230,-200)
            table.insert(d, #d, groups)

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("Config", {
        icon = "icon16/cog.png",
        change = function()
            local d = {}
            config = panel:Add("DPanel")
            config:SetPos(290, 75)
            config:SetSize(660, 455)
            config:TDLib()
            config:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Configuration", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 250,-200)
            table.insert(d, #d, config)

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
end