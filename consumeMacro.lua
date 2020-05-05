--addon init
local consumeMacroInit = CreateFrame("FRAME")
consumeMacroInit:RegisterEvent("PLAYER_LOGIN")

local function initConsumeMacro(self)
	if consumeMacroWarning == nil then
		consumeMacroWarning = 1
	end
	print('consumeMacro loaded! enter /cm for details')
end
consumeMacroInit:SetScript("OnEvent", initConsumeMacro)

--chat commands
local function CMCommands(msg, editbox)
	if msg == 'en' then
		consumeMacroWarning = 1
		print('consumeMacro warnings |cFF00FF00ENABLED|r')
	elseif msg == 'dis' then
		consumeMacroWarning = 0
		print('consumeMacro warnings |cFFFF0000DISABLED|r')
	else
		if consumeMacroWarning == 1 then
			print('consumeMacro warnings |cFF00FF00ENABLED|r')
		elseif consumeMacroWarning == 0 then
			print('consumeMacro warnings |cFFFF0000DISABLED|r')
		end
		print('to enable consumeMacro warnings enter /cm en')
		print('to disable consumeMacro warnings enter /cm dis')
	end
end

SLASH_CM1 = "/cm"
SlashCmdList["CM"] = CMCommands

--consumeMacroEvents
local consumeMacroFrame = CreateFrame("FRAME")
consumeMacroFrame:RegisterEvent("BAG_UPDATE_DELAYED")
consumeMacroFrame:RegisterEvent("PLAYER_LOGIN")
consumeMacroFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

--consumeMacroVariables
local healPotionConsume = {
	"Major Healing Potion",
	"Superior Healing Potion",
	"Greater Healing Potion",
	"Healing Potion",
	"Lesser Healing Potion",
	"Minor Healing Potion"
}
local healStoneConsume = {
	"Major Healthstone",
	"Whipper Root Tuber",
	"Greater Healthstone",
	"Healthstone",
	"Lesser Healthstone",
	"Minor Healthstone"
}
local manaPotionConsume = {
	"Major Mana Potion",
	"Superior Mana Potion",
	"Greater Mana Potion",
	"Mana Potion",
	"Lesser Mana Potion",
	"Minor Mana Potion",
}
local manaGemConsume = {
	"Mana Ruby",
	"Mana Citrine",
	"Mana Jade",
	"Mana Agate"
}
local runeConsume = {
	"Demonic Rune",
	"Dark Rune"
}

--globalFunction
local function globalConsumeExecute(consumeMacro, consume)
	  if GetMacroInfo(consumeMacro) then
    for _,item in ipairs(consume) do
      if GetItemCount(item)>0 then
	    SetMacroItem(consumeMacro, item)
        return
      end
    end
	elseif consumeMacroWarning == 1 then
	print ("create the provided |cFFFFFF00"..consumeMacro.."|r macro with the question mark icon !!!")
  end
end

--conjureGem
local function conjureGemConsume(consumeMacro, consume)
	if GetMacroInfo(consumeMacro) then
		if InCombatLockdown() == false then
			for _,item in ipairs(consume) do
				if GetItemCount(item) == 0 then
					EditMacro(consumeMacro, nil, nil, "#showtooltip\n/cast Conjure "..item)
					return
					else
					EditMacro(consumeMacro, nil, nil, "#showtooltip\n/cast Conjure Mana Ruby")
				end
			end
		else
			return
		end
	elseif consumeMacroWarning == 1 then
		print ("create a blank macro named |cFFFFFF00"..consumeMacro.."|r with the question mark icon !!!")
	end
end


--eventExecutes
local function consumeMacroExecute()
	globalConsumeExecute("healPotion", healPotionConsume)
	globalConsumeExecute("healStone", healStoneConsume)
	globalConsumeExecute("manaPotion", manaPotionConsume)
	globalConsumeExecute("manaGem", manaGemConsume)
	globalConsumeExecute("rune", runeConsume)
	conjureGemConsume("conjureGem", manaGemConsume)
end

consumeMacroFrame:SetScript("OnEvent", consumeMacroExecute)
