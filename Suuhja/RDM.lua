
--[[
        Custom commands:

        Becasue /sch can be a thing... I've opted to keep this part 

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off for locking of weapons
        gs c toggle idlemode            Toggles between Refresh, DT and MDT idle mode.
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle mainweapon          cycles main weapons in the list you defined below
        gs c toggle subweapon           cycles main weapons in the list you defined below

        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking
        gs c nuke cycledown             Cycles element type for nuking in reverse order    
        gs c nuke enspellup             Cycles element type for enspell
        gs c nuke enspelldown           Cycles element type for enspell in reverse order 

        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm buff of saved element  if /sch
        gs c nuke enspell               Cast enspell of saved enspell element

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the Job section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file. Also on CTRL-END

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

include('organizer-lib') -- optional
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'mdt')
meleeModes = M('normal', 'acc', 'dt', 'mdt')
nukeModes = M('normal', 'acc')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list


mainWeapon = M('Crocea Mors', 'Daybreak', 'Naegling', 'Kaja Rod', 'Tauret', 'Wind Knife')
subWeapon = M('Ammurapi Shield', "Bunzi's Rod", 'Daybreak', 'Machaera +2', 'Malevolence', 'Sacro Bulwark', 'Firetongue')

------------------------------------------------------------------------------------------------------

----------------------------------------------------------
-- Auto CP Cape: Will put on CP cape automatically when
-- fighting Apex mobs and job is not mastered
----------------------------------------------------------
CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
----------------------------------------------------------

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
   windower.send_command('bind f7 gs c toggle meleemode')      -- F8 to change Melee Mode  
   windower.send_command('bind !f9 gs c toggle melee')         -- Alt-F9 Toggle Melee mode on / off, locking of weapons
   windower.send_command('bind !f7 gs c toggle mainweapon')    -- Alt-F8 Toggle Main Weapon
   windower.send_command('bind ^f7 gs c toggle subweapon')     -- CTRL-F8 Toggle sub Weapon.
   windower.send_command('bind !` input /ma Stun <t>')         -- Alt-` Quick Stun Shortcut.
   windower.send_command('bind home gs c nuke enspellup')      -- Home Cycle Enspell Up
   windower.send_command('bind PAGEUP gs c nuke enspelldown')  -- PgUP Cycle Enspell Down
   windower.send_command('bind ^f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.
   windower.send_command('bind !f10 gs c toggle nukemode')     -- Alt-F10 to change Nuking Mode
   windower.send_command('bind F10 gs c toggle matchsc')       -- CTRL-F10 to change Match SC Mode      	
   windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version       
   windower.send_command('bind ^end gs c hud keybinds')        -- CTRL-End to toggle Keybinds  
   
   windower.send_command('bind @a send zuuhja input /ma "Indi-Acumen" <me>')
   windower.send_command('bind @s sat youcommand Zuuhja Geo-Malaise')
   -- windower.send_command('bind @s sat youcommand Zuuhja Silence')
   windower.send_command('bind @d send zuuhja input /ma "Cure" Dotnet')
   windower.send_command('bind @z send zuuhja input /ja "Full Circle" <me>')
   windower.send_command('bind @x send zuuhja input /ja "Radial Arcana" <me>')
    
   windower.send_command('bind @b sat youcommand Muuhja "Magic Finale"')
   windower.send_command('bind @n sat youcommand Muuhja "Carnage Elegy"')
   windower.send_command('bind @m sat youcommand Muuhja "Pining Nocturne"')
   windower.send_command('bind @o sat youcommand Muuhja "Horde Lullaby"')
   windower.send_command('bind @p sat youcommand Zuuhja "Sleepga"')
    
   -- windower.send_command('bind @b send muuhja input /ma "Siren" <me>')
   -- windower.send_command('bind @n sat youcommand Muuhja "Hysteric Assault"')
   -- windower.send_command('bind @m sat youcommand Muuhja "Bitter Elegy"')
   -- windower.send_command('bind @o sat youcommand Muuhja Assault')
   -- windower.send_command('bind @p send muuhja input /pet "Release" <me>')
   -- windower.send_command('bind @= send muuhja input /ja "Apogee" <me>')

--[[
    This gets passed in when the Keybinds is turned on.
    IF YOU CHANGED ANY OF THE KEYBINDS ABOVE, edit the ones below so it can be reflected in the hud using the "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_melee'] = '(F7)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mainweapon'] = '(ALT-F7)'
keybinds_on['key_bind_subweapon'] = '(CTRL-F7)'
keybinds_on['key_bind_element_cycle'] = '(INS + DEL)'
keybinds_on['key_bind_enspell_cycle'] = '(HOME + PgUP)'
keybinds_on['key_bind_lock_weapon'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')
    send_command('unbind f9')
    send_command('unbind !f9')
    send_command('unbind f8')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind !f10')
    send_command('unbind `f10')
    send_command('unbind !end')  
    send_command('unbind ^end')
    
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

include('RDM_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,7) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty

    -- Fill this with your own JSE. 
    -- Atrophy
    AF.Head  = "Atro.Chapeau +1"
    AF.Body  = "Atrophy Tabard +3"
    AF.Hands = "Atrophy Gloves +3"
    AF.Legs  = "Atrophy Tights +3"
    AF.Feet  = "Atrophy Boots +1"

    -- Vitiation
    RELIC.Head  = "Viti. Chapeau +3"
    RELIC.Body  = "Viti. Tabard +3"
    RELIC.Hands = "Viti. Gloves +3"
    RELIC.Legs  = "Viti. Tights +3"
    RELIC.Feet  = "Vitiation Boots +3"

    -- Lethargy
    EMPY.Head  = "Leth. Chappel +1"
    EMPY.Body  = "Lethargy Sayon +1"
    EMPY.Hands = "Leth. Gantherots +1"
    EMPY.Legs  = "Leth. Fuseau +1"
    EMPY.Feet  = "Leth. Houseaux +1"

    -- Capes:
    -- Sucellos's And such, add your own.
    RDMCape = {}
    RDMCape.TP        = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    RDMCape.MND_WSD   = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    RDMCape.Aeolian   = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    RDMCape.BlackHalo = { name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

    -- SETS
     
    sets.me = {}                 -- leave this empty
    sets.buff = {}               -- leave this empty
    sets.me.idle = {}            -- leave this empty
    sets.me.melee = {}           -- leave this empty
    sets.weapons = {}            -- leave this empty

    -- Optional 
    --include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    sets.me.idle.refresh = {
      ammo="Homiliary",
      head="Befouled Crown",
      body="Jhakri Robe +2",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Loricate Torque +1",
      waist="Carrier's Sash",
      left_ear="Etiolation Earring",
      right_ear="Odnowa Earring +1",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      back=RDMCape.MND_WSD
    }

    sets.me.idle.dt = set_combine(sets.me.idle.refresh, {
      ammo="Staunch Tathlum +1",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      waist="Carrier's Sash",
      left_ear="Etiolation Earring",
      right_ear="Odnowa Earring +1",
      left_ring="Ilabrat Ring",
      right_ring="Defending Ring",
      back=RDMCape.MND_WSD
    })
    
    sets.me.idle.mdt = set_combine(sets.me.idle.refresh, {
      ammo="Staunch Tathlum +1",
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Warder's Charm +1",
      waist="Carrier's Sash",
      left_ear="Etiolation Earring",
      right_ear="Odnowa Earring +1",
      left_ring="Stikini Ring +1",
      right_ring="Defending Ring",
      back=RDMCape.MND_WSD
    })
    
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 
    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
    -- Combat Related Sets
    ------------------------------------------------------------------------------------------------------
    -- Dual Wield sets
    ------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw = set_combine(sets.me.idle.refresh, {   
      ammo="Staunch Tathlum +1",
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Anu Torque",
      waist="Reiki Yotai",
      left_ear="Telos Earring",
      right_ear="Eabani Earring",
      left_ring="Ilabrat Ring",
      right_ring="Chirich Ring +1",
      back=RDMCape.TP
    })

    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw, {
    })

    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw, {
    })

    sets.me.melee.mdtdw = set_combine(sets.me.melee.normaldw, {
    })
    ------------------------------------------------------------------------------------------------------
    -- Single Wield sets. -- combines from DW sets
    -- So canjust put what will be changing when off hand is a shield
    ------------------------------------------------------------------------------------------------------   
    sets.me.melee.normalsw = set_combine(sets.me.melee.normaldw, {   
    })
    
    sets.me.melee.accsw = set_combine(sets.me.melee.accdw, {
    })

    sets.me.melee.dtsw = set_combine(sets.me.melee.dtdw, {
    })

    sets.me.melee.mdtsw = set_combine(sets.me.melee.mdtdw, {
    })

    ------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
    ------------------------------------------------------------------------------------------------------
    sets.me["Savage Blade"] = {
      ammo="Regal Gem",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Republican platinum medal",
      waist="Kentarch Belt +1",
      left_ear="Moonshade Earring",
      right_ear="Regal Earring",
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back=RDMCape.BlackHalo
    }
    
    sets.me["Black Halo"] = {
      ammo="Regal Gem",
      head="Nyame Helm",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Republican platinum medal",
      waist="Kentarch Belt +1",
      left_ear="Regal Earring",
      right_ear="Sherida Earring",
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back=RDMCape.BlackHalo
    }
    
    sets.me["Requiescat"] = {
    }
    
    sets.me["Chant du Cygne"] = {
      ammo="Yetshila +1",
      head="Blistering Sallet +1",
      neck="Fotia Gorget",
      left_ear="Sherida Earring",
      right_ear="Mache Earring +1",
      body="Ayanmo Corazza +2",
      hands="Bunzi's Gloves",
      left_ring="Begrudging Ring",
      right_ring="Ilabrat Ring",
      back=RDMCape.BlackHalo, -- Make cape
      waist="Fotia Belt",
      legs="Nyame Flanchard", -- "Zoar Subligar +1",
      feet="Thereoid Greaves",
    }
    
    sets.me["Evisceration"] = sets.me["Chant du Cygne"]

    sets.me["Sanguine Blade"] = {
      ammo="Pemphredo Tathlum",
      head="Pixie Hairpin +1",
      body="Amalric Doublet +1",
      hands="Jhakri Cuffs +2",
      legs="Amalric Slops +1",
      feet="Nyame Sollerets",
      neck="Sibyl Scarf",
      waist="Orpheus's Sash",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Archon Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back=RDMCape.MND_WSD
    }

    sets.me["Red Lotus Blade"] = {
      ammo="Pemphredo Tathlum",
      head="Nyame Helm",
      body="Amalric Doublet +1",
      hands="Jhakri Cuffs +2",
      legs="Amalric Slops +1",
      feet="Nyame Sollerets",
      neck="Sibyl Scarf",
      waist="Orpheus's Sash",
      left_ear="Moonshade Earring",
      right_ear="Malignance Earring",
      left_ring="Freke Ring",
      right_ring="Epaminondas's Ring",
      back=RDMCape.MND_WSD
    }

    sets.me["Burning Blade"] = sets.me["Red Lotus Blade"]
    sets.me["Shining Blade"] = sets.me["Red Lotus Blade"]

    sets.me["Seraph Blade"] = set_combine(sets.me["Red Lotus Blade"], {
      ammo="Regal Gem",
    })

    sets.me["Seraph Strike"] = sets.me["Seraph Blade"]
    
    sets.me["Aeolian Edge"] = {
      ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
      head="Nyame Helm",
      body="Amalric Doublet +1",
      hands="Jhakri Cuffs +2",
      legs="Amalric Slops +1",
      feet="Nyame Sollerets",
      neck="Sibyl Scarf",
      waist="Orpheus's Sash",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Freke Ring",
      right_ring="Epaminondas's Ring",
      back=RDMCape.Aeolian
    }

    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 

    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
    sets.midcast.nuking = {}		-- leave this empty
    sets.midcast.MB	= {}		-- leave this empty   
    sets.midcast.enhancing = {} 	-- leave this empty   
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast RDM need 50 pre JP 42 at master
    sets.precast.casting = {
      head={ name="Merlinic Hood", augments={'"Fast Cast"+7','"Mag.Atk.Bns."+14',}},
      body="Viti. Tabard +3",
      hands={ name="Chironic Gloves", augments={'"Fast Cast"+7','MND+9','Mag. Acc.+4','"Mag.Atk.Bns."+13',}},
      legs="Aya. Cosciales +2",
      feet={ name="Merlinic Crackows", augments={'Attack+22','"Fast Cast"+7',}},
      neck="Voltsurge Torque",
      back="Fi Follet Cape +1",
      waist="Embla Sash",
      left_ear="Etiolation Earring",
      right_ear="Malignance Earring",
    }
    
    sets.precast["Dispelga"] = set_combine(sets.precast.casting, {
      main="Daybreak",
      sub="Ammurapi Shield"
    })

    sets.precast["Stun"] = set_combine(sets.precast.casting, {
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

    sets.precast.Impact = set_combine(sets.midcast.casting, {
      head=empty, 
      body="Crepuscular Cloak"
    })

    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Chainspell"] = {}

    ----------
    -- Midcast
    ----------

    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
      waist="Hachirin-no-Obi",
    }
    
    sets.midcast.Orpheus = {
      waist="Orpheus's Sash",
    }
    
    -----------------------------------------------------------------------------------------------
    -- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
    -- Pixie in DarkHelix
    -- Belt that isn't Obi.
    -----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.DarkHelix = {
      head = "Pixie Hairpin +1",
      left_ring = "Archon Ring",
      waist="Skrymir Cord +1",
    }
    
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
      waist="Skrymir Cord +1",
    }

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
    }

    sets.midcast.nuking.normal = {
      main="Bunzi's Rod",
      sub="Ammurapi Shield",
      ammo="Ghastly Tathlum +1",
      head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+10%','INT+5','Mag. Acc.+3','"Mag.Atk.Bns."+9',}},
      body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      neck="Dls. Torque +2",
      waist="Sacro Cord",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Freke Ring",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      back=RDMCape.Aeolian
    }

    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
      head="Ea Hat +1",
      body="Ea Houppe. +1",
      legs="Ea Slops +1",
      hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      right_ring="Mujin Band",
    })

    sets.midcast.nuking.acc = {
      waist="Acuity Belt +1",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      feet="Jhakri Pigaches +2",    
    }

    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {
      waist="Acuity Belt +1",
      right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},	
      feet="Jhakri Pigaches +2",
    })

    -- Enfeebling
    sets.midcast.Enfeebling = {} -- leave Empty
 
    --Type A-pure macc no potency mod
    sets.midcast.Enfeebling.macc = {
      main="Crocea Mors",          -- Murgleis
      sub="Ammurapi Shield",
      range="Ullr",
      ammo=none,
      head="Atrophy Chapeau +3",
      neck="Dls. Torque +2",
      left_ear="Snotra Earring",
      right_ear="Regal Earring",
      body="Atrophy Tabard +3",
      hands="Kaykaus Cuffs +1",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      back="Aurist's Cape +1",
      waist="Obstinate Sash", 
      legs={ name="Chironic Hose", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Fast Cast"+5','MND+11','Mag. Acc.+13','"Mag.Atk.Bns."+6',}},
      feet="Vitiation Boots +3",
    }

    -- Type B-potency from: Mnd & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.mndpot = set_combine(sets.midcast.Enfeebling.macc, {
      range=none,
      ammo="Regal Gem",
      head="Vitiation Chapeau +3",
      body="Lethargy Sayon +1",
      left_ring="Metamorph Ring +1",
      waist="Luminary Sash",
    })

    -- Type C-potency from: Int & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.intpot = set_combine(sets.midcast.Enfeebling.macc, {
      ammo="Regal Gem",
      body="Lethargy Sayon +1",
      left_ring="Metamorph Ring +1",
    })

    -- Type D-potency from: Enfeeb Skill & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.skillpot = sets.midcast.Enfeebling.macc
 
    -- Type E-potency from: Enfeeb skill, Mnd, & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.skillmndpot = {
      main={ name="Crocea Mors", augments={'Path: C',}},
      sub="Ammurapi Shield",
      range=none,
      ammo="Regal Gem",
      head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
      body="Atrophy Tabard +3",
      hands="Leth. Gantherots +1",
      legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
      feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
      neck={ name="Dls. Torque +2", augments={'Path: A',}},
      waist="Luminary Sash",
      left_ear="Snotra Earring",
      right_ear="Vor Earring",
      left_ring="Stikini Ring +1",
      right_ring="Stikini Ring +1",
      back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +7','Enha.mag. skill +7','Mag. Acc.+6','Enh. Mag. eff. dur. +19',}},
    }
    
    -- Type F-potency from "Enfeebling potency" gear only
    sets.midcast.Enfeebling.potency = set_combine(sets.midcast.Enfeebling.macc, {
      body="Lethargy Sayon +1",
      legs="Malignance Tights",
      left_ring="Kishar ring",
    })

    sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeebling.macc, {
      main="Daybreak",
      sub="Ammurapi Shield"
    })

    sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.macc, {
    })

    sets.midcast.Impact = set_combine(sets.midcast.Enfeebling.macc, {
      head=empty, 
      body="Crepuscular Cloak"
    })

    -- Enhancing yourself 
    sets.midcast.enhancing.duration = {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Staunch Tathlum +1",
      neck="Dls. Torque +2",
      body="Viti. Tabard +3",
      head="Telchine Cap",
      hands="Atrophy Gloves +3",
      legs="Telchine Braconi",
      feet="Lethargy Houseaux +1",
      back="Ghostfyre cape",
      waist="Embla Sash",
      left_ring={name="Stikini Ring +1",bag="wardrobe 2"},
      right_ring={name="Stikini Ring +1",bag="wardrobe 3"},
      right_ear="Mimir Earring",
    }
    
    -- For Potency spells like Temper and Enspells
    sets.midcast.enhancing.potency = set_combine(sets.midcast.enhancing.duration, {
      head="Befouled crown",
      hands="Viti. Gloves +3",
      legs="Atrophy Tights +3",
    }) 

    -- This is used when casting under Composure but enhancing someone else other than yourself. 
    sets.midcast.enhancing.composure = set_combine(sets.midcast.enhancing.duration, {
      head="Leth. Chappel +1",
      body="Lethargy Sayon +1",
      hands="Atrophy Gloves +3",
      legs="Leth. Fuseau +1",
      feet="Leth. Houseaux +1",
    })

    -- Phalanx
    sets.midcast.phalanx =  set_combine(sets.midcast.enhancing.duration, {
      head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
      body={ name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}},
      hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
      legs={ name="Taeon Tights", augments={'Phalanx +3',}},
      feet={ name="Taeon Boots", augments={'Phalanx +3',}},
    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.duration, {
    })

    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {
      head="Amalric Coif +1",
      body="Atrophy Tabard +3",
      waist="Gishdubar Sash",
    })

    sets.midcast.aquaveil = set_combine(sets.midcast.refresh, {
      ammo="Staunch Tathlum +1",
      head="Amalric Coif +1",
      body={ name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}},
      hands="Regal Cuffs",
      feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      waist="Emphatikos Rope",
      left_ear="Magnetic Earring",
      right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
      left_ring="Evanescence Ring",
      right_ring="Defending Ring",
      back={ name="Fi Follet Cape +1", augments={'Path: A',}},
    })

    sets.midcast["Drain"] = set_combine(sets.midcast.nuking.normal, {
      main="Bunzi's Rod",
      sub="Ammurapi shield",
      ammo="Pemphredo tathlum",
      head="Pixie hairpin +1",
      hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+11','"Drain" and "Aspir" potency +10','MND+6',}},
      feet={ name="Merlinic Crackows", augments={'"Drain" and "Aspir" potency +10',}},
      neck="Erra pendant",
      waist="Fucho-no-Obi",
      left_ring="Archon ring",
      right_ring="Evanescence ring",
    })

    sets.midcast["Cursna"] = {
      head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      body="Vitiation Tabard +3",
      hands="Malignance Gloves",
      legs="Atrophy Tights +3",
      feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
      neck="Debilis Medallion",
      waist="Bishop's Sash",
      left_ear="Beatific Earring",
      right_ear="Meili Earring",
      left_ring="Menelaus's Ring",
      right_ring="Haoma's Ring",
      back="Oretania's Cape +1",
    }

    sets.midcast["Aspir"] = sets.midcast["Drain"]

    sets.midcast.cure = {} -- Leave This Empty

    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting, {
      main="Daybreak",
      sub="Ammurapi shield",
      ammo="Leisure Musk +1",            --     4
      head="Kaykaus mitra +1",           -- 11     6
      neck="Debilis medallion",          --     3
      body="Malignance tabard",          --        4
      hands="Kaykaus Cuffs +1",          -- 11  6  3
      legs="Atrophy Tights +3",          -- 11     5
      feet="Kaykaus boots +1",           -- 17  6  3
      left_ear="Domesticator's earring", --     5
      right_ear="Mendi. Earring",        --  5
      left_ring="Lebeche ring",          --  3  5
      right_ring="Stikini ring +1",
      waist="Witful belt",               --        3
      --                                        5
      back=RDMCape.MND_WSD               --
    })

    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal, {
      main="Chatoyant staff",             -- 10
      sub="Enki strap",
      waist="Hachirin-no-Obi",
    })

    ------------
    -- Regen
    ------------
    sets.midcast.regen = set_combine(sets.midcast.enhancing.duration, {
      feet="Bunzi's Sabots",
    })

    ------------
    -- Aftercast
    ------------
    
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
end
