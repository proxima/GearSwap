function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
    state.Buff.Majesty = buffactive.Majesty or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal', 'Acc')
  state.HybridMode:options('Normal', 'PDT', 'Reraise')
  state.WeaponskillMode:options('Normal', 'Acc')
  state.CastingMode:options('Normal', 'SIRD')
  state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
  state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
  state.IdleMode:options('Normal', 'Block', 'Meva')
  state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
  state.EquipShield = M(false, 'Equip Shield w/Defense')
  update_defense_mode()
 
  send_command('bind @o sat youcommand Muuhja "Horde Lullaby"')
  send_command('bind @a sat youcommand Suuhja "Spectral Floe"')
  
  send_command('bind @f12 gs c cycle CastingMode')
  send_command('bind ^f11 gs c cycle MagicalDefenseMode')
  send_command('bind !f11 gs c cycle ExtraDefenseMode')
  send_command('bind @f10 gs c toggle EquipShield')
  send_command('bind @f11 gs c toggle EquipShield')
end

function user_unload()
  send_command('unbind @f')
  send_command('unbind @o')  
  send_command('unbind ^f11')
  send_command('unbind !f11')
  send_command('unbind @f10')
  send_command('unbind @f11')
  send_command('unbind @f12')
end

Town = S {
  "Ru'Lude Gardens", "Upper Jeuno", "Lower Jeuno", "Port Jeuno",
  "Port Windurst", "Windurst Waters", "Windurst Woods", "Windurst Walls", "Heavens Tower",
  "Port San d'Oria", "Northern San d'Oria", "Southern San d'Oria", "Chateau d'Oraguille",
  "Port Bastok", "Bastok Markets", "Bastok Mines", "Metalworks",
  "Aht Urhgan Whitegate", "Nashmau",
  "Selbina", "Mhaura", "Norg",  "Kazham", "Tavanazian Safehold",
  "Eastern Adoulin", "Western Adoulin", "Celennia Memorial Library", "Mog Garden"
}

-- Define sets and vars used by this job file.
function init_gear_sets()
  Rud = {}
  Rud.AEOLIAN = { name="Rudianos's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',} }
  Rud.BLOCK =   { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',} }
  Rud.ENMITY =  { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',} }
  Rud.FC =      { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Phys. dmg. taken-10%',} }
  Rud.STP =     { name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',} }
  Rud.MEVA =    { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Occ. inc. resist. to stat. ailments+10',} }
  Rud.CURE =    { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Phys. dmg. taken-10%',} }
  Rud.SB =      { name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',} }

  Ody = {}
  Ody.FC_LEGS = { name="Odyssean Cuisses", augments={'"Mag.Atk.Bns."+11','"Fast Cast"+6','INT+7',}}
  Ody.FC_FEET = { name="Odyssean Greaves", augments={'"Fast Cast"+6','AGI+2','Mag. Acc.+14',} }
  
  MR = {}
  MR.One = {name="Moonlight Ring",bag="Wardrobe 2"}
  MR.Two = {name="Moonlight Ring",bag="Wardrobe 3"}  

  --------------------------------------
  -- Precast sets
  --------------------------------------
  -- Enmity
 
  sets.precast.Enmity = {
    ammo="Sapience Orb",
    head="Loess Barbuta +1",
    neck="Moonlight Necklace",
    ear1="Cryptic Earring",
    ear2="Trux Earring",
    body="Souv. Cuirass +1",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    ring1="Supershear Ring",
    ring2="Eihwaz Ring",
    back=Rud.ENMITY,
    waist="Creed Baudrier",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet="Eschite Greaves"
  }

  -- Precast sets to enhance JAs
  sets.precast.JA['Invincible'] = set_combine(sets.precast.Enmity, {legs="Caballarius Breeches +1"})
  sets.precast.JA['Holy Circle'] = set_combine(sets.precast.Enmity, {feet="Reverence Leggings +3"})
  sets.precast.JA['Shield Bash'] = set_combine(sets.precast.Enmity, {hands="Caballarius Gauntlets +2"})
  sets.precast.JA['Sentinel'] = set_combine(sets.precast.Enmity, {feet="Caballarius Leggings +3"})
  sets.precast.JA['Rampart'] = set_combine(sets.precast.Enmity, {head="Caballarius Coronet +1"})
  sets.precast.JA['Fealty'] = set_combine(sets.precast.Enmity, {body="Caballarius Surcoat +1"})
  sets.precast.JA['Divine Emblem'] = set_combine(sets.precast.Enmity, {feet="Chevalier's Sabatons +1"})
  sets.precast.JA['Sepulcher'] = sets.precast.Enmity
  sets.precast.JA['Palisade'] = sets.precast.Enmity
  sets.precast.JA['Cover'] = set_combine(sets.precast.Enmity, {head="Reverence Coronet +1"})
  
  sets.precast.JA['Valiance'] = sets.precast.Enmity

  sets.precast.JA['Chivalry'] = {
    body="Reverence Surcoat +3",
  }

  -- /WAR
  sets.precast.JA['Provoke'] = set_combine(sets.precast.Enmity, {})
  sets.precast.JA['Berserk'] = set_combine(sets.precast.Enmity, {})
  sets.precast.JA['Warcry'] = set_combine(sets.precast.Enmity, {})
  sets.precast.JA['Aggressor'] = set_combine(sets.precast.Enmity, {})
  sets.precast.JA['Defender'] = set_combine(sets.precast.Enmity, {})

  -- Fast cast sets for spells
  sets.precast.FC = {
    ammo="Egoist's Tathlum",
    head="Carmine Mask +1",         -- 14
    body="Reverence Surcoat +3",    -- 10
    hands="Leyline Gloves",         --  5
    legs=Ody.FC_LEGS,               --  6
    feet=Ody.FC_FEET,               -- 11
    neck="Voltsurge Torque",        --  4
    waist="Creed Baudrier",
    ear1="Tuisto Earring",
    ear2="Etiolation Earring",      --  1
    ring1=MR.One,
    ring2=MR.Two,
    back=Rud.FC                     -- 10
  }                                 --    = 71 (79 when enhancing)

  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
       
  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Egoist's Tathlum",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cryptic Earring",
    right_ear="Tuisto Earring",
    left_ring="Eihwaz Ring",
    right_ring="Vexer Ring +1",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
  }

  sets.precast.WS.Acc = {}

  sets.precast.WS['Requiescat'] = {}
  sets.precast.WS['Requiescat'].Acc = {}
  
  sets.precast.WS['Chant du Cygne'] = {}
  sets.precast.WS['Chant du Cygne'].Acc = {}
  sets.precast.WS['Sanguine Blade'] = {}
    
  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    ammo="Crepuscular Pebble",
    head="Nyame Helm",
    neck="Republican platinum medal",
    left_ear="Moonshade Earring",
    right_ear="Thrud Earring",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    ring1=MR.One,
    ring2="Shukuyu Ring",
    back=Rud.SB
  })

  sets.precast.WS['Atonement'] = {
    ammo="Sapience Orb",
    head="Loess Barbuta +1",
    neck="Moonlight Necklace",
    ear1="Cryptic Earring",
    ear2="Trux Earring",
    body="Souv. Cuirass +1",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    ring1="Supershear ring",
    ring2="Eihwaz Ring",
    back=Rud.ENMITY,
    waist="Creed Baudrier",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet="Eschite Greaves"
  }
    
  sets.precast.WS['Aeolian Edge'] = {
    ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear="Crematio Earring",
    right_ear="Friomisi Earring",
    left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    right_ring="Defending Ring",
    back=Rud.AEOLIAN
  }
  
  sets.precast.WS['Sanguine Blade'] = sets.precast.WS['Aeolian Edge']

  --------------------------------------
  -- Midcast sets
  --------------------------------------
  
  sets.midcast.FastRecast = {}
  
  sets.midcast.Enmity = set_combine(sets.precast.Enmity, {})
  
  sets.midcast.SIRD = {
    ammo="Staunch Tathlum +1",   -- 11
    head="Souveran Schaller +1", -- 20
    neck="Moonlight Necklace",   -- 15
    waist="Audumbla Sash",       -- 10
    legs="Founder's Hose",       -- 30
    feet="Odyssean Greaves",     -- 20
  }
  
  sets.midcast.Flash = set_combine(sets.midcast.Enmity, {
    ear2="Odnowa Earring +1",
    body="Reverence Surcoat +3",
    back=Rud.FC,
  })
  
  sets.midcast.Flash.SIRD = set_combine(sets.midcast.Flash, sets.midcast.SIRD)
  
  sets.midcast.Stun = sets.midcast.Flash
  
  sets.midcast.Enlight = sets.midcast.Divine
  
  sets.midcast['Enlight II'] = sets.midcast.Enlight
  
  sets.midcast.Banish = sets.precast.JA['Provoke']
  
  sets.midcast['Banish II'] = sets.midcast.Banish
  
  sets.midcast.Holy = sets.precast.JA['Provoke']

  sets.midcast['Holy II'] = sets.midcast.Holy
    
  sets.midcast.Cure = {
    ammo="Egoist's Tathlum",
    head="Loess Barbuta +1",
    body="Souveran Cuirass +1",
    hands="Macabre Gauntlets +1",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet="Odyssean Greaves",
    neck="Sacro Gorget",
    waist="Creed Baudrier",
    ear1="Cryptic Earring",
    ear2="Tuisto Earring",
    ring1="Eihwaz Ring",
    ring2="Vexer Ring +1",
    back=Rud.CURE
  }
  
  sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, sets.midcast.SIRD)
  
  sets.midcast.Reprisal = set_combine(sets.precast.FC, {
    body="Shabti Cuirass +1",
    left_ring="Kishar Ring",
    right_ring="Prolix Ring",
  })
  
  sets.midcast.Reprisal.SIRD = set_combine(sets.midcast.Reprisal, sets.midcast.SIRD)
  
  sets.midcast.Crusade = set_combine(sets.midcast.Cure, {
    body="Shabti Cuirass +1",
    hands="Regal Gauntlets",
    back=Rud.FC
  })

  sets.midcast.Crusade.SIRD = set_combine(sets.midcast.Crusade, sets.midcast.SIRD)
  
  sets.midcast['Enhancing Magic'] = {}

  sets.midcast.Phalanx = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head="Yorium Barbuta",
    body="Yorium Cuirass",
    hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
    legs="Sakpata's Cuisses",
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Creed Baudrier",
    left_ear="Mimir Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring=MR.One,
    right_ring=MR.Two,
    back="Weard Mantle",
  }
  
  sets.midcast.Phalanx.SIRD = set_combine(sets.midcast.Phalanx, sets.midcast.SIRD)

  sets.midcast.Protect = {sub= "Srivatsa", body="Shabti Cuirass +1", ring1="Sheltered Ring"}
  sets.midcast.Shell = {ring1="Sheltered Ring", body="Shabti Cuirass +1"}

  sets.midcast['Geist Wall']     = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)  
  sets.midcast.Refueling         = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)
  sets.midcast.Soporific         = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)
  sets.midcast.Banishga          = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)
  sets.midcast['Bomb Toss']      = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)
  sets.midcast['Blank Gaze']     = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)
  sets.midcast['Sheep Song']     = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)
  sets.midcast['Healing Breeze'] = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)
  sets.midcast['Wild Carrot']    = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)
  sets.midcast['Chaotic Eye']    = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)
  sets.midcast.Cocoon            = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)
  sets.midcast.Jettatura         = set_combine(sets.midcast.Enmity, sets.midcast.SIRD)

  --------------------------------------
  -- Idle/resting/defense/etc sets
  --------------------------------------

  sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
  sets.resting = {
  }

  -- Idle sets
  sets.idle = {
    main="Burtgang",
    sub="Srivatsa",               --  8
    ammo="Staunch Tathlum +1",    --  3
    head="Sakpata's Helm",        --  7
    body="Sakpata's Breastplate", -- 10
    hands="Sakpata's Gauntlets",  --  8
    legs="Sakpata's Cuisses",     --  9
    feet="Sakpata's Leggings",    --  6
    neck="Unmoving collar +1",
    waist="Asklepian Belt",
    ear1="Cryptic Earring",
    ear2="Tuisto Earring",
    left_ring=MR.One,
    right_ring="Shneddick Ring +1",
    back=Rud.BLOCK,
  }

  sets.idle.Meva = {
    main="Burtgang",
    sub="Aegis",
    ammo="Staunch Tathlum +1",    --  3
    head="Sakpata's Helm",        --  7
    body="Sakpata's Breastplate", -- 10
    hands="Sakpata's Gauntlets",  --  8
    legs="Sakpata's Cuisses",     --  9
    feet="Sakpata's Leggings",    --  6
    neck="Unmoving collar +1",
    waist="Carrier's Sash",
    ear1="Eabani Earring",
    ear2="Tuisto Earring", 
    ring1="Vexer ring +1",
    ring2="Apeile Ring +1",
    back=Rud.ENMITY               -- 10
  }
  
  sets.idle.Block = {
    main="Malevolence",
    sub="Ochain",
    ammo="Staunch Tathlum +1",      --  3
    head="Sakpata's Helm",          --  7
    neck="Agelast Torque",          -- Combatant's Torque
    body="Sakpata's Breastplate",   -- 10
    hands="Reverence Gauntlets +3",
    legs="Sakpata's Cuisses",       --  9
    feet="Sakpata's Leggings",      --  6
    waist="Flume belt +1",
    ear1="Odnowa Earring +1",       --  3
    ear2="Zwazo Earring +1",
    ring1=MR.One,                   --  5
    ring2=MR.Two,                   --  5
    back=Rud.BLOCK
  }
   
  sets.idle.Town = set_combine(sets.idle, {right_ring="Shneddick Ring +1"})
  sets.idle.Weak = sets.idle    
  sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)    
  sets.Kiting = {right_ring="Shneddick Ring +1"}
  sets.latent_refresh = {
    -- waist="Fucho-no-obi"
  }

  --------------------------------------
  -- Defense sets
  --------------------------------------
    
  -- Extra defense sets.  Apply these on top of melee or defense sets.
  sets.Knockback    = { back="Philidor mantle" }
  sets.MP           = { waist="Flume Belt +1" }
  sets.MP_Knockback = {}
    
  -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
  -- when activating or changing defense mode:
  sets.PhysicalShield = {main="Burtgang", sub="Ochain"}
  sets.MagicalShield  = {main="Burtgang", sub="Aegis"}

  -- Basic defense sets.      
  sets.defense.PDT = {}
  sets.defense.HP = {}
  sets.defense.Reraise = {}
  sets.defense.Charm = {}

  sets.defense.MDT = {
    main="Burtgang",
    sub="Aegis",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Moonlight Necklace",
    waist="Carrier's Sash",
    ear1="Eabani Earring",
    ear2="Sanare Earring",
    ring1="Vexer ring +1",
    ring2="Apeile Ring +1",
    back=Rud.MEVA
  }

  --------------------------------------
  -- Engaged sets
  --------------------------------------
  sets.engaged = {
    ammo="Staunch Tathlum +1",      --  3
    head="Hjarrandi Helm",          -- 10
    body="Hjarrandi Breastplate",   -- 12
    hands="Reverence Gauntlets +3",
    legs="Volte Brayettes",         --  7
    feet="Reverence Leggings +3",   --  6
    neck="Agelast Torque",          -- Combatants Torque
    waist="Sailfi belt +1",
    ear1="Odnowa Earring +1",       --  3
    ear2="Zwazo Earring +1",
    ring1=MR.One,                   --  5
    ring2=MR.Two,                   --  5
    back=Rud.BLOCK
  }

  --------------------------------------
  -- Custom buff sets
  --------------------------------------
  
  sets.buff.Doom = {neck="Nicander's Necklace", -- 20
    ring1={name="Eshmun's Ring", bag="wardrobe3"}, -- 20
    ring2={name="Eshmun's Ring", bag="wardrobe5"}, -- 20
    waist="Gishdubar Sash", --10
  }

  sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
  -- If DefenseMode is active, apply that gear over midcast
  -- choices.  Precast is allowed through for fast cast on
  -- spells, but we want to return to def gear before there's
  -- time for anything to hit us.
  -- Exclude Job Abilities from this restriction, as we probably want
  -- the enhanced effect of whatever item of gear applies to them,
  -- and only one item should be swapped out.
  if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
    handle_equipping_gear(player.status)
    eventArgs.handled = true
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
  classes.CustomDefenseGroups:clear()
  classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
  if state.EquipShield.value == true then
    classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
  end

  classes.CustomMeleeGroups:clear()
  classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
  update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  if player.mpp < 51 then
    idleSet = set_combine(idleSet, sets.latent_refresh)
  end

  if state.Buff.Doom then
    idleSet = set_combine(idleSet, sets.buff.Doom)
  end
  
  return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if state.Buff.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end
    
  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.ExtraDefenseMode.value ~= 'None' then
    defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
  end
  
  if state.EquipShield.value == true then
    defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
  end
  
  if state.Buff.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end
  
  return defenseSet
end

function display_current_job_state(eventArgs)
  local msg = 'Melee'
  
  if state.CombatForm.has_value then
    msg = msg .. ' (' .. state.CombatForm.value .. ')'
  end
  
  msg = msg .. ': '
  
  msg = msg .. state.OffenseMode.value
  if state.HybridMode.value ~= 'Normal' then
    msg = msg .. '/' .. state.HybridMode.value
  end
  
  msg = msg .. ', WS: ' .. state.WeaponskillMode.value
  
  if state.DefenseMode.value ~= 'None' then
    msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
  end

  if state.ExtraDefenseMode.value ~= 'None' then
    msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
  end
  
  if state.EquipShield.value == true then
    msg = msg .. ', Force Equip Shield'
  end
  
  if state.Kiting.value == true then
    msg = msg .. ', Kiting'
  end

  if state.PCTargetMode.value ~= 'default' then
      msg = msg .. ', Target PC: '..state.PCTargetMode.value
  end

  if state.SelectNPCTargets.value == true then
    msg = msg .. ', Target NPCs'
  end

  add_to_chat(122, msg)

  eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
  if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
      classes.CustomDefenseGroups:append('Kheshig Blade')
  end
  
  if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
    if player.equipment.sub and not player.equipment.sub:contains('Shield') and
       player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
      state.CombatForm:set('DW')
    else
      state.CombatForm:reset()
    end
  end
end

function job_buff_change(buff, gain)
  if state.Buff[buff] ~= nil then
    state.Buff[buff] = gain
    handle_equipping_gear(player.status)
  end

  if not midaction() then
      handle_equipping_gear(player.status)
  end

  -- if not gain then 
  --    if tostring(buff) == 'Majesty' and not Town:contains(world.area) then
  --        windower.send_command('input /ja Majesty <me>')
  --    end
  -- end

  if buff:lower() == 'paralysis' then
    if gain then
      send_command('@input /echo Paralyna')
    end
  end

  if buff:lower() == 'slow' then
    if gain then
      send_command('@input /echo Erase - Slowed')
    end
  end
  
  if buff:lower() == 'sleep' then
    if gain then
      send_command('@input /p zzz')
    end
  end

  if buff:lower() == 'doom' then
    if gain then
      send_command('input /p Doom on -- halp')
      equip(sets.Doom)
      send_command('@input /item "Holy Water" <me>')
      disable('ring1', 'ring2', 'waist', 'legs')
    elseif not gain and not player.status == "Dead" and not player.status == "Engaged Dead" then
      enable('ring1', 'ring2', 'waist', 'legs')
      send_command('input /p Doom off.')
      handle_equipping_gear(player.status)
    else
      enable('ring1', 'ring2', 'waist', 'legs')
      send_command('input /p '..player.name..' is no longer doomed.')
      handle_equipping_gear(player.status)
    end
  end
end
---End of Maps----------------------------------------------------------------------------------------------------------------------------------------------------------

function msg(str)
  send_command('@input /echo <----- ' .. str .. ' ----->')
end

------------------------------------------
-- Macro and Style Change on Job Change
------------------------------------------
function set_macros(sheet,book)
  if book then 
    send_command('@input /macro book '..tostring(book)..';wait 1;input /macro set '..tostring(sheet))
    return
  end

  send_command('@input /macro set '..tostring(sheet))
end

function set_style(sheet)
  send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end

--Page, Book--
set_macros(1,15)
--Use the Lockstyle Number-- 
set_style(1) 

------------------------------------------
-- Variables
------------------------------------------
SetLocked = false --Used to Check if set is locked before changing equipment
LockedEquipSet = {} --Placeholder to store desired lock set
LockGearSet = {}
equipSet = {} --Currently Equiped Gearset
LockGearIndex = false
LockGearIndex = false
TargetDistance = 0
TH = false -- Defaults
SIR = false -- Spell Interruption Rate
TankingTP = true -- If true, default set is tanking TP array.
-----------------------------
--      Spell control      --
-----------------------------
unusable_buff = {
    spell={'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'},
    ability={'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'}}
  --check_recast('ability',spell.recast_id)  check_recast('spell',spell.recast_id)
function check_recast(typ,id) --if spell can be cast(not in recast) return true
    local recasts = windower.ffxi['get_'..typ..'_recasts']()
    if id and recasts[id] and recasts[id] == 0 then
        return true
    else
        return false
    end
end
 --return true if spell/ability is unable to be used at this time
function spell_control(spell)
  if spell.type == "Item" then
    return false
  --Stops spell if you do not have a target
  elseif spell.target.name == nil and not spell.target.raw:contains("st") then
    return true
  --Stops spell if a blocking buff is active
  elseif spell.action_type == 'Ability' and spell.type ~= 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability) or not check_recast('ability',spell.recast_id)) then
    return true
  elseif spell.type == 'WeaponSkill' and player.tp < 1000 then
    return true
  elseif spell.type == 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability)) then
    msg("Weapon Skill Canceled, Can't")
    return true
  elseif spell.action_type == 'Magic' and (has_any_buff_of(unusable_buff.spell) or not check_recast('spell',spell.recast_id)) then
    return true
  --Stops spell if you do not have enuf mp/tp to use
  elseif spell.mp_cost and spell.mp_cost > player.mp and not has_any_buff_of({'Manawell','Manafont'}) and not spell.action_type == 'Ability' then
    msg("Spell Canceled, Not Enough MP")
    return true
  end

  if spell.name == 'Utsusemi: Ichi' and overwrite and buffactive['Copy Image (3)'] then
    return true
  end

  if player.tp >= 1000 and player.target and player.target.distance and player.target.distance > 7 and spell.type == 'WeaponSkill' then
    msg("Weapon Skill Canceled  Target Out of Range")
    return true
  end
end