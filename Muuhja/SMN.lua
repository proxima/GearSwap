-- Summoner Gearswap Lua by Pergatory - http://pastebin.com/u/pergatory
-- IdleMode determines the set used after casting. You change it with "/console gs c <IdleMode>"
-- The out-of-the-box modes are:
-- Refresh: Uses the most refresh available.
-- DT: A mix of refresh, PDT, and MDT to help when you can't avoid AOE.
-- Favor: Uses Beckoner's Horn and max smn skill to boost the favor effect.
 
-- You can add your own modes in the IdleModes list, just make sure to add corresponding sets as well.
 
-- Additional Bindings:
-- F9 - Toggles between a subset of IdleModes (Refresh > Favor > DT)
-- F10 - Toggles WeaponLock (When enabled, equips Nirvana and Elan+1, then disables those 2 slots from swapping)
--       NOTE: If you don't already have the Nirvana & Elan+1 equipped, YOU WILL LOSE TP
 
-- Additional Commands:
-- /console gs c AccMode - Toggles high-accuracy sets to be used where appropriate.
-- /console gs c ImpactMode - Toggles between using normal magic BP set for Fenrir's Impact or a custom high-skill set for debuffs.
-- /console gs c TH - Treasure Hunter toggle. By default, this is only used for Dia, Dia II, and Diaga.
-- /console gs c LagMode - Used to help BPs land in the right gear in high-lag situations.
--                          Sets a timer to swap gear 0.5s after the BP is used rather than waiting for server response.
 
function file_unload()
    send_command('unbind f9')
    send_command('unbind f11')
    send_command('unbind ^f9')
    send_command('unbind ^f10')
    enable("main","sub","range","ammo","head","neck","ear1","ear2","body","hands","ring1","ring2","back","waist","legs","feet")
end
 
function get_sets()
    send_command('bind f9 gs c ToggleIdle')  -- F9 = Cycle through commonly used idle modes
    send_command('bind ^f9 gs c WeaponLock') -- F10 = Toggle Melee Mode
    send_command('bind ^f10 gs c TH')        -- Ctrl+F10 = Treasure Hunter toggle
 
    MeteorStrike = 1
    HeavenlyStrike = 1
    WindBlade = 1
    Geocrush = 5
    Thunderstorm = 1
    GrandFall = 1

    StartLockStyle = '1'
    IdleMode = 'DT'
    AccMode = false
    ImpactDebuff = false
    WeaponLock = false
    TreasureHunter = false
    THSpells = S{"Dia","Dia II","Diaga"} -- If you want Treasure Hunter gear to swap for a spell/ability, add it here.
    LagMode = true                       -- Default LagMode. If you have a lot of lag issues, change to "true".
                                         -- Warning: LagMode can cause problems if you spam BPs during Conduit because it doesn't trust server packets to say whether the BP is readying or not.
    SacTorque = true                     -- If you have Sacrifice Torque, this will auto-equip it when slept in order to wake up.
    AutoRemedy = false                   -- Auto Remedy when using an ability while Paralyzed.
    AutoEcho = false                     -- Auto Echo Drop when using an ability while Silenced.
 
    -- Add idle modes here if you need more options for your sets
    IdleModes = {'Refresh', 'Favor', 'DT'}

    MerlHands = {}
    MerlHands.PHYS    = { name="Merlinic Dastanas", augments={'Pet: Attack+28 Pet: Rng.Atk.+28','Blood Pact Dmg.+9','Pet: STR+4','Pet: Mag. Acc.+7',}}
    MerlHands.MAG     = { name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+25 Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+9','Pet: DEX+3','Pet: Mag. Acc.+11',}}
    MerlHands.REFRESH = { name="Merlinic Dastanas", augments={'Weapon skill damage +1%','"Avatar perpetuation cost" -1','"Refresh"+2','Accuracy+9 Attack+9','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
    -- MerlHands.TH      = { name="Merlinic Dastanas", augments={'Magic dmg. taken -2%','Pet: Phys. dmg. taken -2%','"Treasure Hunter"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}      
    MerlHands.FC      = { name="Merlinic Dastanas", augments={'MND+5','Pet: DEX+3','"Fast Cast"+8','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}

    MerlLegs = {}
    MerlLegs.REFRESH = { name="Merlinic Shalwar", augments={'Mag. Acc.+15','Attack+2','"Refresh"+2','Accuracy+10 Attack+10',}}
    -- ===================================================================================================================
    --      Sets
    -- ===================================================================================================================
 
     sets.idle = {}
 
     sets.idle.Refresh = {
      main="Nirvana",               -- 8 perp, can use jse
      sub="Khonsu",                 -- 
      ammo="Epitaph",
      head="Beckoner's Horn +3",    -- 4 favor, 3 refresh
      neck="Caller's Pendant",      -- 1 perp sometimes
      ear1="Evans earring",         -- 2 perp
      ear2="Beckoner's earring +1", -- 2 refresh
      body="Apo. Dalmatica +1",     -- 4 refresh
      hands=MerlHands.REFRESH,      -- 2 refresh 1 perp
      ring1="Stikini Ring +1",      -- 1 refresh
      ring2="Evoker's Ring",        -- 1 refresh
      legs=MerlLegs.REFRESH,        -- 2 refresh
      feet="Baayami Sabots +1",     -- 3 refresh
      waist="Lucidity Sash",        -- 2 perp
      back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','Damage taken-5%',}}, -- avatar level
    }

    sets.idle.Favor = set_combine(sets.idle.Refresh, {
      head="Beckoner's Horn +3",
      ear2="Lodurr Earring",
      hands="Baayami Cuffs",
      legs="Baayami Slops",
      feet="Baayami Sabots +1",
      back="Conveyance cape",
    })

    sets.idle.DT = set_combine(sets.idle.Refresh, {
      neck="Loricate Torque +1",
      body="Bunzi's Robe",
      hands="Bunzi's Gloves",
      legs="Bunzi's Pants",
      feet="Bunzi's Sabots",
    })

    -- Treasure Hunter set. Don't put anything in here except TH+ gear.
    -- It overwrites slots in other sets when TH toggle is on (Ctrl+F10).
    sets.TH = {
      -- hands=MerlHands.TH,
      waist="Chaac Belt",
    }
 
    sets.precast = {}
 
    -- Fast Cast
    sets.precast.FC = {
      head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+10','"Fast Cast"+7','INT+8','Mag. Acc.+13',}}, -- 15
      body="Inyanga Jubbah +2", -- 14
      hands=MerlHands.FC, -- 8
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
    -- Use BP Recast Reduction here, along with Avatar's Favor gear.
    -- Avatar's Favor skill tiers are 512 / 575 / 670.
    sets.midcast.BP = {
      main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
      sub="Vox Grip",
      ammo="Sancus Sachet +1",
      head="Beckoner's Horn +3",
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
 
    -- Elemental Siphon sets. Chatoyant Staff by weather, and Twilight Cape by both.
    sets.midcast.Siphon = {
      main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
      sub="Vox Grip",
      ammo="Sancus Sachet +1",
      head="Beckoner's Horn +3",
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
  
    sets.midcast.SiphonWeather = set_combine(sets.midcast.Siphon, { main="Chatoyant Staff" })
     
    -- Summoning Midcast, cap spell interruption if possible (Baayami Robe gives 100, need 2 more)
    -- PDT isn't a bad idea either, so don't overwrite a lot from the DT set it inherits from.
    sets.midcast.Summon = set_combine(sets.idle.DT, {
      body="Baayami Robe"
    })
 
    -- If you ever lock your weapon, keep that in mind when building cure potency set.
    sets.midcast.Cure = {
      head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      body="Bunzi's Robe",
      hands="Inyan. Dastanas +2",
      legs="Bunzi's Pants",
      feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      neck="Warder's Charm +1",
      waist="Bishop's Sash",
      left_ear="Meili Earring",
      right_ear="Mendi. Earring",
      left_ring="Stikini Ring +1",
      right_ring="Stikini Ring +1",
      back={ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
    }
 
    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
      neck="Debilis medallion",
      left_ring="Menelaus's ring",
      right_ring="Haoma's ring",
    })
    
    -- Just a standard set for spells that have no set
    sets.midcast.EnmityRecast = set_combine(sets.precast.FC, {
    })
 
    -- Strong alternatives: Daybreak and Ammurapi Shield, Cath Crown, Gwati Earring
    sets.midcast.Enfeeble = {
    }

    sets.midcast.Enfeeble.INT = set_combine(sets.midcast.Enfeeble, {
    })
 
    sets.midcast.Enhancing = {
    }
 
    sets.midcast.Stoneskin = set_combine(sets.midcast.Enhancing, {
    })
 
    sets.midcast.Nuke = {
    }
 
    sets.midcast["Refresh"] = set_combine(sets.midcast.Enhancing, {
	  head="Amalric coif +1",
	  waist="Gishdubar sash"
    })
 
    sets.midcast["Aquaveil"] = set_combine(sets.midcast.Enhancing, {
       head="Amalric coif +1",
       waist="Emphatikos rope",
    })
 
    sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeeble, {
      main="Daybreak",
      sub="Ammurapi Shield"
    })
 
    sets.midcast["Mana Cede"] = { hands="Beckoner's Bracers +2" }
    sets.midcast["Astral Flow"] = { head="Glyphic Horn" }
    
    -- ===================================================================================================================
    --  Weaponskills
    -- ===================================================================================================================
 
    -- Magic accuracy can be nice here to land the defense down effect. Also keep in mind big damage Garland can make it
    -- harder for multiple people to get AM3 on trash mobs before popping an NM.
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
      waist="Orpheus's Sash",
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
    
    sets.midcast["Shell Crusher"] = sets.midcast["Garland of Bliss"]
 
    sets.pet_midcast = {}
 
    -- Main physical pact set (Volt Strike, Pred Claws, etc.)
    -- Prioritize BP Damage & Pet: Double Attack
    -- Strong Alternatives:
    -- Gridarvor, Apogee Crown, Apogee Pumps, Convoker's Doublet, Apogee Dalmatica, Shulmanu Collar (equal to ~R15 Collar), Gelos Earring, Regal Belt
    sets.pet_midcast.Physical_BP = {
      main="Nirvana",
      sub="Elan Strap +1",
      ammo="Epitaph",
      head={ name="Helios Band", augments={'Pet: Accuracy+29 Pet: Rng. Acc.+29','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
      body="Glyphic Doublet +3",
      hands=MerlHands.PHYS,
      legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
      feet={ name="Helios Boots", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
      neck={ name="Smn. Collar +2", augments={'Path: A',}},
      waist="Incarnation Sash",
      left_ear="Lugalbanda Earring",
      right_ear="Sroda Earring",
      left_ring="Fickblix's Ring",
      right_ring="Cath Palug Ring",
      back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10',}},
    }
 
    -- Physical Pact AM3 set, less emphasis on Pet:DA
    sets.pet_midcast.Physical_BP_AM3 = set_combine(sets.pet_midcast.Physical_BP, {
      right_ear="Beckoner's earring +1",
      body="Convoker's Doublet +3",
      right_ring="Varar Ring +1",
      feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}}
    })
 
    -- Physical pacts which benefit more from TP than Pet:DA (like Spinning Dive and other pacts you never use except that one time)
    sets.pet_midcast.Physical_BP_TP = set_combine(sets.pet_midcast.Physical_BP, {
      head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
      right_ear="Beckoner's earring +1",
      body="Convoker's Doublet +3",
      right_ring="Varar Ring +1",
      waist="Regal Belt",
      legs="Enticer's Pants",
      feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}}
    })
 
    -- Used for all physical pacts when AccMode is true
    sets.pet_midcast.Physical_BP_Acc = set_combine(sets.pet_midcast.Physical_BP, {
      head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
      right_ear="Beckoner's earring +1",
      right_ring="Varar Ring +1",
      body="Convoker's Doublet +3",
      hands="Convoker's Bracers +3",
    })
 
    -- Base magic pact set
    -- Prioritize BP Damage & Pet:MAB
    -- Strong Alternatives:
    -- Espiritus, Apogee Crown, Adad Amulet (equal to ~R12 Collar)
    sets.pet_midcast.Magic_BP_Base = {
      main="Grioavolr", -- or Espiritus
      sub="Elan Strap +1",
      ammo="Epitaph",
      head="C. Palug Crown",
      body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      hands=MerlHands.MAG,
      legs={ name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      neck={ name="Smn. Collar +2", augments={'Path: A',}},
      waist="Regal Belt",
      left_ear="Lugalbanda Earring",
      right_ear="Beckoner's earring +1",
      left_ring="Fickblix's Ring",
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
      hands=MerlHands.MAG
    })
 
    sets.pet_midcast.Magic_BP_NoTP_Acc = set_combine(sets.pet_midcast.Magic_BP_NoTP, {
      body="Convoker's Doublet +3",
      hands=MerlHands.MAG
    })
 
    -- Favor BP Damage above all. Pet:MAB also very strong.
    -- Pet: Accuracy, Attack, Magic Accuracy moderately important.
    -- Strong Alternatives:
    -- Keraunos, Grioavolr, Espiritus, Was, Apogee Crown, Apogee Dalmatica, Adad Amulet
    sets.pet_midcast.FlamingCrush = {
      main="Nirvana",
      sub="Elan Strap +1",
      ammo="Epitaph",
      head="C. Palug Crown",
      body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      hands=MerlHands.MAG,
      legs={ name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
      neck={ name="Smn. Collar +2", augments={'Path: A',}},
      waist="Regal Belt",
      left_ear="Lugalbanda Earring",
      right_ear="Beckoner's earring +1",
      left_ring={name="Varar Ring +1", bag="wardrobe"},
      right_ring="Fickblix's Ring",
      back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10',}},
    }
 
    sets.pet_midcast.FlamingCrush_Acc = set_combine(sets.pet_midcast.FlamingCrush, {
      body="Convoker's Doublet +3",
    })
 
    -- Pet: Magic Acc set - Mainly used for debuff pacts like Shock Squall
    sets.pet_midcast.MagicAcc_BP = {
      main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
      sub="Vox Grip",
      ammo="Epitaph",
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
      feet="Bunzi's sabots"
    }
 
    sets.pet_midcast.Debuff_Rage = sets.pet_midcast.MagicAcc_BP
 
    -- Pure summoning magic set, mainly used for buffs like Hastega II.
    -- Strong Alternatives:
    -- Andoaa Earring, Summoning Earring, Lamassu Mitts +1, Caller's Pendant
    sets.pet_midcast.SummoningMagic = {
      main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
      sub="Vox Grip",
      ammo="Epitaph",
      head="Beckoner's Horn +3",
      body="Baayami Robe",     -- + 1 if you're rich
      hands="Baayami Cuffs",   -- + 1 if you're rich
      legs="Baayami Slops",    -- + 1 if you're rich
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
    
    -- Wind's Blessing set. Pet:MND increases potency.
    sets.pet_midcast.Buff_MND = set_combine(sets.pet_midcast.Buff, {
      main="Nirvana",
      sub="Vox Grip",
      neck="Summoner's Collar +2",
    })
 
    -- Don't drop Avatar level in this set if you can help it.
    -- You can use Avatar:HP+ gear to increase the HP recovered, but most of it will decrease your own max HP.
    sets.pet_midcast.Buff_Healing = set_combine(sets.pet_midcast.Buff, {
      main="Nirvana",
    })
 
    -- This set is used for certain blood pacts when ImpactDebuff mode is turned ON. (/console gs c ImpactDebuff)
    -- These pacts are normally used with magic damage gear, but they're also strong debuffs when enhanced by summoning skill.
    -- This set is safe to ignore.
    sets.pet_midcast.Impact = set_combine(sets.pet_midcast.SummoningMagic, {
      main="Nirvana",
      head="Convoker's Horn +2",
      ear1="Lugalbanda Earring",
      ear2="Enmerkar Earring"
    })
  
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
    Physical_BPs_TP = S{'Rock Buster','Mountain Buster','Crescent Fang','Spinning Dive','Roundhouse'}
end
 
-- ===================================================================================================================
--      Gearswap rules below this point - Modify at your own peril
-- ===================================================================================================================
 
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
    if (pet.isvalid and pet_midaction() and not spell.type=="SummonerPact") or spell.type=="Item" then
        -- Do not swap if pet is mid-action. I added the type=SummonerPact check because sometimes when the avatar
        -- dies mid-BP, pet.isvalid and pet_midaction() continue to return true for a brief time.
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
        if pet.element==world.weather_element then
            equip(sets.midcast.SiphonWeather)
        else
            equip(sets.midcast.Siphon)
        end
    elseif spell.type=="SummonerPact" then
        equip(sets.midcast.Summon)
    elseif string.find(spell.name,"Cure") or string.find(spell.name,"Curaga") then
        equip(sets.midcast.Cure)
    elseif string.find(spell.name,"Protect") or string.find(spell.name,"Shell") then
        equip(sets.midcast.Enhancing,{ring2="Sheltered Ring"})
    elseif spell.skill=="Enfeebling Magic" then
        equip(sets.midcast.Enfeeble)
    elseif spell.skill=="Enhancing Magic" then
        equip(sets.midcast.Enhancing)
    elseif spell.skill=="Elemental Magic" then
        equip(sets.midcast.Nuke)
    elseif spell.action_type=="Magic" then
        equip(sets.midcast.EnmityRecast)
    else
        idle()
    end
    -- Treasure Hunter
    if TreasureHunter and THSpells:contains(spell.name) then
        equip(sets.TH)
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
 
function pet_change(pet,gain)
    if (not (gain and pet_midaction())) then
        idle()
    end
end
 
function status_change(new,old)
    if not midaction() and not pet_midaction() then
        idle()
    end
end
 
function buff_change(name,gain)
    if name=="quickening" and not pet_midaction() then
        idle()
    end

    if SacTorque and name=="sleep" and gain and pet.isvalid then
        equip({neck="Sacrifice Torque"})

        disable("neck")

        if buffactive["Stoneskin"] then
            windower.send_command('cancel 37;')
        end
    end
    if SacTorque and name=="sleep" and not gain then
        enable("neck")
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
    -- Custom Timers
    -- if spell=="Mewing Lullaby" and string.find(world.area,"Walk of Echoes [P") then
    --     send_command('timers create "Mewing Resist" 60 down') -- In Gaol, underperforms if used every 20s. 30s wait is better. 60s is full potency.
    -- end
end
 
-- This command is called whenever you input "gs c <command>"
function self_command(command)
    is_valid = command:lower()=="idle"
    
    for _, v in ipairs(IdleModes) do
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
    elseif command:lower()=="lagmode" then
        LagMode = LagMode==false
        is_valid = true
        send_command('console_echo "Lag Compensation Mode: '..tostring(LagMode)..'"')
    elseif command:lower()=="th" then
        TreasureHunter = TreasureHunter==false
        is_valid = true
        send_command('console_echo "Treasure Hunter Mode: '..tostring(TreasureHunter)..'"')
    elseif command:lower()=="weaponlock" then
        if WeaponLock then
            enable("main","sub")
            WeaponLock = false
        else
            equip({main="Nirvana",sub="Elan Strap +1"})
            disable("main","sub")
            WeaponLock = true
        end
        is_valid = true
        send_command('console_echo "Weapon Lock: '..tostring(WeaponLock)..'"')
    elseif command=="ToggleIdle" then
        is_valid = true
        -- If you want to change the sets cycled with F9, this is where you do it
        if IdleMode=="Refresh" then
            IdleMode = "Favor"
    elseif IdleMode=="Favor" then
            IdleMode = "DT"
        else
            IdleMode = "Refresh"
        end
        send_command('console_echo "Idle Mode: ['..IdleMode..']"')
    elseif command:lower()=="lowhp" then
        -- Use for "Cure 500 HP" objectives in Omen
        equip({head="Apogee Crown +1",body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},legs="Apogee Slacks +1",feet="Apogee Pumps +1",back="Campestres's Cape"})
        return
    end
 
    if is_valid then
        if not midaction() and not pet_midaction() then
            idle()
        end
    else
        sanitized = command:gsub("\"", "")
        send_command('console_echo "Invalid self_command: '..sanitized..'"') -- Note: If you use Gearinfo, comment out this line
    end
end
 
-- This function is for returning to aftercast gear after an action/event.
function idle()
    equipSet = sets.idle

    if equipSet[IdleMode] then
        equipSet = equipSet[IdleMode]
    end

    if equipSet[player.status] then
        equipSet = equipSet[player.status]
    end

    equip(equipSet)
 
    if buffactive['Quickening'] and IdleMode~='DT' then
        equip({feet="Herald's Gaiters"})
    end
end