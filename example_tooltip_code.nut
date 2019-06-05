//Named Weapon tooltip mod.  Updated for Battle Brothers v1.3.0.20.

this.named_weapon <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		PrefixList = this.Const.Strings.RandomWeaponPrefix,
		NameList = [],
		UseRandomName = true,
		
		//changed
		OriginalConditionMax = 0,
		OriginalRegularDamage = 0,
		OriginalRegularDamageMax = 0,
		OriginalDirectDamageMult = 0,
		OriginalDirectDamageAdd = 0,
		OriginalArmorDamageMult = 0,
		OriginalChanceToHitHead = 0,
		OriginalStaminaModifier = 0,
		OriginalShieldDamage = 0,
		OriginalAmmoMax = 0,
		OriginalAdditionalAccuracy = 0,
		OriginalFatigueOnSkillUse = 0
	},
	
	function create()
	{
		this.weapon.create();
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Named;
		this.m.IsDroppedWhenDamaged = true;
		
		//changed
		this.m.OriginalConditionMax= this.m.ConditionMax;
		this.m.OriginalRegularDamage = this.m.RegularDamage;
		this.m.OriginalRegularDamageMax = this.m.RegularDamageMax;
		this.m.OriginalDirectDamageMult = this.m.DirectDamageMult;
		this.m.OriginalDirectDamageAdd = this.m.DirectDamageAdd;
		this.m.OriginalArmorDamageMult = this.m.ArmorDamageMult;
 		this.m.OriginalChanceToHitHead = this.m.ChanceToHitHead;
		this.m.OriginalStaminaModifier = this.m.StaminaModifier;
		this.m.OriginalShieldDamage = this.ShieldDamage;
		this.m.OriginalAmmoMax = this.AmmoMax;
		this.m.OriginalAdditionalAccuracy = this.AdditionalAccuracy;
		this.m.OriginalFatigueOnSkillUse = this.FatigueOnSkillUse;
	}

	function getRandomCharacterName( _list )
	{
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				this.Const.World.LocationNames.VillageWestern[this.Math.rand(0, this.Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(_list[this.Math.rand(0, _list.len() - 1)], vars);
	}

	function createRandomName()
	{
		if (!this.m.UseRandomName || this.Math.rand(1, 100) <= 60)
		{
			return this.m.PrefixList[this.Math.rand(0, this.m.PrefixList.len() - 1)] + " ";
		}
		else if (this.Math.rand(1, 2) == 1)
		{
			return this.getRandomCharacterName(this.Const.Strings.KnightNames) + "\'s ";
		}
		else
		{
			return this.getRandomCharacterName(this.Const.Strings.BanditLeaderNames) + "\'s ";
		}
	}

	function onEquip()
	{
		this.weapon.onEquip();

		if (this.m.Name.len() == 0)
		{
			if (this.Math.rand(1, 100) <= 25)
			{
				this.setName(this.getContainer().getActor().getName() + "\'s ");
			}
			else
			{
				this.setName(this.createRandomName());
			}
		}
	}

	function onAddedToStash( _stashID )
	{
		if (this.m.Name.len() == 0)
		{
			this.setName(this.createRandomName());
		}
	}

	function setName( _prefix = "" )
	{
		this.m.Name = _prefix + this.m.NameList[this.Math.rand(0, this.m.NameList.len() - 1)];
	}

	function randomizeValues()
	{
		this.m.Condition = this.Math.round(this.m.Condition * this.Math.rand(90, 140) * 0.01) * 1.0;
		this.m.ConditionMax = this.m.Condition;
		local available = [];
		available.push(function ( _i )
		{
			local f = this.Math.rand(110, 130) * 0.01;
			_i.m.RegularDamage = this.Math.round(_i.m.RegularDamage * f);
			_i.m.RegularDamageMax = this.Math.round(_i.m.RegularDamageMax * f);
		});
		available.push(function ( _i )
		{
			_i.m.ArmorDamageMult = _i.m.ArmorDamageMult + this.Math.rand(10, 30) * 0.01;
		});

		if (this.m.ChanceToHitHead > 0)
		{
			available.push(function ( _i )
			{
				_i.m.ChanceToHitHead = _i.m.ChanceToHitHead + this.Math.rand(10, 20);
			});
		}

		available.push(function ( _i )
		{
			_i.m.DirectDamageAdd = _i.m.DirectDamageAdd + this.Math.rand(8, 16) * 0.01;
		});

		if (this.m.StaminaModifier <= -10)
		{
			available.push(function ( _i )
			{
				_i.m.StaminaModifier = this.Math.round(_i.m.StaminaModifier * this.Math.rand(50, 80) * 0.01);
			});
		}

		if (this.m.ShieldDamage >= 16)
		{
			available.push(function ( _i )
			{
				_i.m.ShieldDamage = this.Math.round(_i.m.ShieldDamage * this.Math.rand(133, 180) * 0.01);
			});
		}

		if (this.m.AmmoMax > 0)
		{
			available.push(function ( _i )
			{
				_i.m.AmmoMax = _i.m.AmmoMax + this.Math.rand(1, 3);
				_i.m.Ammo = _i.m.AmmoMax;
			});
		}

		if (this.m.AdditionalAccuracy != 0 || this.isItemType(this.Const.Items.ItemType.RangedWeapon))
		{
			available.push(function ( _i )
			{
				_i.m.AdditionalAccuracy = _i.m.AdditionalAccuracy + this.Math.rand(5, 15);
			});
		}

		available.push(function ( _i )
		{
			_i.m.FatigueOnSkillUse = _i.m.FatigueOnSkillUse - this.Math.rand(1, 3);
		});

		for( local n = 2; n != 0 && available.len() != 0; n = --n )
		{
			local r = this.Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
		}
	}
	
	//function added (base copied from weapon.nut)
	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 65,
			type = "text",
			text = this.m.Categories
		});
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.ConditionMax > 1)
		{
			//changed!
			if (this.m.OriginalConditionMax != this.m.ConditionMax)
			{
				result.push({
					id = 4,
					type = "progressbar",
					icon = "ui/icons/asset_supplies.png",
					value = this.m.Condition,
					valueMax = this.m.ConditionMax,
					text = "" + this.m.Condition + " / " + this.m.ConditionMax + " (" + (this.m.ConditionMax - this.m.OriginalConditionMax) + ")",
					style = "armor-body-slim"
				});
			}
			else //original text
			{
				result.push({
				id = 4,
				type = "progressbar",
				icon = "ui/icons/asset_supplies.png",
				value = this.m.Condition,
				valueMax = this.m.ConditionMax,
				text = "" + this.m.Condition + " / " + this.m.ConditionMax + "",
				style = "armor-body-slim"
				});
			}
		}

		if (this.m.RegularDamage > 0)
		{
			//changed!
			if (this.m.OriginalRegularDamage != this.m.RegularDamage && this.m.OriginalRegularDamageMax != this.m.RegularDamageMax)
			{
				result.push({
					id = 4,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamage - this.m.OriginalRegularDamage) + "[/color]) - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamageMax - this.m.OriginalRegularDamageMax) + "[/color])"
				});
			}
			else if (this.m.OriginalRegularDamage != this.m.RegularDamage && this.m.OriginalRegularDamageMax == this.m.RegularDamageMax)
			{
				result.push({	
					id = 4,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamage - this.m.OriginalRegularDamage) + "[/color]) - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color]"
				});
			}
			else if (this.m.OriginalRegularDamage == this.m.RegularDamage && this.m.OriginalRegularDamageMax != this.m.RegularDamageMax)
			{
				result.push({	
					id = 4,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamageMax - this.m.OriginalRegularDamageMax) + "[/color])"
				});
			}
			else //original text
			{
				result.push({	
					id = 4,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color]"
				});
			}
		}

		if (this.m.DirectDamageMult > 0)
		{
			//changed!
			if (this.m.OriginalDirectDamageMult != this.m.DirectDamageMult || this.m.OriginalDirectDamageAdd != this.m.DirectDamageAdd)
			{
				result.push({
					id = 64,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor((this.m.DirectDamageMult + this.m.DirectDamageAdd) * 100) + "%[/color] of damage ignores armor ([color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor((this.m.DirectDamageMult - this.m.OriginalDirectDamageMult + this.m.DirectDamageAdd - this.m.OriginalDirectDamageAdd) * 100) + "%[/color])"
				});
			}
			else //original text
			{
				result.push({
					id = 64,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor((this.m.DirectDamageMult + this.m.DirectDamageAdd) * 100) + "%[/color] of damage ignores armor"
				});
			}
		}

		if (this.m.ArmorDamageMult > 0)
		{
			//changed!
			if (this.m.OriginalArmorDamageMult != this.m.ArmorDamageMult)
			{
				result.push({
					id = 5,
					type = "text",
					icon = "ui/icons/armor_damage.png",
					text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor(this.m.ArmorDamageMult * 100) + "%[/color] effective against armor ([color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor((this.m.ArmorDamageMult - this.m.OriginalArmorDamageMult) * 100) + "%[/color])"
				});
			}
			else //original text
			{
				result.push({
					id = 5,
					type = "text",
					icon = "ui/icons/armor_damage.png",
					text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor(this.m.ArmorDamageMult * 100) + "%[/color] effective against armor"
				});
			}
		}

		if (this.m.ShieldDamage > 0)
		{
			//changed!
			if (this.m.OriginalShieldDamage != this.m.ShieldDamage)
			{
				result.push({
					id = 6,
					type = "text",
					icon = "ui/icons/shield_damage.png",
					text = "Shield damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.ShieldDamage + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.ShieldDamage - this.m.OriginalShieldDamage) + "[/color])"
				});
			}
			else //original text
			{
				result.push({
					id = 6,
					type = "text",
					icon = "ui/icons/shield_damage.png",
					text = "Shield damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.ShieldDamage + "[/color]"
				});
			}
		}

		if (this.m.ChanceToHitHead > 0)
		{
			//changed!
			if (this.m.OriginalChanceToHitHead != this.m.ChanceToHitHead)
			{
				result.push({
					id = 9,
					type = "text",
					icon = "ui/icons/chance_to_hit_head.png",
					text = "Chance to hit head [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ChanceToHitHead + "%[/color] (+" + (this.m.ChanceToHitHead - this.m.OriginalChanceToHitHead) + "%)"
				});
			}
			else //original text
			{
				result.push({
					id = 9,
					type = "text",
					icon = "ui/icons/chance_to_hit_head.png",
					text = "Chance to hit head [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ChanceToHitHead + "%[/color]"
				});
			}
		}

		if (this.m.AdditionalAccuracy > 0)
		{
			//changed!
			if (this.m.OriginalAdditionalAccuracy != this.m.AdditionalAccuracy)
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "Has an additional [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] chance to hit ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.AdditionalAccuracy - this.m.OriginalAdditionalAccuracy) + "%[/color])"
				});
			}
			else //original text
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "Has an additional [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] chance to hit"
				});
			}
		}
		else if (this.m.AdditionalAccuracy < 0)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has an additional [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.AdditionalAccuracy + "%[/color] chance to hit"
			});
		}

		if (this.m.RangeMax > 1)
		{
			result.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getRangeMax() + "[/color] tiles"
			});
		}

		if (this.m.StaminaModifier < 0)
		{
			//changed!
			if (this.m.OriginalStaminaModifier != this.m.StaminaModifier)
			{
				result.push({
					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Maximum Fatigue [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.OriginalStaminaModifier - this.m.StaminaModifier) + "[/color])"
				});
			}
			else //original text
			{
				result.push({
					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Maximum Fatigue [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
				});
			}
		}

		if (this.m.FatigueOnSkillUse > 0)
		{
			//changed!
			if (this.m.OriginalFatigueOnSkillUse != this.m.FatigueOnSkillUse)
			{
				result.push({
					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Weapon skills build up [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.FatigueOnSkillUse + "[/color] more fatigue ([color=" +  this.Const.UI.Color.PositiveValue + "]" + (this.m.FatigueOnSkillUse - this.m.OriginalFatigueOnSkillUse) + "[/color])"
				});
			}
			else //original text
			{
				result.push({
					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Weapon skills build up [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.FatigueOnSkillUse + "[/color] more fatigue"
				});
			}
		}
		else if (this.m.FatigueOnSkillUse < 0)
		{
			//changed!
			if (this.m.OriginalFatigueOnSkillUse != this.m.FatigueOnSkillUse)
			{
				result.push({
					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Weapon skills build up [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.FatigueOnSkillUse + "[/color] less fatigue ([color=" + this.Const.UI.Color.PositiveValue + "]" + (this.m.FatigueOnSkillUse - this.m.OriginalFatigueOnSkillUse) + "[/color])"
				});
			}
			else //original text
			{
				result.push({
					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Weapon skills build up [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.FatigueOnSkillUse + "[/color] less fatigue"	
				});
			}
		}

		if (this.m.AmmoMax > 0)
		{
			if (this.m.Ammo != 0)
			{
				//changed!
				if (this.m.OriginalAmmoMax != this.m.AmmoMax)
				{
					result.push({
						id = 10,
						type = "text",
						icon = "ui/icons/ranged_skill.png",
						text = "Contains ammo for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] uses ([color=" + this.Const.UI.Color.PositiveValue + "]+" (this.m.AmmoMax - this.m.OriginalAmmoMax) + "[/color])"
					});
				}
				else //original text
				{
					result.push({
						id = 10,
						type = "text",
						icon = "ui/icons/ranged_skill.png",
						text = "Contains ammo for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] uses"
					});
				}
			}
			else
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]Is empty and useless[/color]"
				});
			}
		}
	}

	function onSerialize( _out )
	{
		_out.writeString(this.m.Name);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		_out.writeU16(this.m.RegularDamage);
		_out.writeU16(this.m.RegularDamageMax);
		_out.writeF32(this.m.ArmorDamageMult);
		_out.writeU8(this.m.ChanceToHitHead);
		_out.writeU16(this.m.ShieldDamage);
		_out.writeU16(this.m.AdditionalAccuracy);
		_out.writeF32(this.m.DirectDamageAdd);
		_out.writeI16(this.m.FatigueOnSkillUse);
		_out.writeU16(this.m.AmmoMax);
		_out.writeF32(0);
		this.weapon.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.Name = _in.readString();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();
		this.m.RegularDamage = _in.readU16();
		this.m.RegularDamageMax = _in.readU16();
		this.m.ArmorDamageMult = _in.readF32();
		this.m.ChanceToHitHead = _in.readU8();
		this.m.ShieldDamage = _in.readU16();
		this.m.AdditionalAccuracy = _in.readU16();
		this.m.DirectDamageAdd = _in.readF32();
		this.m.FatigueOnSkillUse = _in.readI16();
		this.m.AmmoMax = _in.readU16();
		_in.readF32();
		this.weapon.onDeserialize(_in);
		this.updateVariant();
	}

});

