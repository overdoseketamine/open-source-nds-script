--[[
Open Source NDS Script
Original by shawnjbragdon#0001
Modified by elementemerald#4175

https://www.roblox.com/games/189707/Natural-Disaster-Survival
]]

local uis = game:GetService("UserInputService");
local plr = game:GetService("Players").LocalPlayer;
local mouse = plr:GetMouse();

if shared.partcontrol == true then

shared.ua = {};
	
game:GetService('RunService').Stepped:Connect(function()
   pcall(function()
      sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 1000);
      for i = 1, #shared.ua do
	  shared.ua[i].Velocity = Vector3.new(30, 0, 0);
      end;
   end);
end);

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
	BD.MaxForce = Vector3.new(math.huge, math.huge, math.huge); -- faster parts i think?
end
end

game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
	Text = "{System} Getting things ready, please wait...",
	Color = Color3.fromRGB(255, 235, 85),
	Font = Enum.Font.SourceSansBold
})

game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
	Text = "{System} This is the dev build of the NDS Script. If you want a stable build, please switch over to the main build. You may or may not experience bugs and/or crashes.",
	Color = Color3.fromRGB(0, 102, 255),
	Font = Enum.Font.SourceSansBold
});

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

game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
	--[[if typeof(Recipient) == "Instance" and table.find({"autofarm","notifychanges","broadcastdisaster"}) then
		return
	end
	local commands = {
		["autofarm/"] = function(value)
			local boolean = (string.sub(value,1,4) == "true" and true) or (string.sub(value,1,5) == "false" and false);
			shared.autofarm = boolean;
		end,
		["notifychange/"] = function(value)
			local boolean = (string.sub(value,1,4) == "true" and true) or (string.sub(value,1,5) == "false" and false);
			shared.notifyChanges = boolean;
		end,
		["broadcastdisaster/"] = function(value)
			local boolean = (string.sub(value,1,4) == "true" and true) or (string.sub(value,1,5) == "false" and false);
			shared.broadcastDisaster = boolean;
		end,
		["partcontrol/"] = function(value)
			local boolean = (string.sub(value,1,4) == "true" and true) or (string.sub(value,1,5) == "false" and false);
			shared.partcontrol = boolean;
		end,
		["debug/"] = function(value)
			local boolean = (string.sub(value,1,4) == "true" and true) or (string.sub(value,1,5) == "false" and false);
			shared.debug = boolean;
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
	end]]
	--game:GetService("Players").LocalPlayer.Chatted:connect(function(msg)
	local cmds = {
			{
				["name"] = "help",
				["desc"] = "Displays this message.",
				["enabled"] = true
			},
			{
				["name"] = "reua",
				["desc"] = "Refreshes unanchored parts.",
				["enabled"] = shared.partcontrol
			},
			{
				["name"] = "tpuauser",
				["desc"] = "Teleports all of the unanchored parts to the local player.",
				["enabled"] = shared.partcontrol
			},
			{
				["name"] = "getvotes",
				["desc"] = "Get votes for next map.",
				["enabled"] = true
			}
		};

		if msg == shared.prefix .."help" then
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text = "{System} Available commands:",
				Color = Color3.fromRGB(255, 235, 85),
				Font = Enum.Font.SourceSansBold
			});

			for i = 1, #cmds do
				game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
					Text = string.format("{System} %s - %s || IsEnabled: %s", cmds[i].name, cmds[i].desc, tostring(cmds[i].enabled)),
					Color = Color3.fromRGB(255, 235, 85),
					Font = Enum.Font.SourceSansBold
				});
			end
		elseif msg == shared.prefix .."reua" then
			if shared.partcontrol == true then
			for k in pairs(shared.ua) do
				--shared.ua[k]:Destroy();
				shared.ua[k] = nil;
			end
	
			for index, part in pairs(workspace:GetDescendants()) do
				if part:IsA("Part") and part.Anchored == false and part:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) == false then
					table.insert(shared.ua,part)
				end
			end
			  
			for i = 1, #shared.ua do
				shared.ua[i].Parent = workspace
				local BD = Instance.new("BodyPosition")
				BD.Parent = shared.ua[i]
				BD.Name = "BD"
			end
			end
			
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text = "{System} Successfully refreshed the unanchored parts.",
				Color = Color3.fromRGB(255, 235, 85),
				Font = Enum.Font.SourceSansBold
			});
		elseif msg == shared.prefix .."tpuauser" then
			if shared.partcontrol == true then
			for i = 1, #shared.ua do
				shared.ua[i].BD.Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position;
			end
			end

			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text = "{System} The unanchored parts are now teleporting to your location.",
				Color = Color3.fromRGB(255, 235, 85),
				Font = Enum.Font.SourceSansBold
			});
		elseif msg == shared.prefix .."getvotes" then
			local s,e = pcall(function()
				local map1 = game:GetService("ReplicatedStorage").MapVotes.Choice1;
				local map2 = game:GetService("ReplicatedStorage").MapVotes.Choice2;
				local map3 = game:GetService("ReplicatedStorage").MapVotes.Choice3;
	
				game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
					Text = string.format("{System} Votes for maps - %s: %d, %s: %d, %s: %d", map1.Value, #map1:GetChildren(), map2.Value, #map2:GetChildren(), map3.Value, #map3:GetChildren()),
					Color = Color3.fromRGB(255, 235, 85),
					Font = Enum.Font.SourceSansBold
				});
			end);
			if not s then
				if shared.debug == true then
					game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
						Text = string.format("{System} An error occured while getting votes for maps. | Debug: %s", e),
						Color = Color3.fromRGB(255, 85, 85),
						Font = Enum.Font.SourceSansBold
					});
				else
					game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
						Text = "{System} An error occured while getting votes for maps.",
						Color = Color3.fromRGB(255, 85, 85),
						Font = Enum.Font.SourceSansBold
					});
				end
			end;
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
	pcall(function()
		if game:GetService("Players").LocalPlayer:FindFirstChildWhichIsA("PlayerGui"):FindFirstChild("SandStormGui") then
		    game:GetService("Players").LocalPlayer:FindFirstChildWhichIsA("PlayerGui")["SandStormGui"].Enabled = false
		end
		if game:GetService("Players").LocalPlayer:FindFirstChildWhichIsA("PlayerGui"):FindFirstChild("BlizzardGui") then
		    game:GetService("Players").LocalPlayer:FindFirstChildWhichIsA("PlayerGui")["BlizzardGui"].Enabled = false
		end
		game:GetService("Lighting").FogColor = Color3.fromRGB(255, 255, 255)
		game:GetService("Lighting").FogEnd = 1e4
		game:GetService("Lighting").FogStart = game:GetService("Lighting").FogEnd - 1
		pcall(function() workspace.Structure.Cloud:Destroy() end)
    	end)
end)

uis.InputBegan:connect(function(key, gameprocessed)
	if key.UserInputType == Enum.UserInputType.MouseButton1 and shared.tppartkey and uis:IsKeyDown(shared.tppartkey) then
		if shared.partcontrol == true then
		local vect = Vector3.new(mouse.Hit.p);
		print(vect);
		for i = 1, #shared.ua do
			shared.ua[i].BD.Position = vect;
		end
		end
	elseif key.UserInputType == Enum.UserInputType.Keyboard then
	if key.KeyCode == Enum.KeyCode.LeftControl then
		local s,e = pcall(function()
			SurvivalTag = game:GetService("Players").LocalPlayer.Character["SurvivalTag"];
			if tostring(SurvivalTag.Value) == "Sandstorm" then
				if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SandStormGui") ~= nil then
					game:GetService("Players").LocalPlayer.PlayerGui["SandStormGui"]:Destroy();
				end
			end
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text = string.format("{System | InputBegan} The disaster tag is currently %s", tostring(SurvivalTag.Value)),
				Color = Color3.fromRGB(255, 235, 85),
				Font = Enum.Font.SourceSansBold
			});
		end);
		if not s then
			if shared.debug == true then
				game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
					Text = string.format("{System | InputBegan} There is no disaster at the moment, you have joined during a disaster or another error occurred. | Debug: %s", e),
					Color = Color3.fromRGB(255, 85, 85),
					Font = Enum.Font.SourceSansBold
				});
			else
				game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
					Text = "{System | InputBegan} There is no disaster at the moment or you have joined during a disaster.",
					Color = Color3.fromRGB(255, 85, 85),
					Font = Enum.Font.SourceSansBold
				});
			end
		end
	end;
	end;
end);
