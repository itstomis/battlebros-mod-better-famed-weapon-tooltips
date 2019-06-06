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
		if (this.m.ConditionMax > ORIGINALConditionMax)
		{
			result.push({
				id = 4,
				type = "progressbar",
				icon = "ui/icons/asset_supplies.png",
				value = this.m.Condition,
				valueMax = this.m.ConditionMax,
				text = "" + this.m.Condition + " / " + this.m.ConditionMax + " (+" + (this.m.ConditionMax - ORIGINALConditionMax) + ")",
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
				text = "" + this.m.Condition + " / " + this.m.ConditionMax + " (" + (this.m.ConditionMax - ORIGINALConditionMax) + ")",
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
		if (this.m.RegularDamage != ORIGINALRegularDamage && this.m.RegularDamageMax != ORIGINALRegularDamageMax)
		{
			result.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamage - ORIGINALRegularDamage) + "[/color]) - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamageMax - ORIGINALRegularDamageMax) + "[/color])"
			});
		}
		else if (this.m.RegularDamage != ORIGINALRegularDamage && this.m.RegularDamageMax == ORIGINALRegularDamageMax)
		{
			result.push({	
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamage - ORIGINALRegularDamage) + "[/color]) - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color]"
			});
		}
		else if (this.m.RegularDamage == ORIGINALRegularDamage && this.m.RegularDamageMax != ORIGINALRegularDamageMax)
		{
			result.push({	
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.RegularDamageMax - ORIGINALRegularDamageMax) + "[/color])"
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
		if (this.m.DirectDamageMult != ORIGINALDirectDamageMult || this.m.DirectDamageAdd != ORIGINALDirectDamageAdd)
		{
			result.push({
				id = 64,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor((this.m.DirectDamageMult + this.m.DirectDamageAdd) * 100) + "%[/color] of damage ignores armor ([color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor((this.m.DirectDamageMult - ORIGINALDirectDamageMult + this.m.DirectDamageAdd - ORIGINALDirectDamageAdd) * 100) + "%[/color])"
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
		if (this.m.ArmorDamageMult != ORIGINALArmorDamageMult)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor(this.m.ArmorDamageMult * 100) + "%[/color] effective against armor ([color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor((this.m.ArmorDamageMult - ORIGINALArmorDamageMult) * 100) + "%[/color])"
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
		if (this.m.ShieldDamage != ORIGINALShieldDamage)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/shield_damage.png",
				text = "Shield damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.ShieldDamage + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.ShieldDamage - ORIGINALShieldDamage) + "[/color])"
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
		if (this.m.ChanceToHitHead != ORIGINALChanceToHitHead)
		{
			result.push({
				id = 9,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Chance to hit head [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ChanceToHitHead + "%[/color] (+" + (this.m.ChanceToHitHead - ORIGINALChanceToHitHead) + "%)"
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
		if (this.m.AdditionalAccuracy != ORIGINALAdditionalAccuracy)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has an additional [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] chance to hit ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.AdditionalAccuracy - ORIGINALAdditionalAccuracy) + "%[/color])"
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
		if (this.m.StaminaModifier != ORIGINALStaminaModifier)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color] ([color=" + this.Const.UI.Color.PositiveValue + "]+" + (ORIGINALStaminaModifier - this.m.StaminaModifier) + "[/color])"
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
		if (this.m.FatigueOnSkillUse != ORIGINALFatigueOnSkillUse)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weapon skills build up [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.FatigueOnSkillUse + "[/color] more fatigue ([color=" +  this.Const.UI.Color.PositiveValue + "]" + (this.m.FatigueOnSkillUse - ORIGINALFatigueOnSkillUse) + "[/color])"
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
		if (this.m.FatigueOnSkillUse != ORIGINALFatigueOnSkillUse)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weapon skills build up [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.FatigueOnSkillUse + "[/color] less fatigue ([color=" + this.Const.UI.Color.PositiveValue + "]" + (this.m.FatigueOnSkillUse - ORIGINALFatigueOnSkillUse) + "[/color])"
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
			if (this.m.AmmoMax != ORIGINALAmmoMax)
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "Contains ammo for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] uses ([color=" + this.Const.UI.Color.PositiveValue + "]+" (this.m.AmmoMax - ORIGINALAmmoMax) + "[/color])"
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