-- Generated from template

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	CAddonTemplateGameMode:InitGameMode()
end
function CAddonTemplateGameMode:OnPlayerSpawned(args)
	print(args.heroindex)
	print(args.hero)
	print(EntIndexToHScript(args.heroindex)==nil)
	local hero=EntIndexToHScript(args.heroindex)
	local hero_position=hero:GetCenter()
	print(hero_position)
	local hero_lion=CreateUnitByName("npc_dota_hero_lion", Vector(-1000,-1350,164), false, nil, nil, 3)
	local spike=hero_lion:FindAbilityByName("lion_impale")
	hero_lion:UpgradeAbility(spike)
	print(spike:GetLevel())
	print("upgrade")
	hero_lion:CastAbilityOnPosition(hero_position, spike, -1)

end
function CAddonTemplateGameMode:InitGameMode()
	print( "Template addon is loaded." )
	local GameMode = GameRules:GetGameModeEntity()
	GameRules:EnableCustomGameSetupAutoLaunch(true)
	GameRules:SetCustomGameSetupAutoLaunchDelay(0)
	GameMode:SetCustomGameForceHero("antimage")
	ListenToGameEvent("dota_on_hero_finish_spawn", Dynamic_Wrap(self,"OnPlayerSpawned"),self)
end

-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end