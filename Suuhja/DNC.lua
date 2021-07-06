  
-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

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
--              [ WIN+F ]           Toggle Closed Position (Facing) Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+- ]          Primary step element cycle forward.
--              [ CTRL+= ]          Primary step element cycle backward.
--              [ ALT+- ]           Secondary step element cycle forward.
--              [ ALT+= ]           Secondary step element cycle backward.
--              [ CTRL+[ ]          Toggle step target type.
--              [ CTRL+] ]          Toggle use secondary step.
--              [ Numpad0 ]         Perform Current Step
--
--              [ CTRL+` ]          Saber Dance
--              [ ALT+` ]           Chocobo Jig II
--              [ ALT+[ ]           Contradance
--              [ CTRL+Numlock ]    Reverse Flourish
--              [ CTRL+Numpad/ ]    Berserk/Meditate
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki
--              [ CTRL+Numpad- ]    Aggressor/Third Eye
--              [ CTRL+Numpad+ ]    Climactic Flourish
--              [ CTRL+NumpadEnter ]Building Flourish
--              [ CTRL+Numpad0 ]    Sneak Attack
--              [ CTRL+Numpad. ]    Trick Attack
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  WS:         [ CTRL+Numpad7 ]    Exenterator
--              [ CTRL+Numpad4 ]    Evisceration
--              [ CTRL+Numpad5 ]    Rudra's Storm
--              [ CTRL+Numpad6 ]    Pyrrhic Kleos
--              [ CTRL+Numpad1 ]    Aeolian Edge
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c step                       Uses the currently configured step on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c step t                     Uses the currently configured step on the target, but forces use of <t>.
--
--  gs c cycle mainstep             Cycles through the available steps to use as the primary step when using
--                                  one of the above commands.
--  gs c cycle altstep              Cycles through the available steps to use for alternating with the
--                                  configured main step.
--  gs c toggle usealtstep          Toggles whether or not to use an alternate step.
--  gs c toggle selectsteptarget    Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.


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
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false

    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(true, 'Ignore Targetting')

    state.ClosedPosition = M(false, 'Closed Position')

    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
--  state.SkillchainPending = M(false, 'Skillchain Pending')

    state.CP = M(false, "Capacity Points Mode")

    lockstyleset = 1
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'DT')

    -- Additional local binds
    -- include('Global-Binds.lua') -- OK to remove this line
    -- include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('lua l gearinfo')

    send_command('bind ^- gs c cycleback mainstep')
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind !- gs c cycleback altstep')
    send_command('bind != gs c cycle altstep')
    send_command('bind ^] gs c toggle usealtstep')
    send_command('bind ![ input /ja "Contradance" <me>')
    send_command('bind ^` input /ja "Saber Dance" <me>')
    send_command('bind !` input /ja "Chocobo Jig II" <me>')
    send_command('bind @f gs c toggle ClosedPosition')
	send_command('bind @v input /ja "Violent Flourish" <t>')
    send_command('bind ^numlock input /ja "Reverse Flourish" <me>')
    
    send_command('bind @b send muuhja input /ma "Siren" <me>')
    send_command('bind @n sat youcommand Muuhja "Carnage Elegy"')
    send_command('bind @m sat youcommand Muuhja "Bitter Elegy"')
    send_command('bind @o sat youcommand Muuhja Assault')
    send_command('bind @p send muuhja input /pet "Release" <me>')
    send_command('bind @= send muuhja input /ja "Apogee" <me>')

    send_command('bind @c gs c toggle CP')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    elseif player.sub_job == 'SAM' then
        send_command('bind ^numpad/ input /ja "Meditate" <me>')
        send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
        send_command('bind ^numpad- input /ja "Third Eye" <me>')
    elseif player.sub_job == 'THF' then
        send_command('bind ^numpad0 input /ja "Sneak Attack" <me>')
        send_command('bind ^numpad. input /ja "Trick Attack" <me>')
    end

    send_command('bind ^numpad+ input /ja "Climactic Flourish" <me>')
    send_command('bind ^numpadenter input /ja "Building Flourish" <me>')

--    send_command('bind ^numpad7 input /ws "Exenterator" <t>')
--    send_command('bind ^numpad4 input /ws "Evisceration" <t>')
--    send_command('bind ^numpad5 input /ws "Rudra\'s Storm" <t>')
--    send_command('bind ^numpad6 input /ws "Pyrrhic Kleos" <t>')

    send_command('bind ^numpad4 send zuuhja /ma "Cure IV" Aptfury')
    send_command('bind ^numpad5 send zuuhja /ma "Cure IV" Muuhja')
    send_command('bind ^numpad2 send zuuhja /ma "Cure IV" Aller')
    send_command('bind ^numpad3 send zuuhja /ma "Curaga III" Aller')
    send_command('bind ^numpad1 send zuuhja /ma "Cure IV" Suuhja')

	send_command('bind @a sat youcommand Muuhja "Wind Threnody II"')
	send_command('bind @s send zuuhja /ja "Elemental Seal" <me>')
    send_command('bind @d sat youcommand Zuuhja Silence')
	send_command('bind @f sat youcommand Zuuhja "Dia II"')
    send_command('bind @o sat youcommand Zuuhja "Sleep II"')
    send_command('bind @p sat youcommand Zuuhja "Sleep"')
    send_command('bind @n sat youcommand Muuhja "Carnage Elegy"')
	send_command('bind @m sat youcommand Muuhja "Magic Finale"')
    
    send_command('bind numpad0 gs c step t')

    select_default_macro_book()
    set_lockstyle()

    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^]')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ![')
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^,')
    send_command('unbind @f')
    send_command('unbind @c')
	send_command('unbind @v')
    send_command('unbind ^numlock')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad+')
    send_command('unbind ^numpadenter')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind numpad0')
    send_command('unbind ^numpad0')
    send_command('unbind ^numpad.')

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
	
    send_command('unbind @a')
    send_command('unbind @s')
    send_command('unbind @o')
    send_command('unbind @m')
    send_command('unbind @n')
	
    send_command('lua u gearinfo')

end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enmity set
    sets.Enmity = {
    }

    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}
    sets.precast.JA['Trance'] = {head="Horos Tiara +3"}

    sets.precast.Waltz = {
      ammo="Yamarang",                 --  5
	  body="Maxixi casaque +3",        -- 19
	  left_ear="Handler's earring +1",
      neck="Etoile gorget +2",         -- 10
      legs="Dashing subligar",         -- 10
	  feet="Malignance boots",
    } -- Waltz Potency/CHR

    sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {
    }) -- Waltz effects received

    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Samba = {
	  head="Maxixi Tiara +3",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    sets.precast.Jig = {legs="Horos Tights +3", feet="Maxixi Toeshoes +3"}

    sets.precast.Step = {
      ammo="Yamarang",
      head="Maxixi Tiara +3",
      neck="Etoile gorget +2",
      left_ear="Mache Earring +1",
      right_ear="Telos Earring",
      body="Malignance Tabard",
      hands="Maxixi Bangles +3",
      left_ring="Chirich Ring +1",
      right_ring="Regal Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
      waist="Kentarch Belt +1",
      legs="Malignance Tights",
      feet="Horos T. Shoes +3"
    }

    sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step, {feet="Macu. Toeshoes +1"})
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Animated Flourish'] = set_combine(sets.Enmity, {
      head={ name="Herculean Helm", augments={'"Store TP"+1','Magic Damage +1','"Treasure Hunter"+2','Accuracy+7 Attack+7',}},
      hands={ name="Herculean Gloves", augments={'"Conserve MP"+1','Accuracy+21','"Treasure Hunter"+2',}},    
    })

    sets.precast.Flourish1['Violent Flourish'] = {
      ammo="Yamarang",
      neck="Etoile Gorget +2",
      head="Malignance chapeau",
      body="Malignance tabard",
      hands="Malignance gloves",
      legs="Malignance tights",
      feet="Malignance boots",
      left_ring="Stikini Ring +1",
      right_ring="Stikini Ring +1",
    } -- Magic Accuracy

    sets.precast.Flourish1['Desperate Flourish'] = {
    } -- Accuracy

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Charis Bangles +1", back="Toetapper Mantle"}
    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +1"}
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1",}

    sets.precast.FC = {
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
    } -- default set

        
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    })

    sets.precast.WS.Critical = {head="Maculele Tiara +1", body="Meg. Cuirie +2"}


    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
      ammo="C. Palug Stone",
      head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
      body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
      hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
      legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
      feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
      neck={ name="Etoile Gorget +2", augments={'Path: A',}},
      waist="Fotia Belt",
      left_ear="Sherida Earring",
      right_ear="Mache Earring +1",
      left_ring="Gere Ring",
      right_ring="Epona's Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    })

    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
    })

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
      ammo="Charis Feather",
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
      right_ring="Begrudging Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
    })

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
      ammo="Charis Feather",
      head={ name="Herculean Helm", augments={'Accuracy+29','Weapon skill damage +4%',}},
      body={ name="Herculean Vest", augments={'Accuracy+21','Weapon skill damage +4%','Attack+5',}},
      hands="Maxixi bangles +3",
      legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
      feet={ name="Herculean Boots", augments={'Weapon Skill Acc.+1','DEX+5','Weapon skill damage +8%','Accuracy+1 Attack+1',}}, 
      neck="Etoile gorget +2",
      waist="Kentarch Belt +1",
      left_ear="Sherida Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring="Regal Ring",
      right_ring="Epaminondas's Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','Weapon skill damage +10%',}},
    })
    
    sets.precast.WS['Dancing Edge'] = sets.precast.WS['Rudra\'s Storm']
    sets.precast.WS['Shark Bite'] = sets.precast.WS['Rudra\'s Storm']

    sets.precast.WS['Aeolian Edge'] = {
      ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
      head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Magic burst dmg.+3%','INT+9',}},
      body="Samnuha Coat",
      hands="Maxixi Bangles +3",
      legs="Horos Tights +3",
      feet={ name="Herculean Boots", augments={'Weapon skill damage +4%','"Mag.Atk.Bns."+28','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
      neck="Sanctity Necklace",
      ear1="Moonshade Earring",
      ear2="Odr Earring",
      left_ring="Metamorph ring +1",
      right_ring="Epaminondas's Ring",
      back="Argocham. Mantle",
      waist="Orpheus's Sash",
    }
    
    sets.precast.WS['Exenterator'] = sets.precast.WS['Aeolian Edge']

    sets.precast.Skillchain = {
        hands="Macu. Bangles +1",
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Elemental Magic'] = set_combine(sets.engaged.Hybrid, {
      head={ name="Herculean Helm", augments={'"Store TP"+1','Magic Damage +1','"Treasure Hunter"+2','Accuracy+7 Attack+7',}},
      hands={ name="Herculean Gloves", augments={'"Conserve MP"+1','Accuracy+21','"Treasure Hunter"+2',}},
    })

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
      right_ring="Defending ring",
      ammo="Yamarang",
      head="Malignance chapeau",
      body="Malignance tabard",
      hands="Malignance gloves",
      legs="Malignance tights",
      feet="Malignance boots",
    }

    sets.idle.DT = set_combine(sets.idle, {
    })

    sets.idle.Town = set_combine(sets.idle, {
      main={ name="Terpsichore", augments={'Path: A',}},
      sub="Twashtar",
      ammo="Yamarang",
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck={ name="Etoile Gorget +2", augments={'Path: A',}},
      waist="Reiki Yotai",
      left_ear="Eabani Earring",
      right_ear="Sherida Earring",
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},    
    })

    sets.idle.Weak = sets.idle.DT


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Tandava crackows"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
      ammo="Yamarang",
      head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
      body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
      hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
      legs="Samnuha Tights",
      feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
      neck="Etoile gorget +2",
      waist="Windbuffet belt +1",
      left_ear="Sherida Earring",
      right_ear="Mache Earring +1",
      left_ring="Gere Ring",
      right_ring="Epona's Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
    })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    })

    sets.engaged.STP = set_combine(sets.engaged, {
    })

    -- * DNC Native DW Trait: 30% DW
    -- * DNC Job Points DW Gift: 5% DW

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
      ammo="Yamarang",
	  head="Maxixi Tiara +3",     -- 8
	  neck="Etoile Gorget +2",
	  left_ear="Suppanomimi",     -- 5
	  right_ear="Sherida Earring",
	  body="Adhemar Jacket +1",   -- 6
      hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
      left_ring="Epona's Ring",
      right_ring="Gere Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, -- 10
	  waist="Reiki Yotai",        -- 7
      legs="Samnuha Tights",
      feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    }

    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    })

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
    })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    })

    sets.engaged.DW.STP = set_combine(sets.engaged.DW, {
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      body="Malignance tabard",
      head="Malignance chapeau",
      hands="Malignance gloves",
      legs="Malignance tights",
      feet="Malignance boots"
    })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = {
      ammo="Yamarang",
	  head="Adhemar Bonnet +1",
	  neck="Etoile Gorget +2",
	  left_ear="Suppanomimi",     -- 5
	  right_ear="Eabani earring", -- 4
	  body="Adhemar Jacket +1",   -- 6
      hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
      left_ring="Epona's Ring",
      right_ring="Gere Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, -- 10
	  waist="Reiki Yotai",        -- 7
      legs="Samnuha Tights",
      feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    } -- 32%

    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    })

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    })

    sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      body="Malignance tabard",
      head="Malignance chapeau",
      hands="Malignance gloves",
      legs="Malignance tights",
      feet="Malignance boots"
    })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {
      ammo="Yamarang",
	  head="Maxixi Tiara +3",     -- 8
	  neck="Etoile Gorget +2",
	  left_ear="Eabani Earring",  -- 4
	  right_ear="Sherida Earring",
	  body="Horos Casaque +3",
      hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
      left_ring="Epona's Ring",
      right_ring="Gere Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, -- 10
	  waist="Windbuffet Belt +1",
      legs="Samnuha Tights",
      feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    } -- 22%

    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    })

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    })

    sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      body="Malignance tabard",
      head="Malignance chapeau",
      hands="Malignance gloves",
      legs="Malignance tights",
      feet="Malignance boots"	
    })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
      ammo="Yamarang",
      head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
      body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
      hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
      legs="Samnuha Tights",
      feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
      neck="Etoile gorget +2",
      waist="Reiki yotai",
      left_ear="Sherida Earring",
      right_ear="Mache Earring +1",
      left_ring="Epona's Ring",
      right_ring="Gere Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}, -- 10
    } -- 17% Gear

    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    })

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    })

    sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      body="Malignance tabard",
      head="Malignance chapeau",
      hands="Malignance gloves",
      legs="Malignance tights",
      feet="Malignance boots"	
    })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
      ammo="Yamarang",
      head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
      body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
      hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
      legs="Samnuha Tights",
      feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
      neck="Etoile gorget +2",
      waist="Windbuffet belt +1",
      left_ear="Sherida Earring",
      right_ear="Mache Earring +1",
      left_ring="Epona's Ring",
      right_ring="Gere Ring",
      back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},   
    } -- 0%

    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    })

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
    })

    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      body="Malignance tabard",
      head="Malignance chapeau",
      hands="Malignance gloves",
      legs="Malignance tights",
      feet="Malignance boots"
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------    

    -- No Magic Haste (74% DW to cap)
    sets.engaged.Hybrid = {
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      head="Malignance chapeau",
      body="Malignance tabard",
      hands="Malignance gloves",
      legs="Malignance tights",
      feet="Malignance boots",
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff['Saber Dance'] = {legs="Horos Tights +3"}
    sets.buff['Fan Dance'] = {body="Horos Bangles +3"}
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +1", body="Meg. Cuirie +2"}
    sets.buff['Closed Position'] = {feet="Horos T. Shoes +3"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    --auto_presto(spell)
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

function job_midcast(spell, action, spellMap, eventArgs)
  if spell.type == 'BlackMagic' then
    equip(sets.midcast['Elemental Magic'])
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if state.Buff['Sneak Attack'] == true then
            equip(sets.precast.WS.Critical)
        end
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
    end
    if spell.type=='Waltz' and spell.english:startswith('Curing') and spell.target.type == 'SELF' then
        equip(sets.precast.WaltzSelf)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    if buff == 'Saber Dance' or buff == 'Climactic Flourish' or buff == 'Fan Dance' then
        handle_equipping_gear(player.status)
    end

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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    determine_haste_group()
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

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end

    return wsmode
end

function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.Buff['Climactic Flourish'] then
        meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
    end
    if state.ClosedPosition.value == true then
        meleeSet = set_combine(meleeSet, sets.buff['Closed Position'])
    end

    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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

    local s_msg = state.MainStep.current
    if state.UseAltStep.value == true then
        s_msg = s_msg .. '/'..state.AltStep.current
    end

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
        ..string.char(31,060).. ' Step: '  ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 1 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 1 and DW_needed <= 9 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 9 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 21 and DW_needed <= 39 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 39 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doStep = ''
        if state.UseAltStep.value == true then
            doStep = state[state.CurrentStep.current..'Step'].current
            state.CurrentStep:cycle()
        else
            doStep = state.MainStep.current
        end

        send_command('@input /ja "'..doStep..'" <t>')
    end

    gearinfo(cmdParams, eventArgs)
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


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']

        if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
            cast_delay(1.1)
            send_command('input /ja "Presto" <me>')
        end
    end
end

windower.register_event('zone change', 
    function()
        send_command('gi ugs true')
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 20)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end