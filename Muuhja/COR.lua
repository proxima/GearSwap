-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Ranged', 'Melee', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

    gear.RAbullet = "Bronze Bullet"
    gear.WSbullet = "Bronze Bullet"
    gear.MAbullet = "Bronze Bullet"
    gear.QDbullet = "Bronze Bullet"
    options.ammo_warning_limit = 15

    -- Additional local binds
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')

    select_default_macro_book()

    Cape = {}
    Cape.SB      = {name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%'}}
    Cape.TP      = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    Cape.AEOLIAN = {name="Camulus's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
    sets.precast.JA['Snake Eye'] = {legs="Comm. Trews +2"}
    sets.precast.JA['Wild Card'] = {feet="Comm. Bottes +2"}
    sets.precast.JA['Random Deal'] = {body="Comm. Frac +2"}

    sets.precast.CorsairRoll = {
      main={ name="Rostam", bag="wardrobe 4", priority=1},
      head="Lanun Tricorne +2",
      neck="Regal necklace",
      range="Compensator",
      hands="Chasseur's gants +1",
      right_ring="Luzaf's Ring",
      back=Cape.TP
    }
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's culottes +1"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's tricorne +1"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's gants +1"})
    
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +2"}
    sets.precast.CorsairShot = {}    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


    sets.precast.RA = {ammo=gear.RAbullet,
      head="Chasseur's tricorne +1",
      neck="Commodore Charm +2",
      body="Laksa. Frac"
    }

   -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
   
    sets.precast.WS['Hot Shot'] = {ammo="Eminent Bullet",
      head={ name="Nyame Helm", augments={'Path: B',}},
      body={ name="Nyame Mail", augments={'Path: B',}},
      hands={ name="Nyame Gauntlets", augments={'Path: B',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Telos Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring="Regal Ring",
      right_ring="Epaminondas's Ring",
      back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = sets.precast.WS

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet}
    sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet}

    sets.precast.WS['Detonator'] = {ammo="Eminent Bullet",
      head={ name="Nyame Helm", augments={'Path: B',}},
      body={ name="Nyame Mail", augments={'Path: B',}},
      hands={ name="Nyame Gauntlets", augments={'Path: B',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Telos Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring="Regal Ring",
      right_ring="Epaminondas's Ring",
      back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }

    sets.precast.WS['Wildfire'] = {ammo="Bronze Bullet",}
    sets.precast.WS['Wildfire'].Brew = {ammo=gear.MAbullet,}

    sets.precast.WS['Leaden Salute'] = sets.precast.WS['Wildfire']
    
    sets.precast.WS['Savage Blade'] = {
      head={ name="Nyame Helm", augments={'Path: B',}},
      body={ name="Nyame Mail", augments={'Path: B',}},
      hands={ name="Nyame Gauntlets", augments={'Path: B',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck="Loricate Torque +1",
      waist="Kentarch Belt +1",
      left_ear="Ishvara Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring="Regal Ring",
      right_ring="Epaminondas's Ring",
      back=Cape.SB
    }

    sets.precast.WS['Aeolian Edge'] = {
      head={ name="Nyame Helm", augments={'Path: B',}},
      body={ name="Nyame Mail", augments={'Path: B',}},
      hands={ name="Nyame Gauntlets", augments={'Path: B',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck="Sibyl Scarf",
      left_ear="Moonshade Earring",
      right_ear="Odr Earring",
      left_ring="Dingir Ring",
      right_ring="Epaminondas's Ring",
      back=Cape.AEOLIAN,
      waist="Eschan Stone",
    }

    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {ammo=gear.QDbullet}

    sets.midcast.CorsairShot.Acc = {ammo=gear.QDbullet}

    sets.midcast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet
    }

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
      head="Malignance Chapeau",
      -- neck="Iskur Gorget",
      left_ear="Telos Earring",
      right_ear="Digni. Earring",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 3"},
      waist="Reiki Yotai",
      back=Cape.RTP
    }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
    })
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {
      main={ name="Rostam", bag="wardrobe 4", priority=1},
      sub={ name="Rostam", bag="wardrobe 2", priority=2},
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Commodore Charm +2",
      waist="Flume belt +1",
      left_ear="Odnowa Earring +1",
      right_ear="Tuisto Earring +1",
      left_ring="Defending Ring",
      right_ring="Vocane Ring +1",
      back="Mecisto. Mantle",
    }

    sets.idle.Town = sets.idle
    
    -- Defense sets
    sets.defense.PDT = sets.idle
    
    sets.defense.MDT = sets.idle

    sets.Kiting = {feet="Skadi's Jambeaux +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged.Melee = {ammo=gear.RAbullet,
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck={ name="Loricate Torque +1", augments={'Path: A',}},
      waist="Reiki Yotai",
      left_ear="Telos Earring",
      right_ear="Digni. Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 3"},
      back=Cape.TP
    }
    
    sets.engaged.Acc = {ammo=gear.RAbullet,
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck={ name="Loricate Torque +1", augments={'Path: A',}},
      waist="Reiki Yotai",
      left_ear="Telos Earring",
      right_ear="Digni. Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 3"},
      back=Cape.TP
    }

    sets.engaged.Melee.DW = {ammo=gear.RAbullet,
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck={ name="Loricate Torque +1", augments={'Path: A',}},
      waist="Reiki Yotai",
      left_ear="Eabani Earring",
      right_ear="Suppanomimi",
      -- left_ear="Telos Earring",
      -- right_ear="Digni. Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 3"},
      back=Cape.TP
    }
    
    sets.engaged.Acc.DW = {}
    sets.engaged.Ranged = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 19)
end

