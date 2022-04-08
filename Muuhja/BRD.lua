-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Cycle SongMode
--
--  Songs:      [ ALT+` ]           Chocobo Mazurka
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Mordant Rime
--              [ CTRL+Numpad4 ]    Evisceration
--              [ CTRL+Numpad5 ]    Rudra's Storm
--              [ CTRL+Numpad1 ]    Aeolian Edge
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    SongMode may take one of three values: None, Placeholder, FullLength
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle SongMode
    gs c set SongMode Placeholder
    The Placeholder state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    Simple macro to cast a placeholder Daurdabla song:
    /console gs c set SongMode Placeholder
    /ma "Shining Fantasia" <me>
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    lockstyleset = 1
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'MEva')

    state.LullabyMode = M{['description']='Lullaby Instrument', 'Harp', 'Horn'}

    state.Carol = M{['description']='Carol',
        'Fire Carol', 'Fire Carol II', 'Ice Carol', 'Ice Carol II', 'Wind Carol', 'Wind Carol II',
        'Earth Carol', 'Earth Carol II', 'Lightning Carol', 'Lightning Carol II', 'Water Carol', 'Water Carol II',
        'Light Carol', 'Light Carol II', 'Dark Carol', 'Dark Carol II',
    }

    state.Threnody = M{['description']='Threnody',
        'Fire Threnody II', 'Ice Threnody II', 'Wind Threnody II', 'Earth Threnody II',
        'Ltng. Threnody II', 'Water Threnody II', 'Light Threnody II', 'Dark Threnody II',
    }

    state.Etude = M{['description']='Etude', 'Sinewy Etude', 'Herculean Etude', 'Learned Etude', 'Sage Etude',
        'Quick Etude', 'Swift Etude', 'Vivacious Etude', 'Vital Etude', 'Dextrous Etude', 'Uncanny Etude',
        'Spirited Etude', 'Logical Etude', 'Enchanting Etude', 'Bewitching Etude'
    }

    state.WeaponSet = M{['description']='Weapon Set', 'Carnwenhan', 'Twashtar', 'Naegling', 'Tauret', 'Aeolian', 'Free'}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
    send_command('lua l gearinfo')

    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2

    send_command('bind ^` gs c cycle SongMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')
    send_command('bind !p input /ja "Pianissimo" <me>')

    send_command('bind ^backspace gs c cycle SongTier')
    send_command('bind ^insert gs c cycleback Etude')
    send_command('bind ^delete gs c cycle Etude')
    send_command('bind ^home gs c cycleback Carol')
    send_command('bind ^end gs c cycle Carol')
    send_command('bind ^pageup gs c cycleback Threnody')
    send_command('bind ^pagedown gs c cycle Threnody')

    send_command('bind @` gs c cycle LullabyMode')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')

    --send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad7 input /ws "Mordant Rime" <t>')
    send_command('bind ^numpad4 input /ws "Evisceration" <t>')
    send_command('bind ^numpad5 input /ws "Rudra\'s Storm" <t>')
    send_command('bind ^numpad1 input /ws "Aeolian Edge" <t>')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^backspace')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind @`')
    send_command('unbind @w')
    send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad1')

    send_command('lua u gearinfo')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
      main="Kali",                                                                                                  --  7
      head="Fili Calot +1",                                                                                         -- 14
      body="Inyanga Jubbah +2",                                                                                     -- 14
      hands="Gendewitha gages +1",                                                                                  -- 12
      legs="Aya. Cosciales +2",                                                                                     --  6
      feet={ name="Telchine Pigaches", augments={'Song spellcasting time -6%',}},                                   -- 12
      neck="Mnbw. Whistle +1",
      waist="Flume Belt +1",
      left_ear="Genmei Earring",
      right_ear="Odnowa Earring +1",
      left_ring="Gelatinous Ring",
      right_ring="Kishar Ring",                                                                                     --  4
      back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},  -- 10
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
    })

    sets.precast.FC.BardSong = {
      main="Kali",                                                                                         --  7
      head="Fili Calot +1",                                                                                -- 14
      body="Inyanga Jubbah +2",                                                                            -- 14
      hands="Gendewitha gages +1",                                                                         -- 12
      legs="Aya. Cosciales +2",                                                                            --  6
      feet={ name="Telchine Pigaches", augments={'Song spellcasting time -6%',}},                          -- 12
      neck="Mnbw. Whistle +1",
      waist="Flume Belt +1",
      left_ear="Genmei Earring",
      right_ear="Odnowa Earring +1",
      left_ring="Gelatinous Ring",
      right_ring="Kishar Ring",                                                                            --  4
      back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},  -- 10
    }

    sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})

    -- Precast sets to enhance JAs

    sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
    sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
      range="Linos",
      head="Aya. Zucchetto +2",
      body="Ayanmo Corazza +2",
      hands="Aya. Manopolas +2",
      legs="Aya. Cosciales +2",
      feet="Aya. Gambieras +2",
      neck={ name="Bard's Charm +2", augments={'Path: A',}},
      waist="Grunfeld Rope",
      left_ear="Regal Earring",
      right_ear="Rimeice Earring",
      left_ring="Metamorph Ring +1",
      right_ring="Overbearing Ring",
      back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Damage taken-5%',}},    
    })

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
    })

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
      range={ name="Linos", augments={'Accuracy+12 Attack+12','Weapon skill damage +3%','STR+6 CHR+6',}},
      head="Nyame Helm",
      body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck={ name="Bard's Charm +2", augments={'Path: A',}},
      waist="Kentarch Belt +1",
      left_ear="Regal Earring",
      right_ear="Ishvara Earring",
      left_ring="Metamorph Ring +1",
      right_ring="Epaminondas's Ring",
      back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Damage taken-5%',}},
    })

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
      range={ name="Linos", augments={'Accuracy+12 Attack+12','Weapon skill damage +3%','STR+6 CHR+6',}}, -- Dex Linos
      head="Nyame Helm",
      body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck={ name="Bard's Charm +2", augments={'Path: A',}},
      waist="Kentarch Belt +1",
      left_ear="Moonshade Earring",
      right_ear="Ishvara Earring",
      left_ring="Ilabrat Ring",
      right_ring="Epaminondas's Ring",
      back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}, -- Dex belt
    })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
      range={ name="Linos", augments={'Accuracy+12 Attack+12','Weapon skill damage +3%','STR+6 CHR+6',}},
      head="Nyame Helm",
      body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck={ name="Bard's Charm +2", augments={'Path: A',}},
      waist="Kentarch Belt +1",
      left_ear="Moonshade Earring",
      right_ear="Ishvara Earring",
      left_ring="Metamorph Ring +1",
      right_ring="Epaminondas's Ring",
      back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    })

    sets.precast.WS['Aeolian Edge'] = {
      range={ name="Linos", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +3%','INT+7',}},
      body={ name="Cohort Cloak +1", augments={'Path: A',}},
      hands={ name="Nyame Gauntlets", augments={'Path: B',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck="Sanctity Necklace",
      waist="Eschan Stone",
      left_ear="Regal Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring="Metamorph Ring +1",
      right_ring="Epaminondas's Ring",
      back={ name="Intarabus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC

    -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
    sets.midcast.Carol = {hands="Mousai Gages +1"}
    sets.midcast.Etude = {head="Mousai Turban +1"}
    sets.midcast.HonorMarch = {range="Marsyas", hands="Fili Manchettes +1"}
    sets.midcast.Lullaby = {
      body="Fili Hongreline +1",
      -- hands="Brioso Cuffs +3",
      legs="Inyanga Shalwar +2",
      hands={ name="Chironic Gloves", augments={'Crit. hit damage +3%','MND+13','"Treasure Hunter"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
      feet={ name="Chironic Slippers", augments={'"Fast Cast"+2','MND+5','"Treasure Hunter"+2',}}
    }
    sets.midcast.Madrigal = {head="Fili Calot +1"}
    sets.midcast.Mambo = {feet="Mousai Crackows +1"}
    sets.midcast.March = {hands="Fili Manchettes +1"}
    sets.midcast.Minne = {legs="Mousai Seraweels +1"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
    sets.midcast.Paeon = {head="Brioso Roundlet +2"}
    sets.midcast.Threnody = {body="Mou. Manteel +1"}
    sets.midcast['Adventurer\'s Dirge'] = {range="Marsyas", hands="Bihu Cuffs +3"}
    sets.midcast['Foe Sirvente'] = {head="Bihu Roundlet +3"}
    sets.midcast['Magic Finale'] = {legs="Fili Rhingrave +1"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
    sets.midcast["Chocobo Mazurka"] = {range="Marsyas"}

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEnhancing = {
      main="Carnwenhan",
      sub="Genmei Shield",
      range="Gjallarhorn",
      head="Fili Calot +1",
      body="Fili Hongreline +1",
      hands="Fili Manchettes +1",
      legs="Inyanga shalwar +2",
      feet="Brioso Slippers +3",
      neck="Mnbw. Whistle +1",
      waist="Flume Belt +1",
      left_ear="Odnowa Earring +1",
      right_ear="Etiolation Earring",
      left_ring="Defending Ring",
      right_ring="Gelatinous Ring",
      back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},
    }

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongEnfeeble = {
      main="Carnwenhan",
      sub="Ammurapi Shield",
      range="Gjallarhorn",
      head="Brioso Roundlet +2",
      body="Brioso Justau. +3",
      hands="Brioso Cuffs +3",
      legs="Brioso Cannions +3",
      feet="Brioso Slippers +3",
      neck="Mnbw. Whistle +1",
      ear1="Digni. Earring",
      ear2="Regal Earring",
      ring1="Stikini Ring +1",
      ring2="Stikini Ring +1",
      waist="Acuity Belt +1",
      back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},
    }

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {
    })

    -- For Horde Lullaby maxiumum AOE range.
    sets.midcast.SongStringSkill = {
      ear1="Darkside Earring",
      ear2="Gersemi Earring"
    }

    -- Placeholder song; minimize duration to make it easy to overwrite.
    sets.midcast.SongPlaceholder = set_combine(sets.midcast.SongEnhancing, {
      main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
      range="Daurdabla",
      head="Fili Calot +1",
      body="Fili Hongreline +1",
      hands="Fili Manchettes +1",
      legs="Fili Rhingrave +1",
      feet="Fili Cothurnes +1",
      neck="Mnbw. Whistle +1",
      waist="Flume Belt +1",
      left_ear="Odnowa Earring +1",
      left_ring="Stikini Ring +1",
      right_ring="Gelatinous Ring",
      back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},
    })

    -- Other general spells and classes.
    sets.midcast.Cure = {
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
    })

    sets.midcast.StatusRemoval = {
    }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
    })

    sets.midcast['Enhancing Magic'] = {
    }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {
      main="Carnwenhan",
      sub="Ammurapi Shield",
      range="Gjallarhorn",
      head="Brioso Roundlet +2",
      body="Brioso Justau. +3",
      hands="Inyanga Dastanas +2",
      legs="Brioso Cannions +3",
      feet="Brioso Slippers +3",
      neck="Mnbw. Whistle +1",
      ear1="Digni. Earring",
      ear2="Regal Earring",
      ring1="Stikini Ring +1",
      ring2="Metamor. Ring +1",
      waist="Acuity Belt +1",
      back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},
    }

    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak", sub="Ammurapi Shield"})

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
      main="Carnwenhan",
      sub="Genmei Shield",
      range={ name="Linos", augments={'Mag. Evasion+14','Phys. dmg. taken -4%','HP+17',}},
      head="Bunzi's Hat",
      body="Nyame Mail",
      hands="Bunzi's Gloves",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Loricate Torque +1",
      waist="Flume Belt +1",
      left_ear="Odnowa Earring +1",
      right_ear="Etiolation Earring",
      left_ring="Inyanga Ring",
      right_ring="Defending ring",
      back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Phys. dmg. taken-10%',}},
    }

    sets.idle.DT = {
      main="Carnwenhan",
      sub="Genmei Shield",
      range={ name="Linos", augments={'Mag. Evasion+14','Phys. dmg. taken -4%','HP+17',}},
      head="Bunzi's Hat",
      body="Nyame Mail",
      hands="Bunzi's Gloves",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Loricate Torque +1",
      waist="Carrier's Sash",
      left_ear="Odnowa Earring +1",
      right_ear="Etiolation Earring",
      left_ring="Defending ring",
      right_ring="Gelatinous Ring",
      back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Phys. dmg. taken-10%',}},
    }

    sets.idle.MEva = {
      main="Carnwenhan",
      sub="Genmei Shield",
      range={ name="Linos", augments={'Mag. Evasion+14','Phys. dmg. taken -4%','HP+17',}},
      head="Bunzi's Hat",
      body="Nyame Mail",
      hands="Bunzi's Gloves",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Loricate Torque +1",
      waist="Flume Belt +1",
      left_ear="Odnowa Earring +1",
      right_ear="Etiolation Earring",
      left_ring="Defending ring",
      right_ring="Inyanga Ring",
      back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Phys. dmg. taken-10%',}},
    }

    sets.idle.Town = set_combine(sets.idle, {
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Fili Cothurnes +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
      range={ name="Linos", augments={'Accuracy+17','"Store TP"+3','Quadruple Attack +3',}},
      head="Bunzi's Hat",       -- 7
      body="Ashera Harness",    -- 9
      hands="Bunzi's Gloves",   -- 8
      legs="Nyame Flanchard",   -- 8
      feet="Nyame Sollerets",   -- 7
      neck="Bard's Charm +2",
      ear1="Brutal Earring",
      ear2="Dignitary's Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring="Moonlight Ring",
      back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
      waist="Grunfeld Rope"
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
    })

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
      range={ name="Linos", augments={'Accuracy+17','"Store TP"+3','Quadruple Attack +3',}},
      head="Bunzi's Hat",
      body="Ashera Harness",
      hands="Bunzi's Gloves",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Bard's Charm +2",
      ear1="Eabani Earring",
      ear2="Telos Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring="Moonlight Ring",
      back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
      waist="Reiki Yotai"
    }

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
    })
    
    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = sets.engaged.DW
    sets.engaged.DW.Acc.LowHaste = sets.engaged.DW.Acc

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = sets.engaged.DW
    sets.engaged.DW.Acc.MidHaste = sets.engaged.DW.Acc

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = sets.engaged.DW
    sets.engaged.DW.Acc.HighHaste = sets.engaged.DW.Acc

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = sets.engaged.DW
    sets.engaged.DW.MaxHaste.Acc = sets.engaged.DW.Acc

    sets.engaged.DW.MaxHastePlus = sets.engaged.DW
    sets.engaged.DW.Acc.MaxHastePlus = sets.engaged.DW.Acc

    sets.engaged.Aftermath = sets.engaged.DW

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        neck="Loricate Torque +1", --6/6
        ring1="Gelatinous Ring",
        ring2="Defending Ring", --10/10
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.SongDWDuration = {main="Carnwenhan", sub="Kali"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip({range="Daurdabla"})
            elseif buffactive.Troubadour then
                equip({range="Marsyas"})
            else
                equip({range="Gjallarhorn"})
            end
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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- layer general gear on first, then let default handler add song-specific gear.
        local generalClass = get_song_class(spell)
        if generalClass and sets.midcast[generalClass] then
            equip(sets.midcast[generalClass])
        end
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip({range="Daurdabla"})
                equip(sets.midcast.SongStringSkill)
            elseif buffactive.Troubadour then
                equip({range="Marsyas"})
            else
			    equip({range="Gjallarhorn"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.CombatForm.current == 'DW' then
            equip(sets.SongDWDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Lullaby') and not spell.interrupted then
        get_lullaby_duration(spell)
    end
end

function job_buff_change(buff,gain)

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'etude' then
        send_command('@input /ma '..state.Etude.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'carol' then
        send_command('@input /ma '..state.Carol.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'threnody' then
        send_command('@input /ma '..state.Threnody.value..' <stnpc>')
    end

    gearinfo(cmdParams, eventArgs)
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.WeaponSet.value == "Carnwenhan" then
        equip({main="Carnwenhan",sub="Taming Sari"})
    elseif state.WeaponSet.value == "Twashtar" then
        equip({main="Twashtar",sub="Fusetto +2"})
    elseif state.WeaponSet.value == "Naegling" then
        equip({main="Naegling",sub="Fusetto +2"})
    elseif state.WeaponSet.value == "Tauret" then
        equip({main="Tauret",sub="Twashtar"})
    elseif state.WeaponSet.value == "Aeolian" then
        equip({main="Tauret",sub="Malevolence"})
    end
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'SongEnfeebleAcc'
        else
            return 'SongEnfeeble'
        end
    elseif state.SongMode.value == 'Placeholder' then
        return 'SongPlaceholder'
    else
        return 'SongEnhancing'
    end
end

function get_lullaby_duration(spell)
    local self = windower.ffxi.get_player()

    local troubadour = false
    local clarioncall = false
    local soulvoice = false
    local marcato = false

    for i,v in pairs(self.buffs) do
        if v == 348 then troubadour = true end
        if v == 499 then clarioncall = true end
        if v == 52 then soulvoice = true end
        if v == 231 then marcato = true end
    end

    local mult = 1

    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    if player.equipment.range == "Marsyas" then mult = mult + 0.5 end

    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.neck == "Mnbw. Whistle" then mult = mult + 0.2 end
    if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +2' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.2 end

    --JP Duration Gift
    if self.job_points.brd.jp_spent >= 1200 then
        mult = mult + 0.05
    end

    if troubadour then
        mult = mult * 2
    end

    if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then
        base = 60
    elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then
        base = 30
    end

    totalDuration = math.floor(mult * base)

    -- Job Points Buff
    totalDuration = totalDuration + self.job_points.brd.lullaby_duration
    if troubadour then
        totalDuration = totalDuration + self.job_points.brd.lullaby_duration
        -- adding it a second time if Troubadour up
    end

    if clarioncall then
        if troubadour then
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2 * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.  * 2 again for Troubadour
        else
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.
        end
    end

    if marcato and not soulvoice then
        totalDuration = totalDuration + self.job_points.brd.marcato_effect
    end

    -- Create the custom timer
    if spell.english == "Foe Lullaby II" or spell.english == "Horde Lullaby II" then
        send_command('@timers c "Lullaby II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00377.png')
    elseif spell.english == "Foe Lullaby" or spell.english == "Horde Lullaby" then
        send_command('@timers c "Lullaby ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00376.png')
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 12 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 12 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
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
    set_macro_page(2, 18)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end