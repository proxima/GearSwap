-------------------------------------------------------------------------------------------------------------------
-- ctrl+F12 cycles Idle modes 
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
  
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

  
  Cape = {}
  Cape.STP      = { name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
  Cape.PET_PHYS = { name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}}
  Cape.PET_MACC = { name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}
  Cape.STR_DA   = { name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
  Cape.STR_WSD  = { name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
  Cape.REND     = { name="Artio's Mantle", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
end
 
ready_moves_to_check = S{'Sic','Whirl Claws','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
  'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
  'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit',
  'Numbing Noise','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Power Attack',
  'Hi-Freq Field','Sandpit','Sandblast','Venom Spray','Mandibular Bite','Metallic Body','Bubble Shower',
  'Bubble Curtain','Scissor Guard','Big Scissors','Grapple','Spinning Top','Double Claw','Filamented Hold',
  'Frog Kick','Queasyshroom','Silence Gas','Numbshroom','Spore','Dark Spore','Shakeshroom','Blockhead',
  'Secretion','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics','??? Needles',
  'Needleshot','Chaotic Eye','Blaster','Scythe Tail','Ripper Fang','Intimidate','Recoil Dive',
  'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Spiral Spin','Noisome Powder',
  'Beak Lunge','Suction','Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath',
  'Fantod','Charged Whisker','Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath',
  'Sensilla Blades','Tegmina Buffet','Molting Plumage','Swooping Frenzy',
  'Zealous Snort','Somersault','Stink Bomb','Nectarous Deluge','Nepenthic Plunge',
  'Pestilent Plume','Foul Waters','Spider Web','Sickle Slash','Frogkick','Ripper Fang',
  'Scythe Tail','Chomp Rush','Fluid Toss','Fluid Spread','Digest'}
       
multihit_ready_moves = S{'Sweeping Gouge', 'Tickling Tendrils', 'Chomp Rush', 'Pentapeck', 'Wing Slap', 'Pecking Flurry'}
      
mab_ready_moves = S{
  'Cursed Sphere','Venom','Toxic Spit',
  'Venom Spray','Bubble Shower',
  'Fireball','Plague Breath',
  'Snow Cloud','Acid Spray','Silence Gas','Dark Spore',
  'Charged Whisker','Aqua Breath','Stink Bomb',
  'Nectarous Deluge','Nepenthic Plunge','Foul Waters','Dust Cloud','Sheep Song','Scream','Dream Flower','Roar','Gloeosuccus','Palsy Pollen',
  'Soporific','Geist Wall','Numbing Noise','Spoil','Hi-Freq Field',
  'Sandpit','Sandblast','Filamented Hold',
  'Spore','Infrasonics','Chaotic Eye',
  'Blaster','Intimidate','Noisome Powder','Jettatura','Spider Web',
  'Corrosive Ooze','Molting Plumage','Swooping Frenzy',
  'Pestilent Plume',}
     
macc_ready_moves = S{
  'Purulent Ooze', 'TP Drainkiss'
}
 
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
 
function init_gear_sets()
    sets.precast.Sheep = { ammo="Lyrical Broth" }

    sets.precast.JA['Killer Instinct'] = {head="Ankusa Helm +3"}
    sets.precast.JA['Bestial Loyalty'] = {hands="Ankusa Gloves"}
    sets.precast.JA['Call Beast']      = sets.precast.JA['Bestial Loyalty']
    sets.precast.JA.Familiar           = {legs="Ankusa Trousers +1"}
    sets.precast.JA.Tame               = {head="Totemic Helm +1"}
    sets.precast.JA.Spur               = {feet="Nukumi Ocreae +3"}

    sets.precast.JA.Reward = {
      ammo="Pet Food Theta",
      head="Stout Bonnet",	
      body="Totemic Jackcoat +3",
      back=Cape.PET_PHYS,
      legs="Ankusa Trousers +1", -- Ankusa Trousers +3
      feet="Totemic gaiters +1" -- Ankusa Gaiters +3
    }
 
    sets.precast.FC = {
      right_ring="Weatherspoon ring +1"
    }
                              
    sets.midcast.Stoneskin = {
    }
               
    sets.precast.WS = {
    }
  
    sets.precast.WS['Decimation'] = {
      ammo="Coiste Bodhar",
      head="Nyame Helm",
      body="Gleti's Cuirass",
      hands="Nyame Gauntlets",
      legs="Gleti's Breeches",
      feet="Nukumi Ocreae +3",
      neck="Fotia Gorget",
      waist="Sailfi Belt +1",
      left_ear="Sroda Earring",
      right_ear="Sherida Earring",
      right_ring="Gere Ring",
      left_ring="Sroda Ring",
      back=Cape.STR_DA
    }

    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS['Decimation'], {
      right_ring="Regal Ring",
    })

    sets.precast.WS['Savage Blade'] = {
      ammo="Coiste Bodhar",
      head="Ankusa Helm +3",
      body="Nukumi Gausape +3",
      hands="Nyame Gauntlets",
      legs="Gleti's Breeches",
      feet="Nyame Sollerets",
      neck="Beastmaster collar +2",
      waist="Sailfi Belt +1",
      left_ear="Moonshade Earring",
      right_ear="Thrud Earring",
      left_ring="Regal Ring",
      right_ring="Epaminondas's Ring",
      back=Cape.STR_WSD
    }

    sets.precast.WS['Calamity'] = set_combine(sets.precast.WS['Savage Blade'], {})
    sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS['Savage Blade'], {})

    sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS['Savage Blade'], {
    })
       
    sets.precast.WS['Primal Rend'] = {
      ammo="Oshasha's Treatise",
      head="Nyame Helm",
      neck="Sanctity Necklace",
      left_ear="Moonshade Earring",
      right_ear="Friomisi Earring",
      body="Nyame Mail",
      hands="Nyame Gauntlets",
      left_ring="Weatherspoon ring +1",
      right_ring="Epaminondas's Ring",
      back=Cape.REND,
      waist="Orpheus's Sash",
      legs="Nyame Flanchard",
      feet="Nyame Sollerets"
    }
    
    sets.precast.WS['Cloudsplitter'] = {
    }
 
    -- PET SIC & READY MOVES
  
    -- This is your base Ready move set, activating for physical Ready moves. Merlin/D.Tassets are accounted for already.
    sets.midcast.Pet.WS = {
      main="Aymur",
      sub="Agwu's Axe",      
      ammo="Voluspa Tathlum",
      head={ name="Emicho Coronet +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
      body={ name="Taeon Tabard", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      hands="Nukumi Manoplas +3",
      legs={ name="Taeon Tights", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      feet="Gleti's Boots",
      neck="Shulmanu Collar",
      waist="Incarnation Sash",
      left_ear="Sroda Earring",
      right_ear="Nukumi Earring +1",
      left_ring="Thur. Ring +1",
      right_ring="C. Palug Ring",
      back=Cape.PET_PHYS
    }

    sets.midcast.Pet.Neutral = set_combine(sets.midcast.Pet.WS, {})           
    sets.midcast.Pet.HighAcc =  set_combine(sets.midcast.Pet.WS, {})
    sets.midcast.Pet.MaxAcc =  set_combine(sets.midcast.Pet.WS, {})
    
    sets.midcast.Pet.Multihit = set_combine(sets.midcast.Pet.WS, {
      neck="Beastmaster collar +2",
      legs={ name="Emicho Hose +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}},
    })
 
    -- This will equip for Magical Ready moves like Fireball
    sets.midcast.Pet.MabReady = {
      main={ name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+19','Pet: TP Bonus+200',}, bag="wardrobe 5"},
      sub={ name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+19','Pet: TP Bonus+200',}, bag="wardrobe 6"},
      ammo="Voluspa Tathlum",
      head={ name="Valorous Mask", augments={'Pet: "Mag.Atk.Bns."+27','Pet: INT+14','Pet: Accuracy+12 Pet: Rng. Acc.+12','Pet: Attack+7 Pet: Rng.Atk.+7',}},
      body="Udug Jacket",
      hands="Nukumi Manoplas +3",
      legs={ name="Valorous Hose", augments={'Pet: "Mag.Atk.Bns."+28','Pet: Haste+3','Pet: INT+12','Pet: Accuracy+14 Pet: Rng. Acc.+14','Pet: Attack+13 Pet: Rng.Atk.+13',}},
      feet={ name="Valorous Greaves", augments={'Pet: "Mag.Atk.Bns."+29','Pet: INT+13','Pet: Accuracy+4 Pet: Rng. Acc.+4','Pet: Attack+10 Pet: Rng.Atk.+10',}},
      neck="Adad Amulet",
      waist="Incarnation Sash",
      left_ear="Enmerkar Earring",
      right_ear="Nukumi Earring +1",
      left_ring="Tali'ah Ring",
      right_ring="C. Palug Ring",
      back="Argocham. Mantle",
    }
    
    sets.midcast.Pet.MaccReady = {
      main="Aymur",
      sub="Sacro Bulwark",
      ammo="Voluspa Tathlum",
      head="Nukumi Cabasset +3",
      body="Nukumi Gausape +3",
      hands="Nukumi Manoplas +3",
      legs="Nukumi Quijotes +3",
      feet="Gleti's Boots",
      left_ear="Handler's Earring +1",
      right_ear="Nukumi Earring +1",
      left_ring="Tali'ah Ring",
      right_ring="C. Palug Ring",
      waist="Incarnation Sash",
      neck="Beastmaster collar +2",
      back=Cape.PET_MACC
    }
    
    sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas +3",}
    sets.midcast.Pet.ReadyRecast = {legs="Gleti's Breeches"}
        
    -- IDLE SETS (TOGGLE between RERAISE and NORMAL with CTRL+F12)
   
    -- Base Idle Set (when you do NOT have a pet out)
    sets.idle = {
      ammo="Staunch Tathlum +1",
      head="Malignance Chapeau",
      body="Sacro Breastplate",
      hands="Gleti's Gauntlets",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Warder's Charm +1",
      waist="Carrier's Sash",
      left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
      right_ear="Etiolation Earring",
      left_ring="Defending Ring",
      right_ring="C. Palug Ring",
      back=Cape.PET_PHYS
    } 
           
    sets.idle.Reraise = set_combine(sets.idle, {head="Crepuscular Helm",body="Crepuscular Mail"})

    -- Idle Set that equips when you have a pet out and not fighting an enemy.
    sets.idle.Pet = set_combine(sets.idle, { 
      body="Totemic Jackcoat +3",
      legs="Nukumi Quijotes +3",
    })
       
    -- Idle set that equips when you have a pet out and ARE fighting an enemy.
    sets.idle.Pet.Engaged = set_combine(sets.idle, {
      ammo="Staunch Tathlum +1",
      head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}},
      body={ name="Taeon Tabard", augments={'Pet: Mag. Evasion+22','Pet: "Regen"+3','Pet: Damage taken -4%',}},
      hands={ name="Taeon Gloves", augments={'Pet: Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%',}},
      legs={ name="Taeon Tights", augments={'Pet: Mag. Evasion+23','Pet: "Regen"+3','Pet: Damage taken -4%',}},
      feet={ name="Taeon Boots", augments={'Pet: Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%',}},
      neck="Shulmanu Collar",
      waist="Isa Belt",
      left_ear="Handler's Earring +1",
      right_ear="Enmerkar Earring",
      left_ring="Thur. Ring +1",
      right_ring="Defending Ring",
      back=Cape.PET_PHYS
    })
   
    -- MELEE (SINGLE-WIELD) SETS   
    sets.engaged = {
      main="Ikenga's Axe",
      sub="Sacro Bulwark",
      ammo="Coiste Bodhar",
      head="Malignance Chapeau",
      body="Gleti's Cuirass",
      hands="Malignance Gloves",
      legs="Gleti's Breeches",
      feet="Malignance Boots",
      neck="Lissome Necklace",
      waist="Sailfi Belt +1",
      left_ear="Brutal Earring",
      right_ear="Sherida Earring",
      left_ring={name="Moonlight Ring",bag="wardrobe 6"},
      right_ring={name="Moonlight Ring",bag="wardrobe 8"},
      back=Cape.STP
    }
    
    sets.engaged.PetDT = {
      ammo="Staunch Tathlum +1",
      head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}},
      body="Totemic Jackcoat +3",
      hands="Gleti's Gauntlets",
      legs={ name="Taeon Tights", augments={'Pet: Mag. Evasion+23','Pet: "Regen"+3','Pet: Damage taken -4%',}},
      feet={ name="Taeon Boots", augments={'Pet: Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%',}},
      neck="Shulmanu Collar",
      waist="Isa Belt",
      left_ear="Handler's Earring +1",
      right_ear="Enmerkar Earring",
      left_ring="Thur. Ring +1",
      right_ring="Defending Ring",
      back=Cape.PET_PHYS
    }
               
    -- MELEE (DUAL-WIELD) SETS FOR DNC AND NIN SUBJOB   
    sets.engaged.DW = {
      ammo="Staunch Tathlum +1",
      head="Malignance Chapeau",
      body="Malignance Tabard",
      hands="Malignance Gloves",
      legs="Malignance Tights",
      feet="Malignance Boots",
      neck="Anu Torque",
      waist="Reiki Yotai",
      left_ear="Eabani Earring",
      right_ear="Sherida Earring",
      left_ring="Epona's Ring",
      right_ring="Gere Ring",
      back=Cape.STP 
    }
           
    sets.engaged.DW.PetDT = {
    }

    sets.midcast.Phalanx = {
      head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
      body={ name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}},
      hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
      legs={ name="Taeon Tights", augments={'Phalanx +3',}},
      feet={ name="Taeon Boots", augments={'Phalanx +3',}},
    }
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
    elseif macc_ready_moves:contains(spell.english) and pet.status == 'Engaged' then
      equip(sets.midcast.Pet.MaccReady)
    elseif multihit_ready_moves:contains(spell.english) and pet.status == 'Engaged' then
      equip(sets.midcast.Pet.Multihit)
    end
 
    if buffactive['Unleash'] then
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