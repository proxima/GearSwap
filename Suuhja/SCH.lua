
--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
                
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm II buff of saved element  
                    
        gs c sc tier                    Cycles SC Tier (1 & 2)
        gs c sc castsc                  Cast All the stuff to create a SC burstable by the nuke element set with '/console gs c nuke element'.

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.

        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Wind                  Set Element Type to Wind DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]

-------------------------------------------------------------                                        
--                              
--      ,---.     |    o               
--      |   |,---.|--- .,---.,---.,---.
--      |   ||   ||    ||   ||   |`---.
--      `---'|---'`---'``---'`   '`---'
--           |                         
-------------------------------------------------------------  

include('organizer-lib') -- Can remove this if you dont use organizer
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'mdt')
regenModes = M('hybrid', 'duration', 'potency')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc', 'occult')

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1400    --important to update these if you have a smaller screen
hud_y_pos = 200     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'


-- Setup your Key Bindings here:
    windower.send_command('bind insert gs c nuke cycle')        -- insert to Cycles Nuke element
    windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
    windower.send_command('bind f9 gs c toggle idlemode')       -- F9 to change Idle Mode    
    windower.send_command('bind !f9 gs c toggle runspeed') 		-- Alt-F9 toggles locking on / off Herald's Gaiters
    windower.send_command('bind f12 gs c toggle melee')			-- F12 Toggle Melee mode on / off and locking of weapons
    windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
    windower.send_command('bind home gs c sc tier')				-- home to change SC tier between Level 1 or Level 2 SC
    windower.send_command('bind end gs c toggle regenmode')		-- end to change Regen Mode	
    windower.send_command('bind f10 gs c toggle mb')            -- F10 toggles Magic Burst Mode on / off.
    windower.send_command('bind !f10 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
    windower.send_command('bind ^F10 gs c toggle matchsc')      -- CTRL-F10 to change Match SC Mode      	
    windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version   

    -- windower.send_command('bind @a send zuuhja input /ma "Indi-Wilt" <me>')
    -- windower.send_command('bind @s sat youcommand Zuuhja Geo-Frailty')

    send_command('bind @a sat youcommand Zuuhja "Bio";input /ma "Luminohelix" <t>')
    send_command('bind @s sat youcommand Zuuhja "Bio";input /ma "Luminohelix II" <t>')

    -- windower.send_command('bind @a sat youcommand Muuhja "Wind Threnody II"')
    -- windower.send_command('bind @s sat youcommand Zuuhja Silence')
    -- windower.send_command('bind @d send zuuhja /ma "Cure" Aller')
    windower.send_command('bind @z send zuuhja input /ja "Full Circle" <me>')
    windower.send_command('bind @x send zuuhja input /ja "Radial Arcana" <me>')

	-- windower.send_command('bind @b sat youcommand Zuuhja "Dispel"')
    windower.send_command('bind @b sat youcommand Muuhja "Earth Threnody II"')
    windower.send_command('bind @n sat youcommand Muuhja "Carnage Elegy"')
    windower.send_command('bind @m sat youcommand Muuhja "Pining Nocture"')
    windower.send_command('bind @o sat youcommand Muuhja "Horde Lullaby II"')
    windower.send_command('bind @p sat youcommand Muuhja "Foe Lullaby II"')
	-- windower.send_command('bind @p send muuhja input /pet "Release" <me>')
    windower.send_command('bind @= send muuhja input /ja "Apogee" <me>')
    -- windower.send_command('bind @n sat youcommand Muuhja "Level ? Holy"')
    windower.send_command('bind @d sat youcommand Muuhja Deploy')


    -- windower.send_command('bind @b send muuhja input /ma "Ramuh" <me>')
    -- windower.send_command('bind @n send Muuhja /input /ja "Mana Cede" <me>')
    -- windower.send_command('bind @v sat youcommand Muuhja "Volt Strike"')
    -- windower.send_command('bind @m sat youcommand Muuhja "Shock Squall"')
    -- windower.send_command('bind @o sat youcommand Muuhja Assault')
    -- windower.send_command('bind @p send muuhja input /pet "Release" <me>')
    -- windower.send_command('bind @= send muuhja input /ja "Apogee" <me>')
    
--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mburst'] = '(F10)'

keybinds_on['key_bind_element_cycle'] = '(INSERT)'
keybinds_on['key_bind_sc_level'] = '(HOME)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(CTRL-F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')
    send_command('unbind f9')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind end')
    send_command('unbind !f10')
    send_command('unbind `f10')
    send_command('unbind !f9')
    send_command('unbind !end')
    
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
end

--------------------------------------------------------------------------------------------------------------
include('SCH_Lib.lua')          -- leave this as is    
refreshType = idleModes[1]      -- leave this as is     
--------------------------------------------------------------------------------------------------------------

-- Optional. Swap to your sch macro sheet / book
set_macros(1,17) -- Sheet, Book


-------------------------------------------------------------                                        
--      ,---.                         |         
--      |  _.,---.,---.,---.,---.,---.|--- ,---.
--      |   ||---',---||    `---.|---'|    `---.
--      `---'`---'`---^`    `---'`---'`---'`---'
-------------------------------------------------------------                                              

-- Setup your Gear Sets below:
function get_sets()
  
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}       -- leave this empty
    sets.buff = {}     -- leave this empty
    sets.me.idle = {}  -- leave this empty

    -- Your idle set
    sets.me.idle.refresh = {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Homiliary",
      head="Befouled crown",
      ear1="Etiolation earring",
      ear2="Odnowa earring +1",  -- 3 DT, 2 MDT
      neck="Loricate torque +1",
      body="Jhakri robe +2",     -- 4
      hands="Pinga mittens +1",
      legs="Pinga pants +1",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      feet="Pinga pumps +1",
      waist="Carrier's Sash",
      back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},
    }

    -- Your idle Sublimation set combine from refresh or DT depening on mode.
    sets.me.idle.sublimation = set_combine(sets.me.idle.refresh, {
      head="Acad. Mortar. +2",
      body="Pedagogy gown +3",
      waist="Embla Sash",
    })

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle[refreshType], {
      ammo="Staunch Tathlum +1",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Loricate Torque +1",
      waist="Carrier's Sash",
      left_ear="Eabani Earring",
      right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
      left_ring="Defending Ring",
      right_ring="Gelatinous Ring +1",
      back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},
    })

    sets.me.idle.mdt = set_combine(sets.me.idle.dt, {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Staunch tathlum +1",  -- 3 DT
      head="Pinga crown +1",
      ear1="Lugalbanda earring",
      ear2="Odnowa earring +1",   -- 3 DT, 2 MDT
      neck="Warder's charm +1",
      body="Pinga Tunic +1",      
      hands="Pinga mittens +1",
      legs="Pinga pants +1",
      ring1="Defending ring",     -- 10 DT
      ring2="Gelatinous ring +1", --  7 PDT, -1MDT
      feet="Pinga pumps +1",
      waist="Carrier's Sash",
      back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},
    })

    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 
    }
    
    sets.me.latent_refresh = { 
      waist="Fucho-no-Obi",
    }
    
    -- Combat Related Sets
    sets.me.melee = {
      ammo="Staunch Tathlum +1",
      head={ name="Blistering Sallet +1", augments={'Path: A',}},
      body="Nyame Mail",
      hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Lissome Necklace",
      waist="Grunfeld Rope",
      left_ear="Cessance Earring",
      right_ear="Telos Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 4"},
      back={ name="Lugh's Cape", augments={'INT+20','Accuracy+20 Attack+20','INT+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, -- Make stp + dex version
    }

    sets.me.melee_dw = set_combine(sets.me.melee, {
      left_ear="Eabani Earring",
      right_ear="Suppanomimi",
      back={ name="Lugh's Cape", augments={'INT+20','Accuracy+20 Attack+20','INT+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, -- Make dual wield + dex version
    })
      
    -- Weapon Skills sets just add them by name.
    sets.me["Heavy Swing"] = {
      ammo="Floestone",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Luminary Sash",
      left_ear="Regal Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},    
    }
    
    sets.me["Retribution"] = sets.me["Heavy Swing"]
    sets.me["Shattersoul"] = set_combine(sets.me["Heavy Swing"], {
      ammo="Ghastly Tathlum +1",
      neck="Fotia Gorget",
      waist="Fotia Belt",
      hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Freke Ring",
      right_ear="Brutal earring",
      left_ear="Regal earring",
      back={ name="Lugh's Cape", augments={'INT+20','Accuracy+20 Attack+20','INT+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    })
    
    sets.me["Shell Crusher"] = set_combine(sets.me["Heavy Swing"], {
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Moonshade Earring",
      right_ear="Telos Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 4"},
      back={ name="Lugh's Cape", augments={'INT+20','Accuracy+20 Attack+20','INT+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    })
    
    sets.me["Full Swing"] = sets.me["Heavy Swing"]
    sets.me["Spirit Taker"] = sets.me["Heavy Swing"]

    sets.me["Earth Crusher"] = {
      ammo="Ghastly Tathlum +1",
      head="Nyame Helm",
      body="Agwu's Robe",
      hands="Jhakri Cuffs +2",
      legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      feet="Nyame Sollerets",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Orpheus's Sash",
      left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      right_ear="Malignance Earring",
      left_ring="Epaminondas's Ring",
      right_ring="Metamorph Ring +1",
      back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
    }
    
    sets.me["Rock Crusher"] = sets.me["Earth Crusher"]
    
    sets.me["Starburst"] = {
    }
    
    sets.me["Cataclysm"] = {
      ammo="Ghastly Tathlum +1",
      head="Pixie hairpin +1",
      body="Nyame Mail",
      hands="Jhakri Cuffs +2",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Orpheus's Sash",
      left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      right_ear="Malignance Earring",
      left_ring="Archon Ring",
      right_ring="Metamorph Ring +1",
      back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
    }

    -- current set vs ceizak bee, voidstorm ii: 21633
    sets.me["Omniscience"] = {
      ammo="Ghastly Tathlum +1",
      head="Pixie hairpin +1",
      body="Agwu's Robe",
      hands="Jhakri Cuffs +2",
      legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Orpheus's Sash",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Archon Ring",
      right_ring="Metamorph Ring +1",
      back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},
    }
    
    sets.me["Myrkr"] = {
      ammo="Ghastly Tathlum +1",
      head="Kaykaus Mitra +1",
      neck="Voltsurge Torque",
      left_ear="Moonshade Earring",
      right_ear="Etiolation Earring",
      body="Acad. Gown +3",
      hands="Pinga mittens +1",
      left_ring="Mephitas's Ring",
      right_ring="Metamorph ring +1",
      back={ name="Lugh's Cape", augments={'MP+60','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
      waist="Luminary sash",
      legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    }

    sets.me["Black Halo"] = {
      ammo="Floestone",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Luminary Sash",
      left_ear="Regal Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},    
    }
        
    ------------
    -- Buff Sets
    ------------
    -- Gear that needs to be worn to **actively** enhance a current player buff.
    -- Fill up following with your avaible pieces.
    sets.buff['Rapture'] = {head="Arbatel bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}

    sets.buff['Immanence'] = {
    }

    sets.buff['Penury'] = {}
    sets.buff['Parsimony'] = {}
    sets.buff['Celerity'] = {feet="Pedagogy loafers +3"}
    sets.buff['Alacrity'] = {feet="Pedagogy loafers +3"}
    -- sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}
    sets.buff['Ebullience'] = {head="Arbatel bonnet +1"}
   	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}        -- Leave this empty  
    sets.midcast = {}        -- Leave this empty  
    sets.aftercast = {}      -- Leave this empty  
    sets.midcast.nuking = {} -- leave this empty
    sets.midcast.MB	= {}     -- leave this empty      
    ----------
    -- Precast
    ----------
      
    sets.precast.casting = {
      ammo="Impatiens",
      head={ name="Merlinic Hood", augments={'"Fast Cast"+7','"Mag.Atk.Bns."+14',}}, -- 15 fc
      neck="Voltsurge Torque",   -- 4 fc
      ear1="Etiolation earring", -- 1 fc
      ear2="Malignance earring", -- 4 fc
      body="Pinga tunic +1",     -- 15 fc
      hands="Acad. Bracers +3",  -- 9 fc
      ring1="Lebeche ring",      -- 
      ring2="Kishar ring",       -- 4 fc
      back={ name="Lugh's Cape", augments={'MP+60','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
      waist="Embla sash",        -- 5 fc
      legs="Pinga pants +1",     -- 13 fc
      feet={ name="Merlinic Crackows", augments={'Attack+22','"Fast Cast"+7',}}, -- 12 fc, 3 haste
    }

   sets.precast["Dispelga"] = set_combine(sets.precast.casting, {
     main="Daybreak",
     sub="Ammurapi Shield"
   })
   
   sets.precast["Impact"] = set_combine(sets.precast.casting, {
     main="Hvergelmir",
     sub="Khonsu",
     head=empty, 
     body="Twilight Cloak"
   })
    
   sets.precast["Stun"] = set_combine(sets.precast.casting, {
     main="Hvergelmir",
     sub="Khonsu",
   })
   
   sets.precast["Modus Veritas"] = {
     main="Tupsimati",
     sub="Khonsu",
     ammo="Pemphredo tathlum",
     head="Acad. Mortar. +2",
     body="Acad. Gown +3",
     hands="Acad. Bracers +3",
     legs="Acad. Pants +3",
     feet="Acad. Loafers +3",
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Acuity Belt +1",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
     right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
     back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
   }

   -- When spell school is aligned with grimoire, swap relevent pieces -- Can also use Arbatel +1 set here if you value 1% quickcast procs per piece. (2+ pieces)  
   -- Dont set_combine here, as this is the last step of the precast, it will have sorted all the needed pieces already based on type of spell.
   -- Then only swap in what under this set after everything else. 
   sets.precast.grimoire = {
     feet="Academic's loafers +3", -- 12 Grimoire
   }


    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting, {
    })
    
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing, {

    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{    
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Tabula Rasa"] = {legs="Pedagogy Pants +3"}
    sets.precast["Enlightenment"] = {body="Pedagogy Gown +3"} 
    sets.precast["Sublimation"] = {}

    ----------
    -- Midcast
    ----------

    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
      waist="Hachirin-no-Obi",
    }

    -----------------------------------------------------------------------------------------------
    -- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
    -- Pixie in DarkHelix
    -- Boots that aren't arbatel +1 (15% of small numbers meh, amalric+1 does more)
    -- Belt that isn't Obi.
    -----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Kaustra = {
      -- Set prioritizing intelligence, mb acc, macc, dark magic skill for Ongo fun.
      main={ name="Bunzi's Rod", augments={'Path: A',}},
      sub="Ammurapi Shield",
      ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
      head={ name="Peda. M.Board +3", augments={'Enh. "Altruism" and "Focalization"',}},
      body={ name="Agwu's Robe", augments={'Path: A',}},
      hands="Regal Cuffs",
      legs={ name="Peda. Pants +3", augments={'Enhances "Tabula Rasa" effect',}},
      feet="Jhakri Pigaches +2",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist={ name="Acuity Belt +1", augments={'Path: A',}},
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Freke Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
      -- When not doing Ongo swap to this stuff, maybe change hands.
      -- head="Pixie hairpin +1",
      -- left_ring="Archon ring",
    }
    
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.
    sets.midcast.Helix = {
      -- left_ear="Crematio Earring",
      -- waist="Skrymir Cord +1",
      -- left_ring="Mallquis Ring",
      -- back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},     
      main="Bunzi's Rod",
      sub="Ammurapi Shield", -- sub="Culminus",
      ammo="Ghastly Tathlum +1",
      head="Pedagogy mortarboard +3",
      body="Agwu's Robe",
      hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','INT+8','Mag. Acc.+8',}},
      feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Skrymir Cord +1",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Metamorph ring +1",
      right_ring="Freke Ring",
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},     
    }

   -- mb helix compared to agwus
   -- head  @ r20: -6int, -11macc,  +5mab, +30mdmg,
   -- body  @ r20: +6int,                  +20mdmg
   -- hands @ r20: -3int, +11macc,  +2mab, +20mdmg
   -- legs  @ r20: -2int,  -8macc, +15mab,  +7mdmg
   -- feet  @ r20: +9int, +25macc,  -7mab
   
   -- nuking compared to agwus
   -- head  @ r20: -6int, -11macc,  +5mab, +30mdmg
   -- body  @ r20: +9int,  -8macc,  -8mab, +20mdmg
   -- hands @ r20: -3int, +11macc,  -8mab, +20mdmg
   -- legs  @ r20: +9int, +25macc, -15mab, +20mdmg
   -- feet  @ r20: +9int, +25macc,  -7mab      
   
   -- mb acc compared to agwus
   -- head  @ r20: -6int, -26macc,  +5mab, +30mdmg,        -4mbd2
   -- body  @ r20: +6int,                  +20mdmg
   -- hands @ r20: -3int, +11macc,  +2mab, +20mdmg, +8mbd, -2mbd2
   -- legs  @ r20: -2int,  -8macc, +15mab,  +7mdmg, -1mbd
   -- feet  @ r20: -3int,  +3macc, +16mab, +20mdmg, -1mbd
   
   -- mb normal compared to agwus
   -- head  @ r20: -6int, -26macc,  +5mab, +30mdmg,        -4mbd2
   -- body  @ r20: +6int,                  +20mdmg
   -- hands @ r20: -3int, +11macc,  -8mab, +20mdmg, +8mbd, -2mbd2
   -- legs  @ r20: -2int,  -8macc, +15mab,  +7mdmg, -1mbd
   -- feet  @ r20: +9int, +25macc,  -7mab,          +6mbd
    
    sets.midcast.WindHelix = {
      main="Marin staff +1",
      sub="Enki Strap",
      waist="Skrymir Cord +1",
      left_ring="Mallquis Ring",
      left_ear="Crematio Earring",
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},
    }
    
    sets.midcast.LightHelix = {
      main="Daybreak",
      sub="Culminus",
      left_ear="Crematio Earring",
      left_ring="Mallquis Ring",
      waist="Skrymir Cord +1",
      -- back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},      
    }

    sets.midcast.DarkHelix = {
      head="Pixie hairpin +1",
      left_ear="Crematio Earring",
      left_ring="Archon ring",
      right_ring="Mallquis Ring",
      waist="Skrymir Cord +1",
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},
    }

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
   sets.midcast.casting = {
     head={ name="Merlinic Hood", augments={'"Fast Cast"+7','"Mag.Atk.Bns."+14',}}, -- 15 fc, 6 haste
     neck="Voltsurge Torque",   -- 4
     ammo="Pemphredo tathlum",
     ear1="Etiolation earring", -- 1
     ear2="Malignance earring", -- 4
     body="Pinga tunic +1",     -- 15
     hands="Acad. Bracers +3",  -- 9 fc, 3 haste
     ring1="Defending ring",
     ring2="Kishar ring",       -- 4
     back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Haste+10','Spell interruption rate down-10%',}},
     waist="Witful belt",       -- 3 fc, 3 haste
     legs="Pinga pants +1",     -- 13
     feet={ name="Merlinic Crackows", augments={'Attack+22','"Fast Cast"+7',}}, -- 12 fc, 3 haste
   }

   sets.midcast["Sublimation"] = {
   }    
   
   sets.midcast.nuking.normal = {
     ammo="Ghastly Tathlum +1",
     head={ name="Peda. M.Board +3", augments={'Enh. "Altruism" and "Focalization"',}},
     body="Agwu's Robe",
     hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Sacro Cord",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Metamorph ring +1",
     right_ring="Freke Ring",
     back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
   }

   sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal, {
     sub="Khonsu",
     feet="Jhakri Pigaches +2",
   })
   
   -- used with toggle, default: F10
   -- Pieces to swap from free nuke to Magic Burst    
   sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
     main="Bunzi's Rod",
     sub="Ammurapi Shield",
     ammo="Ghastly Tathlum +1",
     head="Pedagogy mortarboard +3",
     body="Agwu's Robe",
     hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','INT+8','Mag. Acc.+8',}},
     feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Sacro Cord",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Metamorph Ring +1",
     right_ring="Freke Ring",
     back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
   })

   -- used with toggle, default: F10
   -- Pieces to swap from free nuke to Magic Burst
   sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {   
     feet="Jhakri Pigaches +2",
     waist="Acuity Belt +1",
   })
   
   sets.midcast.nuking.occult = set_combine(sets.midcast.nuking.normal, { 
     ammo="Seraphic Ampulla",
     head="Mall. Chapeau +2",
     body={ name="Merlinic Jubbah", augments={'Mag. Acc.+22','"Occult Acumen"+11','INT+9',}},
     hands={ name="Merlinic Dastanas", augments={'"Occult Acumen"+11','INT+10','Mag. Acc.+6',}},
     legs="Perdition Slops",
     feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+2','"Occult Acumen"+11','MND+9','Mag. Acc.+15',}},
     neck="Lissome Necklace",
     waist="Oneiros Rope",
     left_ear="Dedition Earring",
     right_ear="Telos Earring",
     left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
     right_ring={name="Chirich Ring +1",bag="wardrobe 4"},
     back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Store TP"+10','Phys. dmg. taken-10%',}},
   })

   sets.midcast.MB.occult = set_combine(sets.midcast.MB.normal, {
     main="Khatvanga"
   })

    -- Enfeebling
   sets.midcast["Stun"] = {
     main="Hvergelmir",
     sub="Khonsu",             -- 4
     ammo="Pemphredo tathlum",
     head="Acad. Mortar. +2",  -- 6
     body="Acad. Gown +3",     -- 3
     hands="Acad. Bracers +3", -- 3
     legs="Acad. Pants +3",    -- 5
     feet="Acad. Loafers +3",  -- 3
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Acuity Belt +1",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
     right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
     back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Haste+10','Spell interruption rate down-10%',}}, 
   }

   sets.midcast.IntEnfeebling = {
     main="Tupsimati",
     sub="Khonsu",
     ammo="Pemphredo tathlum",
     head="Acad. Mortar. +2",
     body="Acad. Gown +3",
     hands="Acad. Bracers +3",
     legs="Acad. Pants +3",
     feet="Acad. Loafers +3",
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Acuity Belt +1",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
     right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
     back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
   }
   
   sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebling, {
     main="Daybreak",
     sub="Ammurapi Shield"
   })
   
   sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebling, {
     main="Hvergelmir",
     sub="Khonsu",
     head=empty, 
     body="Twilight Cloak"
   })
   
   sets.midcast.SC_Open = {
      -- main="Malignance Pole",
      main="Hvergelmir",
      sub="Khonsu",                                                                                       --         4 haste
      ammo="Staunch Tathlum +1",
      head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},                         -- 10 fc,  8 haste
      neck="Voltsurge Torque",                                                                            --  4 fc
      left_ear="Etiolation Earring",                                                                      --  1 fc
      right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
      body="Pinga Tunic +1",                                                                              -- 15 fc
      hands="Acad. Bracers +3",                                                                           --  9 fc,  3 haste
      left_ring="Defending Ring",
      right_ring="Kishar Ring",                                                                           --  4 fc
      back={ name="Lugh's Cape", augments={'MP+60','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},    -- 10 fc
      waist="Witful Belt",                                                                                --  3 fc,  3 haste
      legs="Psycloth Lappas",                                                                             --  7 fc,  5 haste
      feet="Acad. Loafers +3",                                                                            --         3 haste
   }                                                                                                      -- 63 fc, 26 haste
   
   sets.midcast["Aero"] = sets.midcast.SC_Open
   sets.midcast["Blizzard"] = sets.midcast.SC_Open
   sets.midcast["Fire"] = sets.midcast.SC_Open
   sets.midcast["Stone"] = sets.midcast.SC_Open
   sets.midcast["Hydrohelix"] = sets.midcast.SC_Open
   sets.midcast["Ionohelix"] = sets.midcast.SC_Open
   sets.midcast["Noctohelix"] = sets.midcast.SC_Open
   
   sets.midcast.MndEnfeebling = {
     main="Tupsimati",
     sub="Khonsu",
     ammo="Pemphredo tathlum",
     head=none,
     body="Cohort Cloak +1",
     hands="Kaykaus Cuffs +1",
     legs={ name="Chironic Hose", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Fast Cast"+5','MND+11','Mag. Acc.+13','"Mag.Atk.Bns."+6',}},
     feet="Acad. Loafers +3",
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Luminary Sash",
     right_ear="Malignance Earring",
     left_ear="Regal Earring",
     left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
     right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
     back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Haste+10','Spell interruption rate down-10%',}}, 
   }

   -- Enhancing, 501 skill atm w/ light arts, caps barspells
    sets.midcast.enhancing = set_combine(sets.midcast.casting, {
      main={ name="Musa", augments={'Path: C',}},
      sub="Khonsu",
      body="Pedagogy gown +3",
      head="Telchine Cap",
      hands="Telchine Gloves",
      legs="Telchine Braconi",
      feet="Telchine Pigaches",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Embla Sash",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      right_ear="Mimir Earring",
      left_ear="Regal Earring",
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},
    })

    sets.midcast.storm = set_combine(sets.midcast.enhancing, {
    })       
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing, {
    })

    sets.midcast.refresh = set_combine(sets.midcast.enhancing, {
    })

    sets.midcast.aquaveil = set_combine(sets.midcast.refresh, {
      head="Chironic hat",
      hands="Regal cuffs",
    })

    sets.midcast["Drain"] = set_combine(sets.midcast.nuking.normal, {
      main="Tupsimati",
      sub="Khonsu",
      ammo="Pemphredo tathlum",
      head="Pixie hairpin +1",
      neck="Erra pendant",
      body="Acad. Gown +3",
      hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+11','"Drain" and "Aspir" potency +10','MND+6',}},
      waist="Fucho-no-Obi",
      legs="Pedagogy pants +3",
      left_ring="Archon ring",
      right_ring="Evanescence ring",
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},
      feet={ name="Merlinic Crackows", augments={'"Drain" and "Aspir" potency +10',}},
    })

    sets.midcast["Aspir"] = sets.midcast["Drain"]
    sets.midcast["Absorb-MND"] = sets.midcast["Aspir"]
    
    sets.midcast["Cursna"] = {
      head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      body="Pedagogy Gown +3",
      hands="Pedagogy bracers +3",
      legs="Academic's Pants +3",
      feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      neck="Debilis Medallion",
      waist="Bishop's Sash",
      left_ear="Beatific Earring",
      right_ear="Meili Earring",
      left_ring="Menelaus's Ring",
      right_ring="Haoma's Ring",
      back="Oretania's Cape +1",
    }

    sets.midcast.cure = {} -- Leave This Empty

    -- Cure Potency    
    sets.midcast.cure.normal = set_combine(sets.midcast.casting, {
      ammo="Leisure Musk +1",            --     4
      head="Kaykaus mitra +1",           -- 11     6
      body="Pedagogy gown +3",           --        3
      hands="Pedagogy bracers +3",       --     7  3
      legs="Academic's pants +3",        -- 15  6  5
      feet="Kaykaus boots +1",           -- 17  6  3
      left_ear="Domesticator's earring", --     5
      right_ear="Mendi. Earring",        --  5
      left_ring="Lebeche ring",          --  3  5
      right_ring="Stikini ring +1",
      waist="Witful belt",               --        3
      back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}}, --  0 10  0
      -- merits                                 5
      -- totals:                             51 48 23 (ignoring Daybreak potency incase we are weapon locked)
    })
    
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal, {
      main="Chatoyant staff",             -- 10
      sub="Enki Strap",
      waist="Hachirin-no-Obi",
    })

    ------------
    -- Regen
    ------------
    sets.midcast.regen = {}    -- leave this empty
    
    -- Normal hybrid well rounded Regen
    sets.midcast.regen.hybrid = {
      main="Musa",
      sub="Khonsu",
      head="Arbatel Bonnet +1",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      right_ear="Mimir Earring",
      left_ear="Regal Earring",
      body="Pedagogy gown +3",
      hands="Arbatel Bracers +1", -- Tired of this not swapping properly
      -- hands="Telchine Gloves",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      waist="Embla Sash",
      back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},
      legs="Telchine Braconi",
      feet="Telchine Pigaches",
    }
    
    -- Focus on Regen Duration
    sets.midcast.regen.duration = set_combine(sets.midcast.regen.hybrid,{
      back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},
    }) 
    
    -- Focus on Regen Potency
    sets.midcast.regen.potency = set_combine(sets.midcast.regen.hybrid,{
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},
    }) 

    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.

end
