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
		mar_isEnabled = false
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


mar_mustHaveSpells = {}
mar_strongSpells = {}
mar_decentSpells = {}
mar_weakSpells = {}

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
mar_finished = false
mar_pickRandomly = false
mar_shouldReroll = false

mar_seenSpells = {}
mar_seenSpells[1] = {}
mar_seenSpells[2] = {}
mar_seenSpells[3] = {}
mar_seenSpells[4] = {}

-- OnUpdate
function mar_onUpdate()
	if not mar_isEnabled then
		return 
	end
	if mar_lastChoiceTime + mar_delay > GetTime() then
		return
	end
	mar_lastChoiceTime = GetTime()
	
	if mar_shouldReroll then
		mar_reroll()
		return
	end
	
	if mar_finished then -- After finishing do 1 iteration of trying to take the spells again to prevent leaving the last roll un-picked.
		mar_isEnabled = false
		mar_finished = false
		local availableSpells = mar_getCardSpells()
		if MaloWUtils_TableLength(availableSpells) ~= 0 then
			for cardId, rolledSpell in pairs(availableSpells) do 
				for pickedSpell, _ in pairs(mar_pickedSpells) do 
					if pickedSpell == rolledSpell then
						_G["Card" .. tostring(cardId) .. "LearnSpellButton"]:Click()
						return
					end
				end
			end
		end
		return
	end
	
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
			mar_finished = true
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
	
	mar_recordStatistics(availableSpells)
	
	if mar_pickRandomly then
		local index = math.random(3)
		mar_print("Random-pick mode is enabled, picking #" .. tostring(index))
		mar_pickSpell(availableSpells[index])
		_G["Card" .. tostring(index) .. "LearnSpellButton"]:Click()
		return
	end
	
	for cardId, rolledSpell in pairs(availableSpells) do 
		for _, mustHaveSpell in pairs(mar_mustHaveSpells) do 
			if rolledSpell == mustHaveSpell then
				if mar_pickedSpells[rolledSpell] ~= nil then
					return
				end
				mar_print("Found must-have, Picking " .. tostring(rolledSpell))
				mar_pickSpell(rolledSpell)
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
				mar_pickSpell(rolledSpell)
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
				mar_pickSpell(rolledSpell)
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
				mar_pickSpell(rolledSpell)
				_G["Card" .. tostring(cardId) .. "LearnSpellButton"]:Click()
				return
			end
		end
	end
	
	if mar_pickedSpells[availableSpells[1]] ~= nil then
		return
	end
	mar_print("Everything was shit, picking left-most: " .. tostring(availableSpells[1]))
	mar_pickSpell(availableSpells[1])
	Card1LearnSpellButton:Click()
end

function mar_pickSpell(spellId)
	mar_pickedSpells[spellId] = true
	if spellId == 965200 then -- Add two fake-spells to make Tame Beast take up 3 slots
		mar_pickedSpells[-1] = true
		mar_pickedSpells[-2] = true
	end
end

function mar_getCardSpells()
	local spells = {}
	if Card1 == nil then
		return spells
	end
	spells[1] = tonumber(Card1.SpellFrame.Icon.Spell)
	spells[2] = tonumber(Card2.SpellFrame.Icon.Spell)
	spells[3] = tonumber(Card3.SpellFrame.Icon.Spell)
	
	return spells
end

function mar_recordStatistics(spells)
	for k, spell in pairs(spells) do
		local index = MaloWUtils_TableLength(mar_pickedSpells) + 1
		local name = GetSpellInfo(spell)
		-- mar_print("Recording statistics for #" .. tostring(index) .. ": " .. name .. " (" .. tostring(spell) .. ")")
		if mar_seenSpells[index][spell] == nil then
			mar_seenSpells[index][spell] = {}
			mar_seenSpells[index][spell].count = 0
			mar_seenSpells[index][spell].name = name
		end
		mar_seenSpells[index][spell].count = mar_seenSpells[index][spell].count + 1
	end
end

function mar_reroll()
	if StaticPopup1Button1:IsVisible() then
		Card1:Hide()
		Card2:Hide()
		Card3:Hide()
		StaticPopup1Button1:Click()
		mar_pickedSpells = {}
		mar_shouldReroll = false
	else
		mar_shouldReroll = true
	end
end

function mar_printSeenSpells()
	local s = ""
	for k, v in pairs(mar_seenSpells) do
		s = s .. "-- " .. tostring(k) .. " - " .. tostring(v) .. "#"
	end
	ChatFrame1:AddMessage(s)
end

function mar_printStatisticsInCopyBox()
	local fe = CreateFrame("EditBox", "MAR_PRINT", UIParent)
	fe:SetFont(ChatFrame1:GetFont(),14,"OUTLINE")
	fe:SetTextInsets(3,3,0,0)
	fe:SetAllPoints(frame)
	fe:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",tile = true, tileSize =12, edgeSize =12,insets = setmetatable({},{__index = function() return 3 end}) 
	});
	fe:SetBackdropColor(0,0,0,0.7)
	fe:SetBackdropBorderColor(1,0.7,0,1)
	fe:SetAutoFocus(false)
	fe:SetScript("OnEscapePressed", function(s) s:ClearFocus(); s:Hide() end)
	fe:SetScript("OnEnterPressed", function(s) s:ClearFocus(); s:Hide() end)
	fe:SetScript("OnEditFocusGained", function(s) s:HighlightText(); end)
	fe:SetScript("OnShow", function(s)
		s.text = ""
		for rollIndex, data in pairs (mar_seenSpells) do
			local tempLine = "Number of times spell was available at roll #" .. tostring(rollIndex) .. "\n"
			for spellId, spellData in pairs(data) do
				tempLine = tempLine .. "    " .. spellData.name .. " (" .. tostring(spellId) .. "): " .. tostring(spellData.count) .. "\n"
			end
			s.text = s.text .. tempLine .. "\n"
		end
		s:SetMaxLetters(s.text:len())
		s:SetText(s.text or "")
		s:HighlightText()
		s:SetFocus()
	end)
	fe:SetMultiLine(true)
	fe:SetMaxLetters(100)
	fe:Hide()
	fe:Show()
end


