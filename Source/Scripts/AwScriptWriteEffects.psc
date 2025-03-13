Scriptname AwScriptWriteEffects extends activemagiceffect  

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	string log = "../AlchemyHelper/Effects"
    int noDuration = 0x00000200
    int noMagnitute = 0x00000400
    int powerEffectsDuration = 0x00400000
    int powerEffectsMagnitute = 0x00200000
    Debug.Notification("Writing down ingredient effects ...")
	JsonUtil.Load(log)
	JsonUtil.ClearAll(log)
    
    int mods = Game.GetModCount()
	int n = 0
    While mods
		mods -= 1
		Form[] list = GameData.GetAllIngredients(Game.GetModName(mods))
		int ingredients = list.Length
		While ingredients
			ingredients -= 1
			Ingredient curIngredient = list[ingredients] as Ingredient

			JsonUtil.SetPathIntValue(log, "ingredients[" + n + "].formId", curIngredient.GetFormID())
			JsonUtil.SetPathStringValue(log, "ingredients[" + n + "].name", curIngredient.GetName())
			int effects = curIngredient.GetNumEffects()
			int m = 0
			While effects
				effects -= 1
				MagicEffect effect = curIngredient.GetNthEffectMagicEffect(effects)
				int duration = curIngredient.GetNthEffectDuration(effects)
				float magnitute = curIngredient.GetNthEffectMagnitude(effects)
				JsonUtil.SetPathIntValue(log, "ingredients[" + n + "].effects[" + m + "].formId", effect.GetFormID())
				JsonUtil.SetPathIntValue(log, "ingredients[" + n + "].effects[" + m + "].duration", duration)
				JsonUtil.SetPathFloatValue(log, "ingredients[" + n + "].effects[" + m + "].magnitute", magnitute)
				JsonUtil.SetPathFloatValue(log, "ingredients[" + n + "].effects[" + m + "].baseCost", effect.GetBaseCost())
				JsonUtil.SetPathIntValue(log, "ingredients[" + n + "].effects[" + m + "].noDuration", effect.IsEffectFlagSet(noDuration) as int)
				JsonUtil.SetPathIntValue(log, "ingredients[" + n + "].effects[" + m + "].noMagnitute", effect.IsEffectFlagSet(noMagnitute) as int)
				JsonUtil.SetPathIntValue(log, "ingredients[" + n + "].effects[" + m + "].powerEffectsDuration", effect.IsEffectFlagSet(powerEffectsDuration) as int)
				JsonUtil.SetPathIntValue(log, "ingredients[" + n + "].effects[" + m + "].powerEffectsMagnitute", effect.IsEffectFlagSet(powerEffectsMagnitute) as int)
				JsonUtil.SetPathStringValue(log, "ingredients[" + n + "].effects[" + m + "].name", effect.GetName())
				m += 1
			EndWhile
			n += 1
		EndWhile 
	EndWhile

	JsonUtil.Unload(log, true, true)
    Debug.Notification("Ingredient effects written")
EndEvent
