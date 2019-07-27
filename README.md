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

It will now keep rerolling until you have ALL must-haves AND you have a score of 6 or better. Strong spells gives 5 score, decent spells give 2 score. You can customize the required score and the values for the different tiers of spells by providing additional arguments to "/mar enable", like:  
/mar enable 15 7 4 2  
This example will require 15 score total, strong spells will give 7 score, decent spells will give 4 score, and weak spells will give 2 score.  

If you notice that the server is not responding quickly enough you can change the delay by running "/mar setdelay 1". The default delay is 0.5.

# To find out spell-ids
Non-complete list:  
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

If a spell is missing from this list that is available as a starter-spell then find the spell-id on https://wotlk.evowow.com/ by finding the spell and looking at the URL of your browser. Please report any missing spells to me and I'll add them to the list above.
