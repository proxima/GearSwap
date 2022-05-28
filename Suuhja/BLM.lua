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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Occult', 'Death')
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind ^b gs c toggle MagicBurst')
    
    windower.send_command('bind @a sat youcommand Muuhja "Thunderspark"')
    windower.send_command('bind @s sat youcommand Zuuhja "Thundara III"')
    windower.send_command('bind @d sat youcommand Suuhja "Thundaja"')
    windower.send_command('bind @f sat youcommand Muuhja "Shock Squall"')

    windower.send_command('bind @b sat youcommand Muuhja "Magic Finale"')
    windower.send_command('bind @n sat youcommand Muuhja "Carnage Elegy"')
    windower.send_command('bind @m sat youcommand Muuhja "Pining Nocturne"')
        
    windower.send_command('bind @o sat youcommand Muuhja "Horde Lullaby II"')
    windower.send_command('bind @p sat youcommand Zuuhja "Sleepga"')
    -- windower.send_command('bind @n input /ma "Breakga" <t>')
    -- windower.send_command('bind @n sat youcommand Zuuhja "Dia II"')
    
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
    
    send_command('unbind @a')
    send_command('unbind @s')
    send_command('unbind @d')
    send_command('unbind @f')
    
    send_command('unbind @o')
    send_command('unbind @p')
    send_command('unbind @b')
    send_command('unbind @m')
    send_command('unbind @n')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Wicce Sabots +1"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
      ammo="Impatiens",
      head={ name="Merlinic Hood", augments={'"Fast Cast"+7','"Mag.Atk.Bns."+14',}}, -- 15
      body="Agwu's Robe",                                                            --  8
      hands="Agwu's gages",                                                          --  6
      legs="Agwu's Slops",                                                           --  7
      feet={ name="Merlinic Crackows", augments={'Attack+22','"Fast Cast"+7',}},     -- 12
      neck="Voltsurge Torque",                                                       --  4
      waist="Embla Sash",                                                            --  5
      left_ear="Malignance Earring",                                                 --  4
      right_ear="Etiolation Earring",                                                --  1
      left_ring="Mallquis Ring",                                                     --  3~
      right_ring="Kishar Ring",                                                      --  4
      back={ name="Taranus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},    
    }
    
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      ammo="Floestone",
      head="Jhakri Coronal +2",
      body="Jhakri Robe +2",
      hands="Jhakri Cuffs +2",
      legs="Jhakri Slops +2",
      feet="Jhakri Pigaches +2",
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Regal Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},    
    }
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Cataclysm'] = {
      ammo="Ghastly Tathlum +1",
      -- head="Pixie hairpin +1",
      head="Agwu's Cap",
      body="Agwu's Robe",
      hands="Jhakri Cuffs +2",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck="Sorcerer's Stole +2",
      waist="Hachirin-no-Obi",
      -- waist="Orpheus's Sash",
      -- left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      -- left_ring="Archon Ring",
      left_ring="Freke Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      -- right_ring="Epaminondas's Ring",
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},      
    }

    sets.precast.WS['Earth Crusher'] = {
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Agwu's Robe",
      hands="Jhakri Cuffs +2",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck="Sorcerer's Stole +2",
      waist="Orpheus's Sash",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Freke Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},      
    }

    sets.precast.WS['Shattersoul'] = {
      ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
      head={ name="Nyame Helm", augments={'Path: B',}},
      body={ name="Nyame Mail", augments={'Path: B',}},
      hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck={ name="Src. Stole +2", augments={'Path: A',}},
      waist={ name="Acuity Belt +1", augments={'Path: A',}},
      left_ear="Malignance Earring",
      right_ear="Regal Earring",
      left_ring="Freke Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back={ name="Taranus's Cape", augments={'INT+20','Accuracy+20 Attack+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }
    
    sets.precast.WS['Vidohunir'] = {
      ammo="Ghastly Tathlum +1",
      head="Pixie hairpin +1",
      body="Agwu's Robe",
      hands="Jhakri Cuffs +2",
      legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      feet="Agwu's Pigaches",
      neck="Sorcerer's Stole +2",
      waist="Orpheus's Sash",
      left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      right_ear="Malignance Earring",
      left_ring="Archon Ring",
      right_ring="Epaminondas's Ring",
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},      
    }
    
    sets.precast.WS['Myrkr'] = {
      ammo="Ghastly Tathlum +1",
      head="Pixie Hairpin +1",
      neck="Voltsurge Torque",
      left_ear="Moonshade Earring",
      right_ear="Etiolation Earring",
      body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      hands="Regal Cuffs",
      left_ring="Mephitas's Ring",
      right_ring="Metamorph ring +1",
      back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Mag. Evasion+15',}},   
      waist="Luminary sash",      
      legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    }
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
      ammo="Leisure musk +1",
      head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      neck="Debilis medallion",
      left_ear="Regal earring",
      right_ear="Meili earring",
      body="Amalric doublet +1",
      hands="Regal cuffs",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      back="Oretania's cape +1",
      waist="Bishop's sash",
      legs="Amalric slops +1",
      feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
      body="Telchine chasuble",
      head="Telchine Cap",
      hands="Telchine Gloves",
      legs="Telchine Braconi",
      feet="Telchine Pigaches",
      waist="Embla Sash",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      right_ear="Mimir Earring",
      left_ear="Regal Earring",    
    }
    
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {
      ammo="Pemphredo tathlum",
      head="Befouled Crown",
      body="Spaekona's Coat +3",
      hands="Regal Cuffs",
      legs="Archmage's Tonban +3",
      feet="Archmage's Sabots +3",
      neck="Sorcerer's Stole +2",
      waist="Acuity Belt +1",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Kishar Ring",
      right_ring="Metamorph Ring +1",
      back="Aurist's Cape +1",
    }
    
    sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {
      head=empty, body="Crepuscular Cloak"
    })
    
    sets.midcast['Sleepga'] = set_combine(sets.midcast['Enfeebling Magic'], {
    })

        
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {
      legs="Archmage's tonban +3",
      feet="Archmage's sabots +3",
    })

    sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = {
      ammo="Pemphredo tathlum",
      head="Pixie hairpin +1",
      neck="Erra pendant",
      body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+11','"Drain" and "Aspir" potency +10','MND+6',}},
      waist="Fucho-no-Obi",
      legs="Agwu's Slops",
      left_ring="Archon ring",
      right_ring="Evanescence ring",
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
      feet="Agwu's Pigaches"
    }
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = sets.midcast['Enfeebling Magic']

    sets.midcast.BardSong = {}
    
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Spaekona's Coat +3",
      hands="Agwu's Gages",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck="Sorcerer's Stole +2",
      -- waist="Orpheus's Sash",
      -- waist="Sacro Cord", -- waist="Hachirin-no-Obi",
      waist="Acuity Belt +1",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Metamorph Ring +1",
      right_ring="Freke Ring",
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
    }
    
    sets.midcast['Luminohelix'] = set_combine(sets.midcast['Elemental Magic'], {
      main="Daybreak",
      sub="Culminus",
      body="Agwu's Robe",
      hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      feet="Agwu's Pigaches",
      left_ear="Crematio Earring",
      left_ring="Mallquis Ring",
      waist="Skrymir Cord +1",
    })

    sets.midcast['Elemental Magic'].Resistant = {}

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {   
    })
    
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Death'] = {
      main="Hvergelmir",
      sub="Khonsu",
      ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
      head="Pixie Hairpin +1",
      body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      hands={ name="Agwu's Gages", augments={'Path: A',}},
      legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      neck="Sanctity Necklace",
      waist="Hachirin-no-Obi",
      left_ear="Barkaro. Earring",
      right_ear="Regal Earring",
      left_ring="Mephitas's Ring",
      right_ring="Archon Ring",
      back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Mag. Evasion+15',}},
    }

    sets.precast.FC.Death = sets.midcast.Death
    sets.midcast.Drain.Death = sets.midcast.Death
    sets.midcast.Aspir.Death = sets.midcast.Death
    
    sets.midcast['Elemental Magic'].Occult = {
      ammo="Seraphic Ampulla",
      head="Mall. Chapeau +2",
      body="Spaekona's Coat +3",
      hands={ name="Merlinic Dastanas", augments={'"Occult Acumen"+11','INT+10','Mag. Acc.+6',}},
      legs="Perdition Slops",
      feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+2','"Occult Acumen"+11','MND+9','Mag. Acc.+15',}},
      neck="Lissome Necklace",
      waist="Oneiros Rope",
      left_ear="Dedition Earring",
      right_ear="Telos Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 4"},
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Store TP"+10','Phys. dmg. taken-10%',}},
    }
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
   
    -- Normal refresh idle set
    sets.idle = {
      ammo="Staunch Tathlum +1",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Warder's Charm +1",
      waist="Carrier's Sash",
      left_ear="Etiolation Earring",
      right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      back={ name="Taranus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},    
    }

    sets.idle.Death = sets.midcast['Death']
    
    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = set_combine(sets.idle, {
      -- feet="Hippo. Socks +1",
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},    
    })

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = sets.idle.PDT
    
    -- Town gear.
    sets.idle.Town = sets.idle
        
    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Mana Wall'] = {
      main="Kaumodaki",
      sub="Khonsu",
    }
 
    sets.magic_burst = {
      ammo="Ghastly Tathlum +1",
      head="Ea Hat +1",
      neck="Sorcerer's Stole +2",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      body="Ea Houppe. +1",
      hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      left_ring="Metamorph Ring +1",
      right_ring="Freke Ring",
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},    
      waist="Acuity Belt +1",
      legs="Ea Slops +1",
      feet="Agwu's Pigaches",
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
      ammo="Floestone",
      head={ name="Nyame Helm", augments={'Path: B',}},
      body={ name="Nyame Mail", augments={'Path: B',}},
      hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck="Lissome Necklace",
      waist="Grunfeld Rope",
      left_ear="Mache Earring +1",
      right_ear="Telos Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 4"},
      back={ name="Taranus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
      gear.default.obi_waist = "Sekhmet Corset"
      if state.CastingMode.value == 'Proc' then
        classes.CustomClass = 'Proc'
      elseif state.CastingMode.value == 'Occult' then
        classes.CustomClass = 'Occult'
      end
    elseif spell.skill == 'Dark Magic' then
      if state.CastingMode.value == 'Death' then
        classes.CustomClass = 'Death'
      end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            -- enable('feet')
            equip(sets.buff['Mana Wall'])
            -- disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            -- state.MagicBurst:reset()
        elseif spell.english == 'Death' then
          eventArgs.handled = true
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        -- enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    if state.CastingMode.value == 'Death' then
      return sets.idle.Death
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 15)
end

