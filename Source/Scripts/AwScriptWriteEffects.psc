Scriptname AwScriptWriteEffects extends activemagiceffect  

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	string log = "AlchemyHelperEffects"
    int noDuration = 0x00000200
    int noMagnitute = 0x00000400
    int powerEffectsDuration = 0x00400000
    int powerEffectsMagnitute = 0x00200000
    Debug.Notification("Writing down ingredient effects ...")
	Debug.OpenUserLog(log)
    
    int mods = Game.GetModCount()
    While mods
		mods -= 1
		Form[] list = GameData.GetAllIngredients(Game.GetModName(mods))
		int ingridients = list.Length
		While ingridients
			ingridients -= 1
			Ingredient ingridient = list[ingridients] as Ingredient
            Debug.TraceUser(log, "Ingridient: " + ingridient.GetFormID() + ";" + ingridient.GetName())
			int effects = ingridient.GetNumEffects()
			While effects
				effects -= 1
				MagicEffect effect = ingridient.GetNthEffectMagicEffect(effects)
				int duration = ingridient.GetNthEffectDuration(effects)
				float magnitute = ingridient.GetNthEffectMagnitude(effects)
				Debug.TraceUser(log, "Effect: " + effect.GetFormID() + ";" + duration + ";" + magnitute + ";" + effect.GetBaseCost() + ";" + effect.IsEffectFlagSet(noDuration) + ";" + effect.IsEffectFlagSet(noMagnitute) + ";" + effect.IsEffectFlagSet(powerEffectsDuration) + ";" + effect.IsEffectFlagSet(powerEffectsMagnitute) + ";" + effect.GetName())
			EndWhile
		EndWhile 
	EndWhile

    Debug.Notification("Ingredient effects written")
	Debug.CloseUserLog(log)
EndEvent
