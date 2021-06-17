
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
    windower.send_command('bind @a sat youcommand Muuhja "Wind Threnody II"')
    windower.send_command('bind @s sat youcommand Zuuhja Silence')
    windower.send_command('bind @d send zuuhja /ma "Cure" Aller')
    windower.send_command('bind @z send zuuhja input /ja "Full Circle" <me>')
    windower.send_command('bind @x send zuuhja input /ja "Radial Arcana" <me>')

    windower.send_command('bind @b sat youcommand Muuhja "Magic Finale"')
    -- windower.send_command('bind @n sat youcommand Muuhja "Carnage Elegy"')
    windower.send_command('bind @m sat youcommand Muuhja "Pining Nocturne"')
	-- windower.send_command('bind @o sat youcommand Muuhja "Horde Lullaby"')
    windower.send_command('bind @p send muuhja input /pet "Release" <me>')
    windower.send_command('bind @= send muuhja input /ja "Apogee" <me>')
	windower.send_command('bind @n sat youcommand Muuhja "Level ? Holy"')

    -- windower.send_command('bind @b send muuhja input /ma "Ramuh" <me>')
    -- windower.send_command('bind @n send Muuhja /input /ja "Mana Cede" <me>')
    -- windower.send_command('bind @v sat youcommand Muuhja "Volt Strike"')
    -- windower.send_command('bind @m sat youcommand Muuhja "Shock Squall"')
    windower.send_command('bind @o sat youcommand Muuhja Assault')
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
      
    sets.me = {}        		-- leave this empty
    sets.buff = {} 				-- leave this empty
    sets.me.idle = {}			-- leave this empty

    -- Your idle set
    sets.me.idle.refresh = {
      -- main="Tupsimati",
      -- sub="Khonsu",
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
      ring1="Stikini ring +1",   -- 1
      ring2="Stikini ring +1",   -- 1
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
      main="Daybreak",
	  sub="Ammurapi Shield",
      -- main="Tupsimati",
      -- sub="Khonsu",               -- 6 DT
      ammo="Staunch tathlum +1",  -- 3 DT
      head="Pinga crown +1",
      ear2="Lugalbanda earring",
      ear2="Odnowa earring +1",   -- 3 DT, 2 MDT
      neck="Warder's charm +1",
      body="Mallquis Saio +2",    -- 8 DT
      hands="Pinga mittens +1",
      legs="Pinga pants +1",
      ring1="Defending ring",     -- 10 DT
      ring2="Gelatinous ring +1", --  7 PDT, -1MDT
      feet="Pinga pumps +1",
      waist="Carrier's Sash",
      back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},
    })

    sets.me.idle.mdt = set_combine(sets.me.idle.dt, {
      body="Pinga tunic +1",
    })

    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 
    }
    
    sets.me.latent_refresh = { 
      waist="Fucho-no-Obi",
    }
    
    -- Combat Related Sets
    sets.me.melee = set_combine(sets.me.idle[idleModes.current], {
    })
      
    -- Weapon Skills sets just add them by name.
    sets.me["Heavy Swing"] = {
      ammo="Floestone",
      head="Jhakri Coronal +2",
      body="Jhakri Robe +2",
      hands="Jhakri Cuffs +2",
      legs="Jhakri Slops +2",
      feet="Jhakri Pigaches +2",
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
      neck="Fotia Gorget",
      waist="Fotia Belt",
      right_ear="Brutal earring",
      left_ear="Regal earring"
    })
    sets.me["Shell Crusher"] = sets.me["Heavy Swing"]
    sets.me["Full Swing"] = sets.me["Heavy Swing"]
    sets.me["Spirit Taker"] = sets.me["Heavy Swing"]

    sets.me["Earth Crusher"] = {
      ammo="Pemphredo Tathlum",
      head="Pedagogy mortarboard +3",
      body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      hands="Jhakri Cuffs +2",
      legs={ name="Peda. Pants +3", augments={'Enhances "Tabula Rasa" effect',}},
      feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
      neck="Saevus Pendant +1",
      waist="Hachirin-no-Obi",
      left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      right_ear="Malignance Earring",
      right_ring="Metamorph Ring +1",
      right_ring="Freke Ring",
      back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
    }
    
    sets.me["Rock Crusher"] = sets.me["Earth Crusher"]
    
    sets.me["Starburst"] = {
    }
    
    sets.me["Cataclysm"] = {
      ammo="Pemphredo Tathlum",
      head="Pixie hairpin +1",
      body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      hands="Jhakri Cuffs +2",
      legs={ name="Peda. Pants +3", augments={'Enhances "Tabula Rasa" effect',}},
      feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
      neck="Saevus Pendant +1",
      waist="Hachirin-no-Obi",
      left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      right_ear="Malignance Earring",
      left_ring="Archon Ring",
      right_ring="Epaminondas's Ring",
      back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
    }

    sets.me["Omniscience"] = {
      ammo="Pemphredo Tathlum",
      head="Pixie hairpin +1",
      body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      hands="Jhakri Cuffs +2",
      legs={ name="Peda. Pants +3", augments={'Enhances "Tabula Rasa" effect',}},
      feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
      neck="Saevus Pendant +1",
      waist="Hachirin-no-Obi",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Archon Ring",
      right_ring="Freke Ring",
      back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},
    }
    
    sets.me["Myrkr"] = {
      ear1="Moonshade earring",
    }
        
    ------------
    -- Buff Sets
    ------------	
    -- Gear that needs to be worn to **actively** enhance a current player buff.
    -- Fill up following with your avaible pieces.
    sets.buff['Rapture'] = {head="Arbatel bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    sets.buff['Penury'] = {}
    sets.buff['Parsimony'] = {}
    sets.buff['Celerity'] = {feet="Pedagogy loafers +3"}
    sets.buff['Alacrity'] = {feet="Pedagogy loafers +3"}
    -- sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}	
    sets.buff['Ebullience'] = {head="Arbatel bonnet +1"}
   	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
	 sets.midcast.nuking = {}	-- leave this empty
	 sets.midcast.MB	= {}		-- leave this empty      
    ----------
    -- Precast
    ----------
      
    sets.precast.casting = {
      ammo="Impatiens",
      head={ name="Merlinic Hood", augments={'"Fast Cast"+7','"Mag.Atk.Bns."+14',}}, -- 15 fc, 6 haste
      neck="Voltsurge Torque",   -- 4 fc
      ear1="Etiolation earring", -- 1 fc
      ear2="Malignance earring", -- 4 fc
      body="Pinga tunic +1",     -- 15 fc
      hands="Acad. Bracers +3",  -- 9 fc, 3 haste
      ring1="Lebeche ring",      -- 
      ring2="Kishar ring",       -- 4 fc
      back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Haste+10','Spell interruption rate down-10%',}},
      waist="Embla sash",        -- 5 fc, 3 haste
      legs="Pinga pants +1",     -- 13 fc
      feet={ name="Merlinic Crackows", augments={'Attack+22','"Fast Cast"+7',}}, -- 12 fc, 3 haste
    }

   sets.precast["Dispelga"] = set_combine(sets.precast.casting, {
     main="Daybreak",
     sub="Ammurapi Shield"
   })
    
	sets.precast["Stun"] = {
	}

    -- When spell school is aligned with grimoire, swap relevent pieces -- Can also use Arbatel +1 set here if you value 1% quickcast procs per piece. (2+ pieces)  
    -- Dont set_combine here, as this is the last step of the precast, it will have sorted all the needed pieces already based on type of spell.
    -- Then only swap in what under this set after everything else. 
    sets.precast.grimoire = {
      head="Pedagogy mortarboard +3", -- 13 grimoire, 6 haste
    }

	
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
    })
    
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{

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
      main="Tupsimati",
      sub="Enki strap",
      ammo="Ghastly Tathlum +1",
      head="Pixie hairpin +1",
      neck={ name="Argute Stole +2", augments={'Path: A',}},
      body={ name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+10%','INT+1','Mag. Acc.+1','"Mag.Atk.Bns."+11',}},
      hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
      legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','INT+8','Mag. Acc.+8',}},
      feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+11%','Mag. Acc.+11','"Mag.Atk.Bns."+13',}},
      waist="Acuity Belt +1",
      left_ear="Regal Earring",
      right_ear="Malignance Earring",
      left_ring="Archon ring",
      right_ring="Metamorph Ring +1",
      back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
    }
    
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
      ammo="Ghastly Tathlum +1",
      -- waist="Orpheus's Sash",
      waist="Sacro Cord",
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},
      feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    }
    
    sets.midcast.WindHelix = {
      main="Marin staff +1",
      sub="Khonsu",
      ammo="Ghastly Tathlum +1",
      waist="Orpheus's Sash",
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},
      feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    }
    
    sets.midcast.LightHelix = {
      main="Daybreak",
      sub="Ammurapi Shield",
      ammo="Ghastly Tathlum +1",
      waist="Orpheus's Sash",
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},
      feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},      
    }

    sets.midcast.DarkHelix = {
      head="Pixie hairpin +1",
      left_ring="Archon ring",
      waist="Orpheus's Sash",
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},
      feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
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
     main="Tupsimati",
     sub="Khonsu",
     ammo="Ghastly Tathlum +1",
     head={ name="Peda. M.Board +3", augments={'Enh. "Altruism" and "Focalization"',}},
     body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Sacro Cord",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Metamorph ring +1",
     right_ring="Freke Ring",
     back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
   }

   sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal, {
     feet="Jhakri Pigaches +2",
   })

   -- int/macc/mab/mbd
   -- Hood: 5/27/33/10 (unlikely to use)
   -- Body: 1/25/35/10
   -- Legs: 8/33/25/10
   -- Feet: 0/32/34/11
   
   -- No Klima!
   -- Chim BiS: 39677
   -- Akademos, Peda, Merl, Amal, Merl, Amal: 40453
   -- Marin,    Peda, Merl, Amal, Merl, Merl: 38838
   -- Marin,    Merl, Amal, Amal, Merl, Merl: 38579
   -- Marin,    Peda, Merl, Amal, Merl, Amal: 38541
   
   -- Klima
   -- Chim BiS: 39269
   -- Akademos, Peda, Merl, Amal, Merl, N/A: 40015
   -- Marin,    Merl, Merl, Amal, Merl, N/A: 
   
   -- used with toggle, default: F10
   -- Pieces to swap from free nuke to Magic Burst    
   sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
     main="Tupsimati",
     sub="Khonsu",
     ammo="Ghastly Tathlum +1",
     head="Pedagogy mortarboard +3",
     body={ name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+10%','INT+1','Mag. Acc.+1','"Mag.Atk.Bns."+11',}},
     hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
     legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','INT+8','Mag. Acc.+8',}},
     feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Sacro Cord",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Mujin Band",
     right_ring="Freke Ring",
     back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
   })

   -- used with toggle, default: F10
    -- Pieces to swap from free nuke to Magic Burst
   sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {
     main="Tupsimati",
     sub="Khonsu",
     feet="Jhakri Pigaches +2",
   })
   
   -- need cape
   sets.midcast.nuking.occult = set_combine(sets.midcast.nuking.normal, { 
     main="Khatvanga",
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
   })

   sets.midcast.MB.occult = set_combine(sets.midcast.MB.normal, {
     main="Khatvanga"
   })

    -- Enfeebling
   sets.midcast["Stun"] = {
     main="Tupsimati",
     sub="Khonsu",             -- 4
     ammo="Pemphredo tathlum",
     head="Acad. Mortar. +2",  -- 6
     body="Acad. Gown +3",     -- 3
     hands="Acad. Bracers +3", -- 3
     legs="Acad. Pants +3",    -- 5
     feet="Acad. Loafers +2",  -- 3
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Luminary sash",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Stikini Ring +1",
     right_ring="Stikini Ring +1",
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
     feet="Acad. Loafers +2",
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Acuity Belt +1",
     left_ear="Regal Earring",
     right_ear="Malignance Earring",
     left_ring="Stikini Ring +1",
     right_ring="Metamorph ring +1",
     back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
   }

   sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebling, {
     main="Daybreak",
     sub="Ammurapi Shield"
   })
   
   sets.midcast.MndEnfeebling = {
     main="Tupsimati",
     sub="Khonsu",
     ammo="Pemphredo tathlum",
     head="Acad. Mortar. +2",
     body="Acad. Gown +3",
     hands="Acad. Bracers +3",
     legs={ name="Chironic Hose", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Fast Cast"+5','MND+11','Mag. Acc.+13','"Mag.Atk.Bns."+6',}},
     feet="Acad. Loafers +2",
     neck={ name="Argute Stole +2", augments={'Path: A',}},
     waist="Luminary Sash",
     right_ear="Malignance Earring",
     left_ear="Regal Earring",
     left_ring="Stikini Ring +1",
     right_ring="Metamorph ring +1",
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
      left_ring="Stikini Ring +1",
      right_ring="Stikini Ring +1",
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

    -- lets do legs
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
--      main="Chatoyant staff",             -- 10
--      sub="Khonsu",
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
      hands="Telchine Gloves",
      left_ring="Stikini Ring +1",
      right_ring="Stikini Ring +1",
      waist="Embla Sash",
      back={ name="Bookworm's Cape", augments={'INT+1','MND+2','Helix eff. dur. +20','"Regen" potency+10',}},
      legs="Telchine Braconi",
      feet="Telchine Pigaches",
    }
    
    -- Focus on Regen Duration
    sets.midcast.regen.duration = set_combine(sets.midcast.regen.hybrid,{
      back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},	
    }) 
    
    -- Focus on Regen Potency
    sets.midcast.regen.potency = set_combine(sets.midcast.regen.hybrid,{
    }) 

    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.

end
