local Players = game:GetService("Players")

local function createGui(player)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AdminPanel"
    screenGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 150)
    frame.Position = UDim2.new(0, 20, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.Parent = screenGui

    local function createButton(text, posY)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.Position = UDim2.new(0, 0, 0, posY)
        btn.Text = text
        btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Parent = frame
        return btn
    end

    local flyBtn = createButton("Fly", 0)
    local speedBtn = createButton("Speed", 50)
    local flingBtn = createButton("Fling", 100)

    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- LOCAL SCRIPT
    local localScript = Instance.new("LocalScript")
    localScript.Parent = screenGui

    localScript.Source = [[
        local player = game.Players.LocalPlayer

        local function getChar()
            return player.Character or player.CharacterAdded:Wait()
        end

        local frame = script.Parent.Frame

        -- FLY
        frame.Fly.MouseButton1Click:Connect(function()
            local char = getChar()
            local root = char:FindFirstChild("HumanoidRootPart")

            if root then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0,50,0)
                bv.MaxForce = Vector3.new(0,math.huge,0)
                bv.Parent = root

                task.wait(3)
                bv:Destroy()
            end
        end)

        -- SPEED
        frame.Speed.MouseButton1Click:Connect(function()
            local char = getChar()
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = 50
            end
        end)

        -- FLING
        frame.Fling.MouseButton1Click:Connect(function()
            local char = getChar()
            local root = char:FindFirstChild("HumanoidRootPart")

            if root then
                local bav = Instance.new("BodyAngularVelocity")
                bav.AngularVelocity = Vector3.new(0,9999,0)
                bav.MaxTorque = Vector3.new(0,math.huge,0)
                bav.Parent = root

                task.wait(2)
                bav:Destroy()
            end
        end)
    ]]
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Wait()
    createGui(player)
end)
