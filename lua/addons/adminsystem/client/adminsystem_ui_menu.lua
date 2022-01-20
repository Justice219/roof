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
            local g = nil
            groups = panel:Add("DPanel")
            groups:SetPos(290, 75)
            groups:SetSize(660, 455)
            groups:TDLib()
            groups:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Group Management", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 230,-200)
            table.insert(d, #d, groups)

            infop = groups:Add("DPanel")
            infop:SetPos(225, 50)
            infop:SetSize(425,400)
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)

            scroll = groups:Add("DScrollPanel")
            scroll:SetPos(10, 50)
            scroll:SetSize(200,400)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)

            local name = infop:Add("DLabel")
            name:SetPos(10, 10)
            name:SetSize(400, 20)
            name:SetText("Name: No Group Selected")
            name:SetTextColor(Color(255,255,255))

            local perms = infop:Add("RichText")
            perms:SetPos(10, 30)
            perms:SetSize(400, 200)
            perms:SetText("Permissions: No Group Selected")

            local priority = infop:Add("DLabel")
            priority:SetPos(10, 250)
            priority:SetSize(400, 20)
            priority:SetText("Priority: No Group Selected")
            priority:SetTextColor(Color(255,255,255))

            create = groups:Add("DButton")
            create:SetText("Create Group")
            create:SetTextColor(Color(255,255,255))
            create:SetPos(240,375)
            create:SetSize(320, 30)
            create:TDLib()
            create:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            create.DoClick = function()
                local pop = vgui.Create("DFrame")
                pop:SetSize(500, 200)
                pop:Center()
                pop:SetTitle("Create Group")
                pop:MakePopup()
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local name = pop:Add("DTextEntry")
                name:SetPos(100, 75)
                name:SetSize(300, 20)
                name:SetText("Group Name")
                name.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local priority = pop:Add("DTextEntry")
                priority:SetPos(100, 100)
                priority:SetSize(300, 20)
                priority:SetText("1 (Must be a number value, higher = can control lower)")
                priority.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local create = pop:Add("DButton")
                create:SetText("Create")
                create:SetTextColor(Color(255,255,255))
                create:SetPos(100, 125)
                create:SetSize(300, 20)
                create:TDLib()
                create:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                create.DoClick = function()
                    local num = tonumber(priority:GetValue())
                    if !num then return end

                    net.Start("AdminSystem:Net:CreateGroup")
                    net.WriteString(name:GetValue())
                    net.WriteInt(num, 32)
                    net.SendToServer()

                    panel:Remove()
                    pop:Remove()
                end

            end

            remove = groups:Add("DButton")
            remove:SetText("Remove Rank")
            remove:SetTextColor(Color(255,255,255))
            remove:SetPos(240, 410)
            remove:SetSize(100, 30)
            remove:TDLib()
            remove:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            remove.DoClick = function()
                if !g then return end
                net.Start("AdminSystem:Net:RemoveRank")
                net.WriteString(g.name)
                net.SendToServer()
                panel:Remove()
            end

            edit = groups:Add("DButton")
            edit:SetText("Edit Rank")
            edit:SetTextColor(Color(255,255,255))
            edit:SetPos(350, 410)
            edit:SetSize(100, 30)
            edit:TDLib()
            edit:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            edit.DoClick = function()
                if !g then return end

                local pop = vgui.Create("DFrame")
                pop:SetSize(500, 200)
                pop:Center()
                pop:SetTitle("Edit Group")
                pop:MakePopup()
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)
                
                local name = pop:Add("DTextEntry")
                name:SetPos(100, 75)
                name:SetSize(300, 20)
                name:SetText(g.name)
                name.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local priority = pop:Add("DTextEntry")
                priority:SetPos(100, 100)
                priority:SetSize(300, 20)
                priority:SetText(g.priority)
                priority.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local create = pop:Add("DButton")
                create:SetText("Edit")
                create:SetTextColor(Color(255,255,255))
                create:SetPos(100, 125)
                create:SetSize(300, 20)
                create:TDLib()
                create:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                create.DoClick = function()
                    if name:GetValue() == "" then return end
                    if priority:GetValue() == "" then return end
                    local num = tonumber(priority:GetValue())
                    if !num then return end

                    net.Start("AdminSystem:Net:EditGroup")
                    net.WriteString(g.name)
                    net.WriteString(name:GetValue())
                    net.WriteInt(num, 32)
                    net.SendToServer()
                    panel:Remove()
                    pop:Remove()
                end
            end
            
            perm = groups:Add("DButton")
            perm:SetText("Edit Perms")
            perm:SetTextColor(Color(255,255,255))
            perm:SetPos(460, 410)
            perm:SetSize(100, 30)
            perm:TDLib()
            perm:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            perm.DoClick = function()
                if !g then return end
                local p = {}

                local pop = vgui.Create("DFrame")
                pop:SetSize(500, 200)
                pop:Center()
                pop:SetTitle("Edit Group")
                pop:MakePopup()
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local scroll2 = pop:Add("DScrollPanel")
                scroll2:SetPos(10, 30)
                scroll2:SetSize(200, 150)
                scroll2:TDLib()
                scroll2:ClearPaint()
                    :Background(Color(0,255,0), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local finish = pop:Add("DButton")
                finish:SetText("Finish")
                finish:SetTextColor(Color(255,255,255))
                finish:SetPos(225, 150)
                finish:SetSize(250, 20)
                finish:TDLib()
                finish:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                finish.DoClick = function()
                    net.Start("AdminSystem:Net:EditPerms")
                    net.WriteString(g.name)
                    net.WriteTable(p)
                    net.SendToServer()
                    panel:Remove()
                    pop:Remove()
                end


                for k,v in pairs(adminsystem.client.data.perms) do
                    local check = scroll2:Add("DCheckBoxLabel")
                    check:SetText(k)
                    check:SetTextColor(Color(255,255,255))
                    check:Dock(TOP)
                    check:DockMargin(5, 5, 5, 5)
                    if !g.permissions[k] then
                        check:SetValue(false)
                    else
                        check:SetValue(true)
                    end
                    check:SetTall(25)
                    check:TDLib()
                    check:ClearPaint()
                        :Background(Color(59,59,59), 6)
                    function check:OnChange(val)
                        if val then
                            p[k] = true
                        else
                            p[k] = false
                        end
                    end
                end
            end
            
            for k,v in pairs(adminsystem.client.data.groups) do
                local button = scroll:Add("DButton")
                button:SetText(v.name)
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
                    perms:SetText("")
                    perms:SetText("Permissions: \n")
                    name:SetText("Name: " .. v.name)
                    for k,v in pairs(v.permissions) do
                        perms:InsertColorChange(255,255,255,255)
                        perms:AppendText(k .. "\n")
                    end
                    if v.priority == 0 then
                        priority:SetText("Priority: " .. v.priority .. " (UNLIMITED PERMS)")
                    else
                        priority:SetText("Priority: " .. v.priority)
                    end
                    g = v
                end
            end

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
    CreateTab("Modules", {
        icon = "icon16/plugin.png",
        change = function()
            local d = {}
            local m = nil
            local p = nil
            local argd = {}
            modules = panel:Add("DPanel")
            modules:SetPos(290, 75)
            modules:SetSize(660, 455)
            modules:TDLib()
            modules:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Modules", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 275,-200)
            table.insert(d, #d, modules)

            scroll = modules:Add("DScrollPanel")
            scroll:SetPos(10, 50)
            scroll:SetSize(150,400)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)

            scroll2 = modules:Add("DScrollPanel")
            scroll2:SetPos(175, 50)
            scroll2:SetSize(150,400)
            scroll2:TDLib()
            scroll2:ClearPaint()
                :Background(Color(40,41,40), 6)
            
            infop = modules:Add("DPanel")
            infop:SetPos(340, 50)
            infop:SetSize(310,400)
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)
                --:Text("Information", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 0, -200)
            
            name = infop:Add("DLabel")
            name:SetPos(5, 5)
            name:SetSize(300, 20)
            name:SetText("Module Name: No Module Selected")
            name:SetTextColor(Color(255,255,255))
            name:SetFont("roofconfig_title")

            plyname = infop:Add("DLabel")
            plyname:SetPos(5, 25)
            plyname:SetSize(300, 20)
            plyname:SetText("Player Name: No Player Selected")
            plyname:SetTextColor(Color(255,255,255))
            plyname:SetFont("roofconfig_title")

            desc = infop:Add("RichText")
            desc:SetPos(5, 75)
            desc:SetSize(300, 200)
            desc:SetText("Description: No Module Selected")
            desc:TDLib()
            desc:ClearPaint()
                :Background(Color(40,41,40), 6)
                :Text("Description: ", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 0, -200)

            args = infop:Add("DButton")
            args:SetPos(5, 350)
            args:SetSize(300, 20)
            args:SetText("Modify Arguments")
            args:SetTextColor(Color(255,255,255))
            args:TDLib()
            args:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            args.DoClick = function()
                local pop = vgui.Create("DFrame")
                pop:SetSize(300, 200)
                pop:SetTitle("Modify Arguments")
                pop:Center()
                pop:MakePopup()
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :Text("Modify Arguments", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 0, -200)
                
                local scroll = pop:Add("DScrollPanel")
                scroll:SetPos(5, 50)
                scroll:SetSize(290, 150)
                scroll:TDLib()
                scroll:ClearPaint()
                    :Background(Color(14,204,14), 6)

                for k,v in pairs(m.args) do
                    if v.type == "string" then
                        entry = scroll:Add("DTextEntry")
                        entry:Dock(TOP)
                        entry:DockMargin(5,5,5,5)
                        entry:SetTall(25)
                        if argd[k] then
                            entry:SetText(argd[k])
                        else
                            entry:SetText(v.description)
                        end
                        entry:SetTextColor(Color(255,255,255))
                        entry:SetFont("roofconfig_title")
                        entry.Paint = function(self, w, h)
                            draw.RoundedBox( 6, 0, 0, w, h, Color(40,41,40) )
                            self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                        end
                        entry.OnValueChange = function(text)
                            argd[k] = entry:GetValue()
                        end
                    end
                end

            end
                
            run = infop:Add("DButton")
            run:SetPos(5, 375)
            run:SetSize(300, 20)
            run:SetText("Run Module")
            run:SetTextColor(Color(255,255,255))
            run:TDLib()
            run:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            run.DoClick = function()
                if !m then return end
                if !p then return end

                local tbl = {
                    name = m.name,
                    perm = m.permission,
                    ply = p,
                    args = argd
                }
                for k,v in pairs(m.args) do
                    if v.optional == true and !argd[k] then
                        Print("Argument "..k.." is not optional and not set.")    
                    return end
                end
                net.Start("AdminSystem:Net:RunModule")
                net.WriteTable(tbl)
                net.SendToServer()
            end
            

            for k,v in pairs(player.GetAll()) do
                local button = scroll:Add("DButton")
                button:SetText(v:Nick())
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
                    plyname:SetText("Player Name: " .. v:Nick())
                    p = v
                end
            end
            for k,v in pairs(adminsystem.client.data.modules) do
                local button = scroll2:Add("DButton")
                button:SetText(v.nick)
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
                    name:SetText("Module Name: " .. v.nick)
                    desc:SetText("Description: " .. v.description)
                    m = v
                    PrintTable(m)

                end
            end

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
end