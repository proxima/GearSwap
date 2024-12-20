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
        gs c toggle zerodmg             Toggles whether Tier 1 spells are cast in SC_Open set
                
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
windower.send_command('bind ^h gs c toggle zerodmg')        -- Ctrl+H to toggle whether tier 1's are cast in SC_Open set

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
keybinds_on['key_bind_zerodmg'] = '(CTRL-H)'
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
    send_command('unbind ^h')
end

--------------------------------------------------------------------------------------------------------------
include('SCH_Lib.lua')          -- leave this as is    
refreshType = idleModes[1]      -- leave this as is     
--------------------------------------------------------------------------------------------------------------

-- Optional. Swap to your sch macro sheet / book
set_macros(1,18) -- Sheet, Book


-------------------------------------------------------------                                        
--      ,---.                         |         
--      |  _.,---.,---.,---.,---.,---.|--- ,---.
--      |   ||---',---||    `---.|---'|    `---.
--      `---'`---'`---^`    `---'`---'`---'`---'
-------------------------------------------------------------                                              

-- Setup your Gear Sets below:
function get_sets()

    -- Capes I don't have but want: 
    -- DEX_DW  - DW melee

    Lugh = {}
    Lugh.DT          = { name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Phys. dmg. taken-10%',}}
    Lugh.STR_WSD     = { name="Lugh's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    Lugh.INT_MAB     = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
    Lugh.INT_STP     = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    Lugh.INT_WSD     = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    Lugh.DEX_DA      = { name="Lugh's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    Lugh.MND_WSD     = { name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    Lugh.MP_FC       = { name="Lugh's Cape", augments={'MP+60','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
    Lugh.ADOULIN     = { name="Bookworm's Cape", augments={'INT+5','MND+3','Helix eff. dur. +20',}}

    sets.me = {}       -- leave this empty
    sets.buff = {}     -- leave this empty
    sets.me.idle = {}  -- leave this empty

    -- Your idle set
    sets.me.idle.refresh = {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Homiliary",
      head="Nyame Helm",
      ear1="Etiolation earring",
      ear2="Odnowa earring +1",
      neck="Loricate torque +1",
      body="Arbatel Gown +3",
      hands="Nyame Gauntlets",
      legs="Agwu's slops",
      left_ring={name="Stikini Ring +1",bag="wardrobe"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 5"},
      feet="Nyame Sollerets",
      waist="Carrier's Sash",
      back=Lugh.DT
    }

    -- Your idle Sublimation set combine from refresh or DT depening on mode.
    sets.me.idle.sublimation = set_combine(sets.me.idle.refresh, {
      head="Acad. Mortar. +3",
      body="Arbatel Gown +3",
      waist="Embla Sash",
    })

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle[refreshType], {
      ammo="Staunch Tathlum +1",
      head="Nyame Helm",
      body="Arbatel Gown +3",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Loricate Torque +1",
      waist="Carrier's Sash",
      left_ear="Eabani Earring",
      right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
      left_ring={name="Stikini Ring +1",bag="wardrobe"},
      right_ring="Gelatinous Ring +1",
      back=Lugh.DT
    })

    sets.me.idle.mdt = set_combine(sets.me.idle.dt, {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Staunch tathlum +1",  --  3 DT
      head="Pinga crown +1",
      ear1="Lugalbanda earring",
      ear2="Odnowa earring +1",   --  3 DT, 2 MDT
      neck="Warder's charm +1",
      body="Arbatel Gown +3",     -- 1? DT  
      hands="Pinga mittens +1",
      legs="Agwu's slops",        --  9 DT
      ring1="Defending ring",     -- 10 DT
      ring2="Gelatinous ring +1", --  7 PDT, -1MDT
      feet="Pinga pumps +1",
      waist="Carrier's Sash",
      back=Lugh.DT                -- 10 PDT
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
      head="Nyame Helm",
      body="Nyame Mail",
      hands={ name="Gazu Bracelets +1", augments={'Path: A',}},
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Lissome Necklace",
      waist="Grunfeld Rope",
      left_ear="Crepuscular Earring",
      right_ear="Telos Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 3"},
      back=Lugh.DEX_DA
    }

    sets.me.melee_dw = set_combine(sets.me.melee, {
      left_ear="Eabani Earring",
      right_ear="Suppanomimi",
      back=Lugh.DEX_DA -- Make dw + dex version
    })
      
    -- Weapon Skills sets just add them by name.
    sets.me["Heavy Swing"] = {
      ammo="Crepuscular Pebble",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Rep. Plat. Medal",
      waist="Grunfeld Rope",
      left_ear="Regal Earring",
      right_ear="Moonshade Earring",
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back=Lugh.STR_WSD  
    }
    
    sets.me["Retribution"] = sets.me["Heavy Swing"]

    sets.me["Shattersoul"] = {
      ammo="Ghastly Tathlum +1",
      head="Nyame Helm",
      neck="Argute stole +2",
      right_ear="Malignance earring",
      left_ear="Regal earring",
      body="Nyame Mail",
      hands={ name="Gazu Bracelets +1", augments={'Path: A',}},
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Freke Ring",
      back=Lugh.STR_WSD,
      waist="Fotia Belt",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets"
    }
    
    sets.me["Shell Crusher"] = {
      ammo="Pemphredo Tathlum",
      head="Arbatel Bonnet +3",
      body="Arbatel Gown +3",
      hands="Arbatel Bracers +3",
      legs="Arbatel Pants +3",
      feet="Arbatel Loafers +3",
      neck="Lissome Necklace",
      waist="Grunfeld Rope",
      left_ear="Mache Earring +1",
      right_ear="Telos Earring",
      left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
      right_ring={name="Chirich Ring +1",bag="wardrobe 3"},
      back=Lugh.INT_WSD
    }
    
    sets.me["Full Swing"] = sets.me["Heavy Swing"]
    sets.me["Spirit Taker"] = sets.me["Heavy Swing"]

    sets.me["Earth Crusher"] = {
      ammo="Sroda Tathlum",
      head="Agwu's Cap",
      body="Nyame Mail",
      hands="Agwu's Gages",
      legs="Nyame Flanchard",
      feet="Arbatel Loafers +3",
      neck="Quanpur Necklace",
      waist="Orpheus's Sash",
      left_ear="Moonshade Earring",
      right_ear="Malignance Earring",
      left_ring="Freke Ring",
      right_ring="Metamorph Ring +1",
      back=Lugh.INT_WSD
    }

    sets.me["Rock Crusher"] = sets.me["Earth Crusher"]

    sets.me["Aeolian Edge"] = set_combine(sets.me["Earth Crusher"], {
      neck="Fotia Gorget",
      body="Arbatel Gown +3",
      hands="Jhakri Cuffs +2",  
    })
    
    sets.me["Cataclysm"] = set_combine(sets.me["Earth Crusher"], {
      head="Pixie hairpin +1",
      body="Arbatel Gown +3",
      neck="Sibyl Scarf",
      left_ring="Archon Ring",
    })

    sets.me["Omniscience"] = {
      ammo="Sroda Tathlum",
      head="Arbatel Bonnet +3",
      body="Arbatel Gown +3",
      hands="Arbatel Bracers +3",
      legs="Nyame Flanchard",
      feet="Arbatel Loafers +3",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Orpheus's Sash",
      left_ear="Regal Earring",
      right_ear="Malignance Earring", -- JSE +2 Earring
      left_ring="Archon Ring",
      right_ring="Metamorph Ring +1",
      back=Lugh.MND_WSD
    }

    sets.me["Seraph Strike"] = {
      ammo="Sroda Tathlum",
      head="Agwu's Cap",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Arbatel Loafers +3",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Hachirin-no-Obi",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Epaminondas's Ring",
      right_ring="Freke Ring",
      back=Lugh.MND_WSD
    }

    sets.me["Shining Strike"] = sets.me["Seraph Strike"]
    sets.me["Flash Nova"] = sets.me["Seraph Strike"]
    sets.me["Starburst"] = sets.me["Flash Nova"]
    
    sets.me["Myrkr"] = {
      ammo="Ghastly Tathlum +1",
      head="Pixie hairpin +1",
      neck="Voltsurge Torque",
      left_ear="Moonshade Earring",
      right_ear="Etiolation Earring",
      body="Acad. Gown +3",
      hands="Pinga mittens +1",
      left_ring="Mephitas's Ring",
      right_ring="Metamorph ring +1",
      back=Lugh.MP_FC,
      waist="Luminary sash",
      legs="Arbatel pants +3",
      feet="Arbatel loafers +3",
    }

    sets.me["Black Halo"] = {
      ammo="Crepuscular Pebble",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Rep. Plat. Medal",
      waist="Luminary Sash",
      left_ear="Regal Earring",
      right_ear="Moonshade Earring",
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back=Lugh.STR_WSD
    }

    sets.me["Realmrazer"] = set_combine(sets.me["Black Halo"], {
      neck="Fotia Gorget",
      waist="Fotia Belt",
      right_ear="Malignance Earring",  
      left_ring="Rufescent Ring",
      right_ring="Metamorph ring +1",
      back=Lugh.MND_WSD
    })

    ------------
    -- Buff Sets
    ------------
    -- Gear that needs to be worn to **actively** enhance a current player buff.
    sets.buff['Rapture'] = {head="Arbatel bonnet +3"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +3"}
    sets.buff['Immanence'] = {}
    sets.buff['Penury'] = {}
    sets.buff['Parsimony'] = {}
    sets.buff['Celerity'] = {feet="Pedagogy loafers +1"}
    sets.buff['Alacrity'] = {feet="Pedagogy loafers +1"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +3"}
    sets.buff['Ebullience'] = {head="Arbatel bonnet +3"}

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
      ammo="Sapience orb",       -- 2 fc
      head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+10','"Fast Cast"+7','INT+8','Mag. Acc.+13',}}, -- 15
      neck="Voltsurge Torque",   -- 4 fc
      ear1="Etiolation earring", -- 1 fc
      ear2="Malignance earring", -- 4 fc
      body="Pinga Tunic +1",     -- 15 fc
      hands="Acad. Bracers +3",  -- 9 fc
      ring1="Lebeche ring",      -- 
      ring2="Kishar ring",       -- 4 fc
      back=Lugh.MP_FC,           -- 10 fc
      waist="Embla sash",        -- 5 fc
      legs="Pinga Pants +1",     -- 13 fc
      feet={ name="Merlinic Crackows", augments={'"Fast Cast"+7','MND+10','"Mag.Atk.Bns."+4',}}, -- 12 fc, 3 haste
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

   -- When spell school is aligned with grimoire, swap relevent pieces
   -- Can also use Arbatel +2 set here if you value 1% quickcast procs per piece. (2+ pieces)  
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

    sets.precast["Tabula Rasa"] = {legs="Pedagogy Pants +1"}
    sets.precast["Enlightenment"] = {body="Pedagogy Gown +1"} 
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
    -- Belt that isn't Obi.
    -----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.

    sets.midcast.Kaustra = {
      main={ name="Bunzi's Rod", augments={'Path: A',}}, 
      sub="Ammurapi Shield",
      ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
      head="Arbatel bonnet +3",               -- assume ebullience
      body="Agwu's Robe",
      hands="Agwu's Gages",
      legs="Agwu's Slops",
      feet="Arbatel Loafers +3",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Hachirin-no-Obi",                -- assume weather
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Freke Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back=Lugh.INT_MAB
    }
    
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.
    sets.midcast.Helix = {
      main="Bunzi's Rod",
      sub="Ammurapi Shield",
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Arbatel Gown +3",
      hands="Arbatel Bracers +3",
      legs="Agwu's Slops",    
      feet="Arbatel Loafers +3",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Skrymir Cord +1",
      left_ear="Regal Earring",
      right_ear="Arbatel earring +1",
      left_ring="Freke Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back=Lugh.ADOULIN     
    }
    
    sets.midcast.WindHelix = {
      main="Marin staff +1",
      sub="Enki Strap",
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Agwu's Robe",
      hands="Arbatel Bracers +3",
      legs="Agwu's Slops",    
      feet="Arbatel Loafers +3",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Skrymir Cord +1",
      left_ear="Malignance Earring",
      right_ear="Arbatel earring +1",
      left_ring="Freke Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back=Lugh.ADOULIN
    }
    
    sets.midcast.LightHelix = {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Arbatel Gown +3",
      hands="Arbatel Bracers +3",
      legs="Agwu's Slops",    
      feet="Arbatel Loafers +3",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Skrymir Cord +1",
      left_ear="Malignance Earring",
      right_ear="Arbatel earring +1",
      left_ring="Freke Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back=Lugh.INT_MAB -- Damage > Duration
    }

    sets.midcast.DarkHelix = {
      main="Bunzi's Rod",
      sub="Ammurapi Shield",
      ammo="Ghastly Tathlum +1",
      head="Agwu's Cap",
      body="Arbatel Gown +3",
      hands="Arbatel Bracers +3",
      legs="Arbatel Pants +3",
      feet="Arbatel Loafers +3",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      waist="Skrymir Cord +1",
      left_ear="Malignance Earring",
      right_ear="Arbatel earring +1",
      left_ring="Archon Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back=Lugh.ADOULIN 
    }

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
   sets.midcast.casting = {
     ammo="Sapience orb",       -- 2 fc
     head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+10','"Fast Cast"+7','INT+8','Mag. Acc.+13',}}, -- 15
     neck="Voltsurge Torque",   -- 4 fc
     ear1="Etiolation earring", -- 1 fc
     ear2="Malignance earring", -- 4 fc
     body="Agwu's Robe",        -- 8 fc -- Pinga Tunic +1
     hands="Acad. Bracers +3",  -- 9 fc
     ring1="Defending ring", 
     ring2="Kishar ring",       -- 4 fc
     back=Lugh.DT,
     waist="Witful Belt",
     legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+15','"Fast Cast"+7','CHR+8','"Mag.Atk.Bns."+4',}}, -- 7 fc (Pinga pants +1)
     feet={ name="Merlinic Crackows", augments={'"Fast Cast"+7','MND+10','"Mag.Atk.Bns."+4',}}, -- 12 fc, 3 haste
   }

   sets.midcast["Sublimation"] = {}
   sets.midcast["Tabula Rasa"] = { legs="Pedagogy Pants +1" }
   
   sets.midcast.nuking.normal = {
     main="Bunzi's rod",
     sub="Ammurapi shield",
     ammo="Ghastly Tathlum +1",
     head="Agwu's Cap",
     body="Agwu's Robe",
     hands="Agwu's Gages",
     legs="Agwu's Slops",
     feet="Arbatel Loafers +3",
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Acuity Belt +1",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Metamorph ring +1",
     right_ring="Freke Ring",
     back=Lugh.INT_MAB,
   }

   sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal, {
   })

   sets.midcast.nuking.DivineMagic = {
     main="Daybreak",
     sub="Ammurapi Shield",
     ammo="Pemphredo Tathlum",
     head="Arbatel Bonnet +3",
     body="Agwu's Robe",
     hands="Agwu's Gages",
     legs="Agwu's Slops",
     feet="Arbatel Loafers +3",
     waist="Hachirin-no-Obi",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Metamorph ring +1",
     right_ring="Freke Ring",
     back=Lugh.MND_WSD
   }
   
   -- used with toggle, default: F10
   -- Pieces to swap from free nuke to Magic Burst    
   sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
   })

   -- used with toggle, default: F10
   -- Pieces to swap from free nuke to Magic Burst
   sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {   
   })
 
   sets.midcast.nuking.occult = set_combine(sets.midcast.nuking.normal, { 
     ammo="Seraphic Ampulla",
     head="Mall. Chapeau +2",
     body={ name="Merlinic Jubbah", augments={'"Occult Acumen"+11','INT+6','"Mag.Atk.Bns."+4',}},
     hands={ name="Merlinic Dastanas", augments={'"Occult Acumen"+11','INT+4','Mag. Acc.+5','"Mag.Atk.Bns."+9',}},
     feet={ name="Merlinic Crackows", augments={'"Occult Acumen"+11','CHR+4','Mag. Acc.+7','"Mag.Atk.Bns."+2',}},
     legs="Perdition Slops",
     neck="Lissome Necklace",
     waist="Oneiros Rope",
     left_ear="Dedition Earring",
     right_ear="Telos Earring",
     left_ring={name="Chirich Ring +1",bag="wardrobe 2"},
     right_ring={name="Chirich Ring +1",bag="wardrobe 3"},
     back=Lugh.INT_STP
   })

   sets.midcast.MB.occult = set_combine(sets.midcast.MB.normal, {
   })

    -- Enfeebling
   sets.midcast["Stun"] = {
     main="Bunzi's rod",
     sub="Ammurapi shield",
     ammo="Pemphredo tathlum",
     head="Acad. Mortar. +3",  --  6  8
     body="Acad. Gown +3",     --  3
     hands="Acad. Bracers +3", --  3  9
     legs="Arbatel Pants +3",  --  5
     feet="Acad. Loafers +3",  --  3
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Acuity Belt +1",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring={name="Stikini Ring +1",bag="wardrobe"},
     right_ring={name="Stikini Ring +1",bag="wardrobe 5"},
     back=Lugh.INT_MAB
   }
   
   sets.midcast.Absorb = set_combine(sets.midcast.Stun, {})

   sets.midcast.IntEnfeebling = {
     main="Bunzi's rod",
     sub="Ammurapi shield",
     ammo="Pemphredo tathlum",
     head="Acad. Mortar. +3",
     body="Acad. Gown +3",
     hands="Acad. Bracers +3",
     legs="Arbatel Pants +3",
     feet="Acad. Loafers +3",
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Obstinate Sash",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring={name="Stikini Ring +1",bag="wardrobe"},
     right_ring={name="Stikini Ring +1",bag="wardrobe 5"},
     back=Lugh.INT_MAB
   }
   
   sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebling, {
     main="Daybreak",
     sub="Ammurapi Shield"
   })
   
   sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebling, {
     main="Marin staff +1", -- main="Hvergelmir",
     sub="Khonsu",
     head=empty, 
     body="Crepuscular Cloak"
   })
   
   sets.midcast.SC_Open = {
     main="Malignance Pole", 
     sub="Khonsu",                                                                                       --         4 haste
     ammo="Staunch Tathlum +1",
     head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},                         -- 10 fc,  8 haste
     neck="Bathy choker +1",                                                                             --                  11 sb
     left_ear="Etiolation Earring",                                                                      --  1 fc
     right_ear="Dignitary's Earring",                                                                    --                   5 sb
     body="Pinga Tunic +1",                                                                              -- 15 fc
     hands="Acad. Bracers +3",                                                                           --  9 fc,  3 haste
     left_ring={name="Chirich Ring +1",bag="wardrobe 2"},                                                --                  10 sb
     right_ring={name="Chirich Ring +1",bag="wardrobe 3"},                                               --                  10 sb
     back=Lugh.MP_FC,                                                                                    -- 10 fc
     waist="Witful Belt",                                                                                --  3 fc,  3 haste
     legs="Psycloth Lappas",                                                                             --  7 fc,  5 haste
     feet="Acad. Loafers +3",                                                                            --         3 haste
   }                                                                                                     -- 55 fc, 26 haste, 36 sb
      
   sets.midcast.MndEnfeebling = {
     main="Mpaca's staff", -- Tupsi
     sub="Khonsu",
     ammo="Pemphredo tathlum",
     head=empty,
     body="Cohort Cloak +1",
     hands="Acad. Bracers +3",
     legs={ name="Chironic Hose", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Fast Cast"+4','INT+9','Mag. Acc.+10',}},
     feet="Acad. Loafers +3",
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Obstinate Sash",
     right_ear="Malignance Earring",
     left_ear="Regal Earring",
     left_ring={name="Stikini Ring +1",bag="wardrobe"},
     right_ring={name="Stikini Ring +1",bag="wardrobe 5"},
     back=Lugh.MND_WSD
   }

   -- Enhancing, 501 skill atm w/ light arts, caps barspells
    sets.midcast.enhancing = set_combine(sets.midcast.casting, {
      main={ name="Musa", augments={'Path: C',}},
      sub="Khonsu",
      body="Pedagogy gown +1",
      head="Telchine Cap",
      hands="Telchine Gloves",
      legs="Telchine Braconi",
      feet="Telchine Pigaches",
      neck="Melic torque",
      waist="Embla Sash",
      left_ring={name="Stikini Ring +1",bag="wardrobe"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 5"},
      right_ear="Mimir Earring",
      left_ear="Regal Earring",
      back=Lugh.ADOULIN
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

    sets.midcast["Drain"] = set_combine(sets.midcast.nuking.normal, {
      main="Rubicundity",
      sub="Ammurapi shield",
      ammo="Pemphredo tathlum",
      head="Pixie hairpin +1",
      neck="Erra pendant",
      body="Acad. Gown +3",
      hands="Academic's bracers +3",
      waist="Fucho-no-Obi",
      legs="Pedagogy pants +1",
      left_ring="Archon ring",
      right_ring="Evanescence ring",
      back=Lugh.INT_MAB,
      feet="Agwu's Pigaches"
    })

    sets.midcast["Aspir"] = sets.midcast["Drain"]
    
    sets.midcast["Cursna"] = {
      head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      body="Pedagogy Gown +1",
      hands="Pedagogy bracers +1",
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

    -- Cure Potency                      -- CP EM  HS DT FC
    sets.midcast.cure.normal = set_combine(sets.midcast.casting, {
      main="Chatoyant Staff",            -- 10
      sub="Khonsu",                      --     5   4  6
      ammo="Leisure Musk +1",            --     4 
      head="Pinga Crown +1",             -- 10  7        10
      neck="Loricate torque +1",         --            6
      left_ear="Domesticator's earring", --     5
      right_ear="Mendi. Earring",        --  5
      body="Arbatel Gown +3",            --    28*  3 13
      hands="Pinga Mittens +1",          --  7  6         7
      left_ring="Gelatinous Ring +1",    --            7
      right_ring="Defending Ring",       --           10
      waist="Witful belt",               --         3
      back=Lugh.DT,                      --        10 10
      legs="Pinga Pants +1",             -- 13  8        13
      feet="Pinga Pumps +1",             --  5  5         5
      -- totals:                            50 45* 20 52 35
      -- merits                                 5
    })                                   --    *Much more w/ grimoire
    
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal, {
      waist="Hachirin-no-Obi",
    })

    ------------
    -- Regen
    ------------
    sets.midcast.regen = {}    -- leave this empty
    
    sets.midcast.regen.hybrid = {
      main="Musa",
      sub="Khonsu",
      head="Arbatel Bonnet +3",
      neck="Melic torque",
      right_ear="Mimir Earring",
      left_ear="Regal Earring",
      body="Telchine chas.",
      hands="Arbatel Bracers +3", -- Tired of this not swapping properly | hands="Telchine Gloves",
      left_ring={name="Stikini Ring +1",bag="wardrobe"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 5"},
      waist="Embla Sash",
      back=Lugh.DT,
      legs="Telchine Braconi",
      feet="Telchine Pigaches",
    }
    
    sets.midcast.regen.duration = set_combine(sets.midcast.regen.hybrid, {
      head="Telchine Cap",
      back=Lugh.DT
    })
    
    sets.midcast.regen.potency = set_combine(sets.midcast.regen.hybrid, {
      -- back=Lugh.ADOULIN
    })
end
