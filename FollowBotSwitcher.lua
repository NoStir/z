local function CreateMove()
    local players = entities.FindByClass("CTFPlayer")
    local followBotMode = "all players" -- Default follow bot mode
    local localPlayer = entities.GetLocalPlayer()

    if localPlayer then
        local localPlayerPos = localPlayer:GetAbsOrigin()
        local activationDistance = gui.GetValue("activation distance")

        for _, player in ipairs(players) do -- Use ipairs instead of pairs for array iteration
            if player ~= localPlayer and player:GetTeamNumber() == localPlayer:GetTeamNumber() then -- Exclude local player and ensure same team
                local playerPos = player:GetAbsOrigin()
                local distance = vector.Distance(localPlayerPos, playerPos)

                if playerlist.GetPriority(player) == -1 and player:IsAlive() and distance <= activationDistance then
                    followBotMode = "friends only" 
                    break -- Exit loop early since condition is met
                end
            end
        end
    end

    gui.SetValue("follow bot", followBotMode) -- Set the GUI value outside the loop
end

callbacks.Register("CreateMove", "Followbot-Switcher", CreateMove)
