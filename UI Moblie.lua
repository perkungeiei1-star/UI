local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "ToggleUI"
toggleGui.Parent = CoreGui  -- << เปลี่ยนจาก PlayerGui เป็น CoreGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 60, 0, 20)
toggleButton.Position = UDim2.new(0, 930, 0, 8)
toggleButton.Text = "Open UI"
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Parent = toggleGui
toggleButton.AutoButtonColor = false

local isOpen = false

local function pressCtrlRight()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
end

toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        toggleButton.Text = "Close UI"
    else
        toggleButton.Text = "Open UI"
    end
    pressCtrlRight()
end)

local dragging = false
local offset = Vector2.new(0,0)

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        local mousePos = UserInputService:GetMouseLocation()
        local guiPos = toggleButton.AbsolutePosition
        offset = mousePos - Vector2.new(guiPos.X, guiPos.Y)
    end
end)

toggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if dragging then
        local mousePos = UserInputService:GetMouseLocation()
        toggleButton.Position = UDim2.new(
            0, mousePos.X - offset.X,
            0, mousePos.Y - offset.Y
        )
    end
end)