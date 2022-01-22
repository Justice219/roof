chatfilter = chatfilter or {}
chatfilter.client = chatfilter.client or {}
chatfilter.client.menus = chatfilter.client.menus or {}
chatfilter.client.menus.main = chatfilter.client.menus.main or {}

function chatfilter.client.menus.main.open()
    local tabs = {}
    local data = {}

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
        :Text("Roof Chat Filter", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 400, -240)
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

    CreateTab("Blacklist", {
        icon = "icon16/cross.png",
        change = function()
            local d = {}
            local w = nil
            blacklist = panel:Add("DPanel")
            blacklist:SetPos(290, 75)
            blacklist:SetSize(660, 455)
            blacklist:TDLib()
            blacklist:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Blacklist", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 250,-200)
            table.insert(d, #d, blacklist)

            scroll = blacklist:Add("DScrollPanel")
            scroll:SetPos(17.5, 50)
            scroll:SetSize(310, 400)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)
                :CircleHover(Color(59, 59, 59), 5, 20)

            infop = blacklist:Add("DPanel")
            infop:SetPos(340, 50)
            infop:SetSize(310,400)
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)

            selected = infop:Add("DLabel")
            selected:SetPos(10, -175)
            selected:SetSize(310,400)
            selected:SetFont("roofconfig_title")
            selected:SetText("Selected Word:")
        
            remove = infop:Add("DButton")
            remove:SetPos(5,350)
            remove:SetSize(300, 20)
            remove:SetText("Remove")
            remove:SetTextColor(Color(255,255,255))
            remove:TDLib()
            remove:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            remove.DoClick = function()
                if !w or w == "" then return end

                net.Start("ChatFilter:Net:Blacklist:Remove")
                net.WriteString(w)
                net.SendToServer()

                panel:Remove()
            end

            add = infop:Add("DButton")
            add:SetPos(5, 375)
            add:SetSize(300, 20)
            add:SetText("Add Word")
            add:SetTextColor(Color(255,255,255))
            add:TDLib()
            add:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            add.DoClick = function()
                pop = vgui.Create("DFrame")
                pop:SetSize(300, 100)
                pop:Center()
                pop:MakePopup()
                pop:SetTitle("Add Word")
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local text = pop:Add("DTextEntry")
                text:SetPos(5, 30)
                text:SetSize(290, 20)
                text:SetText("")
                text:SetTextColor(Color(255,255,255))
                text:TDLib()
                text.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                done = pop:Add("DButton")
                done:SetPos(5, 60)
                done:SetSize(290, 20)
                done:SetText("Done")
                done:SetTextColor(Color(255,255,255))
                done:TDLib()
                done:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                done.DoClick = function()
                    if text:GetValue() == "" then return end

                    net.Start("ChatFilter:Net:Blacklist:Add")
                    net.WriteString(text:GetValue())
                    net.SendToServer()

                    panel:Remove()
                    pop:Remove()
                end

            end

            for k,v in pairs(chatfilter.client.data.blacklist) do
                word = scroll:Add("DButton")
                word:SetText(k)
                word:Dock( TOP )
                word:SetTall( 50 )
                word:DockMargin( 5, 5, 5, 5 )
                word:SetTextColor(Color(255,255,255))
                word:TDLib()
                word:SetFont("RoofConfigMenuButton")
                word:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                word.DoClick = function()
                    selected:SetText("Selected Word: " .. k)
                    w = k
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

    ChangeTab("Blacklist")
end