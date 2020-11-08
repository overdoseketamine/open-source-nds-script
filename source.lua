--[[
Open Source NDS Script
Original by shawnjbragdon#0001
Modified by elementemerald#4175

https://www.roblox.com/games/189707/Natural-Disaster-Survival
]]

game:GetService("RunService").Stepped:connect(function()
    -- this function requires a compatible exploit (Synapse, Sentinel, etc.)
    setsimulationradius(math.pow(math.huge,math.huge)*math.huge, math.pow(math.huge,math.huge)*math.huge);
    wait(9e9);
end);

shared.ua = {}
  
for index, part in pairs(workspace:GetDescendants()) do
    if part:IsA("Part") and part.Anchored == false and part:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) == false then
        table.insert(shared.ua,part)
    end
end
  
for i = 1, #shared.ua do
    shared.ua[i].Parent = workspace
    local BD = Instance.new("BodyPosition") -- body position for the parts
    BD.Parent = shared.ua[i]
    BD.Name = "BD"
end

game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
	Text = "{System} Getting things ready, please wait...",
	Color = Color3.fromRGB(255, 235, 85),
	Font = Enum.Font.SourceSansBold
})

if shared.notifyChanges == false then
	game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
		Text = "{System} You currently have the notifyChanges variable set to \'false\', if you want it on please change the value from \'false\' to \'true\'. You can also use the command \'notifychanges/true\'",
		Color = Color3.fromRGB(255, 85, 85),
		Font = Enum.Font.SourceSansBold
	})
end

pcall(function()
	coroutine.resume(coroutine.create(function()
		SurvivalTag = game:GetService("Players").LocalPlayer.Character:WaitForChild("SurvivalTag")
		if shared.notifyChanges == true then
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
				Text = string.format("{System} The upcoming disaster will be a %s", SurvivalTag.Value),
				Color = Color3.fromRGB(255, 235, 85),
				Font = Enum.Font.SourceSansBold
			})
			SurvivalTag:GetPropertyChangedSignal("Value"):Connect(function()
				game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
					Text = string.format("{System} The upcoming disaster will be a %s", SurvivalTag.Value),
					Color = Color3.fromRGB(255, 235, 85),
					Font = Enum.Font.SourceSansBold
				})
			end)
		end
		if shared.broadcastDisaster == true then
			game:GetService("ReplicatedStorage")["DefaultChatSystemChatEvents"].SayMessageRequest:FireServer(string.format("[LuminentialBot]: The upcoming disaster will be a %s", SurvivalTag.Value),"All")
		end
	end))
	coroutine.resume(coroutine.create(function()
		local FallDamageScript = game:GetService("Players").LocalPlayer.Character:WaitForChild("FallDamageScript")
		FallDamageScript:Destroy()
		if shared.notifyChanges == true then
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
				Text = "{System} FallDamageScript has been destroyed.",
				Color = Color3.fromRGB(255, 235, 85),
				Font = Enum.Font.SourceSansBold
			})
		end
	end))
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(Character)
	coroutine.resume(coroutine.create(function()
		SurvivalTag = Character:WaitForChild("SurvivalTag")
		if shared.notifyChanges == true then
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
				Text = string.format("{System} The upcoming disaster will be a %s", SurvivalTag.Value),
				Color = Color3.fromRGB(255, 235, 85),
				Font = Enum.Font.SourceSansBold
			})
			SurvivalTag:GetPropertyChangedSignal("Value"):Connect(function()
				game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
					Text = string.format("{System} The upcoming disaster will be a %s", SurvivalTag.Value),
					Color = Color3.fromRGB(255, 235, 85),
					Font = Enum.Font.SourceSansBold
				})
			end)
		end
		if shared.broadcastDisaster == true then
			game:GetService("ReplicatedStorage")["DefaultChatSystemChatEvents"].SayMessageRequest:FireServer(string.format("[LuminentialBot]: The upcoming disaster will be a %s", SurvivalTag.Value),"All")
		end
	end))
	coroutine.resume(coroutine.create(function()
		local FallDamageScript = Character:WaitForChild("FallDamageScript")
		FallDamageScript:Destroy()
		if shared.notifyChanges == true then
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
				Text = "{System} FallDamageScript has been destroyed.",
				Color = Color3.fromRGB(255, 235, 85),
				Font = Enum.Font.SourceSansBold
			})
			SurvivalTag:GetPropertyChangedSignal("Value"):Connect(function()
				game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
					Text = string.format("{System} The upcoming disaster will be a %s", SurvivalTag.Value),
					Color = Color3.fromRGB(255, 235, 85),
					Font = Enum.Font.SourceSansBold
				})
			end)
		end
	end))
end)

game:GetService("Players").LocalPlayer.Chatted:Connect(function(Message,Recipient)
	if typeof(Recipient) == "Instance" and table.find({"autofarm","notifychanges","broadcastdisaster"}) then
		return
	end
	local commands = {
		["autofarm/"] = function(value)
			local boolean = (string.sub(value,1,4) == "true" and true) or (string.sub(value,1,5) == "false" and false)
			autofarm = boolean
		end,
		["notifychange/"] = function(value)
			local boolean = (string.sub(value,1,4) == "true" and true) or (string.sub(value,1,5) == "false" and false)
			notifyChanges = boolean
		end,
		["broadcastdisaster/"] = function(value)
			local boolean = (string.sub(value,1,4) == "true" and true) or (string.sub(value,1,5) == "false" and false)
			broadcastDisaster = boolean
		end,
	};
	for index,value in pairs(commands) do
		if string.lower(tostring(index)) == string.sub(string.lower(Message),1,string.len(index)) then
			commands[index](string.sub(Message,string.len(tostring(index)) + 1))

			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
				Text = string.format("{System} Ran a command: %s",tostring(index)),
				Color = Color3.fromRGB(255, 235, 85),
				Font = Enum.Font.SourceSansBold
			})
		end
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	pcall(function()
		if not shared.autofarm then
			return error("Autofarm is not enabled!")
		end
		game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-280, 180, 385) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
		game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").RotVelocity = Vector3.new(0, 0, 0)
		game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, 0, 0)
	end)
end)

game:GetService("Players").LocalPlayer.Chatted:connect(function(msg)
	if msg == shared.prefix .."reua" then
		for k in pairs(shared.ua) do
			shared.ua[k] = nil;
		end

		for index, part in pairs(workspace:GetDescendants()) do
			if part:IsA("Part") and part.Anchored == false and part:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) == false then
				table.insert(shared.ua,part)
			end
		end
		  
		for i = 1, #shared.ua do
			shared.ua[i].Parent = workspace
			local BD = Instance.new("BodyPosition") -- body position for the parts
			BD.Parent = shared.ua[i]
			BD.Name = "BD"
		end
	elseif msg == shared.prefix .."tpua" then
		for i = 1, #shared.ua do
			shared.ua[i].BD.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position;
		end
	end
end);