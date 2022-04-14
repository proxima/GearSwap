-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+H ]           Toggle Charm Defense Mods
--              [ WIN+D ]           Toggle Death Defense Mods
--              [ WIN+K ]           Toggle Knockback Defense Mods
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Use current Rune
--              [ CTRL+- ]          Rune element cycle forward.
--              [ CTRL+= ]          Rune element cycle backward.
--              [ CTRL+` ]          Use current Rune
--
--              [ CTRL+Numpad/ ]    Berserk/Meditate/Souleater
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki/Arcane Circle
--              [ CTRL+Numpad- ]    Aggressor/Third Eye/Weapon Bash
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+G ]          Cycles between available greatswords
--              [ CTRL+W ]          Toggle Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Resolution
--              [ CTRL+Numpad8 ]    Upheaval
--              [ CTRL+Numpad9 ]    Dimidiation
--              [ CTRL+Numpad5 ]    Ground Strike
--              [ CTRL+Numpad6 ]    Full Break
--              [ CTRL+Numpad1 ]    Herculean Slash
--              [ CTRL+Numpad2 ]    Shockwave
--              [ CTRL+Numpad3 ]    Armor Break
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------


--  gs c rune                       Uses current rune
--  gs c cycle Runes                Cycles forward through rune elements
--  gs c cycleback Runes            Cycles backward through rune elements


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  mote_include_version = 2
 
  -- Load and initialize the include file.
  include('Mote-Include.lua')
  res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()
  rune_enchantments = S{'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}
 
  -- /BLU Spell Maps
  blue_magic_maps = {}
 
  blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific', 'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
  blue_magic_maps.Cure = S{'Wild Carrot'}
  blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}
 
  no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)", "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
 
  rayke_duration = 35
  gambit_duration = 96
 
  state.Buff['Fast Cast'] = buffactive['Fast Cast']
  
  lockstyleset = 2
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
  state.OffenseMode:options('Normal', 'Parry')
  state.WeaponskillMode:options('Normal', 'Acc')
  state.HybridMode:options('Normal', 'DT')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'DT', 'Refresh')
  state.PhysicalDefenseMode:options('PDT')
  state.MagicalDefenseMode:options('MDT')

  state.Knockback = M(false, 'Knockback')

  state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'EpeolatryTank', 'Aettir', 'Lycurgos'}
  state.AttackMode = M{['description']='Attack', 'Uncapped', 'Capped'}
  state.WeaponLock = M(false, 'Weapon Lock')

  state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

  send_command('bind ^` input //gs c rune')
  send_command('bind !` input /ja "Vivacious Pulse" <me>')
  send_command('bind ^insert gs c cycleback Runes')
  send_command('bind ^delete gs c cycle Runes')
  send_command('bind ^f11 gs c cycle MagicalDefenseMode')
  send_command('bind @a gs c cycle AttackMode')
  send_command('bind @e gs c cycleback WeaponSet')
  send_command('bind @r gs c cycle WeaponSet')
  send_command('bind @w gs c toggle WeaponLock')
  send_command('bind @k gs c toggle Knockback')
  send_command('bind !q input /ma "Temper" <me>')

  if player.sub_job == 'BLU' then
    send_command('bind !w input /ma "Cocoon" <me>')
  elseif player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
  elseif player.sub_job == 'DRK' then
    send_command('bind !w input /ja "Last Resort" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Hasso" <me>')
  end

  send_command('bind !o input /ma "Regen IV" <stpc>')
  send_command('bind !p input /ma "Shock Spikes" <me>')

  send_command('bind @w gs c toggle WeaponLock')

  if player.sub_job == 'WAR' then
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'DRK' then
    send_command('bind ^numpad/ input /ja "Souleater" <me>')
    send_command('bind ^numpad* input /ja "Arcane Circle" <me>')
    send_command('bind ^numpad- input /ja "Weapon Bash" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Third Eye" <me>')
  end

  send_command('bind ^numpad7 input /ws "Resolution" <t>')
  send_command('bind ^numpad8 input /ws "Upheaval" <t>')
  send_command('bind ^numpad9 input /ws "Dimidiation" <t>')
  send_command('bind ^numpad5 input /ws "Ground Strike" <t>')
  send_command('bind ^numpad6 input /ws "Full Break" <t>')
  send_command('bind ^numpad1 input /ws "Herculean Slash" <t>')
  send_command('bind ^numpad2 input /ws "Shockwave" <t>')
  send_command('bind ^numpad3 input /ws "Armor Break" <t>')

  select_default_macro_book()
  set_lockstyle()

  state.Auto_Kite = M(false, 'Auto_Kite')
  moving = false
  
  AF = {}
  AF.Head = "Rune. Bandeau +2"
  AF.Body = "Runeist's Coat +2"
  AF.Hands = "Runeist's Mitons +2"
  AF.Legs = "Rune. Trousers +2"
  AF.Feet = "Runeist's Boots +2"

  Relic = {}
  Relic.Head  = "Futhark Bandeau +3"
  Relic.Body  = "Futhark Coat +3"
  Relic.Hands = "Futhark Mitons +1"
  Relic.Legs  = "Futhark Trousers +3"
  Relic.Feet  = "Futhark Boots +1"
  
  Empy = {}
  Empy.Head  = "Erilaz Galea +1"
  Empy.Body  = "Erilaz Surcoat +1"
  Empy.Hands = "Erilaz Gauntlets +1"
  Empy.Legs  = "Erilaz Leg Guards +1"
  Empy.Feet  = "Erilaz Greaves +1"
  
  Cape = {}
  Cape.Reive  = { name="Evasionist's Cape", augments={'Enmity+1','"Embolden"+15','"Dbl.Atk."+1',}}
  Cape.Enmity = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}}
  Cape.FC     = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
  Cape.WSD    = { name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
  Cape.Parry  = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Store TP"+10','Parrying rate+5%',}}

  TaeonPhalanx = {}
  TaeonPhalanx.Body = { name="Taeon Tabard", augments={'Mag. Evasion+20','Spell interruption rate down -10%','Phalanx +3',}}
  TaeonPhalanx.Hands = {name="Taeon Gloves", augments={'Mag. Evasion+20','Phalanx +3',}}
  TaeonPhalanx.Legs = {name="Taeon Tights", augments={'Mag. Evasion+20','Phalanx +3',}}
  TaeonPhalanx.Feet = {name="Taeon Boots", augments={'Mag. Evasion+20','Spell interruption rate down -10%','Phalanx +3',}}  
end

function user_unload()
  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind ^f11')
  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind @a')
  send_command('unbind @d')
  send_command('unbind !q')
  send_command('unbind @w')
  send_command('unbind @e')
  send_command('unbind @r')
  send_command('unbind !o')
  send_command('unbind !p')
  send_command('unbind ^,')
  send_command('unbind @w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad7')
  send_command('unbind ^numpad9')
  send_command('unbind ^numpad5')
  send_command('unbind ^numpad1')
  send_command('unbind @numpad*')
  
  send_command('unbind #`')
  send_command('unbind #1')
  send_command('unbind #2')
  send_command('unbind #3')
  send_command('unbind #4')
  send_command('unbind #5')
  send_command('unbind #6')
  send_command('unbind #7')
  send_command('unbind #8')
  send_command('unbind #9')
  send_command('unbind #0')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
 
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
 
  sets.Enmity = {
    ammo="Staunch Tathlum +1",
    head="Halitus Helm",
    body="Emet Harness +1",
    hands="Kurys Gloves",
    legs=Empy.Legs,
    feet=Empy.Feet,
    neck="Moonlight necklace",
    waist="Kasiri Belt",
    left_ear="Cryptic Earring",
    right_ear={ name="Tuisto Earring", priority=1},
    left_ring={ name="Eihwaz Ring", priority=1},
    right_ring="Supershear Ring",
    back=Cape.Enmity
  }
  
  sets.Enmity.DT = {
    ammo="Staunch Tathlum +1",
    head="Halitus Helm",
    body="Emet Harness +1",
    hands="Kurys Gloves",
    legs=Empy.Legs,
    feet=Empy.Feet,
    neck={ name="Futhark Torque +2", augments={'Path: A',}},
    waist="Kasiri Belt",
    right_ear={ name="Odnowa Earring +1", priority=1},
    left_ear="Cryptic Earring",
    left_ring={ name="Eihwaz Ring", priority=1},
    right_ring={ name="Gelatinous Ring +1", priority=1},
    back=Cape.Enmity
  }

  sets.Enmity.SIRD = {
    ammo="Staunch Tathlum +1",
    head="Agwu's Cap",  
    body="Nyame Mail",   
    hands="Rawhide Gloves",
    legs="Carmine Cuisses +1",
    feet=TaeonPhalanx.Feet,
    neck="Moonlight Necklace",
    waist="Audumbla Sash",
    left_ear="Cryptic Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back=Cape.Enmity
  }
   
  sets.precast.JA['Vallation'] = set_combine(sets.Enmity, {
    body=AF.Body,
    legs=Relic.Legs,
  })
 
  sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
  
  sets.precast.JA['Pflug'] = set_combine(sets.Enmity, {feet=AF.Feet})
  sets.precast.JA['Battuta'] = set_combine(sets.Enmity, {head=Relic.Head})
  sets.precast.JA['Liement'] = set_combine(sets.Enmity, {body=Relic.Body})
 
  sets.precast.JA['Lunge'] = {}
  sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
 
  sets.precast.JA['Gambit'] = set_combine(sets.Enmity, {hands=AF.Hands})
  sets.precast.JA['Rayke'] = set_combine(sets.Enmity, {feet=Relic.Feet})
  sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {body=Relic.Body})
  sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, {hands=Relic.Hands})
 
  sets.precast.JA['Vivacious Pulse'] = {
    left_ring={name="Stikini Ring +1", bag="wardrobe"},
    right_ring={name="Stikini Ring +1", bag="wardrobe5"},
    legs=AF.Legs
  }

  sets.precast.JA['Vivacious Pulse'].Status = {head=Empy.HEAD}
 
  sets.precast.FC = {
    ammo="Sapience Orb",
    head=AF.Head,
    neck="Voltsurge Torque",
    left_ear="Etiolation Earring",
    right_ear="Loquacious Earring",
    body="Agwu's Robe",
    hands="Agwu's Gages",
    left_ring="Kishar Ring",
    right_ring="Gelatinous Ring +1",
    back=Cape.FC,
    waist="Kasiri Belt",
    legs="Agwu's Slops",
    feet="Carmine Greaves +1",
  }

  sets.precast.FC.Inspiration = {
    right_ear="Loquacious Earring",
    legs=Relic.Legs,
    feet="Carmine greaves +1",
    back=Cape.FC
  }
  
  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist="Siegel Sash",
    legs=Relic.Legs
  })
 
  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------
 
  sets.precast.WS = {
    ammo="Knobkierrie",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Sherida Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Niqmaddu Ring",
    back=Cape.WSD
  }
 
  sets.precast.WS.Acc = set_combine(sets.precast.WS, {
  })
 
  sets.precast.WS.Uncapped = set_combine(sets.precast.WS, {
  })
 
  sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
  })
 
  sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
  })
 
  sets.precast.WS['Resolution'].Uncapped = set_combine(sets.precast.WS['Resolution'], {
  })
 
  sets.precast.WS['Resolution'].Safe = set_combine(sets.precast.WS['Resolution'], {
  })
 
  sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
  })
 
  sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {
  })
 
  sets.precast.WS['Dimidiation'].Uncapped = set_combine(sets.precast.WS['Dimidiation'], {
  })
 
  sets.precast.WS['Dimidiation'].Safe = set_combine(sets.precast.WS['Dimidiation'], {
  })
 
  sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']
 
  sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS, {
  })
 
  sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {
  })
 
  sets.precast.WS['Fell Cleave'].Acc = set_combine(sets.precast.WS.Acc, {
  })
 
  sets.precast.WS['Fell Cleave'].Safe = set_combine(sets.precast.WS, {
  })
 
  sets.precast.WS['Steel Cyclone'] = sets.precast.WS['Fell Cleave']
  sets.precast.WS['Steel Cyclone'].Acc = sets.precast.WS['Fell Cleave'].Acc
  sets.precast.WS['Steel Cyclone'].Safe = sets.precast.WS['Fell Cleave'].Safe
 
  sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
  sets.precast.WS['Upheaval'].Acc = sets.precast.WS['Resolution'].Acc
  sets.precast.WS['Upheaval'].Safe = sets.precast.WS['Resolution'].Safe
 
  sets.precast.WS['Shield Break'] = sets.precast.WS['Shockwave']
  sets.precast.WS['Armor Break'] = sets.precast.WS['Shockwave']
  sets.precast.WS['Weapon Break'] = sets.precast.WS['Shockwave']
  sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']
 
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
 
  sets.midcast.FastRecast = sets.precast.FC
 
  sets.midcast.SpellInterrupt = {
    ammo="Staunch Tathlum +1",   -- 11
    head="Agwu's Cap",           -- 10
    neck="Moonlight Necklace",   -- 15
    left_ear="Odnowa Earring +1",
    right_ear="Cryptic Earring",
    body="Nyame mail",
    hands="Rawhide gloves",      -- 15
    ring1={name="Moonlight Ring", priority=15},
    ring2={name="Gelatinous Ring +1", priority=15},
    legs="Carmine Cuisses +1",   -- 20  
    feet=TaeonPhalanx.Feet,      -- 10
    waist="Audumbla Sash",       -- 10
    back=Cape.Enmity
  }
 
  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
 
  sets.midcast.Cure = {}
 
  sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.SpellInterrupt, {
    head=Empy.Head,
    neck="Melic Torque",
    left_ear="Andoaa Earring",
    right_ear="Mimir Earring",
    body="Nyame Mail",
    hands=AF.Hands,
    left_ring={name="Stikini Ring +1", bag="wardrobe"},
    right_ring={name="Stikini Ring +1", bag="wardrobe5"},
    back="Reiki Cloak",
    waist="Olympus sash",
    legs=Relic.Legs,
    feet="Carmine greaves +1"
  })
 
  sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
    head="Fu. Bandeau +3",
    body=TaeonPhalanx.Body,
    hands=TaeonPhalanx.Hands,
    legs=TaeonPhalanx.Legs,
    feet=TaeonPhalanx.Feet
  })
  
  sets.midcast.PhalanxDuration = set_combine(sets.midcast.Phalanx, {
    head=Empy.Head,
    legs=Relic.Legs,
  })
 
  sets.midcast['Aquaveil'] = sets.midcast.SpellInterrupt
 
  sets.midcast.Temper = set_combine(sets.midcast['Enhancing Magic'], {
    legs="Carmine cuisses +1",
  })
 
  sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head=AF.Head, neck="Sacro Gorget"})
  sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head=Empy.Head, waist="Gishdubar Sash"})
  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
  sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
  sets.midcast.Shell = sets.midcast.Protect
 
  sets.midcast['Divine Magic'] = sets.Enmity
  sets.midcast['Enfeebling Magic'] = {}
 
  sets.midcast.Flash = sets.Enmity
  sets.midcast.Foil = sets.Enmity
  sets.midcast.Stun = sets.Enmity
  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
 
  sets.midcast['Blue Magic'] = {}
  sets.midcast['Blue Magic'].Enmity = sets.Enmity.SIRD
  sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
  sets.midcast['Blue Magic'].Buffs = sets.Enmity.SIRD
 
  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------
 
  sets.idle = {
    ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Moonlight Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back=Cape.Enmity
  }
 
  sets.idle.DT = sets.idle
 
  sets.idle.Refresh = set_combine(sets.idle, {
    body=AF.Body,
    left_ring={name="Stikini Ring +1", bag="wardrobe"},
    right_ring={name="Stikini Ring +1", bag="wardrobe5"},
    legs="Carmine Cuisses +1",
  })
 
  sets.Kiting = {legs="Carmine Cuisses +1"}
 
  sets.idle.Town = set_combine(sets.idle, sets.Kiting)

 
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
 
  sets.defense.Knockback = {}
 
  sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Moonlight Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back=Cape.Enmity
  }
 
  sets.defense.MDT = {
    ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    neck="Futhark Torque +2",
    left_ear="Sanare earring",
    right_ear="Odnowa earring +1",
    body=AF.Body,
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    left_ring="Vengeful ring",
    right_Ring="Vexer ring +1",
    back=Cape.Enmity,
    waist="Engraved Belt",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
  }
  
  sets.defense.Parry = {
    ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    neck="Futhark Torque +2",
    left_ear="Cryptic earring",
    right_ear="Odnowa earring +1",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Turms mittens +1",
    left_ring="Gelatinous ring +1",
    right_Ring="Moonlight ring",
    back=Cape.Parry,
    waist="Engraved Belt",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Turms leggings +1",
  }
 
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
 
  sets.engaged = {
    ammo="Yamarang",
    head={ name="Nyame Helm", augments={'Path: B',}},
    neck="Anu Torque",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    body="Ashera Harness",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    left_ring="Niqmaddu Ring",
    right_ring="Moonlight Ring",
    back=Cape.Parry,
    waist="Dynamic Belt +1",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},  
  }

  sets.engaged.Parry = sets.defense.Parry
  
  sets.engaged.Aftermath = sets.engaged
 
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------
 
  sets.Hybrid = sets.engaged
 
  sets.engaged.DT = sets.engaged.Parry
 
  sets.engaged.Aftermath.DT = sets.engaged
 
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
 
  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
    ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
    waist="Gishdubar Sash", --10
  }
 
  sets.Embolden = set_combine(sets.midcast['Enhancing Magic'], {back="Evasionist's Cape"})
  sets.Obi = {waist="Hachirin-no-Obi"}
  sets.Epeolatry = {main="Epeolatry", sub="Utu Grip"}
  sets.EpeolatryTank = {main="Epeolatry", sub="Refined Grip +1"}
  sets.Aettir = {main="Aettir", sub="Utu Grip"}
  sets.Lycurgos = {main="Lycurgos", sub="Utu Grip"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
        add_to_chat(167, 'Action stopped due to status.')
        eventArgs.cancel = true
        return
    end
    if rune_enchantments:contains(spell.english) then
        eventArgs.handled = true
    end
    if spell.action_type == 'Magic' and state.Buff['Fast Cast'] then
        equip(sets.precast.FC.Inspiration)
        eventArgs.handled = true
        return
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Vivacious Pulse' then
        if buffactive['poison'] or buffactive['paralysis'] or buffactive['blindness'] or buffactive['silence']
        or buffactive['curse'] or buffactive['bane'] or buffactive['doom'] or buffactive['disease'] or buffactive['plague'] then
             equip(sets.precast.JA['Vivacious Pulse'].Status)
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if spell.english == 'Phalanx' and buffactive['Embolden'] then
        equip(sets.midcast.PhalanxDuration)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if not spell.interrupted then
        if spell.english == 'Valiance' or spell.english == 'Vallation' then
            state.Buff['Fast Cast'] = true
        elseif spell.name == 'Rayke' then
            send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
            send_command('wait '..rayke_duration..';input /echo [Rayke just wore off!];')
        elseif spell.name == 'Gambit' then
            send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
            send_command('wait '..gambit_duration..';input /echo [Gambit just wore off!];')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.Charm.current)
    classes.CustomDefenseGroups:append(state.Knockback.current)
    classes.CustomDefenseGroups:append(state.Death.current)

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.Charm.current)
    classes.CustomMeleeGroups:append(state.Knockback.current)
    classes.CustomMeleeGroups:append(state.Death.current)
end

function job_buff_change(buff, gain)
    if buff == "terror" then
        if gain then
            equip(sets.defense.PDT)
        end
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed - Halp')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('back')
        else
            enable('back')
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

    if buff:lower() == 'fast cast' then
        state.Buff['Fast Cast'] = gain
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    equip(sets[state.WeaponSet.current])

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
    handle_equipping_gear(player.status)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Knockback.value == true then
        idleSet = set_combine(idleSet, sets.defense.Knockback)
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry"
        and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end
    if state.Knockback.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Knockback)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end
    if state.Knockback.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Knockback)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local r_msg = state.Runes.current
    local r_color = ''
    if state.Runes.current == 'Ignis' then r_color = 167
    elseif state.Runes.current == 'Gelus' then r_color = 210
    elseif state.Runes.current == 'Flabra' then r_color = 204
    elseif state.Runes.current == 'Tellus' then r_color = 050
    elseif state.Runes.current == 'Sulpor' then r_color = 215
    elseif state.Runes.current == 'Unda' then r_color = 207
    elseif state.Runes.current == 'Lux' then r_color = 001
    elseif state.Runes.current == 'Tenebrae' then r_color = 160 end

    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local am_msg = '(' ..string.sub(state.AttackMode.value,1,1).. ')'

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Knockback.value == true then
        msg = msg .. ' Knockback Resist |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
        ..string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
        ..string.char(31,207).. ' WS' ..am_msg.. ': ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060)
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, action, spellMap)
    if spell.type == 'WeaponSkill' then
        if state.AttackMode.value == 'Uncapped' and state.DefenseMode.value == 'None' and state.HybridMode.value == 'Normal' then
            return "Uncapped"
        elseif state.DefenseMode.value ~= 'None' or state.HybridMode.value == 'DT' then
            return "Safe"
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book: (set, book)
    if player.sub_job == 'BLU' then
        set_macro_page(2, 12)
    elseif player.sub_job == 'DRK' then
        set_macro_page(3, 12)
    elseif player.sub_job == 'WHM' then
        set_macro_page(4, 12)
    else
        set_macro_page(1, 12)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end