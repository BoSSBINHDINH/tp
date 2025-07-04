-- Script GUI TP người chơi đến bạn (viền rainbow, TP sát cạnh, danh sách đầy đủ)

-- Tạo hiệu ứng rainbow
local function rainbow()
	local hue = tick() % 5 / 5
	return Color3.fromHSV(hue, 1, 1)
end

-- Tạo GUI chính
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "TPA_GUI"

-- Tạo logo TP BOSS để mở menu
local logo = Instance.new("ImageButton", ScreenGui)
logo.Size = UDim2.new(0, 60, 0, 60)
logo.Position = UDim2.new(0, 20, 0.5, -30)
logo.Image = "rbxassetid://13703740115" -- Icon tròn (bạn có thể thay ID)
logo.BackgroundTransparency = 1
logo.Name = "TPBossBtn"

-- Tạo Frame menu
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 350, 0, 240)
Frame.Position = UDim2.new(0.5, -175, 0.5, -120)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true
Frame.Visible = false

-- Viền rainbow liên tục
spawn(function()
	while true do
		Frame.BorderColor3 = rainbow()
		wait(0.05)
	end
end)

-- Nút tắt (X)
local closeBtn = Instance.new("TextButton", Frame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.MouseButton1Click:Connect(function()
	Frame.Visible = false
end)

-- Mở menu
logo.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
end)

-- Tiêu đề
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "TPA MENU"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Danh sách player đầy đủ
local PlayerList = Instance.new("ScrollingFrame", Frame)
PlayerList.Size = UDim2.new(1, -20, 0, 120)
PlayerList.Position = UDim2.new(0, 10, 0, 40)
PlayerList.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PlayerList.ScrollBarThickness = 6
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.BorderSizePixel = 0

-- Chọn player
local selectedPlayer = nil
local function updateList()
	PlayerList:ClearAllChildren()
	local y = 0
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr ~= game.Players.LocalPlayer then
			local btn = Instance.new("TextButton", PlayerList)
			btn.Size = UDim2.new(1, -10, 0, 30)
			btn.Position = UDim2.new(0, 5, 0, y)
			btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			btn.Text = plr.Name
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 14
			btn.MouseButton1Click:Connect(function()
				selectedPlayer = plr
				btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			end)
			y = y + 35
		end
	end
	PlayerList.CanvasSize = UDim2.new(0, 0, 0, y)
end
updateList()

-- Nút TP
local TPButton = Instance.new("TextButton", Frame)
TPButton.Size = UDim2.new(1, -20, 0, 40)
TPButton.Position = UDim2.new(0, 10, 1, -50)
TPButton.BackgroundColor3 = Color3.fromRGB(20, 130, 250)
TPButton.Text = "TPA"
TPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TPButton.Font = Enum.Font.GothamBold
TPButton.TextSize = 18

-- TP xử lý
TPButton.MouseButton1Click:Connect(function()
	if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if myHRP then
			local targetHRP = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
			local newCFrame = myHRP.CFrame + myHRP.CFrame.LookVector * 3 + Vector3.new(0, 0, 1) -- ngay bên cạnh
			targetHRP.CFrame = newCFrame
			print("Đã TP " .. selectedPlayer.Name .. " đến bạn!")
		end
	end
end)
