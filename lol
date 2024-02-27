local mainacc = _G.Mainuser
local autogivecash = _G.AutoGiveCash
local GivecashAmount = _G.GivecashAmount

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local User = Instance.new("TextLabel")
local Total = Instance.new("TextLabel")
local Earned = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
Main.Name = "Main"
Main.Parent = ScreenGui
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(1, 0, 1, 0)

User.Name = "User"
User.Parent = Main
User.AnchorPoint = Vector2.new(0.5, 0.5)
User.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
User.BackgroundTransparency = 1.000
User.BorderColor3 = Color3.fromRGB(0, 0, 0)
User.BorderSizePixel = 0
User.Position = UDim2.new(0.5, 0, 0.5, 0)
User.Size = UDim2.new(0.300000012, 0, 0.100000001, 0)
User.Font = Enum.Font.SourceSansBold
User.Text = game.Players.LocalPlayer.Name
User.TextColor3 = Color3.fromRGB(124, 0, 177)
User.TextSize = 100.000

Total.Name = "Total"
Total.Parent = Main
Total.AnchorPoint = Vector2.new(0.5, 0.744000018)
Total.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Total.BackgroundTransparency = 1.000
Total.BorderColor3 = Color3.fromRGB(0, 0, 0)
Total.BorderSizePixel = 0
Total.Position = UDim2.new(0.5, 0, 0.743929386, 0)
Total.Size = UDim2.new(0.200000003, 0, 0.100000001, 0)
Total.Font = Enum.Font.SourceSansBold
Total.Text = "Total: 0"
Total.TextColor3 = Color3.fromRGB(255, 255, 255)
Total.TextSize = 43.000
Total.TextXAlignment = Enum.TextXAlignment.Center

Earned.Name = "Earned"
Earned.Parent = Main
Earned.AnchorPoint = Vector2.new(0.5, 0.644999981)
Earned.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Earned.BackgroundTransparency = 1.000
Earned.BorderColor3 = Color3.fromRGB(0, 0, 0)
Earned.BorderSizePixel = 0
Earned.Position = UDim2.new(0.5, 0, 0.64459163, 0)
Earned.Size = UDim2.new(0.200000003, 0, 0.100000001, 0)
Earned.Font = Enum.Font.SourceSansBold
Earned.Text = "Earned: 0"
Earned.TextColor3 = Color3.fromRGB(255, 255, 255)
Earned.TextSize = 43.000
Earned.TextXAlignment = Enum.TextXAlignment.Center

local plr = game.Players.LocalPlayer
local HRP = plr.Character.HumanoidRootPart
local ts = game:GetService('TweenService')
local uis = game:GetService('UserInputService')
local cleaning = false
local rs = game:GetService('RunService')
local ready = {}
local moneyearned = 0


uis.InputBegan:Connect(function(key)
if key.KeyCode == Enum.KeyCode.G then
if Main.Visible == true then
Main.Visible = false
rs:Set3dRenderingEnabled(true)
elseif Main.Visible == false then
Main.Visible = true
rs:Set3dRenderingEnabled(false)
end
elseif key.KeyCode == Enum.KeyCode.H then
local A_1 = "sendMoney"
local A_2 =
{
["U"] = mainacc,
["A"] = plr.leaderstats.Wallet.Value
}
local Event = game:GetService("ReplicatedStorage").PhoneRF
Event:InvokeServer(A_1, A_2)
end
end)
plr.leaderstats.Wallet.Changed:Connect(function()
moneyearned += 15
Earned.Text = 'Earned: '..tostring(moneyearned)
Total.Text = 'Total: '..tostring(plr.leaderstats.Wallet.Value)
if autogivecash then
if plr.leaderstats.Wallet.Value >= GivecashAmount then
local A_1 = "sendMoney"
local A_2 =
{
["U"] = mainacc,
["A"] = GivecashAmount
}
local Event = game:GetService("ReplicatedStorage").PhoneRF
Event:InvokeServer(A_1, A_2)
end
end
end)



rs:Set3dRenderingEnabled(false)
local part = Instance.new('Part', workspace)
part.Size = Vector3.new(200,1,200)
part.Anchored = true
part.CFrame = HRP.CFrame * CFrame.new(0,-4,0)
part.Name = 'FarmBrickty'
wait(1)
for i,v in pairs(workspace:GetChildren()) do
if v.Name ~= "Camera" and v.Name ~= "Terrain" and v.Name ~= 'CleanPart' and v.Name ~= plr.Name and v.Name ~= 'FarmBrickty' then
v:Destroy()
end
end
warn('Destroyed Map')
wait(2)

for i,v in pairs(workspace.CleanPart:GetChildren()) do
v.Decal.Changed:Connect(function()
if v.Decal.Transparency == 0 then
if v.ClassName == 'Part' then
table.insert(ready,1,v)
end
end
end)
if v.Decal.Transparency == 0 then
if v.ClassName == 'Part' then
table.insert(ready,1,v)
end
end
end

while true do
if (next(ready) == nil) then
print("Waiting")
else
local dirt = ready[1]
table.remove(ready,1)
ts:Create(HRP,TweenInfo.new(1),{CFrame = dirt.CFrame* CFrame.new(0,3,0)}):Play()
wait(1)
if dirt.ProximityPrompt == nil then
else
fireproximityprompt(dirt.ProximityPrompt)
end
print(plr.leaderstats.Wallet.Value)
end
wait(3)
end
rs.Heartbeat:Connect(function()
for i,v in pairs(game.Players:GetPlayers()) do
if v.Name ~= plr.Name then
v.Character:Destroy()
end
end
end)
