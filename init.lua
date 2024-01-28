local settings = {
    enabled = true,
    Speed = {
        A = {enabled = true},
        B = {enabled = true},
    },
    Flight = {
        A = {enabled = true},
    },
    InvalidPosition = {
        A = {enabled = true, YPos = 250},
    },
    InvalidState = {
        A = {enabled = true},
        B = {enabled = true},
    },
    Improbable = {
        A = {enabled = true},
    }
}

game.Players.PlayerAdded:Connect(function(plr)
    local vls = 0

    plr.CharacterAdded:Connect(function(char)
        function isInAir() return char.Humanoid.FloorMaterial == Enum.Material.Air; end

        local lastpos = char.PrimaryPart.Position
        local airTick = 0

        task.spawn(function()
            repeat
                lastpos = char.PrimaryPart.Position
                task.wait(1)
            until false
        end)

        task.spawn(function()
            repeat
                if (isInAir()) then airTick += 1; else airTick = 0; end
                task.wait()
            until false
        end)

        local flagplayer = function(reason)
            if (isInAir()) then char.PrimaryPart.CFrame -= Vector3.new(0, 10, 0); char.PrimaryPart.Velocity = Vector3.new(0,0,0); else char.PrimaryPart.Velocity = Vector3.new(0,0,0); end
            vls += 1
        end

        -- Speed A
        task.spawn(function()
            repeat
                if (settings.Speed.A.enabled == true and char.Humanoid.WalkSpeed => 24) then
                    flagplayer("Speed A")
                end
                task.wait()
            until false
        end)

        -- Speed B
        task.spawn(function()
            repeat
                if (settings.Speed.B.enabled == true and (lastpos - char.PrimaryPart.Position).Magnitude > 1) then
                    flagplayer("Speed B")
                end
                task.wait()
            until false
        end)

        -- Flight A
        task.spawn(function()
            repeat
                if (settings.Flight.A.enabled == true and airTick > 130 char.PrimaryPart.Velocity.Y > -3) then
                    flagplayer("Flight A")
                end
                task.wait()
            until false
        end)

        -- Invalid Position A
        task.spawn(function()
            repeat
                if (settings.InvalidPosition.A.enabled == true and char.PrimaryPart.Position.Y > settings.InvalidPosition.A.YPos) then
                    flagplayer("Invalid Position A (Y Position)")
                end
                task.wait()
            until false
        end)

        -- Invalid State A
        task.spawn(function()
            repeat
                if (settings.InvalidState.A.enabled == true and char.Humanoid.getState() == Enum.HumanoidStateType.RunningNoPhysics) then
                    flagplayer("Invalid State A")
                end
                task.wait()
            until false
        end)

        -- Invalid State B
        task.spawn(function()
            repeat
                if (settings.InvalidState.B.enabled == true and char.Humanoid.getState() == Enum.HumanoidStateType.StrafingNoPhysics) then
                    flagplayer("Invalid State B")
                end
                task.wait()
            until false
        end)

        -- Improbable A
        task.spawn(function()
            repeat
                if (settings.Improbable.A.enabled == true and vls > 50) then
                    plr:Kick("Improbable A \n You have been banned by Rekt-Anticheat. \n If you feel as if this was a mistake, please contact ...")
                end
                task.wait()
            until false
        end)
    end)
end)
