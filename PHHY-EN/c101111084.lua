--Japanese name
--Xyz Align
--scripted by Naim
local s,id=GetID()
function s.initial_effect(c)
	--Change levels of 2 targets to a declared level
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.cfilter(c,e)
	return c:IsFaceup() and c:HasLevel() and c:IsCanBeEffectTarget(e)
end
function s.rescon(lvltable)
	return function (sg,e,tp,mg)
		return sg:IsExists(Card.IsControler,1,nil,tp) and not sg:IsExists(s.checklevels,1,nil,lvltable)
	end
end
function s.rescon2(lv)
	return function (sg,e,tp,mg)
		return sg:IsExists(Card.IsControler,1,nil,tp) and not sg:IsExists(Card.IsLevel,1,nil,lv)
	end
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	local lvltable=s.GetDeclarableLevels(g)
	if chk==0 then return #g>=2 and aux.SelectUnselectGroup(g,e,tp,2,2,s.rescon(lvltable),0) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_LVRANK)
	local lv=Duel.AnnounceNumber(tp,table.unpack(lvltable))
	local sg=aux.SelectUnselectGroup(g,e,tp,2,2,s.rescon2(lv),1,tp,HINTMSG_TARGET)
	Duel.SetTargetCard(sg)
	e:SetLabel(lv,sg:GetFirst():GetRace(),sg:GetNext():GetRace())
	Duel.SetOperationInfo(0,CATEGORY_LVCHANGE,sg,#sg,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local lv,race1,race2=e:GetLabel()
	local c=e:GetHandler()
	--Cannot Special Summon from the Extra Deck, except monster with the same type as the targets
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(id,1))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetTargetRange(1,0)
		e1:SetTarget(function (e,c) return c:IsLocation(LOCATION_EXTRA) and not c:IsRace(race1|race2) end)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
	local g=Duel.GetTargetCards(e)
	if #g==0 then return end
	for tc in g:Iter() do
		--Change level to the declared level
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function s.GetDeclarableLevels(g)
	local res={}
	for i=1,12 do
		res[i] = i
	end
	local levels=g:GetClass(Card.GetLevel)
	local n_mon=#g
	local n_levels=#levels
	if n_levels==1 then --If all monsters have the same level, remove that level
		table.remove(res,levels[#levels])
		return res
	elseif (n_mon==2 and n_levels==2) then--If 2 monsters with different levels, remove those levels
		table.sort(levels)
		for i=2,1,-1 do
			table.remove(res,levels[i])
		end
	else
		return res
	end
end
function s.checklevels(c,t)
	for _,level in ipairs(t) do
		if c:GetLevel()==level then return true end
	end
	return false
end