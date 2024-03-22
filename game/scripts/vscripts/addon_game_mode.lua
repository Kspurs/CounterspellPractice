-- Generated from template

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({chosen_ability=nil})
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
	local hero_position=hero:GetAbsOrigin()
	local mana_break=hero:FindAbilityByName("antimage_mana_break")
	local spell_shield=hero:GetAbilityByIndex(2)
	local blink=hero:FindAbilityByName("antimage_blink")
	spell_shield:SetLevel(1)
	print(hero_position)
	
	
		
	
end
function OnRandomInterval(args)
	local hero=Entities:FindByName(nil,"npc_dota_hero_antimage")
	args:CastAbilityOnTarget(hero, args:FindAbilityByName("lion_impale"), -1)
	
end
function CAddonTemplateGameMode:OnPlayerChosenAbility(args)
	print(args.abilityname)
	print(args.heroname)
	local hero=Entities:FindByName(nil,"npc_dota_hero_antimage")
	local enermy_spawn_position=hero:GetForwardVector()*400+hero:GetAbsOrigin()
	local enermy=CreateUnitByName("npc_dota_hero_"..args.heroname, enermy_spawn_position, false, nil, nil, 3)
	local ability=enermy:FindAbilityByName(args.abilityname)
	ability:SetLevel(1)
	local random_time=math.random(1,10)
	enermy:SetThink("OnRandomInterval",self,random_time)
end
function CAddonTemplateGameMode:InitGameMode()
	print( "Template addon is loaded." )
	local GameMode = GameRules:GetGameModeEntity()
	GameRules:EnableCustomGameSetupAutoLaunch(true)
	GameRules:SetCustomGameSetupAutoLaunchDelay(0)
	GameMode:SetCustomGameForceHero("antimage")
	ListenToGameEvent("dota_on_hero_finish_spawn", Dynamic_Wrap(self,"OnPlayerSpawned"),self)
	CustomGameEventManager:RegisterListener("OnPlayerChosenAbility", Dynamic_Wrap(self, "OnPlayerChosenAbility"))
	ListenToGameEvent("OnPlayerChosenAbility",Dynamic_Wrap(self,"OnPlayerChosenAbility"),self)
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