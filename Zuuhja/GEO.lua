--[[
        Custom commands:
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.

        Casting functions:
        these are to set fewer macros (2 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC	in reverse order
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke ra1                   Cast tier 1 -ra nuke of saved element 
        gs c nuke ra2                   Cast tier 2 -ra nuke of saved element 
        gs c nuke ra3                   Cast tier 3 -ra nuke of saved element 	

        gs c geo geocycle               Cycles Geomancy Spell
        gs c geo geocycledown           Cycles Geomancy Spell in reverse order
        gs c geo indicycle              Cycles IndiColure Spell
        gs c geo indicycledown          Cycles IndiColure Spell in reverse order
        gs c geo geo                    Cast saved Geo Spell
        gs c geo indi                   Cast saved Indi Spell

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.

        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]


include('organizer-lib') -- Remove if you dont use Organizer

--------------------------------------------------------------------------------------------------------------
res = require('resources')      -- leave this as is    
texts = require('texts')        -- leave this as is    
include('Modes.lua')            -- leave this as is      
--------------------------------------------------------------------------------------------------------------

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('normal', 'dt', 'mdt')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

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
    send_command('bind @o sat youcommand Muuhja "Sleepga"')

    windower.send_command('bind insert gs c nuke cycle')            -- insert Cycles Nuke element
    windower.send_command('bind delete gs c nuke cycledown')        -- delete Cycles Nuke element in reverse order   
    windower.send_command('bind home gs c geo geocycle') 	    -- home Cycles Geomancy Spell
    windower.send_command('bind PAGEUP gs c geo geocycledown')      -- end Cycles Geomancy Spell in reverse order	
    windower.send_command('bind PAGEDOWN gs c geo indicycle') 	    -- PgUP Cycles IndiColure Spell
    windower.send_command('bind end gs c geo indicycledown') 	    -- PgDown Cycles IndiColure Spell in reverse order	
    windower.send_command('bind !f9 gs c toggle runspeed') 	    -- Alt-F9 toggles locking on / off Herald's Gaiters
    windower.send_command('bind f10 gs c toggle mb')		    -- F10 toggles Magic Burst Mode on / off.
    windower.send_command('bind !f10 gs c toggle nukemode')         -- Alt-F10 to change Nuking Mode
    windower.send_command('bind ^F10 gs c toggle matchsc')          -- CTRL-F10 to change Match SC Mode         
    windower.send_command('bind f12 gs c toggle melee')	            -- F12 Toggle Melee mode on / off and locking of weapons
    windower.send_command('bind f9 gs c toggle idlemode')           -- F9 Toggles between MasterRefresh or MasterDT when no luopan is out
--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]                                                    -- or between Full Pet Regen+DT or Hybrid PetDT and MasterDT when a Luopan is out
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mburst'] = '(F10)'
keybinds_on['key_bind_matchsc'] = '(CTRL-F10)'

keybinds_on['key_bind_element_cycle'] = '(INS + DEL)'
keybinds_on['key_bind_geo_cycle'] = '(HOME + PgUP)'
keybinds_on['key_bind_indi_cycle'] = '(End + PgDOWN)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')
    send_command('unbind home')
    send_command('unbind PAGEUP')
    send_command('unbind PAGEDOWN')
    send_command('unbind end')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind f9')
    send_command('unbind !f9')

    send_command('unbind @o')
end

--------------------------------------------------------------------------------------------------------------
include('GEO_Lib.lua')          -- leave this as is     
--------------------------------------------------------------------------------------------------------------

geomancy:set('Geo-Frailty')     -- Geo Spell Default      (when you first load lua / change jobs the saved spells is this one)
indicolure:set('Indi-Haste')    -- Indi Spell Default     (when you first load lua / change jobs the saved spells is this one)
validateTextInformation()

-- Optional. Swap to your geo macro sheet / book
set_macros(1,5) -- Sheet, Book   
    
-- Setup your Gear Sets below:
function get_sets()
  
   -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
   -- All sets that are equipped to faciliate my.pan's behaviour or abilities are under .pan', eg, Perpetuation, Blood Pacts, etc
      
   sets.me = {}        -- leave this empty
   sets.pan = {}       -- leave this empty
   sets.me.idle = {}   -- leave this empty    
   sets.pan.idle = {}  -- leave this empty 

   -- sets starting with sets.me means you DONT have a luopan currently out.
   -- sets starting with sets.pan means you DO have a luopan currently out.

   -- Your idle set when you DON'T have a luopan out
   sets.me.idle.normal = {
     main="Idris",
     sub="Genmei Shield",
     ammo="Staunch Tathlum +1",
     head="Azimuth Hood +3",
     body="Azimuth Coat +3",
     hands="Bagua Mitaines +3",
     legs={ name="Merlinic Shalwar", augments={'DEX+5','INT+4','"Refresh"+2','Accuracy+1 Attack+1',}},
     feet="Geo. Sandals +3",
     neck="Loricate Torque +1",
     waist="Slipor Sash",
     left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
     right_ear="Etiolation Earring",
     left_ring="Defending Ring",
     right_ring="Gelatinous Ring +1", -- 7 dt
     back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}},
   }

   -- This or herald gaiters or +1 +2 +3... 
   sets.me.movespeed = {right_ring="Shneddick Ring +1"}

   -- Your idle MasterDT set (Notice the sets.me, means no Luopan is out)
   sets.me.idle.dt = set_combine(sets.me.idle.normal, {
     head="Nyame Helm",
     body="Nyame Mail",
     hands="Nyame Gauntlets",
     legs="Nyame Flanchard",
     feet="Nyame Sollerets",
   })

   sets.me.idle.mdt = set_combine(sets.me.idle.dt, {
     neck="Warder's Charm +1",
     head="Azimuth Hood +3",
     hands="Azimuth Gloves +2",
     feet="Azimuth Gaiters +3", 
   })

   -- Your MP Recovered Whilst Resting Set
   sets.me.resting = { 
   }

   sets.me.latent_refresh = {waist="Fucho-no-obi"}

   -----------------------
   -- Luopan Perpetuation
   -----------------------

   -- Luopan's Out --  notice sets.pan 
   -- This is the base for all perpetuation scenarios, as seen below
   sets.pan.idle.normal = {
     main="Idris",
     sub="Genmei shield", -- 10 pdt
     ammo="Staunch Tathlum +1", -- 3 dt
     head="Azimuth Hood +3",
     left_ear="Odnowa earring +1", -- 3 dt, 2 mdt
     right_ear="Etiolation Earring", -- 3 mdt
     body={ name="Telchine Chas.", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
     hands="Geo. Mitaines +3",
     legs={ name="Telchine Braconi", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
     feet="Bagua Sandals +3",
     neck="Bagua Charm +2",
     back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}}, -- 5 dt
     waist="Isa belt",
     left_ring="Defending Ring", -- 10 dt
     right_ring="Gelatinous Ring +1", -- 7 dt
   }

   -- This is when you have a Luopan out but want to sacrifice some slot for master DT, put those slots in.
   sets.pan.idle.dt = set_combine(sets.pan.idle.normal, {
     body="Nyame Mail",
     legs="Nyame Flanchard",
     feet="Nyame Sollerets",
     waist="Slipor Sash",
   })

   sets.pan.idle.mdt = set_combine(sets.pan.idle.dt, {
   })
   
   sets.pan.idle.refresh = {
   }

   -- Combat Related Sets
      
   -- Melee
   -- Anything you equip here will overwrite the perpetuation/refresh in that slot.
   -- No Luopan out
   -- they end in [idleMode] so it will derive from either the normal or the dt set depending in which mode you are then add the pieces filled in below.
   sets.me.melee = {
    ammo="Staunch Tathlum +1",
    head={ name="Blistering Sallet +1", augments={'Path: A',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Gazu Bracelets +1", augments={'Path: A',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Sanctity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Crep. Earring",
    right_ear="Telos Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    -- Cape
   }

   sets.pan.melee = sets.me.melee
    
   -- Weapon Skill sets
   sets.me["Flash Nova"] = {
   }

   sets.me["Realmrazer"] = {
   }

   sets.me["Exudation"] = {
   }

   sets.me["Judgment"] = { -- No cape, ammo defined atm
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Rep. Plat. Medal",
    waist="Grunfeld Rope",
    left_ear="Regal Earring",
    right_ear="Ishvara Earring",
    left_ring="Shukuyu Ring",
    right_ring="Epaminondas's Ring",
   }
   
   sets.me["Cataclysm"] = {
     ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
     head="Pixie Hairpin +1",
     body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     hands={ name="Nyame Gauntlets", augments={'Path: B',}},
     legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     feet={ name="Agwu's Pigaches", augments={'Path: A',}},
     neck="Sibyl Scarf",
     waist="Orpheus's Sash",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Freke Ring",
     right_ring="Archon Ring",
     back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
   }
     
   ---------------
   -- Casting Sets
   ---------------
      
   sets.precast = {}               -- leave this empty    
   sets.midcast = {}               -- leave this empty    
   sets.aftercast = {}             -- leave this empty    
   sets.midcast.nuking = {}        -- leave this empty
   sets.midcast.MB = {}            -- leave this empty    
   ----------
   -- Precast
   ----------
      
   sets.precast.casting = {
     main="Idris",
     range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},                           --  3
     head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+11','"Fast Cast"+6','INT+5','Mag. Acc.+9',}}, -- 14
     neck="Voltsurge Torque",                                                                             --  4
     right_ear="Malignance earring",                                                                      --  4
     left_ear="Loquacious earring",                                                                       --  2
     body="Agwu's Robe",                                                                                  --  8
     hands="Agwu's Gages",                                                                                --  6
     left_ring="Kishar Ring",                                                                             --  4
     right_ring="Prolix ring",                                                                            --  2
     back="Lifestream Cape",                                                                              --  7
     waist="Embla sash",                                                                                  --  5
     legs="Geomancy Pants +3",                                                                            -- 15
     feet={ name="Merlinic Crackows", augments={'"Fast Cast"+6','CHR+2','Mag. Acc.+11',}},                -- 11
   }

   sets.precast.geomancy = set_combine(sets.precast.casting, {
   })

   -- Enhancing Magic, eg. Siegal Sash, etc
   sets.precast.enhancing = set_combine(sets.precast.casting, {
   })
  
   -- Stoneskin casting time -, works off of enhancing -
   sets.precast.stoneskin = set_combine(sets.precast.enhancing, {
   })
      
   -- Curing Precast, Cure Spell Casting time -
   sets.precast.cure = set_combine(sets.precast.casting, {
   })
   
   sets.precast.regen = set_combine(sets.precast.casting, {
   })     
   ---------------------
   -- Ability Precasting
   ---------------------
   
   -- Fill up with your JSE! 
   sets.precast["Life Cycle"] = {
      body = "Geomancy Tunic +2",
   }
   
   sets.precast["Bolster"] = {
      body = "Bagua Tunic +1",
   }
   
   sets.precast["Primeval Zeal"] = {
      head = "Bagua Galero +3",
   }  
   
   sets.precast["Cardinal Chant"] = {
      head = "Geomancy Galero +2",
   }  
   
   sets.precast["Full Circle"] = {
      head = "Azimuth Hood +3",
   }  
   
   sets.precast["Curative Recantation"] = {
      hands = "Bagua Mitaines +3",
   }
   
   sets.precast["Mending Halation"] = {
      legs = "Bagua Pants +3",
   }
   
   sets.precast["Radial Arcana"] = {
      feet = "Bagua Sandals +3",
   }

   sets.precast["Dispelga"] = set_combine(sets.precast.casting, {
     main="Daybreak",
     sub="Ammurapi Shield"
   })
   
   ----------
   -- Midcast
   ----------
            
   -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
   sets.midcast.casting = {
   }

   -- ML20 is 445/445 skill, so you cap with only Dunna.
  sets.midcast.geo = set_combine(sets.midcast.casting, {
     main="Idris",
     sub="Genmei Shield",
     range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},                              -- Only item needed for 900 combined
     head="Bagua Galero +3",                                                                                 -- 600 hp
     body="Vedic Coat",                                                                                      -- 10 Conserve
     hands="Azimuth Gloves +2",                                                                              -- Occasionally Free
     legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}}, -- 12 Conserve
     feet="Azimuth Gaiters +3",                                                                              -- Occasionally Free
     neck={ name="Bagua Charm +2", augments={'Path: A',}},                                                   -- 25% Duration
     waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}},                                             -- 15 Conserve
     left_ear="Mendi. Earring",                                                                              --  2 Conserve
     right_ear="Calamitous Earring",                                                                         --  4 Conserve
     left_ring={ name="Mephitas's Ring +1", augments={'Path: A',}},                                          -- 15 Conserve
     right_ring="Defending Ring",
     back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}},
   })                                                                                                        -- 58 conserve (101 total)

   -- ML20 is 445/445 skill, so you cap with only Dunna.
   sets.midcast.indi = set_combine(sets.midcast.geo, {
     main="Idris",
     sub="Genmei Shield",
     range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}}, 
     head={ name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},  -- 12 Conserve
     body="Vedic Coat",                                                                                      -- 10 Conserve
     hands="Azimuth Gloves +2",                                                                              -- Occasionally Free
     legs={ name="Bagua Pants +3", augments={'Enhances "Mending Halation" effect',}},                        -- 21 Duration
     feet="Azimuth Gaiters +3",                                                                              -- Occasionally Free, 30 Duration
     neck="Loricate Torque +1",
     waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}},                                             -- 15 Conserve
     left_ear="Mendi. Earring",                                                                              --  2 Conserve
     right_ear="Calamitous Earring",                                                                         --  4 Conserve
     left_ring={ name="Mephitas's Ring +1", augments={'Path: A',}},                                          -- 15 Conserve
     right_ring="Defending Ring",
     back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +19',}},
   })                                                                                                        -- 58 conserve (101 total)

   sets.midcast.Obi = {
     waist="Hachirin-no-Obi",
   }

   -- Nuking
   sets.midcast.nuking.normal = set_combine(sets.midcast.casting, {
     main="Idris",
     sub="Ammurapi shield",
     ammo="Ghastly Tathlum +1",
     head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
     body="Seidr Cotehardie",
     hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
     neck="Sibyl Scarf",
     waist="Orpheus's Sash",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Metamorph Ring +1",
     right_ring="Freke Ring",
     back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
   })
   
   sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
     head="Ea Hat +1",
     neck="Mizu. Kubikazari",
     body="Ea Houppe. +1",
     legs="Ea Slops +1",
     left_ring="Mujin Band",
   })

   sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal, {
     body="Azimuth Coat +3",
     hands="Agwu's Gages",
     legs="Azimuth Tights +3",
     feet="Agwu's Pigaches",
     waist="Acuity belt +1",
     left_ring="Metamorph Ring +1",
   })

   sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {
     head="Agwu's Cap",
     neck="Sibyl Scarf",
     body="Azimuth Coat +3", 
     hands="Agwu's Gages",
     legs="Azimuth Tights +3",
     feet="Agwu's Pigaches",
     waist="Acuity belt +1",
     left_ring="Metamorph Ring +1",   
   })

   -- Enfeebling
   sets.midcast.IntEnfeebling = set_combine(sets.midcast.casting, {
     main="Idris",
     sub="Ammurapi Shield",
     range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
     head="Geo. Galero +3",
     body="Geomancy Tunic +3",
     legs="Geomancy Pants +3",
     hands="Geo. Mitaines +3",
     feet="Geo. Sandals +3",
     neck={ name="Bagua Charm +2", augments={'Path: A',}},
     waist="Acuity Belt +1",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Freke Ring",
     right_ring="Metamorph Ring +1",
     back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
   })
   
   sets.midcast.Absorb = set_combine(sets.midcast.IntEnfeebling, {
     left_ring={name="Stikini Ring +1",bag="wardrobe"},
     right_ring={name="Stikini Ring +1",bag="wardrobe5"}
   })

   sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebling, {
     main="Daybreak",
     sub="Ammurapi Shield"
   })
   
   -- could use MND cape
   sets.midcast.MndEnfeebling = set_combine(sets.midcast.casting, {
     main="Daybreak",
     sub="Ammurapi Shield",
     range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
     head="Geo. Galero +3",
     body="Geomancy Tunic +3",
     legs="Geomancy Pants +3",
     hands="Geo. Mitaines +3",
     feet="Geo. Sandals +3",
     neck={ name="Bagua Charm +2", augments={'Path: A',}},
     waist="Luminary Sash",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Stikini Ring +1",
     right_ring="Kishar Ring",
     back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
   })

   sets.midcast['Bio'] = set_combine(sets.midcast.IntEnfeebling, {
     legs={ name="Merlinic Shalwar", augments={'INT+10','VIT+1','"Treasure Hunter"+2',}},
     feet={ name="Merlinic Crackows", augments={'Mag. Acc.+17','Weapon skill damage +1%','"Treasure Hunter"+2','Accuracy+8 Attack+8',}},
   })
   
   -- Enhancing
   sets.midcast.enhancing = set_combine(sets.midcast.casting, {
     main="Gada",
     sub="Ammurapi Shield",
     neck="Melic Torque",
     right_ear="Mimir Earring",
     right_ring="Stikini Ring +1",
     head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
     body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
     hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
     waist="Embla sash",
     legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
     feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
   })

   -- Stoneskin
   sets.midcast.stoneskin = set_combine(sets.midcast.enhancing, {
     left_ear="Earthcry Earring",   
   })

   sets.midcast.refresh = set_combine(sets.midcast.enhancing, {
     waist="Gishdubar Sash",
   })
    
   sets.midcast.aquaveil = sets.midcast.refresh
   
   sets.midcast["Drain"] = set_combine(sets.midcast.IntEnfeebling, {
     main="Rubicundity",
     sub="Ammurapi Shield",
     left_ring="Evanescence ring",
     head="Bagua Galero +3",
     legs="Azimuth tights +3",
     feet="Agwu's Pigaches",
   })

   sets.midcast["Aspir"] = sets.midcast["Drain"]
   sets.midcast["Aspir II"] = sets.midcast["Drain"]
   sets.midcast["Aspir III"] = sets.midcast["Drain"]
   
   sets.midcast['Sleepga'] = set_combine(sets.midcast.IntEnfeebling, {
     legs={ name="Merlinic Shalwar", augments={'INT+10','VIT+1','"Treasure Hunter"+2',}},
     feet={ name="Merlinic Crackows", augments={'Mag. Acc.+17','Weapon skill damage +1%','"Treasure Hunter"+2','Accuracy+8 Attack+8',}},
   })
   
   sets.midcast['Sleep'] = sets.midcast['Sleepga']
   sets.midcast['Sleep II'] = sets.midcast['Sleep']

   sets.midcast['Phalanx'] = set_combine(sets.midcast.enhancing, {
     body={ name="Merlinic Jubbah", augments={'Pet: DEX+5','Crit. hit damage +3%','Phalanx +4','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
     hands={ name="Merlinic Dastanas", augments={'"Blood Pact" ability delay -3','Weapon skill damage +1%','Phalanx +5',}},
   })
   
   sets.midcast.cure = {} -- Leave This Empty

   -- Cure Potency

   sets.midcast.cure.normal = set_combine(sets.midcast.casting, {
     main="Gada",
     shield="Sors shield",
     range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
     head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
     body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
     hands={ name="Vanya Cuffs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
     legs={ name="Vanya Slops", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
     feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
     waist="Luminary Sash",
     left_ear="Mendi. Earring",
     right_ear="Meili Earring",
     left_ring="Stikini Ring +1",
     right_ring="Lebeche Ring",   
   })

   sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal, {
     main="Chatoyant Staff",
     sub="Enki Strap",
   })    

   sets.midcast.regen = set_combine(sets.midcast.enhancing, {
   }) 
   
   ------------
   -- Aftercast
   ------------

   -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have a Luopan pan out?
end
