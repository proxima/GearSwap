-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Mod')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

    send_command('bind @a sat youcommand Muuhja "Thunderspark"')
    send_command('bind @v sat youcommand Muuhja "Volt Strike"')
    send_command('bind @b sat youcommand Muuhja "Magic Finale"')
    send_command('bind @n sat youcommand Muuhja "Carnage Elegy"')
    send_command('bind @m sat youcommand Muuhja "Pining Nocturne"')
    send_command('bind @o sat youcommand Muuhja "Horde Lullaby"')
    send_command('bind @p sat youcommand Zuuhja "Sleepga"')

	
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
    
    send_command('unbind @b')
    send_command('unbind @n')
    send_command('unbind @m')
    send_command('unbind @o')
    send_command('unbind @p')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {
      hands={ name="Herculean Gloves", augments={'"Conserve MP"+1','Accuracy+21','"Treasure Hunter"+2',}}, 
      feet="Skulker's poulaines +1"
    }
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Jute boots +1"}

    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +1"}
    sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {head="Plunderer's Bonnet",hands="Pillager's Armlets +1",legs="Pillager's Culottes +1",feet="Pillager's Poulaines +1"}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
    sets.precast.RA = {}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {  
      ammo="Qirmiz tathlum",
      head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
      body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
      hands="Mummu Wrists +2",
      legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
      feet="Mummu Gamash. +2",
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Sherida Earring",
      right_ear="Odr Earring",
      left_ring="Gere Ring",
      right_ring="Ilabrat Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {})
    sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
      ammo="Qirmiz tathlum",
      head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
      body="Meg. Cuirie +2",
      hands="Mummu Wrists +2",
      legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
      feet="Mummu Gamash. +2",
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Sherida Earring",
      right_ear="Odr Earring",
      left_ring="Regal Ring",
      right_ring="Ilabrat Ring",
      back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
    })
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
      ammo="Cath Palug Stone",
      head={ name="Herculean Helm", augments={'Accuracy+29','Weapon skill damage +4%',}},
      body={ name="Herculean Vest", augments={'Accuracy+21','Weapon skill damage +4%','Attack+5',}},
      hands="Mummu Wrists +2",
      legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
      feet={ name="Herculean Boots", augments={'Weapon Skill Acc.+1','DEX+5','Weapon skill damage +8%','Accuracy+1 Attack+1',}},
      neck="Fotia Gorget",
      waist="Kentarch Belt +1",
      left_ear="Sherida Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring="Regal Ring",
      right_ring="Ilabrat Ring",
      back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
    })
    
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {})
    sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {})
    sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})

    sets.precast.WS['Aeolian Edge'] = {
      ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
      head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Magic burst dmg.+3%','INT+9',}},
      body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
      hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Crit. hit damage +5%','INT+9',}},
      legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Phys. dmg. taken -4%','INT+7',}},
      feet={ name="Herculean Boots", augments={'Weapon skill damage +4%','"Mag.Atk.Bns."+28','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
      neck="Sanctity Necklace",
      waist="Orpheus's Sash",
      left_ear="Odr Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back="Argocham. Mantle",
    }
    
    sets.precast.WS['Cyclone'] = sets.precast.WS['Aeolian Edge']
    sets.precast.WS['Gust Slash'] = sets.precast.WS['Aeolian Edge']    

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

    -- Specific spells
    sets.midcast.Utsusemi = {}

    -- Ranged gear
    sets.midcast.RA = {}

    sets.midcast.RA.Acc = {}
    
    sets.midcast["Sleepga"] = {
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands={ name="Herculean Gloves", augments={'"Conserve MP"+1','Accuracy+21','"Treasure Hunter"+2',}}, 
      legs="Malignance Tights",
      feet="Skulker's poulaines +1"   
    }

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    
    sets.idle = {
      ammo="Yamarang",
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      neck="Loricate Torque +1",
      waist="Windbuffet Belt +1",
      left_ear="Sherida Earring",
      right_ear="Odnowa Earring +1",
      right_ring="Defending ring",
      left_ring="Gelatinous Ring",
      back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
      -- feet="Jute boots +1"
      feet="Malignance Boots"
    }

    sets.idle.Town = {feet="Jute boots +1"}

    sets.idle.Weak = {feet="Jute boots +1"}


    -- Defense sets

    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
      ammo="Yamarang",
      head="Adhemar Bonnet +1",
      body="Adhemar Jacket +1",
      hands="Adhemar Wrist. +1",
      legs="Samnuha Tights",
      feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
      neck="Anu torque",
      waist="Reiki Yotai",
      left_ear="Sherida Earring",
      right_ear="Brutal Earring",
      left_ring="Gere Ring",
      right_ring="Hetairoi ring",
      back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    }

    sets.engaged.Acc = {}
    -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.Mod = {}
    
    -- Mod set for trivial mobs (Thaumas)
    sets.engaged.Mod2 = {}
    
    sets.engaged.Evasion = {}
    
    sets.engaged.Acc.Evasion = {}
    
    sets.engaged.PDT = {
      ammo="Yamarang",
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Anu Torque",
      waist="Reiki yotai",
      left_ear="Sherida Earring",
      right_ear="Brutal Earring",
      right_ring="Hetairoi ring",
      left_ring="Gere Ring",
      back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    }
    
    sets.engaged.Acc.PDT = {}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
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
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 5)
    elseif player.sub_job == 'WAR' then
        set_macro_page(3, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 5)
    else
        set_macro_page(2, 5)
    end
end


