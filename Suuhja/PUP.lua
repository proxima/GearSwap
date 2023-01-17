----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
end

function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master", "Trusts")

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "DW", "TP", "DT", "Regen", "Ranged")

    --[[
        Alt-F12 - Turns off any emergency mode
        
        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]  
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(false, "Hide Keybinds")

    --[[ 
        This will toggle the CP Mode 
        //gs c toggle CP 
    ]] 
    state.CP = M(false, "CP") 
    CP_CAPE = "Aptitude Mantle +1" 

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{"head","body","hands","legs","feet"}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c hide keybinds")
    send_command("bind end gs c toggle CP") 
    send_command("bind = gs c clear")
    
    send_command('bind @c gs c toggle CustomGearLock')

    send_command('bind @d sat youcommand Muuhja Deploy')
    
    send_command('bind @b send muuhja input /ja "Apogee" <me>')
    send_command('bind @= send muuhja input /ja "Apogee" <me>')
    send_command('bind @n sat youcommand Muuhja "Hysteric Assault"')
    send_command('bind @n sat youcommand Muuhja "Carnage Elegy"')
    send_command('bind @m sat youcommand Muuhja "Pining Nocturne"')

    send_command('bind @a sat youcommand Muuhja "Thunderspark"')
    send_command('bind @o sat youcommand Muuhja "Shock Squall"')
    send_command('bind @p sat youcommand Zuuhja "Sleepga"')
    send_command('bind @v sat youcommand Muuhja "Flaming Crush"')
    
    select_default_macro_book()

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 1670
    pos_y = 280
    setupTextWindow(pos_x, pos_y)
    
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command('unbind @c')
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind ^`")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")       
    send_command("unbind end")
    send_command("unbind =")
    
    send_command('unbind @=')
    send_command('unbind @a')
    send_command('unbind @n')
    send_command('unbind @o')
    send_command('unbind @p')
end

function job_setup()
    include("PUP-LIB.lua")
end

function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {}
    Animators.Range = "Animator P II"
    Animators.Melee = "Animator P +1"

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head_PRegen = "Foire Taj +1"
    Artifact_Foire.Body_WSD_PTank = "Foire Tobe +3"
    Artifact_Foire.Hands_Mane_Overload = "Foire Dastanas +2"
    Artifact_Foire.Legs_PCure = "Foire Churidars +1"
    Artifact_Foire.Feet_Repair_PMagic = "Foire Babouches +3"

    Relic_Pitre = {}
    Relic_Pitre.Head_PRegen = "Pitre Taj +3" --Enhances Optimization
    Relic_Pitre.Body_PTP = "Pitre Tobe +3" --Enhances Overdrive
    Relic_Pitre.Hands_WSD = "Pitre Dastanas +3" --Enhances Fine-Tuning
    Relic_Pitre.Legs_PMagic = "Pitre Churidars +3" --Enhances Ventriloquy
    Relic_Pitre.Feet_PMagic = "Pitre Babouches +3" --Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head_PTPBonus = "Karagoz Capello +1"
    Empy_Karagoz.Body_Overload = "Karagoz Farsetto"
    Empy_Karagoz.Hands = "Karagoz Guanti +1"
    Empy_Karagoz.Legs_Combat = "Karagoz Pantaloni +1"
    Empy_Karagoz.Feet_Tactical = "Karagoz Scarpe +1"

    Visucius = {}
    
    Visucius.PetDT = {
        name = "Visucius's Mantle",
        augments = {
            'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',
            'Accuracy+20 Attack+20',
            'Pet: Accuracy+10 Pet: Rng. Acc.+10',
            'Pet: Haste+10','System: 1 ID: 1247 Val: 4'
        }    
    }

    Visucius.PetMagic = {
        name = "Visucius's Mantle",
        augments = {
            'Pet: M.Acc.+20 Pet: M.Dmg.+20',
            'Pet: Magic Damage+10',
            'Pet: "Regen"+10',
            'Pet: "Regen"+5'
        }
    }

    Visucius.MasterDA = {
        name = "Visucius's Mantle",
        augments={
            'STR+20',
            'Accuracy+20 Attack+20',
            'STR+10',
            '"Dbl.Atk."+10',
            'Phys. dmg. taken-10%'
        }
    }

    Visucius.Aeolian = {
        name="Visucius's Mantle",
        augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}
    }

    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {
      head={ name="Nyame Helm", augments={'Path: B',}},
      body={ name="Nyame Mail", augments={'Path: B',}},
      hands={ name="Nyame Gauntlets", augments={'Path: B',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck="Bathy Choker +1",
      waist="Moonbow Belt +1",
      left_ear="Infused Earring",
      right_ear="Eabani Earring",
      left_ring="Regal Ring",
      right_ring="Ilabrat Ring",
      back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }

    sets.MEVA = {
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Shulmanu Collar",
      waist="Carrier's Sash",
      left_ear="Eabani Earring",
      right_ear="Etiolation Earring",
      left_ring="C. Palug Ring",
      right_ring="Thur. Ring +1",
      back=Visucius.PetDT
    }

    -------------------------------------Fastcast
    sets.precast.FC = {
    }

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
    }

    -------------------------------------Kiting
    sets.Kiting = {feet = "Hermes' Sandals"}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {feet = Empy_Karagoz.Feet_Tactical}

    sets.precast.JA["Ventriloquy"] = {legs = Relic_Pitre.Legs_PMagic}

    sets.precast.JA["Role Reversal"] = {feet = Relic_Pitre.Feet_PMagic}

    sets.precast.JA["Overdrive"] = {body = Relic_Pitre.Body_PTP}

    sets.precast.JA["Repair"] = {
      ammo = "Automat. Oil +3",
      head={ name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
      left_ear="Guignol Earring",
      right_ear="Pratik Earring",
      body=Artifact_Foire.Body_WSD_PTank,
      hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
      legs="Desultor tassets",
      feet = Artifact_Foire.Feet_Repair_PMagic
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {    
      neck = "Buffoon's Collar +1",
      body = Empy_Karagoz.Body_Overload,
      hands = Artifact_Foire.Hands_Mane_Overload,
      back = "Visucius's Mantle",
      ear1 = "Burana Earring"
    }

    sets.precast.JA["Activate"] = {back = "Visucius's Mantle"}

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
       -- Add your set here 
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      head="Mpaca's Cap",
      body="Mpaca's Doublet",
      hands="Mpaca's Gloves",
      legs="Mpaca's Hose",
      feet="Mpaca's Boots",
      neck="Fotia Gorget",
      waist="Moonbow Belt +1",
      left_ear={ name="Schere Earring", augments={'Path: A',}},
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring="Gere Ring",
      right_ring="Niqmaddu Ring",
      back=Visucius.MasterDA
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = {
      head={ name="Blistering Sallet +1", augments={'Path: A',}},
      body="Mpaca's Doublet",
      hands="Mpaca's Gloves",
      legs="Mpaca's Hose",
      feet="Mpaca's Boots",
      neck="Fotia Gorget",
      waist="Moonbow Belt +1",
      left_ear={ name="Schere Earring", augments={'Path: A',}},
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring="Niqmaddu Ring",
      right_ring="Gere Ring",
      back=Visucius.MasterDA
    }

    sets.precast.WS["Stringing Pummel"].Mod = set_combine(sets.precast.WS["Stringing Pummel"], {
    })

    sets.precast.WS["Victory Smite"] = {
      head={ name="Blistering Sallet +1", augments={'Path: A',}},
      body="Mpaca's Doublet",
      hands="Mpaca's Gloves",
      legs="Mpaca's Hose",
      feet="Mpaca's Boots",
      neck="Fotia Gorget",
      waist="Moonbow Belt +1",
      left_ear={ name="Schere Earring", augments={'Path: A',}},
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring="Gere Ring",
      right_ring="Niqmaddu Ring",
      back=Visucius.MasterDA
    }

    sets.precast.WS["Shijin Spiral"] = {
      head="Mpaca's Cap",
      body="Mpaca's Doublet",
      hands="Mpaca's Gloves",
      legs="Mpaca's Hose",
      feet="Mpaca's Boots",
      neck="Fotia Gorget",
      waist="Moonbow Belt +1",
      left_ear={ name="Schere Earring", augments={'Path: A',}},
      right_ear="Mache Earring +1",
      left_ring="Gere Ring",
      right_ring="Niqmaddu Ring",
      back=Visucius.MasterDA
    }

    sets.precast.WS["Howling Fist"] = {
      head="Mpaca's Cap",
      neck={ name="Pup. Collar +2", augments={'Path: A',}},
      left_ear={ name="Schere Earring", augments={'Path: A',}},
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      left_ring="Gere Ring",
      right_ring="Niqmaddu Ring",
      back=Visucius.MasterDA,
      waist="Moonbow Belt +1",
      legs="Mpaca's Hose",
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
    }

    sets.precast.WS["Aeolian Edge"] = {
      head={ name="Nyame Helm", augments={'Path: B',}},
      body={ name="Nyame Mail", augments={'Path: B',}},
      hands={ name="Nyame Gauntlets", augments={'Path: B',}},
      legs={ name="Nyame Flanchard", augments={'Path: B',}},
      feet={ name="Nyame Sollerets", augments={'Path: B',}},
      neck="Sibyl Scarf",
      waist="Orpheus's Sash",
      left_ear="Friomisi Earring",
      right_ear="Crematio Earring",
      left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
      right_ring="Epaminondas's Ring",
      back=Visucius.Aeolian
    }

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Moonbow Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Gelatinous Ring +1",
        right_ring="Defending Ring",
        back=Visucius.PetDT
    }

    -------------------------------------
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
        head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
        neck="Shulmanu Collar",
        waist="Moonbow Belt +1",
        left_ear={name="Mache Earring +1",bag="wardrobe 4"},
        right_ear={name="Mache Earring +1",bag="wardrobe 5"},
        left_ring="Niqmaddu Ring",
        right_ring="Gere Ring",
        back=Visucius.MasterDA
    }

    -------------------------------------DW
    --[[
        Offense Mode = Master
        Hybrid Mode = DW
    ]]
    sets.engaged.Master.DW = set_combine(sets.engaged.Master, {
      left_ear="Eabani Earring",
      right_ear="Suppanomimi",
      feet="Hizamaru Sune-ate +2"
    })

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = {
        head="Malignance Chapeau", -- 6
        body="Malignance Tabard", -- 9
        hands="Malignance Gloves", -- 5
        legs = "Malignance Tights", -- 7
        feet="Malignance Boots", -- 4
        neck="Shulmanu Collar",
        waist="Moonbow Belt +1", -- 6
        left_ear="Telos Earring",
        right_ear={name="Mache Earring +1",bag="wardrobe 5"},
        left_ring="Niqmaddu Ring",
        right_ring="Gere Ring",
        back=Visucius.MasterDA
    }

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]

    -- 26 Haste, 50 PDT, 25 SB, 25 SBII
    sets.engaged.Master.DT = {
      head={ name="Nyame Helm", augments={'Path: B',}},
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs={ name="Mpaca's Hose", augments={'Path: A',}},
      feet="Malignance Boots",
      neck={ name="Bathy Choker +1", augments={'Path: A',}},
      waist="Moonbow Belt +1",
      left_ear="Mache Earring +1",
      right_ear="Digni. Earring",
      left_ring="Niqmaddu Ring",
      right_ring="Chirich Ring +1",
      back=Visucius.MasterDA
    }
       
    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
      head="Heyoka Cap +1",
      body="Tali'ah Manteel +2",
      hands="Mpaca's Gloves",
      legs="Heyoka Subligar +1",
      feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
      neck="Shulmanu Collar",
      waist="Moonbow Belt +1",
      left_ear="Dedition Earring",
      right_ear="Telos Earring",
      left_ring="Niqmaddu Ring",
      right_ring="Gere Ring",
      back=Visucius.PetDT
    }

    -------------------------------------DW
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DW
    ]]
    sets.engaged.MasterPet.DW = sets.engaged.Master.DW
    
    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = sets.engaged.MasterPet
    
    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = sets.engaged.Master.DT
    
    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = sets.engaged.Master

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {
    }

    sets.midcast.Pet.Cure = sets.midcast.Pet
    sets.midcast.Pet["Healing Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Elemental Magic"] = {
      head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+29','Pet: INT+1','Pet: Attack+8 Pet: Rng.Atk.+8','Pet: "Mag.Atk.Bns."+15',}},
      body="Udug Jacket",
      hands={ name="Herculean Gloves", augments={'"Fast Cast"+3','Pet: Mag. Acc.+23 Pet: "Mag.Atk.Bns."+23','STR+3 DEX+3','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
      legs=Relic_Pitre.Legs_PMagic,
      feet=Relic_Pitre.Feet_PMagic,
      neck={ name="Pup. Collar +2", augments={'Path: A',}},
      waist="Ukko Sash",
      left_ear="Burana Earring",
      right_ear="Enmerkar Earring",
      left_ring="C. Palug Ring",
      right_ring="Tali'ah Ring",
      back=Visucius.PetMagic
    }
    sets.midcast.Pet["Enfeebling Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Dark Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Divine Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Enhancing Magic"] = sets.midcast.Pet

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = set_combine(sets.idle.MasterDT,
        {
        }
    )
        
    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting

        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT = sets.idle.MasterDT

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = {
      head="Heyoka Cap +1",
      body="Heyoka harness +1",
      hands="He. Mittens +1",
      legs="Heyoka Subligar +1",
      feet="He. Leggings +1",
      right_ear="Rimeice Earring",
      left_ear="Domesticator's earring"
    }

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {
      head="Anwig Salade",
      -- head={ name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},       --  4
      body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},         --  4
      hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},        --  4
      legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},      --  4
      feet={ name="Rao sune-ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},     --  4
      neck="Shulmanu Collar",
      -- waist="Klouskap sash +1",
      waist="Isa Belt",                                                                                         --  3
      left_ear="Enmerkar earring",                                                                              --  3
      right_ear="Rimeice Earring",                                                                              --  1
      left_ring="Thurandaut Ring +1",                                                                           --  4
      right_ring="C. Palug Ring",
    --right_ring="Overbearing Ring",
      back=Visucius.PetDT                                                                                       --  5
    }

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = {
        head="Karagoz Capello +1",
        body= Relic_Pitre.Body_PTP,
        hands="Mpaca's Gloves",
        legs="Heyoka Subligar +1",
        feet="Mpaca's Boots",
        neck="Shulmanu Collar",
        waist="Klouskap sash +1",
        left_ear="Enmerkar earring",
        right_ear="Rimeice Earring",
        left_ring="Thurandaut Ring +1",
        right_ring="C. Palug Ring",
        back=Visucius.PetDT
    }


    --[[
        Idle Mode = Idle
        Hybrid Mode = DW
    ]]
    sets.idle.Pet.Engaged.DW = {
        head=Relic_Pitre.Head_PRegen,
        body= Relic_Pitre.Body_PTP,
        hands="Mpaca's Gloves",
        legs="Heyoka Subligar +1",
        feet="Mpaca's Boots",
        neck="Shulmanu Collar",
        waist="Klouskap sash +1",
        left_ear="Enmerkar Earring",
        right_ear="Rimeice Earring",
        left_ring="Thurandaut Ring +1",
        right_ring="Varar Ring +1",
        back=Visucius.PetDT
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
    sets.idle.Pet.Engaged.TP = {
      head={ name="Taeon Chapeau", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      -- body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
      body={ name="Taeon Tabard", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      hands={ name="Taeon Gloves", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      legs={ name="Taeon Tights", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      feet={ name="Taeon Boots", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      neck="Shulmanu Collar",
      waist="Klouskap Sash +1",
      left_ear="Enmerkar Earring",
      right_ear="Domesticator's Earring",
      left_ring="Thurandaut Ring +1",
      right_ring="C. Palug Ring",
      back=Visucius.PetDT
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
    sets.idle.Pet.Engaged.DT = {
      head="Anwig Salade",
      -- head={ name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},       --  4
      body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},         --  4
      hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},        --  4
      legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},      --  4
      feet={ name="Rao sune-ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},     --  4
      neck="Shulmanu Collar",
      waist="Isa Belt",                                                                                         --  3
      left_ear="Enmerkar earring",                                                                              --  3
      right_ear="Rimeice Earring",                                                                              --  1
      left_ring="Thurandaut Ring +1",                                                                           --  4
      right_ring="Overbearing Ring",
      back=Visucius.PetDT                                                                                       --  5
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = {
      head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+29','Pet: INT+1','Pet: Attack+8 Pet: Rng.Atk.+8','Pet: "Mag.Atk.Bns."+15',}},
      body="Udug Jacket",
      hands={ name="Herculean Gloves", augments={'"Fast Cast"+3','Pet: Mag. Acc.+23 Pet: "Mag.Atk.Bns."+23','STR+3 DEX+3','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
      legs=Relic_Pitre.Legs_PMagic,
      feet=Relic_Pitre.Feet_PMagic,
      neck={ name="Pup. Collar +2", augments={'Path: A',}},
      waist="Ukko Sash",
      left_ear="Burana Earring",
      right_ear="Enmerkar Earring",
      left_ring="C. Palug Ring",
      right_ring="Tali'ah Ring",
      back=Visucius.PetMagic
    }
    
    sets.idle.Pet.Regen = {
    }
    
 
    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged =
        set_combine(
        sets.idle.Pet.Engaged,
        {
            legs=Empy_Karagoz.Legs_Combat
        }
    )

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
        head=Relic_Pitre.Head_PRegen,
        body= Relic_Pitre.Body_PTP,
        hands="Mpaca's Gloves",   
        legs=Empy_Karagoz.Legs_Combat,
        feet="Mpaca's Boots",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Enmerkar earring",
        right_ear="Burana earring",
        left_ring="Thurandaut Ring +1",
        right_ring="C. Palug Ring",
        back=Visucius.PetDT
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = set_combine(sets.midcast.Pet.WSNoFTP, {
        head=Empy_Karagoz.Head_PTPBonus,
        back="Dispersal Mantle",
        waist="Klouskap sash +1",
    })

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = {}

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] = {
      head={ name="Taeon Chapeau", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      body={ name="Taeon Tabard", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      hands="Mpaca's Gloves",
      legs={ name="Taeon Tights", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      feet="Mpaca's Boots",
      neck="Shulmanu Collar",
      waist="Incarnation Sash",
      left_ear="Burana earring",
      right_ear="Domesticator's earring",
      left_ring="Thurandaut Ring +1",
      right_ring="C. Palug Ring",
      back=Visucius.PetDT
    }

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] =
        set_combine(
        sets.midcast.Pet.WSFTP,
        {
        }
    )

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = {
        range="Animator P +1",
        ammo="Automat. Oil +3",
        head="Pitre Taj +3",
        body="Udug Jacket",
        hands="Malignance Gloves",
        legs="Heyoka Subligar +1",
        feet="Hermes' Sandals",
        neck="Shulmanu Collar",
        waist="Moonbow Belt +1",
        left_ear="Mache Earring +1",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Gere Ring",
        back=Visucius.MasterDA
    }

    sets.midcast.Phalanx = {
      head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
      body={ name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}},
      hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
      legs={ name="Taeon Tights", augments={'Phalanx +3',}},
      feet={ name="Taeon Boots", augments={'Phalanx +3',}},
    }

    -- Resting sets
    sets.resting = {
       -- Add your set here
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(2, 2)
end

