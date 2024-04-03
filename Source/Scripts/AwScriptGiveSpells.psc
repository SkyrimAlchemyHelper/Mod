Scriptname AwScriptGiveSpells extends Quest  

SPELL Property EffectsSpells  Auto  

SPELL Property InventorySpell  Auto  


Event OnInit()
    Actor player = Game.GetPlayer()
    player.AddSpell(EffectsSpells)
    player.AddSpell(InventorySpell)
EndEvent
