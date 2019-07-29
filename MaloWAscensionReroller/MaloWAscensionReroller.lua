local MY_NAME = "MaloWAscensionReroller"
local MY_ABBREVIATION = "MAR"

function MaloWUtils_SplitStringOnSpace(s)
	t = {}
	index = 1
	for value in string.gmatch(s, "%S+") do 
		t[index] = string.lower(value)
		index = index + 1
	end
	return t
end

function MaloWUtils_TableLength(t)
	local count = 0
	for _ in pairs(t) do 
		count = count + 1 
	end
	return count
end

-- Frame setup for update
local total = 0
local function mar_update(self, elapsed)
	total = total + elapsed
	if total >= 0.1 then
		total = 0
		mar_onUpdate()
    end
end
local f = CreateFrame("frame", MY_NAME .. "Frame", UIParent)
f:SetPoint("CENTER")
f:SetScript("OnUpdate", mar_update)
f:SetSize(1, 1)
f:Show()

-- Cmds
SlashCmdList[MY_ABBREVIATION .. "COMMAND"] = function(msg)
	local arguments = MaloWUtils_SplitStringOnSpace(msg)
	local command = arguments[1]
	if command == "enable" then
		if MaloWUtils_TableLength(arguments) > 1 and MaloWUtils_TableLength(arguments) ~= 5 then
			mar_print("Bad number of arguments, it should be either 0 or 4.")
			return
		end
		
		if MaloWUtils_TableLength(arguments) == 5 then
			mar_requiredScore = tonumber(arguments[2])
			mar_strongScore = tonumber(arguments[3])
			mar_decentScore = tonumber(arguments[4])
			mar_weakScore = tonumber(arguments[5])
		end
	
		mar_isEnabled = true
		mar_print("Starting to look for:")
		local s = ""
		for _, v in pairs(mar_mustHaveSpells) do
			s = s .. v .. " "
		end
		mar_print("Must haves: " .. s)
		s = ""
		for _, v in pairs(mar_strongSpells) do
			s = s .. v .. " "
		end
		mar_print("Strongs: " .. s)
		s = ""
		for _, v in pairs(mar_decentSpells) do
			s = s .. v .. " "
		end
		mar_print("Decents: " .. s)
		s = ""
		for _, v in pairs(mar_weakSpells) do
			s = s .. v .. " "
		end
		mar_print("Weaks: " .. s)
		if MaloWUtils_TableLength(mar_strongSpells) == 0 and MaloWUtils_TableLength(mar_decentSpells) == 0 and MaloWUtils_TableLength(mar_weakSpells) == 0 then
			mar_print("Scoring-system was automatically disabled due to no Strong/Decent/Weak spells added")
			mar_requiredScore = 0
		else
			mar_print("Requiring a score of " .. tostring(mar_requiredScore) .. ". Scores given for Strong/Decent/Weak spells: " .. tostring(mar_strongScore) .. "/" .. tostring(mar_decentScore) .. "/" .. tostring(mar_weakScore))
		end
		mar_print("I wish you the best of luck! If you find any bugs feel free to open an issue on Github or contact me on Discord // MaloW")
		mar_lastChoiceTime = GetTime() + 3
	elseif command == "disable" then
		mar_reset()
		mar_print("MaloWAscensionReroller was disabled.")
	elseif command == "setdelay" then
		mar_delay = tonumber(arguments[2])
		mar_print("Delay set to " .. tostring(mar_delay))
	elseif command == "printseen" then
		mar_printSeenSpells()
	elseif command == "addmusthave" then
		table.insert(mar_mustHaveSpells, tonumber(arguments[2]))
	elseif command == "addstrong" then
		table.insert(mar_strongSpells, tonumber(arguments[2]))
	elseif command == "adddecent" then
		table.insert(mar_decentSpells, tonumber(arguments[2]))
	elseif command == "addweak" then
		table.insert(mar_weakSpells, tonumber(arguments[2]))
	else
		mar_print("Unrecognized command: " .. command)
	end
end 
SLASH_MARCOMMAND1 = "/" .. MY_ABBREVIATION;

-- Prints message in chatbox
function mar_print(msg)
	ChatFrame1:AddMessage(MY_ABBREVIATION .. ": " .. tostring(msg))
end

function mar_printTable(t)
	mar_print("Key - Value for table:")
	for k, v in pairs(t) do
		mar_print(tostring(k) .. " - " .. tostring(v))
	end
end

-- Events
local hasLoaded = false
function mar_onEvent(self, event, arg1, arg2, arg3, ...)
	if event == "ADDON_LOADED" and arg1 == MY_NAME then
		hasLoaded = true
	end
end
f:RegisterEvent("ADDON_LOADED");
f:SetScript("OnEvent", mar_onEvent);


function mar_reset()
	mar_isEnabled = false
	mar_mustHaveSpells = {}
	mar_strongSpells = {}
	mar_decentSpells = {}
	mar_weakSpells = {}
	mar_requiredScore = 7
	mar_strongScore = 5
	mar_decentScore = 2
	mar_weakScore = 1
	mar_pickedSpells = {}
end


-- Corruption - 172
-- Charge - 100
-- Seal of Righteousness - 21084
-- Healing Wave - 331
-- Bloodrage - 2687
-- Searing Totem - 3599
-- Mark of the Wild - 1126
-- Overpower - 7384
-- Righteous Fury - 25780
-- Raptor Strike - 2973
-- Sinister Strike - 1752
-- Lightning Shield - 324
-- Power Word: Fortitude - 1243
-- Concussive Shot - 5116
-- Swipe (Bear) - 779
-- Fireball - 133
-- Arcane Intellect - 1459
-- Backstab - 53
-- Blessing of Wisdom - 19742
-- Defensive Stance - 71
-- Thunder Clap - 6343
-- Curse of Weakness - 702
-- Devotion Aura - 465
-- Life Tap - 1454
-- Wrath - 5176
-- Rejuvenation - 774
-- Thorns - 467
-- Summon Imp - 688
-- Aspect of the Hawk - 13165
-- Stoneskin Totem - 8071
-- Fade - 586
-- Demoralizing Roar - 99
-- Demon Skin - 687
-- Shield Bash - 72
-- Maul - 6807
-- Evasion - 5277
-- Divine Protection - 498
-- Smite - 585
-- Heroic Strike - 78
-- Victory Rush - 34428
-- Healing Touch - 5185
-- Earth Shock - 8042
-- Sprint - 2983
-- Shield Block - 2565
-- Stoneclaw Totem - 5730
-- Renew - 139
-- Auto Shot - 965202
-- Frostbolt - 116
-- Battle Shout - 6673
-- Arcane Shot - 3044
-- Growl - 6795
-- Shadow Word: Pain - 589
-- Immolate - 348
-- Serpent Sting - 1978
-- Hunter's Mark - 1130
-- Battle Stance - 2457
-- Rend - 772
-- Lightning Bolt - 403
-- Hamstring - 1715
-- Pick Pocket - 921
-- Frost Armor - 168
-- Blessing of Might - 19740
-- Gouge - 1776
-- Arcane Missiles - 5143
-- Moonfire - 8921
-- Shadow Bolt - 686
-- Holy Light - 635
-- Tame Beast - 965200
-- Aspect of the Monkey - 13163
-- Stealth - 1784
-- Fire Blast - 2136
-- Bear Form - 5487
-- Mongoose Bite - 1495
-- Curse of Agony - 980
-- Eviscerate - 2098
-- Taunt - 355


mar_mustHaveSpells = {}
mar_strongSpells = {}
mar_decentSpells = {}
mar_weakSpells = {}


-- table.insert(mar_mustHaveSpells, 1454) -- Life Tap
-- table.insert(mar_strongSpells, 331) -- Healing Wave
-- table.insert(mar_decentSpells, 139) -- Renew
-- table.insert(mar_decentSpells, 100) -- Charge
-- table.insert(mar_decentSpells, 774) -- Rejuvenation
-- table.insert(mar_decentSpells, 5277) -- Evasion
-- table.insert(mar_decentSpells, 498) -- Divine Protection
-- table.insert(mar_decentSpells, 585) -- Smite
-- table.insert(mar_decentSpells, 2983) -- Sprint
-- table.insert(mar_decentSpells, 116) -- Frostbolt
-- table.insert(mar_decentSpells, 168) -- Frost Armor
-- table.insert(mar_decentSpells, 5143) -- Arcane Missiles
-- table.insert(mar_decentSpells, 635) -- Holy Light
-- table.insert(mar_decentSpells, 1784) -- Stealth

mar_delay = 0.5
mar_requiredScore = 7
mar_strongScore = 5
mar_decentScore = 2
mar_weakScore = 1


mar_pickedSpells = {}
mar_lastChoiceTime = 0
mar_firstFailedCardTime = 0
mar_isEnabled = false
mar_cardShowTimeout = 2

mar_seenSpells = {}

-- OnUpdate
function mar_onUpdate()
	if not mar_isEnabled then
		return 
	end
	if mar_lastChoiceTime + mar_delay > GetTime() then
		return
	end
	mar_lastChoiceTime = GetTime()
	
	if MaloWUtils_TableLength(mar_pickedSpells) > 3 then
		local score = 0
		for _, mustHaveSpell in pairs(mar_mustHaveSpells) do 
			local found = false
			for pickedSpell, _ in pairs(mar_pickedSpells) do 
				if pickedSpell == mustHaveSpell then
					found = true
				end
			end
			if not found then
				mar_print("Didn't find must-have: " .. tostring(mustHaveSpell) .. ", rerolling")
				mar_reroll()
				return
			end
		end
		for _, strongSpell in pairs(mar_strongSpells) do 
			for pickedSpell, _ in pairs(mar_pickedSpells) do 
				if pickedSpell == strongSpell then
					score = score + mar_strongScore
				end
			end
		end
		for _, decentSpell in pairs(mar_decentSpells) do 
			for pickedSpell, _ in pairs(mar_pickedSpells) do 
				if pickedSpell == decentSpell then
					score = score + mar_decentScore
				end
			end
		end
		for _, weakSpell in pairs(mar_weakSpells) do 
			for pickedSpell, _ in pairs(mar_pickedSpells) do 
				if pickedSpell == weakSpell then
					score = score + mar_weakScore
				end
			end
		end
		if score < mar_requiredScore then
			mar_print("Got a score of " .. tostring(score) .. ", rerolling")
			mar_reroll()
			return
		else
			mar_print("Finished! All must-have spells were found, and a score of " .. tostring(score) .. " was reached.")
			mar_reset()
			mar_isEnabled = false
			return
		end
	end
	
	if not Card1:IsVisible() then
		if mar_firstFailedCardTime == 0 then
			mar_firstFailedCardTime = GetTime()
		else
			if mar_firstFailedCardTime + mar_cardShowTimeout < GetTime() then
				mar_firstFailedCardTime = 0
				mar_print("Timed out with cards not being visible, pickedSpell's size: " .. tostring(MaloWUtils_TableLength(mar_pickedSpells)))
				mar_reroll()
				return
			end
		end
		return
	end
	mar_firstFailedCardTime = 0
	
	local availableSpells = mar_getCardSpells()
	if MaloWUtils_TableLength(availableSpells) == 0 then
		return
	end
	
	for cardId, rolledSpell in pairs(availableSpells) do 
		for pickedSpell, _ in pairs(mar_pickedSpells) do 
			if pickedSpell == rolledSpell then
				_G["Card" .. tostring(cardId) .. "LearnSpellButton"]:Click()
				return
			end
		end
	end
	
	for cardId, rolledSpell in pairs(availableSpells) do 
		for _, mustHaveSpell in pairs(mar_mustHaveSpells) do 
			if rolledSpell == mustHaveSpell then
				if mar_pickedSpells[rolledSpell] ~= nil then
					return
				end
				mar_print("Found must-have, Picking " .. tostring(rolledSpell))
				mar_pickedSpells[rolledSpell] = true
				_G["Card" .. tostring(cardId) .. "LearnSpellButton"]:Click()
				return
			end
		end
		for _, strongSpell in pairs(mar_strongSpells) do 
			if rolledSpell == strongSpell then
				if mar_pickedSpells[rolledSpell] ~= nil then
					return
				end
				mar_print("Found strong, Picking " .. tostring(rolledSpell))
				mar_pickedSpells[rolledSpell] = true
				_G["Card" .. tostring(cardId) .. "LearnSpellButton"]:Click()
				return
			end
		end
		for _, decentSpell in pairs(mar_decentSpells) do 
			if rolledSpell == decentSpell then
				if mar_pickedSpells[rolledSpell] ~= nil then
					return
				end
				mar_print("Found decent, Picking " .. tostring(rolledSpell))
				mar_pickedSpells[rolledSpell] = true
				_G["Card" .. tostring(cardId) .. "LearnSpellButton"]:Click()
				return
			end
		end
		for _, weakSpell in pairs(mar_weakSpells) do 
			if rolledSpell == weakSpell then
				if mar_pickedSpells[rolledSpell] ~= nil then
					return
				end
				mar_print("Found weak, Picking " .. tostring(rolledSpell))
				mar_pickedSpells[rolledSpell] = true
				_G["Card" .. tostring(cardId) .. "LearnSpellButton"]:Click()
				return
			end
		end
	end
	
	if mar_pickedSpells[availableSpells[1]] ~= nil then
		return
	end
	mar_print("Everything was shit, picking left-most: " .. tostring(availableSpells[1]))
	mar_pickedSpells[availableSpells[1]] = true
	Card1LearnSpellButton:Click()
end

function mar_getCardSpells()
	local spells = {}
	if Card1 == nil then
		return spells
	end
	spells[1] = tonumber(Card1.SpellFrame.Icon.Spell)
	spells[2] = tonumber(Card2.SpellFrame.Icon.Spell)
	spells[3] = tonumber(Card3.SpellFrame.Icon.Spell)
	
	local name = GetSpellInfo(Card1.SpellFrame.Icon.Spell)
	mar_seenSpells[name] = Card1.SpellFrame.Icon.Spell
	name = GetSpellInfo(Card2.SpellFrame.Icon.Spell)
	mar_seenSpells[name] = Card2.SpellFrame.Icon.Spell
	name = GetSpellInfo(Card3.SpellFrame.Icon.Spell)
	mar_seenSpells[name] = Card3.SpellFrame.Icon.Spell
	
	return spells
end

function mar_reroll()
	StaticPopup1Button1:Click();
	mar_pickedSpells = {}
end

function mar_printSeenSpells()
	local s = ""
	for k, v in pairs(mar_seenSpells) do
		s = s .. "-- " .. tostring(k) .. " - " .. tostring(v) .. "#"
	end
	ChatFrame1:AddMessage(s)
end





