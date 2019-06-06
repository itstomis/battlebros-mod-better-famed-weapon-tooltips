this.named_two_handed_hammer <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = this.Math.rand(1, 3);
		this.updateVariant();
		this.m.ID = "weapon.named_two_handed_hammer";
		this.m.NameList = this.Const.Strings.HammerNames;
		this.m.Description = "A massive hammer that is surprisingly well-balanced, despite its huge weight. What it lacks in grace, it makes up for in raw force as it is used to shatter even heavily-armored enemy lines by knocking people away or to the ground.";
		this.m.Categories = "Hammer, Two-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 4000;
		this.m.ShieldDamage = 26;
		this.m.Condition = 120.0;
		this.m.ConditionMax = 120.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 2.0;
		this.m.DirectDamageMult = 0.5;
		this.m.ChanceToHitHead = 0;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/hammer_two_handed_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/hammer_two_handed_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_named_hammer_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/smite_skill"));
		this.addSkill(this.new("scripts/skills/actives/shatter_skill"));
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 5);
		this.addSkill(skillToAdd);
	}
	
	//function base copied from weapon.nut
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
			if (this.m.ConditionMax > 120.0)
			{
				result.push({
					id = 4,
					type = "progressbar",
					icon = "ui/icons/asset_supplies.png",
					value = this.m.Condition,
					valueMax = this.m.ConditionMax,
					text = "" + this.m.Condition + " / " + this.m.ConditionMax + " (+" + (this.m.ConditionMax - 120.0) + ")",
					style = "armor-body-slim"
				});
			}
			//changed!
			else if (this.m.ConditionMax < ORIGINALConditionMax)
			{
				result.push({
					id = 4,
					type = "progressbar",
					icon = "ui/icons/asset_supplies.png",
					value = this.m.Condition,
					valueMax = this.m.ConditionMax,
					text = "" + this.m.Condition + " / " + this.m.ConditionMax + " (" + (this.m.ConditionMax - 120.0) + ")",
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
			if (this.m.RegularDamage != 60 && this.m.RegularDamageMax != 90)
			{
				result.push({
					id = 4,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamage - 60) + "[/color]) - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamageMax - 90) + "[/color])"
				});
			}
			else if (this.m.RegularDamage != 60 && this.m.RegularDamageMax == 90)
			{
				result.push({	
					id = 4,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamage - 60) + "[/color]) - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color]"
				});
			}
			else if (this.m.RegularDamage == 60 && this.m.RegularDamageMax != 90)
			{
				result.push({	
					id = 4,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamageMax - 90) + "[/color])"
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
			if (this.m.DirectDamageMult != 0.5)
			{
				result.push({
					id = 64,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor((this.m.DirectDamageMult + this.m.DirectDamageAdd) * 100) + "%[/color] of damage ignores armor ([color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor((this.m.DirectDamageMult - 0.5 + this.m.DirectDamageAdd) * 100) + "%[/color])"
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
			if (this.m.ArmorDamageMult != 2.0)
			{
				result.push({
					id = 5,
					type = "text",
					icon = "ui/icons/armor_damage.png",
					text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor(this.m.ArmorDamageMult * 100) + "%[/color] effective against armor ([color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor((this.m.ArmorDamageMult - 2.0) * 100) + "%[/color])"
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
			if (this.m.ShieldDamage != 26)
			{
				result.push({
					id = 6,
					type = "text",
					icon = "ui/icons/shield_damage.png",
					text = "Shield damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.ShieldDamage + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.ShieldDamage - 26) + "[/color])"
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

		if (this.m.StaminaModifier < 0)
		{
			//changed!
			if (this.m.StaminaModifier != -18)
			{
				result.push({
					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Maximum Fatigue [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.StaminaModifier - -18) + "[/color])"
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
			if (this.m.FatigueOnSkillUse != 0)
			{
				result.push({
					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Weapon skills build up [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.FatigueOnSkillUse + "[/color] more fatigue ([color=" +  this.Const.UI.Color.PositiveValue + "]" + (this.m.FatigueOnSkillUse - 0) + "[/color])"
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
			if (this.m.FatigueOnSkillUse != 0)
			{
				result.push({
					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Weapon skills build up [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.FatigueOnSkillUse + "[/color] less fatigue ([color=" + this.Const.UI.Color.PositiveValue + "]" + (this.m.FatigueOnSkillUse - 0) + "[/color])"
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
	}
});
