-- IdleMode determines the set used after casting. You change it with "/console gs c <IdleMode>"
-- The modes are:
-- Refresh: Uses the most refresh available.
-- DT: A mix of refresh, PDT, and MDT to help when you can't avoid AOE.
-- PetDT: Sacrifice refresh to reduce avatar's damage taken. WARNING: Selenian Cap drops you below 119, use with caution!
-- DD: When melee mode is on and you're engaged, uses TP gear. Otherwise, avatar melee gear.
-- Favor: Uses Beckoner's Horn +1 and max smn skill to boost the favor effect.

-- Additional Bindings:
-- F9 - Toggles between a subset of IdleModes (Refresh > DT > PetDT)
-- F10 - Toggles MeleeMode (When enabled, equips Nirvana and Elan+1, then disables those 2 slots from swapping)
--       NOTE: If you don't already have the Nirvana & Elan+1 equipped, YOU WILL LOSE TP
 
-- Additional Commands:
-- /console gs c AccMode - Toggles high-accuracy sets to be used where appropriate.
-- /console gs c ImpactMode - Toggles between using normal magic BP set for Fenrir's Impact or a custom high-skill set for debuffs.
-- /console gs c ForceIlvl - I have this set up to override a few specific slots where I normally use non-ilvl pieces.
-- /console gs c LagMode - Used to help BPs land in the right gear in high-lag situations.
--                          Sets a timer to swap gear 0.2s after the BP is used rather than waiting for server response.
 
function file_unload()
    send_command('unbind f9')
    send_command('unbind f10')
    send_command('unbind ^f10')
end
 
function get_sets()
    send_command('bind f9 gs c ToggleIdle')
    send_command('bind f10 gs c MeleeMode')
    send_command('bind ^f10 gs c ForceIlvl')
    send_command('bind f12 input /ws "Garland of Bliss" <t>')

    send_command('bind @n input /pet "Thunderspark" <t>')
    send_command('bind @m input /pet "Volt Strike" <t>')
    send_command('bind @o input /pet "Shock Squall" <t>')
    send_command('bind @p input /pet "Thunderstorm" <t>')
 
    -- Set your merits here. This is used in deciding between Enticer's Pants or Apogee Slacks +1.
    -- To change in-game, "/console gs c MeteorStrike3" will change Meteor Strike to 3/5 merits.
    -- The damage difference is very minor unless you're over 2400 TP.
    -- It's ok to just always use Enticer's Pants and ignore this section.
    MeteorStrike = 5
    HeavenlyStrike = 1
    WindBlade = 1
    Geocrush = 1
    Thunderstorm = 1
    GrandFall = 1
 
    StartLockStyle = '1'
    IdleMode = 'DT'
    AccMode = false
    ImpactDebuff = false
    MeleeMode = false
    ForceIlvl = false
    LagMode = true -- Default LagMode. If you have a lot of lag issues, change to "true".
    AutoRemedy = false -- Auto Remedy when using an ability while Paralyzed.
    AutoEcho = false -- Auto Echo Drop when using an ability while Silenced.
    
    -- ===================================================================================================================
    --      Sets
    -- ===================================================================================================================
 
    -- Base Damage Taken Set - Mainly used when IdleMode is "DT"
    sets.DT_Base = {
      main="Nirvana",
      hands="Inyan. Dastanas +2",
      legs="Inyanga Shalwar +2",
      sub="Elan Strap +1",
      ammo="Sancus Sachet +1",
      head="Inyanga Tiara +2",
      body="Inyanga Jubbah +2",
      feet="Inyan. Crackows +2",
      neck={ name="Smn. Collar +2", augments={'Path: A',}},
      waist="Carrier's Sash",
      left_ear="Odnowa Earring +1",
      right_ear="Lugalbanda Earring",
      left_ring="Gelatinous Ring +1",
      right_ring="Defending Ring",
      back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','Damage taken-5%',}},
    }
 
    sets.precast = {}
 
    -- Fast Cast
    sets.precast.FC = {
      head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+10','"Fast Cast"+7','INT+8','Mag. Acc.+13',}}, -- 15
      body="Inyanga Jubbah +2", -- 14
      hands={ name="Merlinic Dastanas", augments={'MND+5','Pet: DEX+3','"Fast Cast"+8','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}, -- 8
      legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+15','"Fast Cast"+7','CHR+8','"Mag.Atk.Bns."+4',}}, -- 7
      feet={ name="Merlinic Crackows", augments={'"Fast Cast"+7','MND+10','"Mag.Atk.Bns."+4',}}, -- 12
      waist="Embla Sash", -- 5
      left_ear="Malignance Earring", -- 4
      right_ear="Etiolation Earring", -- 1
      left_ring="Defending Ring",
      right_ring="Kishar Ring", -- 4
      back={ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}, -- 10
    }
 
    sets.precast["Dispelga"] = set_combine(sets.precast.FC, {
      main="Daybreak",
      sub="Ammurapi Shield"
    })
 
    sets.midcast = {}
 
    -- BP Timer Gear
    sets.midcast.BP = {
      main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
      sub="Vox Grip",
      ammo="Sancus Sachet +1",
      head="Beckoner's Horn +1",
      body="Baayami Robe",
      hands="Baayami Cuffs",
      legs="Baayami Slops",
      feet="Baaya. Sabots +1",
      neck="Caller's Pendant",
      waist="Lucidity Sash",
      left_ear="Lodurr Earring",
      right_ear="C. Palug Earring",
      left_ring="Stikini ring +1",
      right_ring="Evoker's Ring",
      back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Blood Pact Dmg.+1','Blood Pact ab. del. II -3',}},
    }
 
    -- Elemental Siphon sets. Zodiac Ring is affected by day, Chatoyant Staff by weather, and Twilight Cape by both.
    sets.midcast.Siphon = {
      main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
      sub="Vox Grip",
      ammo="Sancus Sachet +1",
      head="Beckoner's Horn +1",
      body="Baayami Robe",
      hands="Baayami Cuffs",
      legs="Baayami Slops",
      feet="Beck. Pigaches +1",
      neck="Caller's Pendant",
      waist="Lucidity Sash",
      left_ear="Lodurr Earring",
      right_ear="C. Palug Earring",
      left_ring="Stikini ring +1",
      right_ring="Evoker's Ring",
      back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Blood Pact Dmg.+1','Blood Pact ab. del. II -3',}},
    }
 
    sets.midcast.SiphonZodiac = set_combine(sets.midcast.Siphon, { ring1="Zodiac Ring" })
    sets.midcast.SiphonWeather = set_combine(sets.midcast.Siphon, { main="Chatoyant Staff" })
    sets.midcast.SiphonWeatherZodiac = set_combine(sets.midcast.SiphonZodiac, { main="Chatoyant Staff" })
 
    -- Summoning Midcast, cap spell interruption if possible (Baayami Robe gives 100, need 2 more)
    -- PDT isn't a bad idea either, so don't overwrite a lot from the DT set it inherits from.
    sets.midcast.Summon = set_combine(sets.DT_Base, {
      body="Baayami Robe",
    })
 
    -- If you ever lock your weapon, keep that in mind when building cure potency set.
    sets.midcast.Cure = {
    }
 
    sets.midcast.Cursna = set_combine(sets.precast.FC, {
    })
   
    sets.midcast.EnmityRecast = set_combine(sets.precast.FC, {
    })
 
    sets.midcast.Enfeeble = {
    }
    
    sets.midcast.Enhancing = {
    }
 
    sets.midcast.Stoneskin = set_combine(sets.midcast.Enhancing, {
    })
 
    sets.midcast.Nuke = {
    }
 
    sets.midcast["Refresh"] = set_combine(sets.midcast.Enhancing, {
    })
 
    sets.midcast["Aquaveil"] = set_combine(sets.midcast.Enhancing, {
    })
 
    sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeeble, {
      main="Daybreak",
      sub="Ammurapi Shield"
    })
 
    sets.midcast["Mana Cede"] = { hands="Beckoner's Bracers +1" } 
    sets.midcast["Astral Flow"] = { head="Glyphic Horn" }
   
    -- ===================================================================================================================
    --  Weaponskills
    -- ===================================================================================================================
 
    sets.midcast["Garland of Bliss"] = {
      head="Nyame Helm",
      neck="Sanctity Necklace",
      ear1="Malignance Earring",
      ear2="Regal Earring",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      ring1="Freke Ring",
      ring2="Metamorph Ring +1",
      back={ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
      waist="Eschan Stone",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets"
    }
 
    sets.midcast["Shattersoul"] = {
      head="Nyame Helm",
      neck="Fotia Gorget",
      ear1="Crepuscular Earring",
      ear2="Telos Earring",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      ring1="Freke Ring",
      ring2="Metamorph Ring +1",
      waist="Fotia Belt",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets"
    }
 
    sets.midcast["Cataclysm"] = sets.midcast.Nuke
 
    sets.pet_midcast = {}
 
    -- Main physical pact set (Volt Strike, Pred Claws, etc.)
    -- Prioritize BP Damage & Pet: DA
    sets.pet_midcast.Physical_BP = {
      main="Nirvana",
      sub="Elan Strap +1",
      ammo="Sancus Sachet +1",
      head={ name="Helios Band", augments={'Pet: Accuracy+29 Pet: Rng. Acc.+29','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
      body="Glyphic Doublet +3",
      hands={ name="Merlinic Dastanas", augments={'Pet: Attack+22 Pet: Rng.Atk.+22','Blood Pact Dmg.+9','Pet: VIT+2','Pet: Mag. Acc.+5',}},
      legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
      feet={ name="Helios Boots", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
      neck={ name="Smn. Collar +2", augments={'Path: A',}},
      waist="Incarnation Sash",
      left_ear="Kyrene's Earring",
      right_ear="Lugalbanda Earring",
      left_ring="Varar Ring +1",
      right_ring="Cath Palug Ring",
      back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10',}},
    }
 
    -- Physical Pact AM3 set, less emphasis on Pet:DA
    sets.pet_midcast.Physical_BP_AM3 = set_combine(sets.pet_midcast.Physical_BP, {
      left_ear="Gelos Earring",
      body="Glyphic Doublet +3",
      right_ring="Varar Ring +1",
      feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}}
    })
 
    -- Physical pacts which benefit more from TP than Pet:DA (like single-hit BP)
    sets.pet_midcast.Physical_BP_TP = set_combine(sets.pet_midcast.Physical_BP, {
      head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
      ear2="Gelos Earring",
      body="Convoker's Doublet +3",
      right_ring="Varar Ring +1",
      waist="Regal Belt",
      legs="Enticer's Pants",
      feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}}
    })
 
    -- Used for all physical pacts when AccMode is true
    sets.pet_midcast.Physical_BP_Acc = set_combine(sets.pet_midcast.Physical_BP, {
      head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
      right_ring="Varar Ring +1",
      body="Convoker's Doublet +3",
      hands="Convoker's Bracers +3",
    })
 
    -- Base magic pact set
    -- Prioritize BP Damage & Pet:MAB
    sets.pet_midcast.Magic_BP_Base = {
      main="Grioavolr", -- or Espiritus
      sub="Elan Strap +1",
      ammo="Sancus Sachet +1",
      head="C. Palug Crown",
      body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+20 Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+10','Pet: Mag. Acc.+2',}},
      legs={ name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      neck={ name="Smn. Collar +2", augments={'Path: A',}},
      waist="Regal Belt",
      left_ear="Lugalbanda Earring",
      right_ear="Gelos Earring",
      left_ring={name="Varar Ring +1", bag="wardrobe"},
      right_ring={name="Varar Ring +1", bag="wardrobe5"},
      back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','Damage taken-5%',}},
    }
   
    -- Some magic pacts benefit more from TP than others.
    -- Note: This set will only be used on merit pacts if you have less than 4 merits.
    --       Make sure to update your merit values at the top of this Lua.
    sets.pet_midcast.Magic_BP_TP = set_combine(sets.pet_midcast.Magic_BP_Base, {
      legs="Enticer's Pants"
    })
 
    -- NoTP set used when you don't need Enticer's
    sets.pet_midcast.Magic_BP_NoTP = set_combine(sets.pet_midcast.Magic_BP_Base, {
      legs={ name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
    })
 
    sets.pet_midcast.Magic_BP_TP_Acc = set_combine(sets.pet_midcast.Magic_BP_TP, {
      body="Convoker's Doublet +3",
      hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+20 Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+10','Pet: Mag. Acc.+2',}},	
    })
 
    sets.pet_midcast.Magic_BP_NoTP_Acc = set_combine(sets.pet_midcast.Magic_BP_NoTP, {
      body="Convoker's Doublet +3",
      hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+20 Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+10','Pet: Mag. Acc.+2',}},
    })
 
    -- Favor BP Damage above all. Pet:MAB also very strong.
    -- Pet: Accuracy, Attack, Magic Accuracy moderately important.
    sets.pet_midcast.FlamingCrush = {
      main="Nirvana",
      sub="Elan Strap +1",
      ammo="Sancus Sachet +1",
      head="C. Palug Crown",
      body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+20 Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+10','Pet: Mag. Acc.+2',}},
      legs={ name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      neck={ name="Smn. Collar +2", augments={'Path: A',}},
      waist="Regal Belt",
      left_ear="Lugalbanda Earring",
      right_ear="Gelos Earring",
      left_ring={name="Varar Ring +1", bag="wardrobe"},
      right_ring={name="Varar Ring +1", bag="wardrobe5"},
      back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10',}},
    }
 
    sets.pet_midcast.FlamingCrush_Acc = set_combine(sets.pet_midcast.FlamingCrush, {
      right_ear="Kyrene's Earring",
      body="Convoker's Doublet +3",
    })
 
    -- Pet: Magic Acc set - Mainly used for debuff pacts like Shock Squall
    sets.pet_midcast.MagicAcc_BP = {
      main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
      sub="Vox Grip",
      ammo="Sancus Sachet +1",
      head="Convoker's Horn +2",
      neck="Summoner's Collar +2",
      ear1="Lugalbanda Earring",
      ear2="Enmerkar Earring",
      body="Convoker's Doublet +3",
      hands="Convoker's Bracers +3", -- Augmented Lamassu Mitts +1
      ring1="Cath Palug Ring",
      ring2="Evoker's Ring",
      back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','Damage taken-5%',}},
      waist="Regal Belt",
      legs="Convoker's Spats +2",
      feet="Convoker's Pigaches +2"
    }
 
    sets.pet_midcast.Debuff_Rage = sets.pet_midcast.MagicAcc_BP
 
    -- Pure summoning magic set, mainly used for buffs like Hastega II.
    sets.pet_midcast.SummoningMagic = {
      main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
      sub="Vox Grip",
      ammo="Sancus Sachet +1",
      head="Beckoner's Horn +1",
      body="Baayami Robe", -- + 1 if you're rich
      hands="Baayami Cuffs", -- + 1 if you're rich
      legs="Baayami Slops", -- + 1 if you're rich
      feet="Baaya. Sabots +1",
      neck="Caller's Pendant",
      waist="Lucidity Sash",
      left_ear="Lodurr Earring",
      right_ear="C. Palug Earring",
      left_ring="Stikini ring +1",
      right_ring="Evoker's Ring",
      back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Blood Pact Dmg.+1','Blood Pact ab. del. II -3',}},
    }
 
    sets.pet_midcast.Buff = sets.pet_midcast.SummoningMagic
   
    -- Used for Wind's Blessing. Here you can sacrifice summoning skill for Pet:MND to increase potency.
    sets.pet_midcast.Buff_MND = set_combine(sets.pet_midcast.Buff, {
        main="Nirvana",
        neck="Summoner's Collar +2",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
    })
 
    -- Don't drop Avatar level in this set if you can help it.
    -- You can use Avatar:HP+ gear to increase the HP recovered, but most of it will decrease your own max HP.
    sets.pet_midcast.Buff_Healing = set_combine(sets.pet_midcast.Buff, {
        main="Nirvana",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
    })
 
    -- This set is used for certain blood pacts when ImpactDebuff mode is ON. (/console gs c ImpactDebuff)
    -- These pacts are normally used as nukes, but they're also strong debuffs which are enhanced by smn skill.
    sets.pet_midcast.Impact = set_combine(sets.pet_midcast.SummoningMagic, {
      main="Nirvana",
      head="Convoker's Horn +2",
      ear1="Lugalbanda Earring",
      ear2="Enmerkar Earring"
    })
 
    sets.aftercast = {}
 
    -- Idle set with no avatar out.
    sets.aftercast.Idle = sets.DT_Base
   
    -- Idle set used when ForceIlvl is ON. Use this mode to avoid Gaiters dropping ilvl.
    sets.aftercast.Idle_Ilvl = set_combine(sets.aftercast.Idle, {
        feet="Baayami Sabots +1"
    })
   
    sets.aftercast.DT = sets.DT_Base
 
    -- Many idle sets inherit from this set.
    -- Put common items here so you don't have to repeat them over and over.
    -- Strong Alternatives:
    -- Asteria Mitts, Shomonjijoe
    sets.aftercast.Perp_Base = {
      main="Nirvana",            -- 8 perp, can use jse
      sub="Khonsu",              -- 
      ammo="Sancus Sachet +1",   -- ilevel avatar, can use epitaph
      head="Beckoner's horn +1", -- 3 favor, 2 refresh
      neck="Caller's Pendant",   -- 1 perp sometimes
      ear1="Cath Palug Earring", -- 1 refresh
      ear2="Evans earring",      -- 2 perp
      body="Apo. Dalmatica +1",  -- 4 refresh
      hands={ name="Merlinic Dastanas", augments={'Weapon skill damage +1%','"Avatar perpetuation cost" -1','"Refresh"+2','Accuracy+9 Attack+9','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}, -- 2 refresh 1 perp
      ring1="Stikini Ring +1", -- 1 refresh
      ring2="Evoker's Ring", -- 1 refresh
      legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+15','Attack+2','"Refresh"+2','Accuracy+10 Attack+10',}}, -- 2 refresh
      feet="Baayami Sabots +1", -- 3 refresh
      waist="Lucidity Sash", -- 2 perp
      back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','Damage taken-5%',}}, -- avatar level
    }
 
    -- Avatar Melee set. Equipped when IdleMode is "DD" and MeleeMode is OFF.
    -- You really don't need this set. It's only here because I can't bring myself to throw it away.
    sets.aftercast.Perp_DD = set_combine(sets.aftercast.Perp_Base, {
    })
 
    -- Refresh set with avatar out. Equipped when IdleMode is "Refresh".
    sets.aftercast.Perp_Refresh = set_combine(sets.aftercast.Perp_Base, {
      body="Apo. Dalmatica +1",
    })
 
    -- Refresh set when MP is under 50%
    sets.aftercast.Perp_RefreshSub50 = set_combine(sets.aftercast.Perp_Refresh, {
      waist="Fucho-no-obi"
    })
   
    sets.aftercast.Perp_Favor = set_combine(sets.aftercast.Perp_Refresh, {
        head="Beckoner's Horn +1",
        ear2="Lodurr Earring",
        ring1="Stikini Ring +1",
        ring2="Evoker's Ring",
        legs="Baayami Slops",
        feet="Baayami Sabots +1"
    })
 
    -- TP set. Equipped when IdleMode is "DD" and MeleeMode is ON.
    sets.aftercast.Perp_Melee = set_combine(sets.aftercast.Perp_Refresh, {
    })
 
    -- Pet:DT build. Equipped when IdleMode is "PetDT".
    sets.aftercast.Avatar_DT = {
    }
 
    -- Perp down set used when ForceIlvl is ON. If you use Selenian Cap for Pet:DT, you can make another set here without it.
    sets.aftercast.Avatar_DT_Ilvl = set_combine(sets.aftercast.Avatar_DT, {
    })
 
    -- DT build with avatar out. Equipped when IdleMode is "DT".
    sets.aftercast.Perp_DT = set_combine(sets.aftercast.Perp_Base, {
      neck="Loricate Torque +1",
      body="Bunzi's Robe",
      hands="Bunzi's Gloves",
      legs="Bunzi's Pants",
      feet="Bunzi's Sabots",
    })
 
    sets.aftercast.Spirit = {
      main="Nirvana",
      sub="Vox Grip",
      ammo="Sancus Sachet +1",
      head="Convoker's Horn +2",
      neck="Caller's Pendant",
      ear1="Cath Palug Earring",
      ear2="Evans Earring",
      body="Baayami Robe",
      hands="Baayami Cuffs",
      ring1="Stikini Ring +1",
      ring2="Evoker's Ring",
      back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Blood Pact Dmg.+1','Blood Pact ab. del. II -3',}},
      waist="Lucidity Sash",
      legs="Baayami Slops",
      feet="Baayami Sabots +1"
    }
 
    -- ===================================================================================================================
    --      End of Sets
    -- ===================================================================================================================
 
    Buff_BPs_Duration = S{'Shining Ruby','Aerial Armor','Frost Armor','Rolling Thunder','Crimson Howl','Lightning Armor','Ecliptic Growl','Glittering Ruby','Earthen Ward','Hastega','Noctoshield','Ecliptic Howl','Dream Shroud','Earthen Armor','Fleet Wind','Inferno Howl','Heavenward Howl','Hastega II','Soothing Current','Crystal Blessing','Katabatic Blades'}
    Buff_BPs_Healing = S{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'}
    Buff_BPs_MND = S{"Wind's Blessing"}
    Debuff_BPs = S{'Mewing Lullaby','Eerie Eye','Lunar Cry','Lunar Roar','Nightmare','Pavor Nocturnus','Ultimate Terror','Somnolence','Slowga','Tidal Roar','Diamond Storm','Sleepga','Shock Squall','Bitter Elegy','Lunatic Voice'}
    Debuff_Rage_BPs = S{'Moonlit Charge','Tail Whip'}
 
    Magic_BPs_NoTP = S{'Holy Mist','Nether Blast','Aerial Blast','Searing Light','Diamond Dust','Earthen Fury','Zantetsuken','Tidal Wave','Judgment Bolt','Inferno','Howling Moon','Ruinous Omen','Night Terror','Thunderspark','Tornado II','Sonic Buffet'}
    Magic_BPs_TP = S{'Impact','Conflag Strike','Level ? Holy','Lunar Bay'}
    Merit_BPs = S{'Meteor Strike','Geocrush','Grand Fall','Wind Blade','Heavenly Strike','Thunderstorm'}
    Physical_BPs_TP = S{'Rock Buster','Mountain Buster','Crescent Fang','Spinning Dive'}
   
    ZodiacElements = S{'Fire','Earth','Water','Wind','Ice','Lightning'}
 
    --TownIdle = S{"windurst woods","windurst waters","windurst walls","port windurst","bastok markets","bastok mines","port bastok","southern san d'oria","northern san d'oria","port san d'oria","upper jeuno","lower jeuno","port jeuno","ru'lude gardens","norg","kazham","tavnazian safehold","rabao","selbina","mhaura","aht urhgan whitegate","al zahbi","nashmau","western adoulin","eastern adoulin"}
    --Salvage = S{"Bhaflau Remnants","Zhayolm Remnants","Arrapago Remnants","Silver Sea Remnants"}
 
    -- Select initial macro set and set lockstyle
    -- This section likely requires changes or removal if you aren't Pergatory
    if pet.isvalid then
        if pet.name=='Fenrir' then
            send_command('input /macro book 10;wait .1;input /macro set 2;wait 3;input /lockstyleset '..StartLockStyle)
        elseif pet.name=='Ifrit' then
            send_command('input /macro book 10;wait .1;input /macro set 3;wait 3;input /lockstyleset '..StartLockStyle)
        elseif pet.name=='Titan' then
            send_command('input /macro book 10;wait .1;input /macro set 4;wait 3;input /lockstyleset '..StartLockStyle)
        elseif pet.name=='Leviathan' then
            send_command('input /macro book 10;wait .1;input /macro set 5;wait 3;input /lockstyleset '..StartLockStyle)
        elseif pet.name=='Garuda' then
            send_command('input /macro book 10;wait .1;input /macro set 6;wait 3;input /lockstyleset '..StartLockStyle)
        elseif pet.name=='Shiva' then
            send_command('input /macro book 10;wait .1;input /macro set 7;wait 3;input /lockstyleset '..StartLockStyle)
        elseif pet.name=='Ramuh' then
            send_command('input /macro book 10;wait .1;input /macro set 8;wait 3;input /lockstyleset '..StartLockStyle)
        elseif pet.name=='Diabolos' then
            send_command('input /macro book 10;wait .1;input /macro set 9;wait 3;input /lockstyleset '..StartLockStyle)
        elseif pet.name=='Cait Sith' then
            send_command('input /macro book 11;wait .1;input /macro set 2;wait 3;input /lockstyleset '..StartLockStyle)
        elseif pet.name=='Siren' then
            send_command('input /macro book 11;wait .1;input /macro set 4;wait 3;input /lockstyleset '..StartLockStyle)
        end
    else
        send_command('input /macro book 10;wait .1;input /macro set 1;wait 3;input /lockstyleset '..StartLockStyle)
    end
    -- End macro set / lockstyle section
end
 
-- ===================================================================================================================
--      Gearswap rules below this point - Modify at your own peril
-- ===================================================================================================================
 
function pet_change(pet,gain)
    idle()
end
 
function pretarget(spell,action)
    if not buffactive['Muddle'] then
        -- Auto Remedy --
        if AutoRemedy and (spell.action_type == 'Magic' or spell.type == 'JobAbility') then
            if buffactive['Paralysis'] or (buffactive['Silence'] and not AutoEcho) then
                cancel_spell()
                send_command('input /item "Remedy" <me>')
            end
        end
        -- Auto Echo Drop --
        if AutoEcho and spell.action_type == 'Magic' and buffactive['Silence'] then
            cancel_spell()
            send_command('input /item "Echo Drops" <me>')
        end
    end
end
 
function precast(spell)
    if (pet.isvalid and pet_midaction()) or spell.type=="Item" then
        return
    end
    -- Spell fast cast
    if sets.precast[spell.english] then
        equip(sets.precast[spell.english])
    elseif spell.action_type=="Magic" then
        if spell.name=="Stoneskin" then
            equip(sets.precast.FC,{waist="Siegel Sash"})
        else
            equip(sets.precast.FC)
        end
    end
end
 
function midcast(spell)
    if (pet.isvalid and pet_midaction()) or spell.type=="Item" then
        return
    end
    -- BP Timer gear needs to swap here
    if (spell.type=="BloodPactWard" or spell.type=="BloodPactRage") then
        if not buffactive["Astral Conduit"] then
            equip(sets.midcast.BP)
        end
        -- If lag compensation mode is on, set up a timer to equip the BP gear.
        if LagMode then
            send_command('wait 0.5;gs c EquipBP '..spell.name)
        end
    -- Spell Midcast & Potency Stuff
    elseif sets.midcast[spell.english] then
        equip(sets.midcast[spell.english])
    elseif spell.name=="Elemental Siphon" then
        if pet.element==world.day_element and ZodiacElements:contains(pet.element) then
            if pet.element==world.weather_element then
                equip(sets.midcast.SiphonWeatherZodiac)
            else
                equip(sets.midcast.SiphonZodiac)
            end
        else
            if pet.element==world.weather_element then
                equip(sets.midcast.SiphonWeather)
            else
                equip(sets.midcast.Siphon)
            end
        end
    elseif spell.type=="SummonerPact" then
        equip(sets.midcast.Summon)
    elseif spell.type=="WhiteMagic" then
        if string.find(spell.name,"Cure") or string.find(spell.name,"Curaga") then
            equip(sets.midcast.Cure)
        elseif string.find(spell.name,"Protect") or string.find(spell.name,"Shell") then
            equip(sets.midcast.Enhancing,{ring2="Sheltered Ring"})
        elseif spell.skill=="Enfeebling Magic" then
            equip(sets.midcast.Enfeeble)
        elseif spell.skill=="Enhancing Magic" then
            equip(sets.midcast.Enhancing)
        else
            idle()
        end
    elseif spell.type=="BlackMagic" then
        if spell.skill=="Elemental Magic" then
            equip(sets.midcast.Nuke)
        end
    elseif spell.action_type=="Magic" then
        equip(sets.midcast.EnmityRecast)
    else
        idle()
    end
    -- Auto-cancel existing buffs
    if spell.name=="Stoneskin" and buffactive["Stoneskin"] then
        windower.send_command('cancel 37;')
    elseif spell.name=="Sneak" and buffactive["Sneak"] and spell.target.type=="SELF" then
        windower.send_command('cancel 71;')
    elseif spell.name=="Utsusemi: Ichi" and buffactive["Copy Image"] then
        windower.send_command('wait 1;cancel 66;')
    end
end
 
function aftercast(spell)
    if pet_midaction() or spell.type=="Item" then
        return
    end
    if not string.find(spell.type,"BloodPact") then
        idle()
    end
end
 
function status_change(new,old)
    if new=="Idle" then
        idle()
    end
end
 
function buff_change(name,gain)
    if name=="Quickening" then
        idle()
    end
end
 
function pet_midcast(spell)
    if not LagMode then
        equipBPGear(spell.name)
    end
end
 
function pet_aftercast(spell)
    idle()
end
 
function equipBPGear(spell)
    if spell=="Perfect Defense" then
        equip(sets.pet_midcast.SummoningMagic)
    elseif Debuff_BPs:contains(spell) then
        equip(sets.pet_midcast.MagicAcc_BP)
    elseif Buff_BPs_Healing:contains(spell) then
        equip(sets.pet_midcast.Buff_Healing)
    elseif Buff_BPs_Duration:contains(spell) then
        equip(sets.pet_midcast.Buff)
    elseif Buff_BPs_MND:contains(spell) then
        equip(sets.pet_midcast.Buff_MND)
    elseif spell=="Flaming Crush" then
        if AccMode then
            equip(sets.pet_midcast.FlamingCrush_Acc)
        else
            equip(sets.pet_midcast.FlamingCrush)
        end
    elseif ImpactDebuff and (spell=="Impact" or spell=="Conflag Strike") then
        equip(sets.pet_midcast.Impact)
    elseif Magic_BPs_NoTP:contains(spell) then
        if AccMode then
            equip(sets.pet_midcast.Magic_BP_NoTP_Acc)
        else
            equip(sets.pet_midcast.Magic_BP_NoTP)
        end
    elseif Magic_BPs_TP:contains(spell) or string.find(spell," II") or string.find(spell," IV") then
        if AccMode then
            equip(sets.pet_midcast.Magic_BP_TP_Acc)
        else
            equip(sets.pet_midcast.Magic_BP_TP)
        end
    elseif Merit_BPs:contains(spell) then
        if AccMode then
            equip(sets.pet_midcast.Magic_BP_TP_Acc)
        elseif spell=="Meteor Strike" and MeteorStrike>4 then
            equip(sets.pet_midcast.Magic_BP_NoTP)
        elseif spell=="Geocrush" and Geocrush>4 then
            equip(sets.pet_midcast.Magic_BP_NoTP)
        elseif spell=="Grand Fall" and GrandFall>4 then
            equip(sets.pet_midcast.Magic_BP_NoTP)
        elseif spell=="Wind Blade" and WindBlade>4 then
            equip(sets.pet_midcast.Magic_BP_NoTP)
        elseif spell=="Heavenly Strike" and HeavenlyStrike>4 then
            equip(sets.pet_midcast.Magic_BP_NoTP)
        elseif spell=="Thunderstorm" and Thunderstorm>4 then
            equip(sets.pet_midcast.Magic_BP_NoTP)
        else
            equip(sets.pet_midcast.Magic_BP_TP)
        end
    elseif Debuff_Rage_BPs:contains(spell) then
        equip(sets.pet_midcast.Debuff_Rage)
    else
        if AccMode then
            equip(sets.pet_midcast.Physical_BP_Acc)
        elseif Physical_BPs_TP:contains(spell) then
            equip(sets.pet_midcast.Physical_BP_TP)
        elseif buffactive["Aftermath: Lv.3"] then
            equip(sets.pet_midcast.Physical_BP_AM3)
        else
            equip(sets.pet_midcast.Physical_BP)
        end
    end
end
 
-- This command is called whenever you input "gs c <command>"
function self_command(command)
    IdleModeCommands = {'DD','Refresh','DT','Favor','PetDT'}
    is_valid = false
   
    for _, v in ipairs(IdleModeCommands) do
        if command:lower()==v:lower() then
            IdleMode = v
            send_command('console_echo "Idle Mode: ['..IdleMode..']"')
            idle()
            return
        end
    end
    if string.sub(command,1,7)=="EquipBP" then
        equipBPGear(string.sub(command,9,string.len(command)))
        return
    elseif command:lower()=="accmode" then
        AccMode = AccMode==false
        is_valid = true
        send_command('console_echo "AccMode: '..tostring(AccMode)..'"')
    elseif command:lower()=="impactmode" then
        ImpactDebuff = ImpactDebuff==false
        is_valid = true
        send_command('console_echo "Impact Debuff: '..tostring(ImpactDebuff)..'"')
    elseif command:lower()=="forceilvl" then
        ForceIlvl = ForceIlvl==false
        is_valid = true
        send_command('console_echo "Force iLVL: '..tostring(ForceIlvl)..'"')
    elseif command:lower()=="lagmode" then
        LagMode = LagMode==false
        is_valid = true
        send_command('console_echo "Lag Compensation Mode: '..tostring(LagMode)..'"')
    elseif command:lower()=="meleemode" then
        if MeleeMode then
            MeleeMode = false
            enable("main","sub")
            send_command('console_echo "Melee Mode: false"')
        else
            MeleeMode = true
            equip({main="Nirvana",sub="Elan Strap +1"})
            disable("main","sub")
            send_command('console_echo "Melee Mode: true"')
        end
        is_valid = true
    elseif command=="ToggleIdle" then
        is_valid = true
        -- If you want to change the sets cycled with F9, this is where you do it
        if IdleMode=="Refresh" then
            IdleMode = "DT"
        elseif IdleMode=="DT" then
            IdleMode = "PetDT"
        elseif IdleMode=="PetDT" then
            IdleMode = "DD"
        else
            IdleMode = "Refresh"
        end
        send_command('console_echo "Idle Mode: ['..IdleMode..']"')
    elseif command:lower()=="lowhp" then
        -- Use for "Cure 500 HP" objectives in Omen
        equip({head="Apogee Crown +1",body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},legs="Apogee Slacks +1",feet="Apogee Pumps +1",back="Campestres's Cape"})
        return
    elseif string.sub(command:lower(),1,12)=="meteorstrike" then
        MeteorStrike = string.sub(command,13,13)
        send_command('console_echo "Meteor Strike: '..MeteorStrike..'/5"')
        is_valid = true
    elseif string.sub(command:lower(),1,8)=="geocrush" then
        Geocrush = string.sub(command,9,9)
        send_command('console_echo "Geocrush: '..Geocrush..'/5"')
        is_valid = true
    elseif string.sub(command:lower(),1,9)=="grandfall" then
        GrandFall = string.sub(command,10,10)
        send_command('console_echo "Grand Fall: '..GrandFall..'/5"')
        is_valid = true
    elseif string.sub(command:lower(),1,9)=="windblade" then
        WindBlade = +string.sub(command,10,10)
        send_command('console_echo "Wind Blade: '..WindBlade..'/5"')
        is_valid = true
    elseif string.sub(command:lower(),1,14)=="heavenlystrike" then
        HeavenlyStrike = string.sub(command,15,15)
        send_command('console_echo "Heavenly Strike: '..HeavenlyStrike..'/5"')
        is_valid = true
    elseif string.sub(command:lower(),1,12)=="thunderstorm" then
        Thunderstorm = string.sub(command,13,13)
        send_command('console_echo "Thunderstorm: '..Thunderstorm..'/5"')
        is_valid = true
    elseif command=="TestMode" then
        Test = Test + 1
        if Test==3 then
            Test = 0
        end
        is_valid = true
        send_command('console_echo "Test Mode: '..tostring(Test)..'"')
    end
 
    if not is_valid then
        send_command('console_echo "gs c {Refresh|DT|DD|PetDT|Favor} {AccMode} {ImpactMode} {MeleeMode}"')
    end
    idle()
end
 
-- This function is for returning to aftercast gear after an action/event.
function idle()
    if pet.isvalid then
        if IdleMode=='DT' then
            equip(sets.aftercast.Perp_DT)
        elseif string.find(pet.name,'Spirit') then
            equip(sets.aftercast.Spirit)
        elseif IdleMode=='PetDT' then
            if ForceIlvl then
                equip(sets.aftercast.Avatar_DT_Ilvl)
            else
                equip(sets.aftercast.Avatar_DT)
            end
        elseif IdleMode=='Refresh' then
            if player.mpp < 50 then
                equip(sets.aftercast.Perp_RefreshSub50)
            else
                equip(sets.aftercast.Perp_Refresh)
            end
        elseif IdleMode=='Favor' then
            equip(sets.aftercast.Perp_Favor)
        elseif MeleeMode then
            equip(sets.aftercast.Perp_Melee)
        elseif IdleMode=='DD' then
            equip(sets.aftercast.Perp_DD)
        end
        -- Gaiters if Fleet Wind is up
        if buffactive['Quickening'] and IdleMode~='DT' and not ForceIlvl then
            equip({feet="Herald's Gaiters"})
        end
    else
        if IdleMode=='DT' then
            equip(sets.aftercast.DT)
        elseif MeleeMode and IdleMode=='DD' then
            equip(sets.aftercast.Perp_Melee)
        elseif ForceIlvl then
            equip(sets.aftercast.Idle_Ilvl)
        else
            equip(sets.aftercast.Idle)
        end
    end
end