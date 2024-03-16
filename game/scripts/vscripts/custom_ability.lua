custom_ability = class({})
function custom_ability:OnSpellStart()
    local caster = self:GetCaster()
    local point=self:GetCursorPosition()
    FindClearSpaceForUnit(caster, point, true)
end