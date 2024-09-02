local Terror_Module = {}

function Terror_Module.GetBall()
    for Index, Value in next, workspace.Balls:GetChildren() do
        if Value:GetAttribute("realBall") then
            return true
        end
    end
    return false
end

function Terror_Module.GetPlayersScreenPositions()
    local Positions = {}
    local Camera = workspace.CurrentCamera
    for Index, Player in workspace.Alive:GetChildren() do
        local humanoidRootPart = Player:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            Positions[Player.Name] = Camera:WorldToScreenPoint(humanoidRootPart.Position)
        end
    end
    return Positions
end

function Terror_Module.Parry()
    local cf = workspace.CurrentCamera.CFrame
    local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cf:GetComponents()

    local args = {
        [1] = 0,
        [2] = CFrame.new(x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22),
        [3] = Terror_Module.GetPlayersScreenPositions(),
        [4] = {
            [1] = workspace.CurrentCamera.ViewportSize.X / 2,
            [2] = workspace.CurrentCamera.ViewportSize.Y / 2
        },
        [5] = false
    }

    local event = game:GetService("SocialService"):WaitForChild("\n")

    if event then
        event:FireServer(unpack(args))
    end
end

return Terror_Module
