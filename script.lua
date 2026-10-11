local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local ACCENT = Color3.fromRGB(139, 92, 246)
local ACCENT2 = Color3.fromRGB(236, 72, 153)
local TEXT = Color3.fromRGB(240, 240, 250)
local MUTED = Color3.fromRGB(170, 172, 200)
local RED = Color3.fromRGB(220, 70, 90)
local GOOD = Color3.fromRGB(52, 199, 120)

local LANG
do
    local selGui = Instance.new("ScreenGui")
    selGui.Name = "VitaHubDoorsLang"
    selGui.ResetOnSpawn = false
    selGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local okP = pcall(function() selGui.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
    if not okP or not selGui.Parent then selGui.Parent = player:WaitForChild("PlayerGui") end

    local function round(obj, r)
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, r)
        c.Parent = obj
    end

    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0, 360, 0, 200)
    panel.Position = UDim2.new(0.5, -180, 0.5, -100)
    panel.BackgroundColor3 = Color3.new(1, 1, 1)
    panel.BackgroundTransparency = 0.22
    panel.BorderSizePixel = 0
    panel.Parent = selGui
    round(panel, 20)

    local pg = Instance.new("UIGradient")
    pg.Color = ColorSequence.new(Color3.fromRGB(76, 64, 148), Color3.fromRGB(16, 18, 38))
    pg.Rotation = 55
    pg.Parent = panel

    local ps = Instance.new("UIStroke")
    ps.Color = Color3.new(1, 1, 1)
    ps.Thickness = 1.6
    ps.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ps.Parent = panel

    local psg = Instance.new("UIGradient")
    psg.Rotation = 45
    psg.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.5, 0.88),
        NumberSequenceKeypoint.new(1, 0.2),
    })
    psg.Parent = ps

    local title = Instance.new("TextLabel")
    title.Position = UDim2.new(0, 0, 0, 22)
    title.Size = UDim2.new(1, 0, 0, 36)
    title.BackgroundTransparency = 1
    title.Text = "VitaHub  Doors"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 28
    title.Parent = panel
    local tg = Instance.new("UIGradient")
    tg.Color = ColorSequence.new(ACCENT, ACCENT2)
    tg.Rotation = 20
    tg.Parent = title

    local sub = Instance.new("TextLabel")
    sub.Position = UDim2.new(0, 0, 0, 64)
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.BackgroundTransparency = 1
    sub.Text = "Выбери язык  /  Choose your language"
    sub.TextColor3 = MUTED
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 14
    sub.Parent = panel

    local function langButton(text, x, code)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 150, 0, 54)
        b.Position = UDim2.new(0, x, 0, 112)
        b.Text = text
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 18
        b.AutoButtonColor = false
        b.BackgroundColor3 = Color3.new(1, 1, 1)
        b.BackgroundTransparency = 0.88
        b.BorderSizePixel = 0
        b.Parent = panel
        round(b, 14)

        local st = Instance.new("UIStroke")
        st.Color = Color3.new(1, 1, 1)
        st.Transparency = 0.7
        st.Thickness = 1
        st.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        st.Parent = b

        b.MouseEnter:Connect(function()
            b.BackgroundColor3 = ACCENT
            b.BackgroundTransparency = 0.25
        end)
        b.MouseLeave:Connect(function()
            b.BackgroundColor3 = Color3.new(1, 1, 1)
            b.BackgroundTransparency = 0.88
        end)
        b.Activated:Connect(function() LANG = code end)
    end

    langButton("Русский", 20, "ru")
    langButton("English", 190, "en")

    while not LANG do
        if not selGui.Parent then LANG = "en" break end
        task.wait(0.1)
    end
    pcall(function() selGui:Destroy() end)
end

local I18N = {
    ru = {
        room_label = "Комната : ",
        entity_label = "Последняя сущность : ",
        sec_esp = "ПОДСВЕТКА",
        tg_esp_doors = "ESP Двери",
        tg_esp_items = "ESP Предметы и ключи",
        tg_esp_gold = "ESP Золото",
        tg_esp_ent = "ESP Сущности",
        tg_esp_hide = "ESP Укрытия",
        tg_esp_levers = "ESP Рычаги",
        tg_esp_chests = "ESP Сундуки",
        tg_esp_books = "ESP Книги (Фигура)",
        tg_esp_fake = "ESP Фейк-комнаты (Дюп)",
        lbl_lever = "Рычаг",
        lbl_chest = "Сундук",
        lbl_book = "Книга",
        lbl_fake = "Фейк-дверь",
        sec_world = "МИР",
        tg_fullbright = "Fullbright",
        tg_nofog = "Без тумана",
        sec_speed = "СКОРОСТЬ",
        tg_speed = "Ускорение",
        sec_auto = "АВТО",
        tg_loot = "Авто-подбор",
        tg_instant = "Мгновенное взаимодействие",
        tg_alert = "Оповещение о сущностях",
        alert = "Появился %s! Прячься",
        ent_rush = "Раш",
        ent_ambush = "Амбуш",
        ent_eyes = "Глаза",
        ent_screech = "Скрич",
        ent_sally = "Салли",
        ent_seek = "Сик",
        ent_figure = "Фигура",
        ent_dread = "Дред",
        alert_rush = "Летит Раш! Прячься!",
        alert_ambush = "Летит Амбуш! Прячься!",
        alert_eyes = "Появились Глаза! Не смотри на них!",
        alert_screech = "Появился Скрич! Посмотри вокруг!",
        alert_sally = "Появилась Салли! Найди её любимую игрушку где-то в шкафчиках!",
        alert_seek = "В этой комнате появится Сик! Подготовься к побегу, удачи!",
        alert_figure = "Комната Фигуры! Найди книги, которые подсвечиваются!",
        alert_dread = "Появился Дред! Беги в следующую комнату!",
        no_prompt = "В твоём executor нет fireproximityprompt",
        hint = "RightShift -\nскрыть меню",
        killed = "VitaHub Doors остановлен, GUI удалён",
        tg_libcode = "Код библиотеки (Фигура)",
        tg_libopen = "Авто-открытие двери Фигуры",
        lib_code = "Код от библиотеки: %s",
        lib_entered = "Код введён: %s",
        seek_speed_off = "Сик! Спид-буст отключён",
        seek_speed_on = "Сик позади, спид-буст снова включён",
        loaded = "VitaHub Doors v1.0 загружен. RightShift - скрыть меню",
        status_idle = "Готов",
        status_loot = "Авто-подбор включён",
    },
    en = {
        room_label = "Room : ",
        entity_label = "Last entity : ",
        sec_esp = "ESP",
        tg_esp_doors = "ESP Doors",
        tg_esp_items = "ESP Items & Keys",
        tg_esp_gold = "ESP Gold",
        tg_esp_ent = "ESP Entities",
        tg_esp_hide = "ESP Hiding Spots",
        tg_esp_levers = "ESP Levers",
        tg_esp_chests = "ESP Chests",
        tg_esp_books = "ESP Books (Figure)",
        tg_esp_fake = "ESP Fake Rooms (Dupe)",
        lbl_lever = "Lever",
        lbl_chest = "Chest",
        lbl_book = "Book",
        lbl_fake = "Fake Door",
        sec_world = "WORLD",
        tg_fullbright = "Fullbright",
        tg_nofog = "No Fog",
        sec_speed = "SPEED",
        tg_speed = "Speed Boost",
        sec_auto = "AUTO",
        tg_loot = "Auto Loot",
        tg_instant = "Instant Interact",
        tg_alert = "Entity Alert",
        alert = "%s spawned! Take cover",
        ent_rush = "Rush",
        ent_ambush = "Ambush",
        ent_eyes = "Eyes",
        ent_screech = "Screech",
        ent_sally = "Sally",
        ent_seek = "Seek",
        ent_figure = "Figure",
        ent_dread = "Dread",
        alert_rush = "Rush is coming! Hide!",
        alert_ambush = "Ambush is coming! Hide!",
        alert_eyes = "Eyes spawned! Don't look at them!",
        alert_screech = "Screech spawned! Look around!",
        alert_sally = "Sally spawned! Find her favorite toy somewhere in the lockers!",
        alert_seek = "Seek will appear in this room! Get ready to run, good luck!",
        alert_figure = "Figure's room! Find the books that light up!",
        alert_dread = "Dread spawned! Run to the next room!",
        no_prompt = "Your executor has no fireproximityprompt",
        hint = "RightShift -\nhide menu",
        killed = "VitaHub Doors stopped, GUI removed",
        tg_libcode = "Library Code (Figure)",
        tg_libopen = "Auto Open Figure Door",
        lib_code = "Library code: %s",
        lib_entered = "Code entered: %s",
        seek_speed_off = "Seek! Speed boost off",
        seek_speed_on = "Seek is gone, speed boost back on",
        loaded = "VitaHub Doors v1.0 loaded. RightShift - hide menu",
        status_idle = "Ready",
        status_loot = "Auto Loot is on",
    },
}

local function T(key, ...)
    local pack = I18N[LANG] or I18N.ru
    local str = pack[key] or I18N.ru[key] or key
    if select("#", ...) > 0 then
        local ok, res = pcall(string.format, str, ...)
        return ok and res or str
    end
    return str
end

local alive = true
local connections = {}
local function track(c) table.insert(connections, c) return c end

local state = {
    espDoors = false,
    espItems = false,
    espGold = false,
    espEntities = false,
    espHide = false,
    espLevers = false,
    espChests = false,
    espBooks = false,
    espFake = false,
    libCode = false,
    libOpen = false,
    fullbright = false,
    noFog = false,
    speed = false,
    autoLoot = false,
    instant = false,
    alert = true,
}

local SPEEDS = {17, 18, 19, 20, 25, 30}
local speedIdx = 2
local boostSpeed = 16
local lastEntity = "-"
local statusText = T("status_idle")
local refreshGui = function() end

local function notify(text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "VitaHub", Text = text, Duration = 4,
        })
    end)
end

local function getRoot()
    local char = player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
    local char = player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

track(player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end))

local ESP = {}

local function anyPart(target)
    if target:IsA("BasePart") then return target end
    return target:FindFirstChildWhichIsA("BasePart", true)
end

local function addESP(cat, target, color, text, useHighlight)
    local bucket = ESP[cat]
    if not bucket then
        bucket = {}
        ESP[cat] = bucket
    end
    if bucket[target] or not target.Parent then return end

    local part = anyPart(target)
    if not part then return end

    local entry = {}

    if useHighlight then
        local hl = Instance.new("Highlight")
        hl.Adornee = target
        hl.FillColor = color
        hl.FillTransparency = 0.75
        hl.OutlineColor = color
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = target
        entry.hl = hl
    end

    local gui = Instance.new("BillboardGui")
    gui.Adornee = part
    gui.Size = UDim2.new(0, 140, 0, 26)
    gui.StudsOffset = Vector3.new(0, 2.5, 0)
    gui.AlwaysOnTop = true

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextStrokeTransparency = 0.3
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.Parent = gui
    gui.Parent = part
    entry.gui = gui

    bucket[target] = entry
end

local function dropEntry(entry)
    if entry.hl then pcall(function() entry.hl:Destroy() end) end
    if entry.gui then pcall(function() entry.gui:Destroy() end) end
end

local function clearCat(cat)
    local bucket = ESP[cat]
    if not bucket then return end
    for target, entry in pairs(bucket) do
        dropEntry(entry)
        bucket[target] = nil
    end
end

local function pruneAll()
    for _, bucket in pairs(ESP) do
        for target, entry in pairs(bucket) do
            if not target.Parent then
                dropEntry(entry)
                bucket[target] = nil
            end
        end
    end
end

local NICE = {
    KeyObtain = "Key", GoldPile = "Gold", LiveHintBook = "Book", LeverForGate = "Lever",
    LiveBreakerPolePickup = "Breaker", Lighter = "Lighter", Flashlight = "Flashlight",
    Lockpicks = "Lockpicks", Vitamins = "Vitamins", Bandage = "Bandage", Battery = "Battery",
    Candle = "Candle", Crucifix = "Crucifix", Smoothie = "Smoothie", Shakelight = "Shakelight",
}

local function niceName(name)
    return NICE[name] or name
end

local function entityLabel(name)
    local n = name:lower()
    if n:find("^rush") then return "Rush" end
    if n:find("^ambush") then return "Ambush" end
    if n:find("^seek") then return "Seek" end
    if n == "eyes" then return "Eyes" end
    if n == "halt" then return "Halt" end
    if n == "screech" then return "Screech" end
    if n:find("^figure") then return "Figure" end
    if n:find("^sally") then return "Sally" end
    if n:find("^dread") then return "Dread" end
    if n == "a60" then return "A-60" end
    if n == "a120" then return "A-120" end
    if n:find("^jeff") then return "Jeff" end
    return nil
end

local function isFakeDoor(model)
    local n = model.Name:lower()
    return n:find("fake", 1, true) ~= nil and n:find("door", 1, true) ~= nil
end

local function anyEspOn()
    return state.espDoors or state.espItems or state.espGold or state.espHide or state.espEntities
        or state.espLevers or state.espChests or state.espBooks or state.espFake
end

local function scanAll()
    local rooms = Workspace:FindFirstChild("CurrentRooms")

    if rooms then
        if state.espDoors then
            for _, room in ipairs(rooms:GetChildren()) do
                local door = room:FindFirstChild("Door")
                if door then
                    addESP("doors", door, GOOD, "Door " .. room.Name, true)
                end
            end
        end

        if anyEspOn() then
            for _, d in ipairs(rooms:GetDescendants()) do
                if d:IsA("ProximityPrompt") then
                    local nm = d.Name
                    local target = d:FindFirstAncestorOfClass("Model") or d.Parent
                    if target then
                        if nm == "ModulePrompt" and state.espItems then
                            addESP("items", target, Color3.fromRGB(255, 220, 90), niceName(target.Name), true)
                        elseif nm == "LootPrompt" and state.espGold then
                            addESP("gold", target, Color3.fromRGB(255, 200, 0), "Gold", false)
                        elseif nm == "HidePrompt" and state.espHide then
                            addESP("hide", target, Color3.fromRGB(120, 200, 255), "Hide", false)
                        end
                    end
                elseif d:IsA("Model") then
                    local n = d.Name
                    local low = n:lower()
                    if state.espBooks and n == "LiveHintBook" then
                        addESP("books", d, Color3.fromRGB(120, 255, 160), T("lbl_book"), true)
                    elseif state.espLevers and (n == "LeverForGate" or low:find("^lever")) then
                        addESP("levers", d, Color3.fromRGB(255, 150, 60), T("lbl_lever"), true)
                    elseif state.espChests and low:find("^chestbox") then
                        addESP("chests", d, Color3.fromRGB(255, 190, 70), T("lbl_chest"), true)
                    elseif state.espFake and isFakeDoor(d) then
                        addESP("fake", d, Color3.fromRGB(255, 80, 200), T("lbl_fake"), true)
                    elseif state.espEntities then
                        local lb = entityLabel(n)
                        if lb then addESP("entities", d, RED, lb, true) end
                    end
                end
            end
        end
    end

    if state.espEntities then
        for _, c in ipairs(Workspace:GetChildren()) do
            if c:IsA("Model") then
                local lb = entityLabel(c.Name)
                if lb then addESP("entities", c, RED, lb, true) end
            end
        end
    end

    pruneAll()
end

task.spawn(function()
    while alive do
        if anyEspOn() then
            pcall(scanAll)
        end
        task.wait(1)
    end
end)

local ENT_KEYS = {
    Rush = "ent_rush", Ambush = "ent_ambush", Eyes = "ent_eyes", Screech = "ent_screech",
    Sally = "ent_sally", Seek = "ent_seek", Figure = "ent_figure", Dread = "ent_dread",
}

local ALERT_KEYS = {
    Rush = "alert_rush", Ambush = "alert_ambush", Eyes = "alert_eyes", Screech = "alert_screech",
    Sally = "alert_sally", Seek = "alert_seek", Figure = "alert_figure", Dread = "alert_dread",
}

local function announce(label)
    lastEntity = ENT_KEYS[label] and T(ENT_KEYS[label]) or label
    if not state.alert then return end
    local key = ALERT_KEYS[label]
    if key then
        notify(T(key))
    else
        notify(T("alert", label))
    end
end

local seekModels = {}
local seekCount = 0
local seekSince = 0
local speedWasOn = false

local function seekStarted(c)
    if seekModels[c] then return end
    seekModels[c] = true
    seekCount = seekCount + 1
    if seekCount == 1 then
        seekSince = os.clock()
        speedWasOn = state.speed
        if state.speed then
            state.speed = false
            boostSpeed = 16
            local hum = getHumanoid()
            if hum then hum.WalkSpeed = 16 end
            refreshGui()
            notify(T("seek_speed_off"))
        end
    end
end

local function seekEnded(c)
    if not seekModels[c] then return end
    seekModels[c] = nil
    seekCount = math.max(0, seekCount - 1)
    if seekCount == 0 and speedWasOn then
        speedWasOn = false
        state.speed = true
        refreshGui()
        notify(T("seek_speed_on"))
    end
end

track(Workspace.ChildAdded:Connect(function(c)
    local lb = entityLabel(c.Name)
    if lb then
        announce(lb)
        if lb == "Seek" then seekStarted(c) end
    end
end))

track(Workspace.ChildRemoved:Connect(function(c)
    if seekModels[c] then seekEnded(c) end
end))

task.spawn(function()
    while alive do
        if seekCount > 0 and os.clock() - seekSince > 90 then
            for c in pairs(seekModels) do seekEnded(c) end
        end
        task.wait(5)
    end
end)

local lastFigureAlert = 0

local function hookRooms(rooms)
    track(rooms.ChildAdded:Connect(function(room)
        task.wait(1.5)
        if not room.Parent then return end

        local books = 0
        for _, d in ipairs(room:GetDescendants()) do
            if d:IsA("Model") and d.Name == "LiveHintBook" then
                books = books + 1
            end
        end

        if books >= 2 and os.clock() - lastFigureAlert > 30 then
            lastFigureAlert = os.clock()
            announce("Figure")
        end
    end))
end

local currentRooms = Workspace:FindFirstChild("CurrentRooms")
if currentRooms then
    hookRooms(currentRooms)
else
    track(Workspace.ChildAdded:Connect(function(c)
        if c.Name == "CurrentRooms" then hookRooms(c) end
    end))
end

local origLighting
local function saveLighting()
    if origLighting then return end
    origLighting = {
        Brightness = Lighting.Brightness,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        FogEnd = Lighting.FogEnd,
        FogStart = Lighting.FogStart,
    }
end

local function restoreLighting()
    if not origLighting then return end
    for k, v in pairs(origLighting) do
        pcall(function() Lighting[k] = v end)
    end
end

track(RunService.Heartbeat:Connect(function()
    if state.fullbright then
        saveLighting()
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    end
    if state.noFog then
        saveLighting()
        Lighting.FogEnd = 1e9
        Lighting.FogStart = 1e9
    end
end))

track(RunService.Heartbeat:Connect(function(dt)
    if not state.speed then return end
    local hum = getHumanoid()
    if not hum then return end

    local target = SPEEDS[speedIdx]
    if hum.MoveDirection.Magnitude > 0 then
        boostSpeed = math.min(target, boostSpeed + 5 * dt)
    else
        boostSpeed = math.max(16, boostSpeed - 20 * dt)
    end

    if boostSpeed > 16.05 then
        hum.WalkSpeed = boostSpeed + math.sin(os.clock() * 2.3) * 0.1
    end
end))

local lootWarned = false
task.spawn(function()
    while alive do
        local rooms = Workspace:FindFirstChild("CurrentRooms")

        if rooms and (state.autoLoot or state.instant) then
            if state.autoLoot and not fireproximityprompt and not lootWarned then
                lootWarned = true
                notify(T("no_prompt"))
            end

            local root = getRoot()
            for _, d in ipairs(rooms:GetDescendants()) do
                if d:IsA("ProximityPrompt") then
                    if state.instant then
                        d.HoldDuration = 0
                    end

                    if state.autoLoot and fireproximityprompt and root and d.Enabled
                        and (d.Name == "ModulePrompt" or d.Name == "LootPrompt") then
                        local holder = d.Parent
                        local pos
                        if holder and holder:IsA("BasePart") then
                            pos = holder.Position
                        elseif holder and holder:IsA("Attachment") then
                            pos = holder.WorldPosition
                        end
                        if pos and (pos - root.Position).Magnitude <= d.MaxActivationDistance + 1 then
                            pcall(fireproximityprompt, d)
                        end
                    end
                end
            end
        end

        task.wait(0.4)
    end
end)

local function readLibraryCode()
    local pg = player:FindFirstChild("PlayerGui")
    local perm = pg and pg:FindFirstChild("PermUI")
    local hints = perm and perm:FindFirstChild("Hints")
    if not hints then return nil end

    local paper = player.Character and player.Character:FindFirstChild("LibraryHintPaper")
    if not paper then paper = player.Backpack:FindFirstChild("LibraryHintPaper") end
    if not paper then return nil end

    local ui = paper:FindFirstChild("UI")
    if not ui then return nil end

    local digits, count = {}, 0
    for _, icon in ipairs(ui:GetChildren()) do
        local idx = tonumber(icon.Name)
        if icon:IsA("ImageLabel") and idx then
            count = count + 1
            digits[idx] = "_"
            for _, hint in ipairs(hints:GetChildren()) do
                if hint:IsA("ImageLabel") and hint.Visible and hint.ImageRectOffset == icon.ImageRectOffset then
                    local t = hint:FindFirstChild("TextLabel")
                    if t then digits[idx] = t.Text end
                end
            end
        end
    end

    if count == 0 then return nil end
    local out = {}
    for i = 1, count do out[i] = digits[i] or "_" end
    return table.concat(out)
end

local function isPadlockPrompt(prompt)
    local a = prompt.Parent
    while a and a ~= Workspace do
        if a.Name:lower():find("padlock", 1, true) then return true end
        a = a.Parent
    end
    return false
end

local openTries = {}

local function tryOpenPadlock(code)
    local rooms = Workspace:FindFirstChild("CurrentRooms")
    local root = getRoot()
    if not rooms or not root then return end

    for _, d in ipairs(rooms:GetDescendants()) do
        if d:IsA("ProximityPrompt") and d.Name == "UnlockPrompt" and d.Enabled and isPadlockPrompt(d) then
            local holder = d.Parent
            local pos
            if holder and holder:IsA("BasePart") then
                pos = holder.Position
            elseif holder and holder:IsA("Attachment") then
                pos = holder.WorldPosition
            end

            local tries = openTries[d] or 0
            if pos and tries < 5 and (pos - root.Position).Magnitude <= d.MaxActivationDistance + 3 then
                local remotes = ReplicatedStorage:FindFirstChild("RemotesFolder")
                local pl = remotes and remotes:FindFirstChild("PL")
                if pl then
                    openTries[d] = tries + 1
                    pcall(function() pl:FireServer(code) end)
                    if tries == 0 then notify(T("lib_entered", code)) end
                end
            end
        end
    end
end

local libCodeNotified = nil

task.spawn(function()
    while alive do
        if state.libCode or state.libOpen then
            local code = readLibraryCode()
            local complete = code ~= nil and code:match("^%d+$") ~= nil

            if state.libCode and complete and code ~= libCodeNotified then
                libCodeNotified = code
                print("[VitaHub] " .. code)
                notify(T("lib_code", code))
            end

            if state.libOpen and complete then
                pcall(tryOpenPadlock, code)
            end
        end
        task.wait(1)
    end
end)

local function setFlag(name, value)
    state[name] = value
    refreshGui()
end

local function toggle(name, onOff)
    setFlag(name, not state[name])
    if onOff then onOff(state[name]) end
end

local function toggleEspDoors() toggle("espDoors", function(on) if not on then clearCat("doors") end end) end
local function toggleEspItems() toggle("espItems", function(on) if not on then clearCat("items") end end) end
local function toggleEspGold() toggle("espGold", function(on) if not on then clearCat("gold") end end) end
local function toggleEspEnt() toggle("espEntities", function(on) if not on then clearCat("entities") end end) end
local function toggleEspHide() toggle("espHide", function(on) if not on then clearCat("hide") end end) end
local function toggleEspLevers() toggle("espLevers", function(on) if not on then clearCat("levers") end end) end
local function toggleEspChests() toggle("espChests", function(on) if not on then clearCat("chests") end end) end
local function toggleEspBooks() toggle("espBooks", function(on) if not on then clearCat("books") end end) end
local function toggleEspFake() toggle("espFake", function(on) if not on then clearCat("fake") end end) end
local function toggleFullbright() toggle("fullbright", function(on) if not on and not state.noFog then restoreLighting() end end) end
local function toggleNoFog() toggle("noFog", function(on) if not on and not state.fullbright then restoreLighting() end end) end
local function toggleSpeed()
    toggle("speed", function(on)
        if not on then
            boostSpeed = 16
            local hum = getHumanoid()
            if hum then hum.WalkSpeed = 16 end
        end
    end)
end
local function toggleLoot() toggle("autoLoot") end
local function toggleInstant() toggle("instant") end
local function toggleAlert() toggle("alert") end
local function toggleLibCode() toggle("libCode") end
local function toggleLibOpen() toggle("libOpen") end

local function setSpeedIdx(i)
    speedIdx = i
    refreshGui()
end

local function buildGui()
    local gui = Instance.new("ScreenGui")
    gui.Name = "VitaHubDoorsGui"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local okParent = pcall(function() gui.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
    if not okParent or not gui.Parent then gui.Parent = player:WaitForChild("PlayerGui") end

    local function corner(obj, r)
        local c = Instance.new("UICorner")
        c.CornerRadius = r or UDim.new(0, 10)
        c.Parent = obj
        return c
    end

    local function brandGradient(obj)
        local g = Instance.new("UIGradient")
        g.Color = ColorSequence.new(ACCENT, ACCENT2)
        g.Rotation = 20
        g.Parent = obj
        return g
    end

    local function glass(obj, transp, strokeT)
        obj.BackgroundColor3 = Color3.new(1, 1, 1)
        obj.BackgroundTransparency = transp or 0.9
        obj.BorderSizePixel = 0
        local s = Instance.new("UIStroke")
        s.Color = Color3.new(1, 1, 1)
        s.Transparency = strokeT or 0.8
        s.Thickness = 1
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        s.Parent = obj
        return s
    end

    local W, H = 560, 400

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, W, 0, H)
    main.Position = UDim2.new(0.5, -W / 2, 0.5, -H / 2)
    main.BackgroundColor3 = Color3.new(1, 1, 1)
    main.BackgroundTransparency = 0.22
    main.BorderSizePixel = 0
    main.Active = true
    main.Parent = gui
    corner(main, UDim.new(0, 20))

    local mainGrad = Instance.new("UIGradient")
    mainGrad.Color = ColorSequence.new(Color3.fromRGB(76, 64, 148), Color3.fromRGB(16, 18, 38))
    mainGrad.Rotation = 55
    mainGrad.Parent = main

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.new(1, 1, 1)
    mainStroke.Thickness = 1.6
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    mainStroke.Parent = main

    local strokeGrad = Instance.new("UIGradient")
    strokeGrad.Rotation = 45
    strokeGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.5, 0.88),
        NumberSequenceKeypoint.new(1, 0.2),
    })
    strokeGrad.Parent = mainStroke

    local sheen = Instance.new("Frame")
    sheen.Size = UDim2.new(1, 0, 0.42, 0)
    sheen.BackgroundColor3 = Color3.new(1, 1, 1)
    sheen.BorderSizePixel = 0
    sheen.Parent = main
    corner(sheen, UDim.new(0, 20))

    local sheenGrad = Instance.new("UIGradient")
    sheenGrad.Rotation = 90
    sheenGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.84),
        NumberSequenceKeypoint.new(1, 1),
    })
    sheenGrad.Parent = sheen

    local function makeDraggable(handle, target, onClick)
        local dragging, moved = false, false
        local dragStart, startPos

        track(handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging, moved = true, false
                dragStart, startPos = input.Position, target.Position
            end
        end))

        track(UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch) then
                local d = input.Position - dragStart
                if d.Magnitude > 6 then moved = true end
                if moved then
                    target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
                        startPos.Y.Scale, startPos.Y.Offset + d.Y)
                end
            end
        end))

        track(UIS.InputEnded:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch) then
                dragging = false
                if not moved and onClick then onClick() end
            end
        end))
    end

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 56)
    header.BackgroundTransparency = 1
    header.Parent = main

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Position = UDim2.new(0, 20, 0, 8)
    titleLbl.Size = UDim2.new(0, 220, 0, 28)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "VitaHub"
    titleLbl.TextColor3 = Color3.new(1, 1, 1)
    titleLbl.Font = Enum.Font.GothamBlack
    titleLbl.TextSize = 24
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = header
    brandGradient(titleLbl)

    local subLbl = Instance.new("TextLabel")
    subLbl.Position = UDim2.new(0, 20, 0, 36)
    subLbl.Size = UDim2.new(0, 220, 0, 14)
    subLbl.BackgroundTransparency = 1
    subLbl.Text = "DOORS  •  v1.0"
    subLbl.TextColor3 = MUTED
    subLbl.Font = Enum.Font.Gotham
    subLbl.TextSize = 12
    subLbl.TextXAlignment = Enum.TextXAlignment.Left
    subLbl.Parent = header

    makeDraggable(header, main)

    local function windowButton(text, x, tint, callback)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 28, 0, 28)
        b.Position = UDim2.new(1, x, 0, 14)
        b.Text = text
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 15
        b.AutoButtonColor = false
        b.Parent = header
        glass(b, 0.88, 0.7)
        if tint then
            b.BackgroundColor3 = tint
            b.BackgroundTransparency = 0.45
        end
        corner(b, UDim.new(1, 0))
        b.Activated:Connect(callback)
        return b
    end

    local function infoPill(x, w)
        local pill = Instance.new("Frame")
        pill.Position = UDim2.new(0, x, 0, 58)
        pill.Size = UDim2.new(0, w, 0, 26)
        pill.Parent = main
        glass(pill, 0.88, 0.72)
        corner(pill, UDim.new(0, 13))

        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, -20, 1, 0)
        l.Position = UDim2.new(0, 10, 0, 0)
        l.BackgroundTransparency = 1
        l.TextColor3 = TEXT
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 13
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.TextTruncate = Enum.TextTruncate.AtEnd
        l.Text = ""
        l.Parent = pill
        return l
    end

    local roomLabel = infoPill(16, 170)
    local entityLbl = infoPill(194, W - 194 - 16)

    local sidebar = Instance.new("Frame")
    sidebar.Position = UDim2.new(0, 14, 0, 98)
    sidebar.Size = UDim2.new(0, 128, 0, H - 98 - 14)
    sidebar.BackgroundTransparency = 1
    sidebar.Parent = main

    local updaters = {}
    local orders = {}
    local function nextOrder(p)
        orders[p] = (orders[p] or 0) + 1
        return orders[p]
    end

    local tabNames = {"Visuals", "Player", "Auto"}
    local pages, tabButtons = {}, {}
    local currentTab = "Visuals"

    for i, name in ipairs(tabNames) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 38)
        b.Position = UDim2.new(0, 0, 0, (i - 1) * 46)
        b.Text = name
        b.TextColor3 = TEXT
        b.Font = Enum.Font.GothamBold
        b.TextSize = 14
        b.AutoButtonColor = false
        b.Parent = sidebar
        glass(b, 0.9, 0.8)
        corner(b, UDim.new(0, 12))
        tabButtons[name] = b
    end

    local hint = Instance.new("TextLabel")
    hint.Position = UDim2.new(0, 0, 1, -34)
    hint.Size = UDim2.new(1, 0, 0, 32)
    hint.BackgroundTransparency = 1
    hint.Text = T("hint")
    hint.TextColor3 = MUTED
    hint.Font = Enum.Font.Gotham
    hint.TextSize = 11
    hint.TextXAlignment = Enum.TextXAlignment.Left
    hint.Parent = sidebar

    local CONTENT_X, CONTENT_Y = 152, 98
    local CONTENT_W = W - CONTENT_X - 14
    local CONTENT_H = H - CONTENT_Y - 14 - 34

    local function makePage(name)
        local sf = Instance.new("ScrollingFrame")
        sf.Name = name
        sf.Position = UDim2.new(0, CONTENT_X, 0, CONTENT_Y)
        sf.Size = UDim2.new(0, CONTENT_W, 0, CONTENT_H)
        sf.BackgroundTransparency = 1
        sf.BorderSizePixel = 0
        sf.ScrollBarThickness = 3
        sf.ScrollBarImageColor3 = ACCENT
        sf.CanvasSize = UDim2.new(0, 0, 0, 0)
        sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
        sf.Visible = false
        sf.Parent = main

        local lay = Instance.new("UIListLayout")
        lay.Padding = UDim.new(0, 8)
        lay.SortOrder = Enum.SortOrder.LayoutOrder
        lay.Parent = sf

        local pd = Instance.new("UIPadding")
        pd.PaddingRight = UDim.new(0, 6)
        pd.PaddingBottom = UDim.new(0, 4)
        pd.Parent = sf

        pages[name] = sf
        return sf
    end

    local visualsPage = makePage("Visuals")
    local playerPage = makePage("Player")
    local autoPage = makePage("Auto")

    local function setTab(name)
        currentTab = name
        for n, p in pairs(pages) do p.Visible = (n == name) end
        refreshGui()
    end

    for name, b in pairs(tabButtons) do
        b.Activated:Connect(function() setTab(name) end)
    end

    table.insert(updaters, function()
        for name, b in pairs(tabButtons) do
            local sel = (name == currentTab)
            b.BackgroundColor3 = sel and ACCENT or Color3.new(1, 1, 1)
            b.BackgroundTransparency = sel and 0.15 or 0.9
        end
    end)

    local function sectionLabel(parent, text)
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, 0, 0, 16)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = MUTED
        l.Font = Enum.Font.GothamBold
        l.TextSize = 11
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.LayoutOrder = nextOrder(parent)
        l.Parent = parent
    end

    local function makeToggle(parent, text, getFn, callback)
        local row = Instance.new("TextButton")
        row.Size = UDim2.new(1, 0, 0, 40)
        row.Text = ""
        row.AutoButtonColor = false
        row.LayoutOrder = nextOrder(parent)
        row.Parent = parent
        glass(row, 0.9, 0.8)
        corner(row, UDim.new(0, 12))

        local label = Instance.new("TextLabel")
        label.Position = UDim2.new(0, 14, 0, 0)
        label.Size = UDim2.new(1, -76, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = TEXT
        label.Font = Enum.Font.GothamMedium
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextTruncate = Enum.TextTruncate.AtEnd
        label.Parent = row

        local pill = Instance.new("Frame")
        pill.Size = UDim2.new(0, 40, 0, 22)
        pill.Position = UDim2.new(1, -52, 0.5, -11)
        pill.BackgroundColor3 = Color3.fromRGB(110, 112, 140)
        pill.BackgroundTransparency = 0.4
        pill.BorderSizePixel = 0
        pill.Parent = row
        corner(pill, UDim.new(1, 0))

        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 18, 0, 18)
        knob.Position = UDim2.new(0, 2, 0.5, -9)
        knob.BackgroundColor3 = Color3.new(1, 1, 1)
        knob.BorderSizePixel = 0
        knob.Parent = pill
        corner(knob, UDim.new(1, 0))

        row.Activated:Connect(callback)

        local info = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
        table.insert(updaters, function()
            local on = getFn()
            TweenService:Create(pill, info, {
                BackgroundColor3 = on and ACCENT or Color3.fromRGB(110, 112, 140),
                BackgroundTransparency = on and 0.05 or 0.4,
            }):Play()
            TweenService:Create(knob, info, {
                Position = on and UDim2.new(0, 20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
            }):Play()
        end)
    end

    local function makeSegment(parent, labels, getIdx, onSelect)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 36)
        row.BackgroundTransparency = 1
        row.LayoutOrder = nextOrder(parent)
        row.Parent = parent

        local n = #labels
        local buttons = {}
        for i = 1, n do
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1 / n, -6, 1, 0)
            b.Position = UDim2.new((i - 1) / n, 3, 0, 0)
            b.AutoButtonColor = false
            b.Text = labels[i]
            b.Font = Enum.Font.GothamMedium
            b.TextSize = 13
            b.TextColor3 = TEXT
            b.Parent = row
            glass(b, 0.9, 0.8)
            corner(b, UDim.new(0, 10))
            b.Activated:Connect(function() onSelect(i) end)
            buttons[i] = b
        end

        table.insert(updaters, function()
            for i, b in ipairs(buttons) do
                local sel = (i == getIdx())
                b.BackgroundColor3 = sel and ACCENT or Color3.new(1, 1, 1)
                b.BackgroundTransparency = sel and 0.15 or 0.9
            end
        end)
    end

    sectionLabel(visualsPage, T("sec_esp"))
    makeToggle(visualsPage, T("tg_esp_doors"), function() return state.espDoors end, toggleEspDoors)
    makeToggle(visualsPage, T("tg_esp_items"), function() return state.espItems end, toggleEspItems)
    makeToggle(visualsPage, T("tg_esp_gold"), function() return state.espGold end, toggleEspGold)
    makeToggle(visualsPage, T("tg_esp_ent"), function() return state.espEntities end, toggleEspEnt)
    makeToggle(visualsPage, T("tg_esp_hide"), function() return state.espHide end, toggleEspHide)
    makeToggle(visualsPage, T("tg_esp_levers"), function() return state.espLevers end, toggleEspLevers)
    makeToggle(visualsPage, T("tg_esp_chests"), function() return state.espChests end, toggleEspChests)
    makeToggle(visualsPage, T("tg_esp_books"), function() return state.espBooks end, toggleEspBooks)
    makeToggle(visualsPage, T("tg_esp_fake"), function() return state.espFake end, toggleEspFake)
    sectionLabel(visualsPage, T("sec_world"))
    makeToggle(visualsPage, T("tg_fullbright"), function() return state.fullbright end, toggleFullbright)
    makeToggle(visualsPage, T("tg_nofog"), function() return state.noFog end, toggleNoFog)

    sectionLabel(playerPage, T("sec_speed"))
    makeToggle(playerPage, T("tg_speed"), function() return state.speed end, toggleSpeed)
    makeSegment(playerPage, {"17", "18", "19", "20", "25", "30"}, function() return speedIdx end, setSpeedIdx)

    sectionLabel(autoPage, T("sec_auto"))
    makeToggle(autoPage, T("tg_loot"), function() return state.autoLoot end, toggleLoot)
    makeToggle(autoPage, T("tg_instant"), function() return state.instant end, toggleInstant)
    makeToggle(autoPage, T("tg_alert"), function() return state.alert end, toggleAlert)
    makeToggle(autoPage, T("tg_libcode"), function() return state.libCode end, toggleLibCode)
    makeToggle(autoPage, T("tg_libopen"), function() return state.libOpen end, toggleLibOpen)

    local statusRow = Instance.new("Frame")
    statusRow.Position = UDim2.new(0, CONTENT_X, 1, -14 - 26)
    statusRow.Size = UDim2.new(0, CONTENT_W, 0, 26)
    statusRow.Parent = main
    glass(statusRow, 0.88, 0.75)
    corner(statusRow, UDim.new(0, 13))

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0, 12, 0.5, -4)
    dot.BackgroundColor3 = MUTED
    dot.BorderSizePixel = 0
    dot.Parent = statusRow
    corner(dot, UDim.new(1, 0))

    local status = Instance.new("TextLabel")
    status.Position = UDim2.new(0, 28, 0, 0)
    status.Size = UDim2.new(1, -36, 1, 0)
    status.BackgroundTransparency = 1
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.TextTruncate = Enum.TextTruncate.AtEnd
    status.TextColor3 = MUTED
    status.Font = Enum.Font.Gotham
    status.TextSize = 12
    status.Text = ""
    status.Parent = statusRow

    refreshGui = function()
        for _, update in ipairs(updaters) do update() end
        local anyOn = state.autoLoot or state.speed or anyEspOn()
        dot.BackgroundColor3 = anyOn and GOOD or MUTED
    end

    local circle = Instance.new("TextButton")
    circle.Size = UDim2.new(0, 52, 0, 52)
    circle.Position = main.Position
    circle.BackgroundColor3 = Color3.new(1, 1, 1)
    circle.BackgroundTransparency = 0.15
    circle.BorderSizePixel = 0
    circle.Text = "VH"
    circle.TextColor3 = Color3.new(1, 1, 1)
    circle.Font = Enum.Font.GothamBlack
    circle.TextSize = 17
    circle.AutoButtonColor = false
    circle.Active = true
    circle.Visible = false
    circle.Parent = gui
    corner(circle, UDim.new(1, 0))
    brandGradient(circle).Rotation = 45

    local circleStroke = Instance.new("UIStroke")
    circleStroke.Color = Color3.new(1, 1, 1)
    circleStroke.Thickness = 1.5
    circleStroke.Transparency = 0.5
    circleStroke.Parent = circle

    local function setGuiVisible(v)
        if v then
            main.Position = circle.Position
        else
            circle.Position = main.Position
        end
        main.Visible = v
        circle.Visible = not v
    end

    makeDraggable(circle, circle, function() setGuiVisible(true) end)

    local function killAll()
        alive = false
        for name in pairs(state) do state[name] = false end
        for cat in pairs(ESP) do clearCat(cat) end
        restoreLighting()
        local hum = getHumanoid()
        if hum then hum.WalkSpeed = 16 end
        for _, c in ipairs(connections) do pcall(function() c:Disconnect() end) end
        gui:Destroy()
        notify(T("killed"))
    end

    windowButton("-", -76, nil, function() setGuiVisible(false) end)
    windowButton("X", -40, RED, killAll)

    task.spawn(function()
        while alive do
            local room = "?"
            pcall(function()
                room = tostring(ReplicatedStorage.GameData.LatestRoom.Value)
            end)
            roomLabel.Text = T("room_label") .. room
            entityLbl.Text = T("entity_label") .. lastEntity

            if state.autoLoot then
                statusText = T("status_loot")
            else
                statusText = T("status_idle")
            end
            status.Text = statusText
            task.wait(0.5)
        end
    end)

    track(UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            setGuiVisible(not main.Visible)
        end
    end))

    setTab("Visuals")
    notify(T("loaded"))
end

buildGui()
