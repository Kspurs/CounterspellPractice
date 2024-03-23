$.Msg("hello")
const available_abilities=[{heroname:'lion',abilityname:"lion_impale"},{heroname:'doom_bringer',abilityname:"doom_bringer_doom"}]
available_abilities.forEach((value)=>{
    $.Msg(value.abilityname)
})
function OnUseImpale(){
    $.Msg("use spike")
    GameEvents.SendCustomGameEventToServer("OnPlayerChosenAbility",{abilityname:"lion_impale",heroname:"lion"})
}