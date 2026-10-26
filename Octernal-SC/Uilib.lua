--[[
    Code is not as clean as it could be but it works
    
    Made by samet
    This is a FREE ui release made by me (samet) on May 30 to celebrate my birthday, If anyone is selling this they are scammers.
    The design credits for the ui goes to eskolzz. It was brought to life in luau by me.

    MY ONLY ACCOUNT IS: joestar._3

    If you want to commission a ui:
    https://discord.gg/XsTteAwprs

    Please give credit if used or modified.
]]

if getgenv().Library then
    getgenv().Library:Exit()
end

cloneref = cloneref or function(...) return ... end 

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local CoreGui = cloneref(game:GetService("CoreGui"))

gethui = gethui or function() return CoreGui end

local LocalPlayer = Players.LocalPlayer
local IsMobile = UserInputService.TouchEnabled or false
local GuiInset = GuiService:GetGuiInset().Y
local Mouse = cloneref(LocalPlayer:GetMouse())

local Library = { 
    Flags = { },
    MenuKeybind = tostring(Enum.KeyCode.X), -- has to be a string

    Directory = "juanitaaaaaaa",
    Folders = {
        Assets = "/Assets",
        Configs = "/Configs",
        Themes = "/Themes"
    },

    FontSize = 12,

    Animation = {
        Time = 0.3,
        Style = "Quint",
        Direction = "Out"
    },

    TabAnimation = {
        Time = 1,
        Style = "Exponential",
        Direction = "Out"
    },

    ColorpickerAnimation = {
        Time = 0.55,
        Style = "Exponential",
        Direction = "Out"
    },

    NotifAnimation = {
        Time = 0.85,
        Style = "Exponential",
        Direction = "Out"
    },

    ZIndexOrder = {
        ["OptionHolder"] = 4,
        ["KeybindWindow"] = 4, -- burp
        ["ColorpickerWindow"] = 6
    },

    -- Ignore below
    Threads = { },
    Connections = { },
    SetFlags = { },

    ThemingStuff = { },
    ThemeMap = { },

    OpenFrames = { },

    Holder = nil,
    UnusedHolder = nil,

    Font = nil,

    Notifications = { },
    KeyList = nil,

    Theme = nil,
} do 
    Library.__index = Library

    local Flags = Library.Flags 
    local SetFlags = Library.SetFlags

    local Keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBracked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    -- Folders
    if not isfolder(Library.Directory) then 
        makefolder(Library.Directory)
    end

    for _, Folder in Library.Folders do 
        if not isfolder(Library.Directory .. Folder) then 
            makefolder(Library.Directory .. Folder)
        end
    end

    if not isfile(Library.Directory .. "/autoload.json") then 
        writefile(Library.Directory .. "/autoload.json", "")
    end

    local Themes = {
        ["Preset"] = {
            ["Border"] = Color3.fromRGB(8, 6, 14),
            ["Outline"] = Color3.fromRGB(45, 38, 58),
            ["Background"] = Color3.fromRGB(15, 12, 22),
            ["Inline"] = Color3.fromRGB(24, 19, 36),
            ["Accent"] = Color3.fromRGB(166, 120, 243), -- Purple accent
            ["Text"] = Color3.fromRGB(225, 215, 245),
            ["Inactive Text"] = Color3.fromRGB(140, 130, 155),
            ["Element"] = Color3.fromRGB(35, 28, 50),
            ["Element 2"] = Color3.fromRGB(50, 40, 70),
            ["Hovered Element"] = Color3.fromRGB(65, 50, 90)
        }
    }

    Library.Theme = Themes.Preset

    -- Custom Font
    local CustomFont = { } do
        function CustomFont:New(Name, Weight, Style, Data)
            if not isfile(Data.Id) then 
                writefile(Data.Id, game:HttpGet(Data.Url))
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = Name,
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Data.Id)
                    }
                }
            }

            writefile(`{Library.Directory .. Library.Folders.Assets}/{Name}.font`, HttpService:JSONEncode(Data))
            return Font.new(getcustomasset(`{Library.Directory .. Library.Folders.Assets}/{Name}.font`))
        end

        Library.Font = CustomFont:New("TahomaXP", 400, "Regular", {
            Id = "TahomaXP",
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/windows-xp-tahoma.ttf"
        })
    end

    Library.Exit = function(Self)
        for _, Connection in Library.Connections do 
            Connection:Disconnect()
        end

        for _, Thread in Library.Threads do 
            coroutine.close(Thread)
        end

        if Self.Holder then 
            Self.Holder.Instance:Destroy()
        end

        if Self.UnusedHolder then 
            Self.UnusedHolder.Instance:Destroy()
        end

        for Index, Value in Library.Notifications do 
            Value.Items.Notification.Instance:Destroy()
        end

        if Self.NotifHolder then 
            Self.NotifHolder.Instance:Destroy()
        end

        Library = nil
        getgenv().Library = nil
    end

    Library.Create = function(Self, Class, Properties)
        local Data = {
            Class = Class,
            Properties = Properties,
            Instance = Instance.new(Class)
        }

        for Index, Property in Properties do 
            if Property == "FontFace" then
                Data.Instance[Property] = Library.Font
                continue
            end

            if Property == "TextSize" then 
                Data.Instance[Property] = Library.FontSize
                continue
            end

            if Property == "Name" then 
                Data.Instance[Property] = "\0"
                continue
            end

            if Class == "TextButton" then 
                if Property == "AutoButtonColor" then 
                    Data.Instance[Property] = false
                    continue
                end

                if Property == "Text" then 
                    Data.Instance[Property] = ""
                    continue
                end
            end

            Data.Instance[Index] = Property
        end

        return setmetatable(Data, Library)
    end

    Library.Thread = function(Self, Function)
        local NewThread = coroutine.create(Function)
        
        coroutine.wrap(function()
            coroutine.resume(NewThread)
        end)()

        table.insert(Library.Threads, NewThread)
        return NewThread
    end

    Library.Connect = function(Self, Signal, Callback)
        local Connection

        if Self.Instance then
            if Self.Instance[Signal] then 
                if IsMobile and Signal == "MouseButton1Down" then 
                    Connection = Self.Instance.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Callback(Input)
                        end
                    end)

                    return
                end
                
                Connection = Self.Instance[Signal]:Connect(Callback)
            else
                Connection = Signal:Connect(Callback)
            end
        else
            Connection = Signal:Connect(Callback)
        end

        table.insert(Library.Connections, Connection)
        return Connection
    end

    Library.Tween = function(Self, Properties, Info, IsRawItem)
        if not Library then return end 

        local Object = Self.Instance or IsRawItem
        Info = Info or TweenInfo.new(Library.Animation.Time, Enum.EasingStyle[Library.Animation.Style], Enum.EasingDirection[Library.Animation.Direction])

        if not Object then 
            return 
        end

        local NewTween = TweenService:Create(Object, Info, Properties)
        NewTween:Play()

        return NewTween
    end

    Library.GetTweenProperty = function(Self, IsRawItem)
        local Object = Self.Instance or IsRawItem

        if not Object then 
            return { }
        end

        if Object:IsA("Frame") then
            return { "BackgroundTransparency" }
        elseif Object:IsA("TextLabel") or Object:IsA("TextButton") then
            return { "TextTransparency", "BackgroundTransparency" }
        elseif Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
            return { "BackgroundTransparency", "ImageTransparency" }
        elseif Object:IsA("ScrollingFrame") then
            return { "BackgroundTransparency", "ScrollBarImageTransparency" }
        elseif Object:IsA("TextBox") then
            return { "TextTransparency", "BackgroundTransparency" }
        elseif Object:IsA("UIStroke") then 
            return { "Transparency" }
        end
    end

    Library.Fade = function(Self, Property, Visibility, IsRawItem)
        local Object = Self.Instance or IsRawItem

        if not Object then 
            return 
        end

        local OldTransparency = Object[Property]
        Object[Property] = Visibility and 1 or OldTransparency

        local NewTween = Library:Tween({[Property] = Visibility and OldTransparency or 1}, nil, Object)

        Library:Connect(NewTween.Completed, function()
            if not Visibility then 
                task.wait()
                Object[Property] = OldTransparency
            end
        end)

        return NewTween
    end

    Library.FadeDescendants = function(Self, Visibility, Callback)
        if Visibility then 
            Self.Instance.Visible = true 
        end

        local NewTween 

        local Children = Self.Instance:GetDescendants()
        table.insert(Children, Self.Instance)

        for _, Child in Children do 
            local TransparencyProperty = Library:GetTweenProperty(Child)

            if not TransparencyProperty then 
                continue 
            end

            if type(TransparencyProperty) == "table" then
                for _, Property in TransparencyProperty do
                    NewTween = Library:Fade(Property, Visibility, Child)
                end
            else
                NewTween = Library:Fade(TransparencyProperty, Visibility, Child)
            end
        end

        Library:Connect(NewTween.Completed, function()
            if Callback and type(Callback) == "function" then 
                Callback()
            end

            Self.Instance.Visible = Visibility
        end)
    end

    Library.MakeDraggable = function(Self)
        if not Self.Instance then 
            return
        end
    
        local Gui = Self.Instance
        local Dragging = false 
        local DragStart
        local StartPosition 
    
        local Set = function(Input)
            local Scale = Library:GetScreenScale()
            local DragDelta = (Input.Position - DragStart) / Scale
            
            local NewX = StartPosition.X.Offset + DragDelta.X
            local NewY = StartPosition.Y.Offset + DragDelta.Y

            local ScreenSize = Gui.Parent.AbsoluteSize / Scale
            local GuiSize = Gui.AbsoluteSize / Scale
            
            NewX = math.clamp(NewX, 0, ScreenSize.X - GuiSize.X)
            NewY = math.clamp(NewY, 0, ScreenSize.Y - GuiSize.Y)
    
            Self:Tween({Position = UDim2.new(0, NewX, 0, NewY)}, TweenInfo.new(0.65, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
        end
    
        local InputChanged
    
        Self:Connect("InputBegan", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = Input.Position
                StartPosition = Gui.Position
    
                if InputChanged then 
                    return
                end
    
                InputChanged = Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                        InputChanged:Disconnect()
                        InputChanged = nil
                    end
                end)
            end
        end)
    
        Library:Connect(UserInputService.InputChanged, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                if Dragging then
                    Set(Input)
                end
            end
        end)
    
        return Dragging
    end

    Library.MakeResizeable = function(Self, Minimum)
        if not Self.Instance then 
            return
        end

        local Gui = Self.Instance

        local Resizing = false 
        local CurrentSide = nil

        local StartMouse = nil 
        local StartPosition = nil 
        local StartSize = nil
        
        local EdgeThickness = 2

        local MakeEdge = function(Name, Position, Size)
            local Button = Library:Create("TextButton", {
                Name = "\0",
                Size = Size,
                Position = Position,
                BackgroundColor3 = Color3.fromRGB(166, 120, 243),
                BackgroundTransparency = 1,
                Text = "",
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Parent = Gui,
            })  Button:AddToTheme({BackgroundColor3 = "Accent"})

            return Button
        end

        local Edges = {
            {Button = MakeEdge(
                "Left", 
                UDim2.new(0, 0, 0, 0), 
                UDim2.new(0, EdgeThickness, 1, 0)), 
                Side = "L"
            },

            {Button = MakeEdge(
                "Right", 
                UDim2.new(1, -EdgeThickness, 0, 0), 
                UDim2.new(0, EdgeThickness, 1, 0)), 
                Side = "R"
            },

            {Button = MakeEdge(
                "Top", UDim2.new(0, 0, 0, 0), 
                UDim2.new(1, 0, 0, EdgeThickness)), 
                Side = "T"
            },

            {Button = MakeEdge(
                "Bottom", 
                UDim2.new(0, 0, 1, -EdgeThickness), 
                UDim2.new(1, 0, 0, EdgeThickness)), 
                Side = "B"
            },
        }

        local BeginResizing = function(Side)
            Resizing = true 
            CurrentSide = Side 

            StartMouse = UserInputService:GetMouseLocation()

            StartPosition = Vector2.new(Gui.Position.X.Offset, Gui.Position.Y.Offset)
            StartSize = Vector2.new(Gui.Size.X.Offset, Gui.Size.Y.Offset)
            
            for Index, Value in Edges do 
                Value.Button.Instance.BackgroundTransparency = (Value.Side == Side) and 0 or 1
            end
        end

        local EndResizing = function()
            Resizing = false 
            CurrentSide = nil

            for Index, Value in Edges do 
                Value.Button.Instance.BackgroundTransparency = 1
            end
        end

        for Index, Value in Edges do 
            Value.Button:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    BeginResizing(Value.Side)
                end
            end)
        end

        Library:Connect(UserInputService.InputEnded, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                if Resizing then
                    EndResizing()
                end
            end
        end)

        Library:Connect(RunService.RenderStepped, function()
            if not Resizing or not CurrentSide then 
                return 
            end

            local MouseLocation = UserInputService:GetMouseLocation()
            local dx = MouseLocation.X - StartMouse.X
            local dy = MouseLocation.Y - StartMouse.Y
        
            local x, y = StartPosition.X, StartPosition.Y
            local w, h = StartSize.X, StartSize.Y

            if CurrentSide == "L" then
                x = StartPosition.X + dx
                w = StartSize.X - dx
            elseif CurrentSide == "R" then
                w = StartSize.X + dx
            elseif CurrentSide == "T" then
                y = StartPosition.Y + dy
                h = StartSize.Y - dy
            elseif CurrentSide == "B" then
                h = StartSize.Y + dy
            end
        
            if w < Minimum.X then
                if CurrentSide == "L" then
                    x = x - (Minimum.X - w)
                end
                w = Minimum.X
            end
            if h < Minimum.Y then
                if CurrentSide == "T" then
                    y = y - (Minimum.Y - h)
                end
                h = Minimum.Y
            end
        
            Self:Tween({Position = UDim2.fromOffset(x, y)}, TweenInfo.new(0.65, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
            Self:Tween({Size = UDim2.fromOffset(w, h)}, TweenInfo.new(0.65, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
        end)
    end

    Library.IsMouseOverFrame = function(Self)
        if not Self.Instance then 
            return 
        end

        local Object = Self.Instance

        local MousePosition = Vector2.new(Mouse.X, Mouse.Y)

        return MousePosition.X >= Object.AbsolutePosition.X and MousePosition.X <= Object.AbsolutePosition.X + Object.AbsoluteSize.X 
        and MousePosition.Y >= Object.AbsolutePosition.Y and MousePosition.Y <= Object.AbsolutePosition.Y + Object.AbsoluteSize.Y
    end

    Library.SafeCall = function(Self, Function, ...)
        local Arguements = { ... }
        local Success, Result = pcall(Function, table.unpack(Arguements))

        if not Success then
            warn(Result)
            return false
        end

        return Success, Result
    end

    Library.Round = function(Self, Number, Float)
        local Multiplier = 1 / (Float or 1)
        return math.floor(Number * Multiplier) / Multiplier
    end

    Library.GetConfig = function(Self)
        local Config = { }

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Key then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
                elseif type(Value) == "table" and Value.Color then
                    Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end
        end)

        if not Success then
            warn("Failed to get config:\n"..Result)
            return
        end

        return HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(Self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Key then 
                    SetFunction(Value)
                elseif type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                else
                    SetFunction(Value)
                end
            end
        end)

        return Success, Result
    end

    Library.GetConfigsList = function(Self, Element)
        local List = { }
        local ReturnList = { }

        List = listfiles(Library.Directory .. Library.Folders.Configs)

        for Index = 1, #List do 
            local File = List[Index]

            if File:sub(-5) == ".json" then
                local Position = File:find(".json", 1, true)
                local StartPosition = Position

                local Character = File:sub(Position, Position)
                while Character ~= "/" and Character ~= "\\" and Character ~= "" do
                    Position = Position - 1
                    Character = File:sub(Position, Position)
                end

                if Character == "/" or Character == "\\" then
                    table.insert(ReturnList, File:sub(Position + 1, StartPosition - 1))
                end
            end
        end

        Element:Refresh(ReturnList)
    end

    Library.AddToTheme = function(Self, Properties)
        local Object = Self.Instance

        local ThemeData = {
            Item = Object,
            Properties = Properties,
        }

        for Property, Value in ThemeData.Properties do
            if type(Value) == "string" then
                if not Library.Theme[Value] then
                    Object[Property] = Value 
                end

                Object[Property] = Library.Theme[Value]
            else
                Object[Property] = Value()
            end
        end

        table.insert(Library.ThemingStuff, ThemeData)
        Library.ThemeMap[Object] = ThemeData
        return Self
    end

    Library.ChangeItemTheme = function(Self, Properties)
        local Object = Self.Instance

        if not Library.ThemeMap[Object] then 
            return
        end

        Library.ThemeMap[Object].Properties = Properties
        Library.ThemeMap[Object] = Library.ThemeMap[Object]
    end

    Library.ChangeTheme = function(Self, Theme, Color)
        Library.Theme[Theme] = Color

        for _, Item in Library.ThemingStuff do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and Value == Theme then
                    Item.Item[Property] = Color
                elseif type(Value) == "function" then
                    Item.Item[Property] = Value()
                end
            end
        end
    end

    Library.OnHover = function(Self, OnHoverEnter, OnHoverLeave)
        local Object = Self.Instance

        if not Object then 
            return 
        end 

        Library:Connect(Object.MouseEnter, OnHoverEnter)
        Library:Connect(Object.MouseLeave, OnHoverLeave)
    end

    Library.GetScreenScale = function(Self)
        local Scale = 1
    
        for _, Obj in Library.Holder.Instance:GetDescendants() do
            if Obj:IsA("UIScale") then
                Scale *= Obj.Scale
            end
        end
    
        return Scale
    end
    
    Library.PopupPosition = function(Self, Anchor, Popup, ExtraY)
        local Scale = Library:GetScreenScale()
        ExtraY = ExtraY or 0
    
        local X = Anchor.AbsolutePosition.X / Scale
        local Y = (Anchor.AbsolutePosition.Y + Anchor.AbsoluteSize.Y + GuiInset + ExtraY) / Scale
    
        return UDim2.fromOffset(X, Y)
    end

    Library.VisibleCheck = function(Self)
        local Object = Self.Instance 

        if not Object then 
            return 
        end

        local OriginalParent = Object.Parent

        Library:Connect(Object:GetPropertyChangedSignal("Visible"), function()
            local IsVisible = Object.Visible
            Object.Parent = IsVisible and OriginalParent or Library.UnusedHolder.Instance
        end)
    end

    Library.GetTheme = function(Self)
        local Config = { }

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Color and Value.Flag:find("Theming") then
                    Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
                end
            end
        end)

        if not Success then
            warn("Failed to get theme:\n"..Result)
            return
        end

        return HttpService:JSONEncode(Config)
    end

    Library.LoadTheme = function(Self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                end
            end
        end)

        return Success, Result
    end

    Library.GetThemesList = function(Self, Element)
        local List = { }
        local ReturnList = { }

        List = listfiles(Library.Directory .. Library.Folders.Themes)

        for Index = 1, #List do 
            local File = List[Index]

            if File:sub(-5) == ".json" then
                local Position = File:find(".json", 1, true)
                local StartPosition = Position

                local Character = File:sub(Position, Position)
                while Character ~= "/" and Character ~= "\\" and Character ~= "" do
                    Position = Position - 1
                    Character = File:sub(Position, Position)
                end

                if Character == "/" or Character == "\\" then
                    table.insert(ReturnList, File:sub(Position + 1, StartPosition - 1))
                end
            end
        end

        Element:Refresh(ReturnList)
    end

    Library.Holder = Library:Create("ScreenGui", {
        Parent = gethui(),
        IgnoreGuiInset = true,
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })

    Library.NotifHolder = Library:Create("ScreenGui", {
        Parent = gethui(),
        IgnoreGuiInset = true,
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })

    Library.UnusedHolder = Library:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        Enabled = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })

    -- themes
    Library:Thread(function()
        writefile(Library.Directory .. Library.Folders.Themes .. "/Purple.json", '{"MenuKeybindModeDropdown":"Toggle","AccentTheming":{"Color":"#a678f3","Alpha":0},"BackgroundTheming":{"Color":"#0f0c16","Alpha":0},"color":{"Color":"#ffffff","Alpha":0},"MenuKeybind":{"Key":"Enum.KeyCode.X","Mode":"Toggle"},"keybindModeDropdown":"Toggle","keybind2ModeDropdown":"Toggle","Hovered ElementTheming":{"Color":"#41325a","Alpha":0},"keybind2ShowInKeybindsList":true,"target":"Head","OutlineTheming":{"Color":"#2d263a","Alpha":0},"keybind3ShowInKeybindsList":true,"InlineTheming":{"Color":"#181324","Alpha":0},"keybind":{"Key":"Enum.KeyCode.E","Mode":"Toggle"},"keybind3":{"Key":"Enum.KeyCode.R","Mode":"Toggle"},"keybind3ModeDropdown":"Toggle","ElementTheming":{"Color":"#231c32","Alpha":0},"Element 2Theming":{"Color":"#322846","Alpha":0},"keybind2":{"Key":"Enum.KeyCode.F","Mode":"Toggle"},"ThemeName":"Purple","BorderTheming":{"Color":"#08060e","Alpha":0},"AutoParry":false,"ConfigName":"","keybindShowInKeybindsList":true,"Inactive TextTheming":{"Color":"#8c829b","Alpha":0},"walkspeed":16,"TextTheming":{"Color":"#e1d7f5","Alpha":0},"MenuKeybindShowInKeybindsList":true,"textbox":"default"}')
        writefile(Library.Directory .. Library.Folders.Themes .. "/Sky.json", '{"MenuKeybindModeDropdown":"Toggle","AccentTheming":{"Color":"#93eeff","Alpha":0},"BackgroundTheming":{"Color":"#141718","Alpha":0},"color":{"Color":"#ffffff","Alpha":0},"MenuKeybind":{"Key":"Enum.KeyCode.X","Mode":"Toggle"},"keybindModeDropdown":"Toggle","keybind2ModeDropdown":"Toggle","Hovered ElementTheming":{"Color":"#444949","Alpha":0},"keybind2ShowInKeybindsList":true,"target":"Head","OutlineTheming":{"Color":"#292d2e","Alpha":0},"keybind3ShowInKeybindsList":true,"InlineTheming":{"Color":"#1f2324","Alpha":0},"keybind":{"Key":"Enum.KeyCode.E","Mode":"Toggle"},"keybind3":{"Key":"Enum.KeyCode.R","Mode":"Toggle"},"keybind3ModeDropdown":"Toggle","ElementTheming":{"Color":"#2e3131","Alpha":0},"Element 2Theming":{"Color":"#454a4b","Alpha":0},"keybind2":{"Key":"Enum.KeyCode.F","Mode":"Toggle"},"ThemeName":"Sky","BorderTheming":{"Color":"#1a1d1d","Alpha":0},"AutoParry":false,"ConfigName":"","keybindShowInKeybindsList":true,"Inactive TextTheming":{"Color":"#868686","Alpha":0},"walkspeed":16,"TextTheming":{"Color":"#ffffff","Alpha":0},"MenuKeybindShowInKeybindsList":true,"textbox":"default"}')
        writefile(Library.Directory .. Library.Folders.Themes .. "/Magma.json", '{"MenuKeybindModeDropdown":"Toggle","AccentTheming":{"Color":"#e92b1a","Alpha":0},"BackgroundTheming":{"Color":"#221c1c","Alpha":0},"color":{"Color":"#ffffff","Alpha":0},"MenuKeybind":{"Key":"Enum.KeyCode.X","Mode":"Toggle"},"keybindModeDropdown":"Toggle","keybind2ModeDropdown":"Toggle","Hovered ElementTheming":{"Color":"#362a2a","Alpha":0},"keybind2ShowInKeybindsList":true,"target":"Head","OutlineTheming":{"Color":"#291d1d","Alpha":0},"keybind3ShowInKeybindsList":true,"InlineTheming":{"Color":"#1f1717","Alpha":0},"keybind":{"Key":"Enum.KeyCode.E","Mode":"Toggle"},"keybind3":{"Key":"Enum.KeyCode.R","Mode":"Toggle"},"keybind3ModeDropdown":"Toggle","ElementTheming":{"Color":"#292121","Alpha":0},"Element 2Theming":{"Color":"#363131","Alpha":0},"keybind2":{"Key":"Enum.KeyCode.F","Mode":"Toggle"},"ThemeName":"Magma","BorderTheming":{"Color":"#000000","Alpha":0},"AutoParry":true,"ConfigName":"","keybindShowInKeybindsList":true,"Inactive TextTheming":{"Color":"#867979","Alpha":0},"walkspeed":16,"TextTheming":{"Color":"#d0cfe3","Alpha":0},"MenuKeybindShowInKeybindsList":true,"textbox":"default"}')
        writefile(Library.Directory .. Library.Folders.Themes .. "/Sand.json", '{"MenuKeybindModeDropdown":"Toggle","AccentTheming":{"Color":"#ffe593","Alpha":0},"BackgroundTheming":{"Color":"#2d2e25","Alpha":0},"color":{"Color":"#ffffff","Alpha":0},"MenuKeybind":{"Key":"Enum.KeyCode.X","Mode":"Toggle"},"keybindModeDropdown":"Toggle","keybind2ModeDropdown":"Toggle","Hovered ElementTheming":{"Color":"#47473b","Alpha":0},"keybind2ShowInKeybindsList":true,"target":"Head","OutlineTheming":{"Color":"#585344","Alpha":0},"keybind3ShowInKeybindsList":true,"InlineTheming":{"Color":"#3f4137","Alpha":0},"keybind":{"Key":"Enum.KeyCode.E","Mode":"Toggle"},"keybind3":{"Key":"Enum.KeyCode.R","Mode":"Toggle"},"keybind3ModeDropdown":"Toggle","ElementTheming":{"Color":"#36362c","Alpha":0},"Element 2Theming":{"Color":"#414133","Alpha":0},"keybind2":{"Key":"Enum.KeyCode.F","Mode":"Toggle"},"ThemeName":"Sand","BorderTheming":{"Color":"#141403","Alpha":0},"AutoParry":false,"ConfigName":"","keybindShowInKeybindsList":true,"Inactive TextTheming":{"Color":"#888784","Alpha":0},"walkspeed":16,"TextTheming":{"Color":"#d0cfe3","Alpha":0},"MenuKeybindShowInKeybindsList":true,"textbox":"default"}')
        writefile(Library.Directory .. Library.Folders.Themes .. "/Navy.json", '{"MenuKeybindModeDropdown":"Toggle","AccentTheming":{"Color":"#0066ff","Alpha":0},"BackgroundTheming":{"Color":"#1c1e24","Alpha":0},"color":{"Color":"#ffffff","Alpha":0},"Watermark":true,"keybind2ModeDropdown":"Toggle","keybindModeDropdown":"Toggle","Hovered ElementTheming":{"Color":"#282b31","Alpha":0},"keybind2ShowInKeybindsList":true,"ThemeName":"Navy","InlineTheming":{"Color":"#202229","Alpha":0},"textbox":"default","OutlineTheming":{"Color":"#252a36","Alpha":0},"keybind":{"Key":"Enum.KeyCode.E","Mode":"Toggle"},"MenuKeybind":{"Key":"Enum.KeyCode.X","Mode":"Toggle"},"BorderTheming":{"Color":"#030303","Alpha":0},"keybind3":{"Key":"Enum.KeyCode.R","Mode":"Toggle"},"keybind3ModeDropdown":"Toggle","ElementTheming":{"Color":"#1d202b","Alpha":0},"Keybind list":true,"keybind2":{"Key":"Enum.KeyCode.F","Mode":"Toggle"},"AutoParry":true,"keybind3ShowInKeybindsList":true,"Element 2Theming":{"Color":"#3e414b","Alpha":0},"keybindShowInKeybindsList":true,"ConfigName":"","Inactive TextTheming":{"Color":"#65697e","Alpha":0},"walkspeed":34,"TextTheming":{"Color":"#a5a4bb","Alpha":0},"MenuKeybindShowInKeybindsList":true,"target":"Head"}')
    end)
