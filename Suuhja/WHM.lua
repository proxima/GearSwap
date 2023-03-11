-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+R ]           Toggle Regen Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Afflatus Solace
--              [ ALT+` ]           Afflatus Misery
--              [ CTRL+[ ]          Divine Seal
--              [ CTRL+] ]          Divine Caress
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+; ]           Penury/Parsimony
--
--  Spells:     [ ALT+o ]           Regen IV
--
--  Weapons:    [ WIN+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Black Halo
--              [ CTRL+Numpad8 ]    Hexa Strike
--              [ CTRL+Numpad9 ]    Realmrazer
--              [ CTRL+Numpad1 ]    Flash Nova
--              [ CTRL+Numpad0 ]    Mystic Boon
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts                    Dark Arts
--                                          ----------                  ---------
--              gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar addendum       Addendum: White             Addendum: Black


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false

    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}

    lockstyleset = 1

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'MEva')

    state.BarElement = M{['description']='BarElement', 'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesra', 'Barvira', 'Barparalyzra', 'Barsilencera', 'Barpetra', 'Barpoisonra', 'Barblindra', 'Barsleepra'}
    state.BoostSpell = M{['description']='BoostSpell', 'Boost-STR', 'Boost-INT', 'Boost-AGI', 'Boost-VIT', 'Boost-DEX', 'Boost-MND', 'Boost-CHR'}

    state.WeaponLock = M(false, 'Weapon Lock')
    state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
    -- include('Global-Binds.lua') -- OK to remove this line
    -- include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('lua l gearinfo')

    send_command('bind ^` input /ja "Afflatus Solace" <me>')
    send_command('bind !` input /ja "Afflatus Misery" <me>')
    send_command('bind ^- input /ja "Light Arts"')
    send_command('bind ^= input /ja "Dark Arts"')
    send_command('bind ^; gs c scholar speed')
    send_command('bind ![ input /ja "Accession"')
    send_command('bind !; gs c scholar cost')
    send_command('bind ^insert gs c cycleback BoostSpell')
    send_command('bind ^delete gs c cycle BoostSpell')
    send_command('bind ^home gs c cycleback BarElement')
    send_command('bind ^end gs c cycle BarElement')
    send_command('bind ^pageup gs c cycleback BarStatus')
    send_command('bind ^pagedown gs c cycle BarStatus')
    send_command('bind ^[ input /ja "Divine Seal" <me>')
    send_command('bind ^] input /ja "Divine Caress" <me>')
    send_command('bind !o input /ma "Regen IV" <stpc>')
    send_command('bind @c gs c toggle CP')
    send_command('bind @r gs c cycle RegenMode')
    send_command('bind @w gs c toggle WeaponLock')
    
    -- send_command('bind @a send zuuhja input /ma "Indi-Malaise" <me>')
    -- send_command('bind @s sat youcommand Zuuhja Geo-Frailty')
    send_command('bind @a sat youcommand Muuhja "Wind Threnody II"')
    send_command('bind @s send Zuuhja input /ma "Cure" Bippin')
    send_command('bind @d send zuuhja input /ma "Cure" Aller')
    send_command('bind @z send zuuhja input /ja "Full Circle" <me>')
    send_command('bind @x send zuuhja input /ja "Radial Arcana" <me>')
    
    send_command('bind @b sat youcommand Muuhja "Magic Finale"')
    send_command('bind @n sat youcommand Muuhja "Carnage Elegy"')
    -- send_command('bind @m sat youcommand Muuhja "Pining Nocturne"')
    -- send_command('bind @o sat youcommand Muuhja "Horde Lullaby II"')
    -- send_command('bind @p sat youcommand Muuhja "Horde Lullaby"')
    
    send_command('bind @b send muuhja input /ma "Cait Sith" <me>')
    -- send_command('bind @n sat youcommand Muuhja "Predator Claws"')
    send_command('bind @m sat youcommand Muuhja "Mewing Lullaby"')
    send_command('bind @o sat youcommand Muuhja Assault')
    send_command('bind @p send muuhja input /pet "Release" <me>')
    send_command('bind @= send muuhja input /ja "Apogee" <me>')
        
    send_command('bind ^numpad7 input /ws "Black Halo" <t>')
    send_command('bind ^numpad8 input /ws "Hexa Strike" <t>')
    send_command('bind ^numpad5 input /ws "Realmrazer" <t>')
    send_command('bind ^numpad1 input /ws "Flash Nova" <t>')
    send_command('bind ^numpad0 input /ws "Mystic Boon" <t>')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^;')
    send_command('unbind ![')
    send_command('unbind !;')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind !o')
    send_command('unbind @c')
    send_command('unbind @r')
    send_command('unbind @w')
    
    send_command('unbind @a')
    send_command('unbind @s')
    send_command('unbind @d')
    send_command('unbind @z')
    send_command('unbind @x')
    send_command('unbind @b')
    send_command('unbind @n')
    send_command('unbind @m')
    send_command('unbind @o')
    send_command('unbind @p')
    send_command('unbind @=')
    
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad0')

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

    send_command('unbind 1')
    send_command('unbind 2')
    send_command('unbind 3')
    send_command('unbind 4')
    send_command('unbind 5')
    send_command('unbind 6')

    send_command('lua u gearinfo')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
      ammo="Impatiens",
      head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
      body="Inyanga Jubbah +2",
      hands="Fanatic Gloves",
      legs="Aya. Cosciales +2",
      feet={ name="Chironic Slippers", augments={'Mag. Acc.+21','"Fast Cast"+7','MND+9',}},
      neck="Cleric's torque +1",
      waist="Witful Belt",
      left_ear="Etiolation Earring",
      right_ear="Malignance Earring",
      left_ring="Kishar Ring",
      right_ring="Lebeche Ring",
      back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
      legs="Ebers pantaloons +3",     -- 13, 5
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})

    -- Precast sets to enhance JAs
    --sets.precast.JA.Benediction = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      ammo="Floestone",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Republican platinum medal",
      waist="Grunfeld Rope",
      left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      right_ear="Regal Earring",
      left_ring="Epaminondas's Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back={ name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
      waist="Luminary sash",
      right_ear="Ebers Earring +2",      
    })

    sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
      neck="Fotia Gorget",
      waist="Fotia Belt",
      right_ear="Ebers Earring +2",
    })
    
    sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {
      neck="Fotia Gorget",
      waist="Fotia Belt",
      right_ear="Ebers Earring +2",
    })

    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {
      ammo="Ghastly Tathlum +1",
      head="Pixie Hairpin +1",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Sibyl Scarf",
      ear1="Malignance Earring",
      ear2="Regal Earring",
      ring1="Metamorph ring +1",
      ring2="Archon Ring",
      back={ name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
      waist="Orpheus's Sash",
    })

    sets.precast.WS['Rock Crusher'] = set_combine(sets.precast.WS['Cataclysm'],  {
      head="Nyame Helm",
      neck="Quanpur Necklace",
      ring2="Freke Ring",  
    })

    -- Midcast Sets

    sets.midcast.FC = sets.precast.FC

    sets.midcast.ConserveMP = {
    }

    -- Cure sets
    sets.midcast.CureSolace = {                             -- CP ENM HA FC DT
      main="Daybreak",                                      -- 30                              
      sub="Genmei Shield",                                  --              10
      ammo="Staunch Tathlum +1",                            --               3
      head="Nyame Helm",                                    --         6     7
      body="Ebers Bliaut +3",                               --         3       +Solace
      hands="Pinga mittens +1",                             --  7
      legs="Ebers Pant. +3",                                --         5    12
      feet="Ebers Duckbills +3",                            --         3    11
      neck={ name="Clr. Torque +1", augments={'Path: A',}}, --  7  20     8
      waist="Emphatikos rope",
      left_ear="Magnetic Earring",                          --
      right_ear="Mendicant's earring",                      --  5
      left_ring="Defending Ring",                           --              10
      right_ring="Gelatinous Ring +1",                      --               7
      back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}},
    }

    sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
      waist="Hachirin-no-Obi",
    })

    sets.midcast.CureNormal = set_combine(sets.midcast.CureSolace, {
      body="Theo. Bliaut +2",
    })

    sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
      back="Twilight Cape",
      waist="Hachirin-no-Obi",
    })

    sets.midcast.CuragaNormal = sets.midcast.CureSolace

    sets.midcast.CuragaWeather = set_combine(sets.midcast.CuragaNormal, {
      back="Twilight Cape",
      waist="Hachirin-no-Obi",
    })

    sets.midcast.Esuna = set_combine(sets.midcast.CureSolace, {
      main="Asclepius", 
      sub="Genmei Shield"
    })

    --sets.midcast.CureMelee = sets.midcast.CureSolace

    sets.midcast.StatusRemoval = {
      main="Yagrush",
      head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      body="Inyanga Jubbah +2",
      hands="Fanatic Gloves",
      legs="Aya. Cosciales +2",
      feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      neck="Debilis Medallion",
      waist="Bishop's Sash",
      right_ear="Ebers Earring +2",
      left_ear="Meili Earring",
      left_ring="Menelaus's Ring",
      right_ring="Haoma's Ring",
      back="Mending Cape",
    }
	
    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
      main="Gambanteinn",
      --main="Yagrush",
      head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      body="Ebers Bliaut +3",
      hands="Fanatic Gloves",
      legs="Th. Pant. +3",
      feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      neck="Debilis Medallion",
      waist="Bishop's Sash",
      right_ear="Ebers Earring +2",
      left_ear="Meili Earring",
      left_ring="Menelaus's Ring",
      right_ring="Haoma's Ring",
      back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}},
    })

    sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque +1"})

    sets.midcast['Enhancing Magic'] = { -- 502 @ ML 24
      main="Beneficus",
      sub="Ammurapi Shield",
      head="Telchine Cap",
      body="Telchine Chasuble",
      hands="Telchine Gloves",
      legs="Telchine Braconi",
      feet="Theophany duckbills +3",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      left_ear="Beatific Earring",
      right_ear="Mimir Earring",
      waist="Embla Sash",
      back="Mending cape",
    }

    sets.midcast.EnhancingDuration = sets.midcast['Enhancing Magic']

    sets.midcast['Haste'] = sets.midcast.EnhancingDuration

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
      main="Bolelabunga",
      sub="Ammurapi Shield",      
      body="Piety Bliaut +3",
      head="Inyanga Tiara +2",
      hands="Ebers Mitts +3",
      legs="Th. Pant. +3",
      feet="Bunzi's Sabots",
    })

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
      main="Bolelabunga",
      sub="Ammurapi Shield",
      body="Piety Bliaut +3",
      head="Inyanga Tiara +2",
      hands="Ebers Mitts +3",
      legs="Th. Pant. +3",
      feet="Theo. Duckbills +3",
    })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
      waist="Gishdubar Sash",
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
      waist="Siegel Sash",
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
      hands="Regal Cuffs",
      waist="Emphatikos Rope",

    })

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
      feet="Ebers Duckbills +3",
    })

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
      main="Beneficus",
      sub="Ammurapi Shield",
      head="Ebers Cap +1",
      body="Ebers Bliaut +3",
      hands="Ebers Mitts +3",
      legs="Piety Pantaln. +3",
      feet="Ebers Duckbills +3",
      back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
    })

    sets.midcast.BarStatus = set_combine(sets.midcast['Enhancing Magic'], {
      neck="Sroda Necklace",
      back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
    })
    
    sets.midcast.Baramnesra = sets.midcast.BarStatus
    sets.midcast.Barvira = sets.midcast.BarStatus
    sets.midcast.Barparalyzra = sets.midcast.BarStatus
    sets.midcast.Barsilencera = sets.midcast.BarStatus
    sets.midcast.Barpetra = sets.midcast.BarStatus
    sets.midcast.Barpoisonra = sets.midcast.BarStatus
    sets.midcast.Barblindra = sets.midcast.BarStatus
    sets.midcast.Barsleepra = sets.midcast.BarStatus

    sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'], {
    })

    sets.midcast.Protect = set_combine(sets.midcast.ConserveMP, sets.midcast.EnhancingDuration, {
      ring1="Sheltered Ring",
    })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Pemphredo Tathlum",
      head="Bunzi's Hat",
      body="Bunzi's Robe",
      hands="Bunzi's Gloves",
      legs="Bunzi's Pants",
      feet="Bunzi's Sabots",
      neck="Saevus Pendant +1",
      left_ear="Malignance Earring",
      right_ear="Regal Earring",
      left_ring="Freke Ring",
      back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
      waist="Skrymir Cord +1",
    }
    
    sets.midcast['Elemental Magic'] = sets.midcast['Divine Magic']

    sets.midcast.Banish = sets.midcast['Divine Magic']
    sets.midcast.Holy = sets.midcast.Banish

    sets.midcast['Dark Magic'] = {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Pemphredo Tathlum",
      head="Pixie Hairpin +1",
      body="Theo. Bliaut +2",
      hands="Theophany Mitts +2",
      legs={ name="Chironic Hose", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Fast Cast"+5','MND+11','Mag. Acc.+13','"Mag.Atk.Bns."+6',}},
      feet="Theo. Duckbills +3",
      neck="Erra Pendant",
      right_ear="Ebers Earring +2",
      left_ear="Regal Earring",
      ring1="Metamorph ring +1",
      ring2="Archon Ring",
      back="Aurist's Cape +1",
      waist="Obstinate Sash",
    }

    sets.midcast.MndEnfeebles = {
      main="Asclepius",
      sub="Ammurapi Shield",
      ammo="Pemphredo Tathlum",
      head=empty, 
      body="Cohort Cloak +1",
      hands="Kaykaus Cuffs +1",
      legs={ name="Chironic Hose", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Fast Cast"+5','MND+11','Mag. Acc.+13','"Mag.Atk.Bns."+6',}},
      feet="Theo. Duckbills +3",
      neck="Erra Pendant",
      right_ear="Ebers Earring +2",
      left_ear="Regal Earring",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      back="Aurist's Cape +1",
      waist="Obstinate Sash",
    }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
    })

    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})

    sets.midcast.Impact = {
      main="Yagrush",
      sub="Ammurapi Shield",
      ammo="Pemphredo Tathlum",
      head=empty,
      body="Crepuscular Cloak",
      hands="Theophany Mitts +2",
      legs="Th. Pant. +3",
      feet="Theo. Duckbills +3",
      neck="Erra Pendant",
      waist={ name="Acuity Belt +1", augments={'Path: A',}},
      right_ear="Ebers Earring +2",
      left_ear="Regal Earring",
      left_ring="Stikini Ring +1",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back="Aurist's Cape +1",
    }

    sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Impact, {
      head={ name="Bunzi's Hat", augments={'Path: A',}},
      body="Ebers Bliaut +3",
      back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}},  
    })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
      main="Chatoyant Staff",
      waist="Shinjutsu-no-Obi",
    }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
      main="Daybreak",
      sub="Genmei Shield",
      ammo="Staunch Tathlum +1",
      head={ name="Bunzi's Hat", augments={'Path: A',}},
      body="Ebers Bliaut +3",
      hands="Pinga Mittens +1",
      legs="Ebers Pant. +3",
      feet="Ebers Duckbills +3",
      neck="Warder's Charm +1",
      waist="Carrier's Sash",
      left_ear="Tuisto Earring",
      right_ear="Etiolation Earring",
      left_ring="Stikini Ring +1",
      right_ring="Stikini Ring +1",
      back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}},
    }

    sets.idle.DT = set_combine(sets.idle, {
      main="Asclepius",
      sub="Genmei Shield",
      ammo="Staunch Tathlum +1",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck={ name="Loricate Torque +1", augments={'Path: A',}},
      waist="Carrier's Sash",
      left_ear="Tuisto Earring",
      right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
      left_ring="Stikini Ring +1",
      right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
      back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}},
    })

    sets.idle.MEva = set_combine(sets.idle, {
      main="Daybreak",
      sub="Genmei Shield",
      ammo="Staunch Tathlum +1",
      head={ name="Bunzi's Hat", augments={'Path: A',}},
      body="Ebers Bliaut +3",
      hands="Pinga Mittens +1",
      legs="Ebers Pant. +3",
      feet="Ebers Duckbills +3",
      neck="Warder's Charm +1",
      waist="Carrier's Sash",
      left_ear="Sanare Earring",
      right_ear="Etiolation Earring",
      left_ring="Inyanga Ring",
      right_ring="Shadow Ring",
      back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}},
    })

    sets.idle.Town = set_combine(sets.idle.MEva, {
      main="Gambanteinn",
      hands="Ebers Mitts +3",
      right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    })

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.MEva

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
      main="Maxentius",
      sub="Ammurapi Shield",
      ammo="Staunch Tathlum +1",
      head={ name="Blistering Sallet +1", augments={'Path: A',}},
      body="Nyame Mail",
      hands={ name="Gazu Bracelets +1", augments={'Path: A',}},
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Lissome necklace",
      waist="Windbuffet Belt +1",
      left_ear="Cessance Earring",
      right_ear="Brutal Earring",
      left_ring="Hetairoi Ring",
      right_ring="Petrov Ring",
      back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +3", back="Mending Cape"}
    sets.buff['Devotion'] = {head="Piety Cap +3"}
    sets.buff.Sublimation = {waist="Embla Sash"}

    sets.buff.Doom = {
      neck="Nicander's Necklace", --20
      ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
      ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
      waist="Gishdubar Sash", --10
    }

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
    if spellMap == 'Banish' or spellMap == "Holy" then
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spell.name:match('storm') then
            equip(sets.midcast.EnhancingDuration)
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Repose" then
            send_command('@timers c "Repose ['..spell.target.name..']" 90 down spells/00098.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            --send_command('@input /p Doomed.')
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

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    update_sublimation()
end

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'boostspell' then
        send_command('@input /ma '..state.BoostSpell.value..' <me>')
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
--      if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
--          return "CureMelee"
        if default_spell_map == 'Cure' then
            if buffactive['Afflatus Solace'] then
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureSolaceWeather"
                else
                    return "CureSolace"
              end
            else
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureWeather"
                else
                    return "CureNormal"
              end
            end
        elseif default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "CuragaNormal"
            end
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.Sublimation)
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        -- enable('back')
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
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

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 4)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end