-- Released under Modified BSD

ProbablyEngine.rotation.register_custom(270, 'Tao\'s Mistweaver', {
  -- ** Modifiers
  { 'Summon Jade Serpent Statue', 'modifier.lalt', 'ground' },
  { 'Healing Sphere', 'modifier.lshift', 'ground' },
  { 'Charging Ox Wave', 'modifier.rshift' },
 
  -- ** DEFENSIVES

  -- Fortifying Brew if you get low. 
  { 'Fortifying Brew', {
    'toggle.defensive',
    'modifier.cooldowns',
    'player.health < 40',
    '!player.buff(Diffuse Magic)',
    '!player.buff(Dampen Harm)'
  }},

  -- Diffuse Magic if you get low. Talent
  { 'Diffuse Magic', {
    'toggle.defensive',
    'player.health < 50',
    '!player.buff(Fortifying Brew)',
    '!player.buff(Dampen Harm)'
  }},

  -- Dampen Harm if you get low. Talent
  { 'Dampen Harm', {
    'toggle.defensive',
    'player.health < 60',
    '!player.buff(Fortifying Brew)',
    '!player.buff(Diffuse Magic)',
  }},

	-- Insta-kill single target when available 
  { 'Touch of Death', {
    'modifier.cooldowns',
    'player.buff(Death Note)'
  }},

  -- Interrupts
  { 'Spear Hand Strike', { 'modifier.interrupts', '@mistweaver.interrupt()' }, nil },
  { 'Charging Ox Wave', { 'modifier.interrupts', '@mistweaver.interrupt()' }, nil },
  { 'Charging Ox Wave', { 'modifier.interrupts', 'modifier.enemies > 3' }, nil },

  -- { 'Grapple Weapon', { '@mistweaver.grappleWeapon(92)' }, nil },

	-- Thunder Focus Tea on CD 
  { 'Thunder Focus Tea', 'modifier.cooldowns' },

	-- Life Cocoon on the tank if he's low. 
  { 'Life Cocoon', { 'modifier.cooldowns', 'tank.health < 10' }, 'tank' },

  -- Detox if needed. 
  { '!Detox', { 'player.buff(Gift of the Titans)', '@coreHealing.needsDispelled("Mark of Arrogance")' }, nil },
  { '!Detox', '@coreHealing.needsDispelled("Shadow Word: Bane")', nil },
  { '!Detox', '@coreHealing.needsDispelled("Corrosive Blood")', nil },
  { '!Detox', { 'toggle.detox', '@mistweaver.detox()' }, nil },

  { 'Mana Tea', {
    'player.buff(Mana Tea).count >= 2',
    'player.mana <= 90'
  }},

  { 'Surging Mist', {
    'player.buff(Vital Mists).count = 5',
    '@mistweaver.surgingMist()'
  }, nil },

  { 'Renewing Mist', {
    'toggle.renewingmists',
    'player.chi < 5',
    '@mistweaver.renewingMist()'
  }, nil },
  { 'Expel Harm', {
    'player.chi < 5',
    '!toggle.generatechi',
    'player.health < 99',
  }},
  { 'Expel Harm', {
    'player.chi < 5',
    'toggle.generatechi',
  }},

  -- { '#trinket1', 'player.mana <= 90' },

  -- Fistweave
  {{
    { 'Renewing Mist', 'player.chi < 5' },

    { 'Chi Wave' },

    { 'Invoke Xuen, the White Tiger', 'modifier.cooldowns' },

    { 'Blackout Kick', '!player.buff(Serpent\'s Zeal)' },
    { 'Tiger Palm', '!player.buff(Tiger Power)' },

    { 'Blackout Kick', 'player.buff(Muscle Memory)' },
    { 'Tiger Palm', 'player.buff(Muscle Memory)' },

    { 'Jab' },
  }, 'toggle.fistweaving' },

  -- Mistweave
  { 'Invoke Xuen, the White Tiger', 'modifier.cooldowns', 'tank.health < 35', 'tank.target' },

  { 'Renewing Mist', '@coreHealing.needsHealing(85, 3)', nil },
  { 'Revival', { 'modifier.cooldowns', '@coreHealing.needsHealing(50, 15)' }, nil },
  { 'Uplift', { 'player.chi >= 2', '@mistweaver.uplift(90000)' }, nil },
  { 'Uplift', { 'player.chi >= 5', '@mistweaver.uplift(40000)' }, nil },
  { 'Uplift', { 'player.chi >= 2', '@coreHealing.needsHealing(65, 10)' }, nil },

  { 'Zen Sphere', 'tank.health < 85', 'tank' },
  { 'Chi Burst', 'tank.health < 85', 'tank' },

  { 'Tiger Palm', '!player.buff(Tiger Power)' },
  { 'Tiger Palm', 'player.buff(Tiger Power).duration <= 2' },

  { 'Blackout Kick', '!player.buff(Serpent\'s Zeal)' },
  { 'Blackout Kick', 'player.buff(Serpent\'s Zeal).duration <= 5' },

  { 'Spinning Crane Kick', { 'modifier.multitarget', 'player.mana > 55', 'player.chi < 4', '@mistweaver.spinningCraneKick(3)' }, nil },

  { 'Chi Wave', 'lowest.health < 95' },

  { 'Surging Mist', { '!player.moving', 'player.casting(Soothing Mist)', 'player.chi < 5', '@mistweaver.soothingTarget(50)' }, nil}, -- 0.3
  { 'Enveloping Mist', { '!player.moving', 'player.casting(Soothing Mist)', 'player.chi >= 3', '!focus.buff(Enveloping Mist)', '@mistweaver.soothingTarget(75)' }, nil},
  { 'Soothing Mist', { '!player.moving', '@mistweaver.soothingMist(90, 95, 65)' }, nil },

  { 'Jab', { '!player.casting(Soothing Mist)', 'player.buff(Tiger Power)', 'player.buff(Serpent\'s Zeal)' }},
  { 'Tiger Palm', { '!player.casting(Soothing Mist)', 'lowest.health < 85', 'player.chi >= 2' }}, 
}, {
  -- Buffs
  { 'Legacy of the Emperor', { '!player.buff(Legacy of the Emperor).any', '!player.buff(Mark of the Wild).any', '!player.buff(Blessing of Kings).any', '!player.buff(Embrace of the Shale Spider).any' }},
  { 'Summon Jade Serpent Statue', 'modifier.lalt', 'ground' },
}, function ()
  ProbablyEngine.toggle.create('defensive', 'Interface\\Icons\\ability_monk_fortifyingale_new', 'Defensive Abilities', '')
  ProbablyEngine.toggle.create('detox', 'Interface\\Icons\\Spell_Holy_DispelMagic', 'Detox Everything', '')
  ProbablyEngine.toggle.create('fistweaving', 'Interface\\Icons\\ability_monk_tigerpalm', 'Fistweave', '')
  ProbablyEngine.toggle.create('renewingmists', 'Interface\\Icons\\ability_monk_renewingmists', 'Renewing', '')
  ProbablyEngine.toggle.create('generatechi', 'Interface\\Icons\\ability_Monk_ChiBrew', 'Generate Chi', '')
end)
