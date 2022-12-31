-- Function to spawn a Character to a player
function SpawnCharacter(player)
    -- Spawns a Character at position 0, 0, 0 with default's constructor parameters
    local new_character = Character(Vector(0, 0, 0), Rotator(0, 0, 0), "nanos-world::SK_Male")

    -- Possess the new Character
    player:Possess(new_character)


end

function Kill(player, character)
    character:SetHealth(0)
end
-- Subscribes to an Event which is triggered when Players join the server (i.e. Spawn)
Player.Subscribe("Spawn", SpawnCharacter)

-- Iterates for all already connected players and give them a Character as well
-- This will make sure you also get a Character when you reload the package
Package.Subscribe("Load", function()
	for k, player in pairs(Player.GetAll()) do
		SpawnCharacter(player)
	end
end)

Events.SubscribeRemote("Kill", Kill)


Character.Subscribe("Death", function(self, last_damage_taken, last_bone_damaged, damage_type_reason, hit_from_direction, instigator, causer)
    local player = self:GetPlayer()
    player:UnPossess()
    Timer.SetTimeout(function()
        SpawnCharacter(player)
    end, 5000)
end)