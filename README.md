# MaloWAscensionReroller
An addon that lets you find the perfect starting-abilities on Ascension's Draft realms

# Instructions for how to use
1. Make a macro where you define the spell-ids of your must-have spells, your strong spells, your decent spells, and your weak spells like:  
/mar addmusthave 71  
/mar addmusthave 355  
/mar addstrong 6343  
/mar addstrong 2565  
/mar addstrong 25780  
/mar adddecent 78  
/mar addweak 5277  
/mar enable  

Note that any spells you don't define will be counted as worthless and randomly picked if no better option exist.  
If you run out of macro space you can split it up into multiple marcos, just make sure only 1 macro has the "/mar enable", and to press the one macro that does have it after you've pressed the other macros.

2. Drag the Draft Mode Deck item onto your bars at a convenient key-binding.  
3. Press the keybind for Draft Mode Deck, press "Accept" and press that key-bind again (so that both the 3 spell-choices and the Accept/Cancel frame is visible).  
4. Press the macro you created earlier.  
5. Spam-press the keybind for Draft Mode Deck.  

It will now keep rerolling until you have ALL must-haves AND you have a score of 7 or better. Strong spells gives 5 score, decent spells give 2 score and weak spells give 1 score. You can customize the required score and the values for the different tiers of spells by providing additional arguments to "/mar enable", like:  
/mar enable 15 7 4 2  
This example will require 15 score total, strong spells will give 7 score, decent spells will give 4 score, and weak spells will give 2 score.  
Must-have spells do not use the scoring system at all, if you don't provide any Strong/Decent/weak spells then the scoring system will be automatically disabled since it's impossible to get any score without spells in those tiers.  
Note that if you for example want 3 specific spells 100%, and for your fourth spell you want 1 of 5 possible good spells, then if you add those 3 first spells as must-haves, and you add the other 5 spells as Strong spells, the scoring system will only be active on that last spell, and you need to modify the required-score and/or the score given from strong spells to ensure that getting a single strong spell gives enough score to meet the required score. If you don't do this the roll can never be successful.

If you notice that the server is not responding quickly enough you can change the delay by running "/mar setdelay 1". The default delay is 0.5.

# Some math
I've seen 78 different starting-spells. Assuming half of those are locked behind requiring other spells first that means that using a macro like:  
/mar addmusthave 71  
/mar addmusthave 355  
/mar addmusthave 6343  
/mar addmusthave 2565  
Will result in roughly a 0.0012% chance of hitting the right spells on a roll (Using (4/39) * (3/38) * (2/37) * (1/36)). This means that 83333 rolls are needed on average to hit it, which using the addon (which can do a reroll every 2 seconds) would take rougly 46 hours of rolling. So you're probably better off being less picky and using fewer must-have's and allowing multiple different spells to hit for Strong/Decent/Weak spells.  

Do note that only these spells are possible to get on the first of the four rolls:  
-- Healing Wave  
-- Immolate  
-- Defensive Stance  
-- Lightning Bolt  
-- Searing Totem  
-- Stoneskin Totem  
-- Sinister Strike  
-- Frostbolt  
-- Shadow Bolt  
-- Gouge  
-- Wrath  
-- Backstab  
-- Summon Imp  
-- Seal of Righteousness  
-- Fireball  
-- Moonfire  
-- Corruption  
-- Stealth  
-- Arcane Missiles  
-- Bear Form  
-- Battle Stance  
-- Tame Beast  

# To find out spell-ids
Non-complete list (mined from running the addon for hours and then running "/mar printseen"):  
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
-- Tame Beast - 965200 (Note: This spell takes up 3 of the 4 starter spell-slots)  
-- Aspect of the Monkey - 13163  
-- Stealth - 1784  
-- Fire Blast - 2136  
-- Bear Form - 5487  
-- Mongoose Bite - 1495  
-- Curse of Agony - 980  
-- Eviscerate - 2098  
-- Taunt - 355  
-- Slice and Dice - 5171  
-- Judgement of Light - 20271  
-- Judgement of Wisdom - 53408  

If a spell is missing from this list that is available as a starter-spell then find the spell-id on https://wotlk.evowow.com/ by finding the spell and looking at the URL of your browser. Please report any missing spells to me and I'll add them to the list above.

# Statistics from randomly picking spells
```
Number of times spell was available at roll #1
    Healing Wave (331): 99
    Immolate (348): 105
    Defensive Stance (71): 167
    Lightning Bolt (403): 106
    Searing Totem (3599): 86
    Stoneskin Totem (8071): 82
    Sinister Strike (1752): 88
    Frostbolt (116): 102
    Shadow Bolt (686): 83
    Gouge (1776): 80
    Wrath (5176): 90
    Backstab (53): 90
    Summon Imp (688): 94
    Seal of Righteousness (21084): 89
    Fireball (133): 92
    Moonfire (8921): 78
    Corruption (172): 85
    Stealth (1784): 149
    Arcane Missiles (5143): 101
    Bear Form (5487): 151
    Battle Stance (2457): 159
    Tame Beast (965200): 149

Number of times spell was available at roll #2
    Gouge (1776): 42
    Arcane Intellect (1459): 26
    Mark of the Wild (1126): 31
    Fireball (133): 34
    Growl (6795): 2
    Renew (139): 26
    Shadow Bolt (686): 32
    Curse of Weakness (702): 31
    Curse of Agony (980): 38
    Hamstring (1715): 35
    Battle Shout (6673): 33
    Evasion (5277): 28
    Rejuvenation (774): 31
    Bloodrage (2687): 25
    Demon Skin (687): 31
    Aspect of the Hawk (13165): 32
    Maul (6807): 7
    Blessing of Might (19740): 35
    Hunter's Mark (1130): 37
    Stoneclaw Totem (5730): 39
    Summon Imp (688): 31
    Overpower (7384): 31
    Shield Block (2565): 4
    Backstab (53): 32
    Power Word: Fortitude (1243): 28
    Devotion Aura (465): 32
    Sinister Strike (1752): 31
    Bear Form (5487): 18
    Stealth (1784): 33
    Fade (586): 35
    Slice and Dice (5171): 7
    Sprint (2983): 39
    Seal of Righteousness (21084): 32
    Wrath (5176): 30
    Victory Rush (34428): 40
    Defensive Stance (71): 23
    Shield Bash (72): 41
    Auto Shot (965202): 38
    Concussive Shot (5116): 28
    Heroic Strike (78): 29
    Eviscerate (2098): 4
    Holy Light (635): 28
    Healing Wave (331): 31
    Frost Armor (168): 40
    Serpent Sting (1978): 36
    Corruption (172): 29
    Healing Touch (5185): 35
    Judgement of Wisdom (53408): 1
    Smite (585): 32
    Divine Protection (498): 36
    Pick Pocket (921): 3
    Swipe (Bear) (779): 2
    Righteous Fury (25780): 35
    Thunder Clap (6343): 6
    Moonfire (8921): 32
    Demoralizing Roar (99): 2
    Charge (100): 36
    Lightning Bolt (403): 37
    Life Tap (1454): 23
    Rend (772): 28
    Fire Blast (2136): 31
    Shadow Word: Pain (589): 23
    Judgement of Light (20271): 3
    Stoneskin Totem (8071): 40
    Arcane Missiles (5143): 34
    Raptor Strike (2973): 35
    Arcane Shot (3044): 44
    Blessing of Wisdom (19742): 27
    Earth Shock (8042): 36
    Lightning Shield (324): 28
    Searing Totem (3599): 21
    Mongoose Bite (1495): 32
    Frostbolt (116): 30
    Thorns (467): 28
    Battle Stance (2457): 21
    Immolate (348): 38
    Aspect of the Monkey (13163): 33

Number of times spell was available at roll #3
    Gouge (1776): 27
    Arcane Intellect (1459): 39
    Mark of the Wild (1126): 32
    Fireball (133): 23
    Growl (6795): 3
    Renew (139): 40
    Shadow Bolt (686): 29
    Curse of Weakness (702): 28
    Curse of Agony (980): 27
    Hamstring (1715): 40
    Battle Shout (6673): 27
    Stoneskin Totem (8071): 32
    Rejuvenation (774): 32
    Bloodrage (2687): 42
    Demon Skin (687): 33
    Aspect of the Hawk (13165): 33
    Maul (6807): 3
    Blessing of Might (19740): 37
    Hunter's Mark (1130): 34
    Stoneclaw Totem (5730): 32
    Summon Imp (688): 28
    Overpower (7384): 48
    Shield Block (2565): 3
    Backstab (53): 28
    Power Word: Fortitude (1243): 31
    Devotion Aura (465): 24
    Sinister Strike (1752): 46
    Bear Form (5487): 29
    Stealth (1784): 22
    Fade (586): 32
    Slice and Dice (5171): 9
    Sprint (2983): 31
    Seal of Righteousness (21084): 34
    Wrath (5176): 27
    Victory Rush (34428): 32
    Defensive Stance (71): 28
    Shield Bash (72): 20
    Auto Shot (965202): 33
    Concussive Shot (5116): 34
    Heroic Strike (78): 35
    Eviscerate (2098): 7
    Holy Light (635): 23
    Healing Wave (331): 37
    Frost Armor (168): 26
    Serpent Sting (1978): 42
    Earth Shock (8042): 35
    Healing Touch (5185): 20
    Taunt (355): 5
    Judgement of Wisdom (53408): 1
    Pick Pocket (921): 3
    Divine Protection (498): 28
    Thunder Clap (6343): 5
    Judgement of Light (20271): 2
    Aspect of the Monkey (13163): 28
    Mongoose Bite (1495): 29
    Moonfire (8921): 29
    Demoralizing Roar (99): 1
    Charge (100): 27
    Lightning Bolt (403): 25
    Righteous Fury (25780): 30
    Life Tap (1454): 35
    Fire Blast (2136): 38
    Blessing of Wisdom (19742): 36
    Shadow Word: Pain (589): 25
    Evasion (5277): 25
    Corruption (172): 27
    Smite (585): 36
    Raptor Strike (2973): 27
    Arcane Missiles (5143): 35
    Rend (772): 47
    Lightning Shield (324): 30
    Searing Totem (3599): 38
    Arcane Shot (3044): 38
    Frostbolt (116): 43
    Thorns (467): 38
    Battle Stance (2457): 28
    Immolate (348): 37
    Swipe (Bear) (779): 4

Number of times spell was available at roll #4
    Gouge (1776): 36
    Arcane Intellect (1459): 32
    Mark of the Wild (1126): 35
    Arcane Missiles (5143): 35
    Growl (6795): 4
    Renew (139): 32
    Shadow Bolt (686): 26
    Curse of Weakness (702): 34
    Curse of Agony (980): 45
    Hamstring (1715): 34
    Battle Shout (6673): 40
    Evasion (5277): 46
    Rejuvenation (774): 39
    Aspect of the Monkey (13163): 36
    Demon Skin (687): 33
    Aspect of the Hawk (13165): 46
    Maul (6807): 1
    Mongoose Bite (1495): 52
    Hunter's Mark (1130): 29
    Stoneclaw Totem (5730): 33
    Summon Imp (688): 31
    Overpower (7384): 38
    Smite (585): 25
    Backstab (53): 30
    Power Word: Fortitude (1243): 39
    Devotion Aura (465): 38
    Sinister Strike (1752): 37
    Bear Form (5487): 38
    Stealth (1784): 35
    Fade (586): 30
    Slice and Dice (5171): 6
    Sprint (2983): 33
    Seal of Righteousness (21084): 32
    Wrath (5176): 33
    Victory Rush (34428): 34
    Defensive Stance (71): 23
    Shield Bash (72): 37
    Auto Shot (965202): 26
    Concussive Shot (5116): 39
    Heroic Strike (78): 33
    Eviscerate (2098): 10
    Holy Light (635): 33
    Healing Wave (331): 31
    Pick Pocket (921): 6
    Serpent Sting (1978): 35
    Earth Shock (8042): 35
    Healing Touch (5185): 28
    Taunt (355): 2
    Righteous Fury (25780): 34
    Divine Protection (498): 31
    Judgement of Wisdom (53408): 3
    Shield Block (2565): 2
    Moonfire (8921): 41
    Blessing of Wisdom (19742): 33
    Swipe (Bear) (779): 4
    Demoralizing Roar (99): 2
    Charge (100): 30
    Lightning Bolt (403): 34
    Corruption (172): 41
    Blessing of Might (19740): 27
    Fire Blast (2136): 42
    Life Tap (1454): 32
    Shadow Word: Pain (589): 28
    Thorns (467): 32
    Stoneskin Totem (8071): 28
    Rend (772): 35
    Fireball (133): 18
    Bloodrage (2687): 34
    Raptor Strike (2973): 42
    Lightning Shield (324): 34
    Searing Totem (3599): 40
    Arcane Shot (3044): 43
    Frostbolt (116): 39
    Thunder Clap (6343): 7
    Battle Stance (2457): 35
    Immolate (348): 27
    Frost Armor (168): 39
```
