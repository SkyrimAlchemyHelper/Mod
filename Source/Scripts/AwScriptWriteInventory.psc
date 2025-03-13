Scriptname AwScriptWriteInventory extends activemagiceffect  


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	string log = "../AlchemyHelper/Inventory"
    Debug.Notification("Writing down ingredients ...")
	JsonUtil.Load(log)
	JsonUtil.ClearAll(log)
    
	Actor player = Game.GetPlayer()
    int mods = Game.GetModCount()
	int n = 0
    While mods
		mods -= 1
		Form[] list = GameData.GetAllIngredients(Game.GetModName(mods))
		int ingredients = list.Length
		While ingredients
			ingredients -= 1
			Ingredient curIngredient = list[ingredients] as Ingredient
			int count = player.GetItemCount(curIngredient)
			If count > 0
				JsonUtil.SetPathIntValue(log, "inventory[" + n + "].formId", curIngredient.GetFormID())
				JsonUtil.SetPathIntValue(log, "inventory[" + n + "].count", count)
				n += 1
			EndIF
		EndWhile 
	EndWhile

	JsonUtil.Unload(log, true, true)
    Debug.Notification("Ingredients written")
EndEvent