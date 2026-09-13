-- VENOM.EXE
-- Interface para Roblox Studio

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "VenomExe"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(650, 430)
main.Position = UDim2.new(0.5, -325, 0.5, -215)
main.BackgroundColor3 = Color3.fromRGB(35, 15, 30)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 18)
corner.Parent = main

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 55)
title.Position = UDim2.fromOffset(15, 5)
title.BackgroundTransparency = 1
title.Text = "VENOM.EXE"
title.TextColor3 = Color3.fromRGB(255, 80, 180)
title.TextSize = 30
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

-- Categorias
local categories = {
	"Speed",
	"Combat",
	"Steal",
	"Movement",
	"Visual",
	"Utility",
	"OP Options"
}

local functions = {
	Speed = {
		"Speed Modes",
		"Lagger Speed"
	},

	Combat = {
		"Auto Bat",
		"Auto Swing",
		"Auto Switch",
		"Bat Counter",
		"Medusa Counter",
		"Medusa Reset",
		"Duel Lagger"
	},

	Steal = {
		"Insta Steal",
		"Drop Brainrot"
	},

	Movement = {
		"Anti Ragdoll",
		"Infinite Jump",
		"Unwalk",
		"Auto TP Down",
		"TP Down"
	},

	Visual = {
		"ESP",
		"Stretch Rez",
		"FOV 120"
	},

	Utility = {
		"Anti Lag",
		"Instant Reset",
		"Control Support"
	},

	["OP Options"] = {
		"TP BAT Bypass",
		"Anti TP BAT Configs",
		"Anti Anti Bat"
	}
}

local categoryFrame = Instance.new("Frame")
categoryFrame.Size = UDim2.fromOffset(155, 350)
categoryFrame.Position = UDim2.fromOffset(15, 65)
categoryFrame.BackgroundTransparency = 1
categoryFrame.Parent = main

local content = Instance.new("Frame")
content.Size = UDim2.fromOffset(445, 350)
content.Position = UDim2.fromOffset(185, 65)
content.BackgroundColor3 = Color3.fromRGB(45, 20, 40)
content.BorderSizePixel = 0
content.Parent = main

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 15)
contentCorner.Parent = content

local function clearContent()
	for _, object in ipairs(content:GetChildren()) do
		if not object:IsA("UICorner") then
			object:Destroy()
		end
	end
end

local function createToggle(name, y)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -30, 0, 50)
	button.Position = UDim2.fromOffset(15, y)
	button.BackgroundColor3 = Color3.fromRGB(70, 30, 60)
	button.Text = name
	button.TextColor3 = Color3.fromRGB(245, 225, 240)
	button.TextSize = 16
	button.Font = Enum.Font.GothamMedium
	button.TextXAlignment = Enum.TextXAlignment.Left
	button.AutoButtonColor = false
	button.Parent = content

	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 18)
	padding.Parent = button

	local toggle = Instance.new("Frame")
	toggle.Size = UDim2.fromOffset(55, 28)
	toggle.Position = UDim2.new(1, -70, 0.5, -14)
	toggle.BackgroundColor3 = Color3.fromRGB(90, 45, 80)
	toggle.Parent = button

	local tc = Instance.new("UICorner")
	tc.CornerRadius = UDim.new(1, 0)
	tc.Parent = toggle

	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(22, 22)
	knob.Position = UDim2.fromOffset(3, 3)
	knob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
	knob.Parent = toggle

	local kc = Instance.new("UICorner")
	kc.CornerRadius = UDim.new(1, 0)
	kc.Parent = knob

	local enabled = false

	button.MouseButton1Click:Connect(function()
		enabled = not enabled

		if enabled then
			toggle.BackgroundColor3 = Color3.fromRGB(255, 70, 175)
			knob.Position = UDim2.new(1, -25, 0, 3)
		else
			toggle.BackgroundColor3 = Color3.fromRGB(90, 45, 80)
			knob.Position = UDim2.fromOffset(3, 3)
		end

		print("[VENOM.EXE]", name, enabled and "ON" or "OFF")
	end)
end

local function showCategory(category)
	clearContent()

	local header = Instance.new("TextLabel")
	header.Size = UDim2.new(1, -30, 0, 40)
	header.Position = UDim2.fromOffset(15, 10)
	header.BackgroundTransparency = 1
	header.Text = category
	header.TextColor3 = Color3.fromRGB(255, 90, 185)
	header.TextSize = 23
	header.Font = Enum.Font.GothamBold
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.Parent = content

	local list = functions[category]

	for i, funcName in ipairs(list) do
		createToggle(funcName, 55 + ((i - 1) * 58))
	end
end

for i, category in ipairs(categories) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 43)
	button.Position = UDim2.fromOffset(0, (i - 1) * 48)
	button.BackgroundColor3 = Color3.fromRGB(55, 25, 48)
	button.Text = category
	button.TextColor3 = Color3.fromRGB(235, 210, 230)
	button.TextSize = 15
	button.Font = Enum.Font.GothamBold
	button.AutoButtonColor = false
	button.Parent = categoryFrame

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 10)
	c.Parent = button

	button.MouseButton1Click:Connect(function()
		showCategory(category)
	end)
end

-- Arrastar janela
local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

title.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

showCategory("Speed")
