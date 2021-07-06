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
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
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
		
    windower.send_command('bind @o sat youcommand Muuhja "Horde Lullaby"')
    windower.send_command('bind @p sat youcommand Zuuhja "Sleepga"')
    -- windower.send_command('bind @n input /ma "Breakga" <t>')
    windower.send_command('bind @n sat youcommand Zuuhja "Dia II"')
	
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
      main="Malevolence", -- 5
      sub="Genmei Shield",
      ammo="Impatiens",
      head={ name="Merlinic Hood", augments={'"Fast Cast"+7','"Mag.Atk.Bns."+14',}}, -- 15
      body="Mallquis Saio +2", -- 9
      hands="Jhakri Cuffs +2",
      legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','INT+8','Mag. Acc.+8',}},
      feet={ name="Merlinic Crackows", augments={'Attack+22','"Fast Cast"+7',}}, -- 12
      neck="Voltsurge Torque", -- 4
      waist="Embla Sash", -- 5
      left_ear="Malignance Earring", -- 4
      left_ring="Mallquis Ring", -- 3
      right_ring="Kishar Ring", -- 4
      back={ name="Taranus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},	
    }
	
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Cataclysm'] = {
      ammo="Pemphredo Tathlum",
      head="Pixie hairpin +1",
      body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      hands="Jhakri Cuffs +2",
      legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
      neck="Sorcerer's Stole +2",
      waist="Orpheus's Sash",
      left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      right_ear="Malignance Earring",
      left_ring="Archon Ring",
      right_ring="Epaminondas's Ring",
    }

    sets.precast.WS['Shattersoul'] = {
      ammo="Floestone",
      head="Jhakri Coronal +2",
      body="Jhakri Robe +2",
      hands="Jhakri Cuffs +2",
      legs="Jhakri Slops +2",
      feet="Jhakri Pigaches +2",
      waist="Luminary Sash",
      left_ear="Regal Earring",
      right_ring="Epaminondas's Ring",
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
      neck="Fotia Gorget",
      waist="Fotia Belt",
      right_ear="Brutal earring",
      left_ear="Regal earring"
    }
	
    sets.precast.WS['Vidohunir'] = {}
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Leisure musk +1",
      head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      neck="Debilis medallion",
      left_ear="Regal earring",
      right_ear="Meili earring",
      body="Amalric doublet +1",
      hands="Regal cuffs",
      left_ring="Stikini ring +1",
      right_ring="Stikini ring +1",
      back="Oretania's cape +1",
      waist="Bishop's sash",
      legs="Amalric slops +1",
      feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
      main="Daybreak",
      sub="Ammurapi Shield",
      body="Telchine chasuble",
      head="Telchine Cap",
      hands="Telchine Gloves",
      legs="Telchine Braconi",
      feet="Telchine Pigaches",
      waist="Embla Sash",
      left_ring="Stikini Ring +1",
      right_ring="Stikini Ring +1",
      right_ear="Mimir Earring",
      left_ear="Regal Earring",	
    }
	
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {
      main="Marin Staff +1",
      sub="Khonsu",
      ammo="Pemphredo tathlum",
      head="Mallquis Chapeau +2",
      body="Spaekona's Coat +2",
      hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      legs="Amalric Slops +1",
      feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
      neck="Sorcerer's Stole +2",
      waist="Sacro Cord",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Mallquis Ring",
      right_ring="Freke Ring",
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},	
    }
	
    sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {
      head=empty, body="Twilight Cloak"
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
      legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','INT+8','Mag. Acc.+8',}},
      left_ring="Archon ring",
      right_ring="Evanescence ring",
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
      feet={ name="Merlinic Crackows", augments={'"Drain" and "Aspir" potency +10',}},
    }
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = sets.midcast['Enfeebling Magic']

    sets.midcast.BardSong = {}
	
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
      main="Marin Staff +1",
      sub="Enki Strap",
      ammo="Ghastly Tathlum +1",
      head="Archmage's Petasos +3",
      body="Spaekona's Coat +2",
      -- body="Archmage's coat +3",
      hands="Archmage's Gloves +3",
      legs="Archmage's Tonban +3",
      feet="Archmage's Sabots +3",
      neck="Sorcerer's Stole +2",
      waist="Orpheus's Sash",
      -- waist="Sacro Cord", -- waist="Hachirin-no-Obi",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Metamorph Ring +1",
      right_ring="Freke Ring",
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
    }

    sets.midcast['Elemental Magic'].Resistant = {}

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {   
    })
	
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {})

    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {
      ammo="Seraphic Ampulla",
      head="Mall. Chapeau +2",
      body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22','"Occult Acumen"+11','INT+9',}},
      hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+20','"Occult Acumen"+9','"Mag.Atk.Bns."+10',}},
      legs="Perdition Slops",
      feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+8','"Occult Acumen"+9','INT+8','Mag. Acc.+10',}},
      waist="Oneiros Rope",
      left_ear="Dedition Earring",
      right_ear="Telos Earring",
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
    }
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
   
    -- Normal refresh idle set
    sets.idle = {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Staunch Tathlum +1",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Sorcerer's Stole +2",
      -- neck="Warder's Charm +1",
      waist="Carrier's Sash",
      left_ear="Etiolation Earring",
      right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
      left_ring="Stikini Ring +1",
      right_ring="Stikini Ring +1",
      back={ name="Taranus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},	
    }

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = set_combine(sets.idle, {
    })

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {}
    
    -- Town gear.
    sets.idle.Town = {feet="Herald's Gaiters"}
        
    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Mana Wall'] = {
      feet="Wicce Sabots +1",
      left_ring="Defending ring"
    }
 
    sets.magic_burst = {
      main="Marin Staff +1",
      sub="Enki Strap",
      neck="Sorcerer's Stole +2",
      ammo="Ghastly Tathlum +1",
      -- waist="Orpheus's Sash",
      -- waist="Hachirin-no-Obi",
      waist="Sacro Cord",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Mujin Band",
      right_ring="Freke Ring",
      hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},    
      head="Ea Hat +1",
      body="Ea Houppe. +1",
      -- body="Spaekona's Coat +2",
      legs="Ea Slops +1",
      feet="Amalric Nails +1",
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}
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
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            -- state.MagicBurst:reset()
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
        enable('feet')
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

