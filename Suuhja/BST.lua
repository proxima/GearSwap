-------------------------------------------------------------------------------------------------------------------
-- ctrl+F12 cycles Idle modes
 
 
-------------------------------------------------------------------------------------------------------------------
                            -- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
                            -- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
                            -- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
                            -- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
                            -- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
                            -- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
                            -- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
                            -- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
                            -- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
 
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
function job_setup()
 
    get_combat_form()
 
end
 
 
function user_setup()
        state.IdleMode:options('Normal', 'Reraise')
        state.OffenseMode:options('Normal', 'PetDT')
        state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'HighAcc', 'MaxAcc',}
        send_command('bind ^f8 gs c cycle CorrelationMode')
        select_default_macro_book()

		send_command('bind @o sat youcommand Muuhja "Horde Lullaby"')
		    send_command('bind @n sat youcommand Muuhja "Carnage Elegy"')
 
       
 end
     
 
-- Complete list of Ready moves to use with Sic & Ready Recast -5 Desultor Tassets.
ready_moves_to_check = S{'Sic','Whirl Claws','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
    'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
    'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit',
    'Numbing Noise','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Power Attack',
    'Hi-Freq Field','Sandpit','Sandblast','Venom Spray','Mandibular Bite','Metallic Body','Bubble Shower',
    'Bubble Curtain','Scissor Guard','Big Scissors','Grapple','Spinning Top','Double Claw','Filamented Hold',
    'Frog Kick','Queasyshroom','Silence Gas','Numbshroom','Spore','Dark Spore','Shakeshroom','Blockhead',
    'Secretion','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics','??? Needles',
    'Needleshot','Chaotic Eye','Blaster','Scythe Tail','Ripper Fang','Chomp Rush','Intimidate','Recoil Dive',
    'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Spiral Spin','Noisome Powder','Wing Slap',
    'Beak Lunge','Suction','Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath',
    'Fantod','Charged Whisker','Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath',
    'Sensilla Blades','Tegmina Buffet','Molting Plumage','Swooping Frenzy','Pentapeck','Sweeping Gouge',
    'Zealous Snort','Somersault ','Tickling Tendrils','Stink Bomb','Nectarous Deluge','Nepenthic Plunge',
        'Pecking Flurry','Pestilent Plume','Foul Waters','Spider Web','Sickle Slash','Frogkick','Ripper Fang','Scythe Tail','Chomp Rush'}
 
       
mab_ready_moves = S{
     'Cursed Sphere','Venom','Toxic Spit',
     'Venom Spray','Bubble Shower',
     'Fireball','Plague Breath',
     'Snow Cloud','Acid Spray','Silence Gas','Dark Spore',
     'Charged Whisker','Purulent Ooze','Aqua Breath','Stink Bomb',
     'Nectarous Deluge','Nepenthic Plunge','Foul Waters','Dust Cloud','Sheep Song','Scream','Dream Flower','Roar','Gloeosuccus','Palsy Pollen',
     'Soporific','Geist Wall','Numbing Noise','Spoil','Hi-Freq Field',
     'Sandpit','Sandblast','Filamented Hold',
     'Spore','Infrasonics','Chaotic Eye',
     'Blaster','Intimidate','Noisome Powder','TP Drainkiss','Jettatura','Spider Web',
     'Corrosive Ooze','Molting Plumage','Swooping Frenzy',
     'Pestilent Plume',}
 
 
-- List of abilities to reference for applying Treasure Hunter +1 via Chaac Belt.
 
 
function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end
 
    -- Unbinds the Jug Pet, Reward, Correlation, Treasure, PetMode, MDEF Mode hotkeys.
    send_command('unbind !=')
    send_command('unbind ^=')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind @f8')
    send_command('unbind ^f11')
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  set_macro_page(6, 5)
end 

        -- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
        -- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
        -- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
        -- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
        -- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
        -- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
        -- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
        -- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
        -- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
        -- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
       
 
-- BST gearsets
function init_gear_sets()
    -- PRECAST SETS
    sets.precast.JA['Killer Instinct'] = {head="Ankusa Helm +1"}       
    sets.precast.JA['Bestial Loyalty'] = {hands="Ankusa Gloves"}
    sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']
    sets.precast.JA.Familiar = {legs="Ankusa Trousers"}     
    sets.precast.JA.Tame = {head="Totemic Helm +1",}   
    sets.precast.JA.Spur = {feet="Nukumi Ocreae +1"}
       
    --This is what will equip when you use Reward.  No need to manually equip Pet Food Theta.
    sets.precast.JA.Reward = {
      ammo="Pet Food Theta",
      body="Totemic Jackcoat +1",
      back="Pastoralist's Mantle",
      legs="Ankusa Trousers",
      feet="Totemic gaiters +1"
    }
 
    --This is your base FastCast set that equips during precast for all spells/magic.
    sets.precast.FC = {
    }
           
                   
    sets.midcast.Stoneskin = {
    }
               
    sets.precast.WS = {
    }
 
    -- Specific weaponskill sets.
    sets.precast.WS['Ruinator'] = {
    }
    
    sets.precast.WS['Decimation'] = {
      -- main="Kaja Axe",
      -- sub="Adapa Shield",
      ammo="Demonry Core",
      head="Skormoth Mask",
      body="Tali'ah Manteel +2",
      hands={ name="Argosy Mufflers +1", augments={'STR+12','DEX+12','Attack+20',}},
      legs="Meg. Chausses +2",
      feet={ name="Argosy Sollerets +1", augments={'STR+12','DEX+12','Attack+20',}},
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Brutal Earring",
      right_ear="Sherida Earring",
      left_ring="Gere Ring",
      right_ring="Epona's Ring",
      back={ name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
               
    sets.precast.WS['Onslaught'] = {
    }
       
    sets.precast.WS['Primal Rend'] = {
    }
    
    sets.precast.WS['Cloudsplitter'] = {
    }
 
    -- PET SIC & READY MOVES
  
    -- This is your base Ready move set, activating for physical Ready moves. Merlin/D.Tassets are accounted for already.
    sets.midcast.Pet.WS = {
      -- main={ name="Kumbhakarna", augments={'Pet: Accuracy+13 Pet: Rng. Acc.+13','Pet: TP Bonus+200',}},
      -- sub="Adapa Shield",
      ammo="Demonry Core",
      head={ name="Emicho Coronet +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
      body={ name="Taeon Tabard", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      hands="Nukumi Manoplas +1",
      legs={ name="Taeon Tights", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      feet={ name="Emi. Gambieras +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
      neck="Shulmanu Collar",
      waist="Incarnation Sash",
      left_ear="Enmerkar Earring",
      right_ear="Domesticator's earring",
      left_ring="Thurandaut Ring +1",
      right_ring="C. Palug Ring",
      back={ name="Pastoralist's Mantle", augments={'STR+1 DEX+1','Accuracy+4','Pet: Accuracy+18 Pet: Rng. Acc.+18',}},
    }
	   
    sets.midcast.Pet.Neutral = set_combine(sets.midcast.Pet.WS, {})           
    sets.midcast.Pet.HighAcc =  set_combine(sets.midcast.Pet.WS, {})
    
    sets.midcast.Pet.MaxAcc =  set_combine(sets.midcast.Pet.WS, {
      main={ name="Arktoi", augments={'Accuracy+50','Pet: Accuracy+50','Pet: Attack+30',}},
      sub="Adapa Shield",
      ammo="Demonry Core",
      head="Tali'ah Turban +2",
      body="Tali'ah Manteel +2",
      hands="He. Mittens +1",
      legs="Heyoka Subligar +1",
      feet="He. Leggings +1",
      neck="Shulmanu Collar",
      waist="Klouskap Sash +1",
      left_ear="Enmerkar Earring",
      right_ear="Domes. Earring",
      left_ring="Thurandaut Ring +1",
      right_ring="C. Palug Ring",
      back={ name="Pastoralist's Mantle", augments={'STR+1 DEX+1','Accuracy+4','Pet: Accuracy+18 Pet: Rng. Acc.+18',}},
    })
 
    -- This will equip for Magical Ready moves like Fireball
    sets.midcast.Pet.MabReady = set_combine(sets.midcast.Pet.WS, {
      main={ name="Kumbhakarna", augments={'Pet: Accuracy+13 Pet: Rng. Acc.+13','Pet: TP Bonus+200',}},
      sub="Adapa Shield",
      ammo="Demonry Core",
      head={ name="Emicho Coronet +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
      body="Udug Jacket",
      hands="Nukumi Manoplas +1",
      legs={ name="Taeon Tights", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      feet={ name="Emi. Gambieras +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
      neck="Adad Amulet",
      waist="Incarnation Sash",
      left_ear="Enmerkar Earring",
      right_ear="Domesticator's earring",
      left_ring="Tali'ah ring",
      right_ring="C. Palug Ring",
      back={ name="Pastoralist's Mantle", augments={'STR+1 DEX+1','Accuracy+4','Pet: Accuracy+18 Pet: Rng. Acc.+18',}},
    })
   
    sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas +1",}
    sets.midcast.Pet.ReadyRecast = {legs="Desultor Tassets",}
        
    -- IDLE SETS (TOGGLE between RERAISE and NORMAL with CTRL+F12)
   
    -- Base Idle Set (when you do NOT have a pet out)
    sets.idle = {
      -- main={ name="Kumbhakarna", augments={'Pet: Accuracy+13 Pet: Rng. Acc.+13','Pet: TP Bonus+200',}},
      -- sub="Adapa Shield",
      ammo="Demonry Core",
      head="Malignance Chapeau",
      body="Tali'ah Manteel +2",
      hands="He. Mittens +1",
      legs="Heyoka Subligar +1",
      feet="He. Leggings +1",
      neck="Shulmanu Collar",
      waist="Windbuffet belt +1",
      left_ear="Enmerkar Earring",
      right_ear="Sherida Earring",
      left_ring="Gere Ring",
      right_ring="Epona's Ring",
      back={ name="Pastoralist's Mantle", augments={'STR+1 DEX+1','Accuracy+4','Pet: Accuracy+18 Pet: Rng. Acc.+18',}},
    } 
           
    sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

    -- Idle Set that equips when you have a pet out and not fighting an enemy.
    sets.idle.Pet = set_combine(sets.idle, {
      -- main="Kaja Axe",
      -- sub="Adapa Shield",
      ammo="Staunch Tathlum +1",
      head="Malignance Chapeau",
      body="Tali'ah Manteel +2",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Anu Torque",
      waist="Windbuffet Belt +1",
      left_ear="Brutal Earring",
      right_ear="Sherida Earring",
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      back={ name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Phys. dmg. taken-10%',}},
    })
       
    -- Idle set that equips when you have a pet out and ARE fighting an enemy.
    sets.idle.Pet.Engaged = set_combine(sets.idle, {
      -- main="Kaja Axe",
      -- sub="Adapa Shield",
      ammo="Staunch Tathlum +1",
      head="Malignance Chapeau",
      body="Tali'ah Manteel +2",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Anu Torque",
      waist="Windbuffet Belt +1",
      left_ear="Brutal Earring",
      right_ear="Sherida Earring",
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      back={ name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Phys. dmg. taken-10%',}},
    })
    
    -- MELEE (SINGLE-WIELD) SETS   
    sets.engaged = {
      -- main="Kaja Axe",
      -- sub="Adapa Shield",
      ammo="Staunch Tathlum +1",
      head="Malignance Chapeau",
      body="Tali'ah Manteel +2",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Anu Torque",
      waist="Windbuffet Belt +1",
      left_ear="Brutal Earring",
      right_ear="Sherida Earring",
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      back={ name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Phys. dmg. taken-10%',}},
    }
    
    sets.engaged.PetDT = {
      ammo="Demonry Core",
      head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}},
      body={ name="Taeon Tabard", augments={'Pet: Mag. Evasion+22','Pet: "Regen"+3','Pet: Damage taken -4%',}},
      hands={ name="Taeon Gloves", augments={'Pet: Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%',}},
      legs={ name="Taeon Tights", augments={'Pet: Mag. Evasion+23','Pet: "Regen"+3','Pet: Damage taken -4%',}},
      feet={ name="Taeon Boots", augments={'Pet: Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%',}},
      neck="Empath Necklace",
      waist="Isa Belt",
      left_ear="Enmerkar Earring",
      right_ear="Handler's Earring +1",
      left_ring="Thurandaut Ring +1",
      right_ring="Defending Ring",
      back={ name="Pastoralist's Mantle", augments={'STR+1 DEX+1','Accuracy+4','Pet: Accuracy+18 Pet: Rng. Acc.+18',}},
    }
               
    -- MELEE (DUAL-WIELD) SETS FOR DNC AND NIN SUBJOB   
    sets.engaged.DW = {
      -- main="Kaja Axe",
      -- sub="Tauret",
      ammo="Staunch Tathlum +1",
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Anu Torque",
      waist="Reiki Yotai",
      left_ear="Eabani Earring",
      right_ear="Suppanomimi",
      left_ring="Chirich Ring +1",
      right_ring="Chirich Ring +1",
      back={ name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10','Phys. dmg. taken-10%',}},    
    }
           
    sets.engaged.DW.PetDT = {
    }
   
           
            -- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
            -- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
            -- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
            -- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
            -- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
            -- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
            -- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
            -- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
            -- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
            -- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
 
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
 
function job_precast(spell, action, spellMap, eventArgs)
    cancel_conflicting_buffs(spell, action, spellMap, eventArgs)
 
     
   
 
-- Define class for Sic and Ready moves.
        if ready_moves_to_check:contains(spell.name) and pet.status == 'Engaged' then
                classes.CustomClass = "WS"
        equip(sets.midcast.Pet.ReadyRecast)
        end
end
 
 
 
function job_pet_midcast(spell, action, spellMap, eventArgs)
end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
  if spell.type == "Monster" and not spell.interrupted then 
    equip(set_combine(sets.midcast.Pet.WS, sets.midcast.Pet[state.CorrelationMode.value]))
 
    if mab_ready_moves:contains(spell.english) and pet.status == 'Engaged' then
      equip(sets.midcast.Pet.MabReady)
    end
 
    if buffactive['Unleash'] then
      main="Arktoi"
      hands={ name="Taeon Gloves", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    end
    
    eventArgs.handled = true
  end 
end
 
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Correlation Mode' then
        state.CorrelationMode:set(newValue)
    end
end
 
function get_combat_form()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.CombatForm:set('DW')
    else
         state.CombatForm:reset()
         end
 
end