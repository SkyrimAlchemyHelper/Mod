Scriptname AwScriptWriteInventory extends activemagiceffect  


Event OnEffectFinish(Actor akTarget, Actor akCaster)
	string log = "AlchemyHelperIngridients"
    Debug.Notification("Writing down ingredients ...")
	Debug.OpenUserLog(log)
    
	Actor player = Game.GetPlayer()
    int mods = Game.GetModCount()
    While mods
		mods -= 1
		Form[] list = GameData.GetAllIngredients(Game.GetModName(mods))
		int ingridients = list.Length
		While ingridients
			ingridients -= 1
			int count = player.GetItemCount(list[ingridients])
			If count > 0
            	Debug.TraceUser(log, "Ingridient: " + list[ingridients].GetFormID() + ";" + count)
			EndIF
		EndWhile 
	EndWhile

    Debug.Notification("Ingredients written")
	Debug.CloseUserLog(log)
EndEvent