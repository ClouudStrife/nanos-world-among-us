range = 500

function distance( x1, y1, x2, y2 )
	return math.sqrt( (x2-x1)^2 + (y2-y1)^2 )
end

function isAtRange(dist)
    return dist < range
end

function impostorActionKill()
    local localPlayer
    local minDist = math.huge
    local characterToKill

    for k, character in pairs(Character.GetAll()) do
		local player = character:GetPlayer()

        if(player ~= nil and player:IsLocalPlayer()) then
            localPlayer = character
        end
	end

    for k, character in pairs(Character.GetAll()) do
		local player = character:GetPlayer()
        if(player ~= nil and not player:IsLocalPlayer()) then
          local dist = distance(localPlayer:GetLocation().X, localPlayer:GetLocation().Y, character:GetLocation().X, character:GetLocation().Y)
          if(dist < minDist and isAtRange(dist)) then
            minDist = dist
            characterToKill = character
            end
        end
	end

    if(characterToKill ~= nil) then
        Events.CallRemote("Kill", characterToKill)
    end
end

Client.Subscribe("KeyPress", function(key_name)
    if(key_name == "K") then
        impostorActionKill()
    end
end)