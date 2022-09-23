--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off kiting set
        gs c toggle idlemode            Toggles between idle modes. 
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
        gs c toggle mpreturn            Toggles whether you wear mp return gear during elemental spells
          
        Casting functions:
        these are to set fewer macros (1 cycle, many to cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element
        gs c nuke t6                    Cast tier 6 nuke of saved element
        gs c nuke am                    Cast ancient magic of saved element
        gs c nuke am2                   Cast ancient magic 2 of saved element
        gs c nuke ja                    Cast the appropriate -ja spell of saved element
        gs c nuke ga1                   Cast the -ga spell of saved element
        gs c nuke ga2                   Cast the -ga II spell of saved element
        gs c nuke ga3                   Cast the -ga III spell of saved element

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
idleModes = M('refresh', 'dt', 'mdt', 'death')
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
    windower.send_command('bind !f9 gs c toggle runspeed')      -- Alt-F9 toggles locking on / off kiting set
    windower.send_command('bind f12 gs c toggle melee')         -- F12 Toggle Melee mode on / off and locking of weapons
    windower.send_command('bind !` input /ma Stun <t>')         -- Alt-` Quick Stun Shortcut.
    windower.send_command('bind f10 gs c toggle mb')            -- F10 toggles Magic Burst Mode on / off.
    windower.send_command('bind !f10 gs c toggle nukemode')     -- Alt-F10 to change Nuking Mode
    windower.send_command('bind ^F10 gs c toggle matchsc')      -- CTRL-F10 to change Match SC Mode      	
    windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version   
    windower.send_command('bind @b gs c toggle mpreturn')       -- Win+B to toggle mp return swap on nukes

--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mburst'] = '(F10)'
keybinds_on['key_bind_mpreturn'] = '(WIN-B)'

keybinds_on['key_bind_element_cycle'] = '(INSERT)'
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
    send_command('unbind !f10')
    send_command('unbind ^f10')
    send_command('unbind !f9')
    send_command('unbind !end')
    send_command('unbind @b')
end

--------------------------------------------------------------------------------------------------------------
include('BLM_Lib.lua')          -- leave this as is    
refreshType = idleModes[1]      -- leave this as is     
--------------------------------------------------------------------------------------------------------------

-- Optional. Swap to your BLM macro sheet / book
set_macros(1,3) -- Sheet, Book

-------------------------------------------------------------                                        
--      ,---.                         |         
--      |  _.,---.,---.,---.,---.,---.|--- ,---.
--      |   ||---',---||    `---.|---'|    `---.
--      `---'`---'`---^`    `---'`---'`---'`---'
-------------------------------------------------------------                                              

-- Setup your Gear Sets below:
function get_sets()
    Taranus = {}
    Taranus.INT_WSD     = { name="Taranus's Cape", augments={'INT+20','Accuracy+20 Attack+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    Taranus.DEX_DA      = { name="Taranus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    Taranus.MP_FC       = { name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Mag. Evasion+15',}}
    Taranus.INT_MAB     = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
    Taranus.MND_FC_MEVA = { name="Taranus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}}
    Taranus.INT_STP     = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Store TP"+10','Phys. dmg. taken-10%',}}
      
    sets.me = {}       -- leave this empty
    sets.buff = {}     -- leave this empty
    sets.me.idle = {}  -- leave this empty

    -- Your idle set
    sets.me.idle.refresh = {
      ammo="Staunch Tathlum +1",
      head="Nyame Helm",
      ear1="Etiolation earring",
      ear2="Odnowa earring +1",
      neck="Loricate torque +1",
      body="Agwu's Robe",
      hands="Nyame Gauntlets",
      legs="Agwu's slops",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      feet="Wicce Sabots +2",
      waist="Carrier's Sash",
      back=Taranus.MND_FC_MEVA
    }

    -- Your idle Sublimation set combine from refresh or DT depening on mode.
    sets.me.idle.sublimation = set_combine(sets.me.idle.refresh, {
      waist="Embla Sash",
    })

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle[refreshType], {
      ammo="Staunch Tathlum +1",
      head="Nyame Helm",
      body="Agwu's Robe",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Wicce Sabots +2",
      neck="Loricate Torque +1",
      waist="Carrier's Sash",
      left_ear="Eabani Earring",
      right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
      left_ring="Defending Ring",
      right_ring="Gelatinous Ring +1",
      back=Taranus.INT_WSD
    })

    sets.me.idle.mdt = set_combine(sets.me.idle.dt, {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Staunch tathlum +1",  --  3 DT
      head="Nyame Helm",
      ear1="Lugalbanda earring",
      ear2="Odnowa earring +1",   --  3 DT, 2 MDT
      neck="Warder's charm +1",
      body="Agwu's Robe",
      hands="Nyame Gauntlets",
      legs="Agwu's slops",        --  9 DT
      ring1="Defending ring",     -- 10 DT
      ring2="Gelatinous ring +1", --  7 PDT, -1MDT
      feet="Wicce Sabots +2",     -- 12 DT
      waist="Carrier's Sash",
      back=Taranus.MND_FC_MEVA    -- 10 PDT
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
      head={ name="Nyame Helm", augments={'Path: B',}},
      body={ name="Nyame Mail", augments={'Path: B',}},
      hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck="Lissome Necklace",
      waist="Grunfeld Rope",
      left_ear="Crepuscular Earring",
      right_ear="Telos Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 4"},
      back=Taranus.DEX_DA
    }  

    sets.me.melee_dw = set_combine(sets.me.melee, {
      left_ear="Eabani Earring",
      right_ear="Suppanomimi",
      back=Taranus.DEX_DA -- Make dw + dex version
    })
 
    -- Weapon Skills sets just add them by name.
    sets.me["Heavy Swing"] = {
      ammo="Floestone",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Rep. Plat. Medal",
      waist="Grunfeld Rope",
      left_ear="Regal Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back=Taranus.INT_WSD  
    }
    
    sets.me["Retribution"] = sets.me["Heavy Swing"]

    sets.me["Shattersoul"] = {
      ammo="Ghastly Tathlum +1",
      head="Nyame Helm",
      neck="Sorcerer's Stole +2",
      right_ear="Malignance earring",
      left_ear="Regal earring",
      body="Nyame Mail",
      hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Freke Ring",
      back=Taranus.INT_WSD,
      waist="Fotia Belt",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets"
    }
    
    sets.me["Shell Crusher"] = {
      ammo="Amar Cluster",
      head={ name="Nyame Helm", augments={'Path: B',}},
      body={ name="Agwu's Robe", augments={'Path: A',}},
      hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck="Lissome Necklace",
      waist="Grunfeld Rope",
      left_ear="Mache Earring +1",
      right_ear="Telos Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 4"},
      back=Taranus.INT_WSD
    }
    
    sets.me["Full Swing"] = sets.me["Heavy Swing"]
    sets.me["Spirit Taker"] = sets.me["Heavy Swing"]

    sets.me["Earth Crusher"] = {
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Agwu's Robe",
      hands="Jhakri Cuffs +2",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck="Quanpur Necklace",
      waist="Orpheus's Sash",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Freke Ring",
      right_ring="Metamorph Ring +1",
      back=Taranus.INT_WSD
    }

    sets.me["Rock Crusher"] = sets.me["Earth Crusher"]

    sets.me["Aeolian Edge"] = set_combine(sets.me["Earth Crusher"], {
      neck="Sorcerer's Stole +2",
    })
    
    sets.me["Cataclysm"] = set_combine(sets.me["Aeolian Edge"], {
      ammo="Ghastly Tathlum +1",
      head="Pixie hairpin +1",
      body="Agwu's Robe",
      hands="Jhakri Cuffs +2",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck={ name="Sorcerer's Stole +2", augments={'Path: A',}},
      waist="Orpheus's Sash",
      left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      right_ear="Malignance Earring",
      left_ring="Archon Ring",
      right_ring="Metamorph Ring +1",
    })

    sets.me["Seraph Strike"] = {
      ammo="Pemphredo Tathlum",
      head="Agwu's Cap",
      body="Agwu's Robe",
      hands="Jhakri Cuffs +2",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck={ name="Sorcerer's Stole +2", augments={'Path: A',}},
      waist="Hachirin-no-Obi",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Epaminondas's Ring",
      right_ring="Metamorph Ring +1",
      back=Taranus.MND_WSD
    }

    sets.me["Flash Nova"] = sets.me["Seraph Strike"]
    sets.me["Starburst"] = sets.me["Flash Nova"]
    
    sets.me["Myrkr"] = {
      ammo="Ghastly Tathlum +1",
      head="Kaykaus Mitra +1",
      neck="Voltsurge Torque",
      left_ear="Moonshade Earring",
      right_ear="Etiolation Earring",
      body="Amalric Doublet +1",
      hands="Regal Cuffs",
      left_ring="Mephitas's Ring",
      right_ring="Metamorph ring +1",
      back=Taranus.MND_FC_MEVA,
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
      neck="Rep. Plat. Medal",
      waist="Luminary Sash",
      left_ear="Regal Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back=Taranus.MND_WSD
    }

    sets.me["Realmrazer"] = set_combine(sets.me["Black Halo"], {
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ring="Rufescent Ring",
      right_ring={name="Chirich Ring +1",bag="wardrobe 4"},
    })

    sets.me['Vidohunir'] = {
      ammo="Ghastly Tathlum +1",
      head="Pixie hairpin +1",
      body="Agwu's Robe",
      hands="Jhakri Cuffs +2",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck="Sorcerer's Stole +2",
      waist="Orpheus's Sash",
      left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      right_ear="Malignance Earring",
      left_ring="Archon Ring",
      right_ring="Epaminondas's Ring",
      back=Taranus.INT_WSD    
    }

    ------------
    -- Buff Sets
    ------------
    -- Gear that needs to be worn to **actively** enhance a current player buff.
    sets.buff['Manafont']       = {}
    sets.buff['Elemental Seal'] = {}
    sets.buff['Mana Wall']      = {feet="Wicce Sabots +2"}
    sets.buff['Enmity Douse']   = {}
    sets.buff['Manawell']       = {}
    sets.buff['Cascade']        = {}
    sets.buff['Subtle Sorcery'] = {}

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
      back=Taranus.MND_FC_MEVA
    }

   sets.precast["Dispelga"] = set_combine(sets.precast.casting, {
     main="Daybreak",
     sub="Ammurapi Shield"
   })
   
   sets.precast["Impact"] = set_combine(sets.precast.casting, {
     main="Hvergelmir",
     sub="Khonsu",
     head=empty, 
     body="Crepuscular Cloak"
   })
    
   sets.precast["Stun"] = set_combine(sets.precast.casting, {
     main="Hvergelmir",
     sub="Khonsu",
   })

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

   sets.precast['Manafont']       = {body="Archmage's Coat +3"}
   sets.precast['Elemental Seal'] = {}
   sets.precast['Mana Wall']      = {feet="Wicce Sabots +2"}
   sets.precast['Enmity Douse']   = {}
   sets.precast['Manawell']       = {}
   sets.precast['Cascade']        = {}
   sets.precast['Subtle Sorcery'] = {}

    ----------
    -- Midcast
    ----------

    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi             = { waist="Hachirin-no-Obi"   }
    sets.midcast.Orpheus         = { waist="Orpheus's Sash"    }
    sets.midcast.MPReturn        = { body="Spaekona's Coat +3" }
    sets.midcast.JaSpellDuration = { legs="Wicce Chausses +2"  }

    -----------------------------------------------------------------------------------------------
    -- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
    -- Pixie in DarkHelix
    -- Belt that isn't Obi.
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    -----------------------------------------------------------------------------------------------

    sets.midcast.Helix = {
      main="Bunzi's Rod",
      sub="Culminus",
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Agwu's Robe",
      hands="Agwu's Gages",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck={ name="Sorcerer's Stole +2", augments={'Path: A',}},
      waist="Skrymir Cord +1",
      left_ear="Crematio Earring",
      right_ear="Malignance Earring",
      left_ring="Mallquis Ring",
      right_ring="Freke Ring",
      back=Taranus.ADOULIN     
    }
    
    sets.midcast.WindHelix = {
      main="Marin staff +1",
      sub="Enki Strap",
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Agwu's Robe",
      hands="Agwu's Gages",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck={ name="Sorcerer's Stole +2", augments={'Path: A',}},
      waist="Skrymir Cord +1",
      left_ear="Crematio Earring",
      right_ear="Malignance Earring",
      left_ring="Mallquis Ring",
      right_ring="Freke Ring",
      back=Taranus.ADOULIN
    }
    
    sets.midcast.LightHelix = {
      main="Daybreak",
      sub="Culminus",
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Agwu's Robe",
      hands="Agwu's Gages",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck={ name="Sorcerer's Stole +2", augments={'Path: A',}},
      waist="Skrymir Cord +1",
      left_ear="Crematio Earring",
      right_ear="Malignance Earring",
      left_ring="Mallquis Ring",
      right_ring="Freke Ring",
      back=Taranus.INT_MAB -- Damage > Duration
    }

    sets.midcast.DarkHelix = {
      main={ name="Bunzi's Rod", augments={'Path: A',}},
      sub="Ammurapi Shield",
      ammo="Ghastly Tathlum +1",
      head="Pixie hairpin +1",
      body="Agwu's Robe",
      hands="Agwu's Gages",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck={ name="Sorcerer's Stole +2", augments={'Path: A',}},
      waist="Skrymir Cord +1",
      left_ear="Crematio Earring",
      right_ear="Malignance Earring",
      left_ring="Archon ring",
      right_ring="Freke Ring",
      back=Taranus.ADOULIN 
    }

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
   sets.midcast.casting = {
     head={ name="Merlinic Hood", augments={'"Fast Cast"+7','"Mag.Atk.Bns."+14',}}, -- 15 fc, 6 haste
     neck="Voltsurge Torque",   -- 4
     ammo="Pemphredo tathlum",
     ear1="Etiolation earring", -- 1
     ear2="Malignance earring", -- 4
     body="Agwu's Robe",        -- 8
     hands="Agwu's Gages",      -- 6
     ring1="Defending ring",
     ring2="Kishar ring",       -- 4
     back=Taranus.MND_HASTE,
     waist="Witful belt",       -- 3 fc, 3 haste
     legs="Agwu's Slops",       -- 7
     feet={ name="Merlinic Crackows", augments={'Attack+22','"Fast Cast"+7',}}, -- 12 fc, 3 haste
   }
   
   sets.midcast.nuking.normal = {
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Agwu's Robe",
      hands="Agwu's Gages",
      legs="Agwu's Slops",
      feet="Agwu's Pigaches",
      neck="Sorcerer's Stole +2",
      waist="Sacro Cord",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Metamorph Ring +1",
      right_ring="Freke Ring",
      back=Taranus.INT_MAB
   }

   sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal, {
      waist="Acuity Belt +1",
   })
   
   -- used with toggle, default: F10
   -- Pieces to swap from free nuke to Magic Burst    
   sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
      ammo="Ghastly Tathlum +1",
      head="Ea Hat +1",
      neck="Sorcerer's Stole +2",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      body="Ea Houppe. +1",
      hands="Agwu's Gages",
      left_ring="Metamorph Ring +1",
      right_ring="Mujin Band",
      back=Taranus.INT_MAB,
      waist="Acuity Belt +1",
      legs="Ea Slops +1",
      feet="Agwu's Pigaches",
   })

   -- used with toggle, default: F10
   -- Pieces to swap from free nuke to Magic Burst
   sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {
     right_ring="Freke Ring",
   })
      
   sets.midcast.nuking.occult = set_combine(sets.midcast.nuking.normal, { 
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
      back=Taranus.INT_STP
   })

   sets.midcast.MB.occult = set_combine(sets.midcast.MB.normal, {
   })
   
    -- Enfeebling
   sets.midcast.IntEnfeebling = {
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
   
   sets.midcast["Stun"] = sets.midcast.IntEnfeebling

   sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.IntEnfeebling, {
      head="Wicce Petasos +2",
      legs="Archmage's tonban +3",
      feet="Archmage's sabots +3",
    })   
   
   sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebling, {
     main="Daybreak",
     sub="Ammurapi Shield"
   })
   
   sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebling, {
     head=empty,
     body="Crepuscular Cloak"
   })

   sets.midcast.Impact.occult = set_combine(sets.midcast.nuking.occult, sets.midcast.Impact)
   
   sets.midcast.MndEnfeebling = {
     ammo="Pemphredo tathlum",
     head=empty,
     body="Cohort Cloak +1",
     hands="Regal Cuffs",
     legs={ name="Chironic Hose", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Fast Cast"+5','MND+11','Mag. Acc.+13','"Mag.Atk.Bns."+6',}},
     feet="Wicce Sabots +2",
     neck={ name="Sorcerer's Stole +2", augments={'Path: A',}},
     waist="Luminary Sash",
     right_ear="Malignance Earring",
     left_ear="Regal Earring",
     left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
     right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
     back="Aurist's Cape +1"
   }

    sets.midcast.enhancing = set_combine(sets.midcast.casting, {
      body="Telchine Chas.",
      head="Telchine Cap",
      hands="Telchine Gloves",
      legs="Telchine Braconi",
      feet="Telchine Pigaches",
      neck={ name="Sorcerer's Stole +2", augments={'Path: A',}},
      waist="Embla Sash",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      right_ear="Mimir Earring",
      left_ear="Regal Earring",
      back=Taranus.INT_WSD
    })

    sets.midcast.storm = set_combine(sets.midcast.enhancing, {
    })

    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing, {
    })

    sets.midcast.refresh = set_combine(sets.midcast.enhancing, {
      head="Amalric Coif +1",
    })

    sets.midcast.aquaveil = set_combine(sets.midcast.refresh, {
      head="Amalric Coif +1",
      hands="Regal cuffs",
      waist="Emphatikos Rope",
    })

    sets.midcast.Drain = set_combine(sets.midcast.nuking.normal, {
      ammo="Pemphredo tathlum",
      head="Pixie hairpin +1",
      neck="Erra pendant",
      body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+11','"Drain" and "Aspir" potency +10','MND+6',}},
      waist="Fucho-no-Obi",
      legs="Agwu's Slops",
      left_ring="Archon ring",
      right_ring="Evanescence ring",
      back=Taranus.INT_MAB,
      feet="Agwu's Pigaches"
    })

    sets.midcast.Aspir = sets.midcast["Drain"]
    
    sets.midcast.Cursna = {
      head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
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
    })
    
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal, {
      waist="Hachirin-no-Obi",
    })

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
      back=Taranus.MND_FC_MEVA
    }

    sets.precast.Death = sets.midcast.Death
    sets.me.idle.death = sets.midcast.Death

    ------------
    -- Regen
    ------------
    sets.midcast.Regen = {}

    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
end
