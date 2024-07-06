using Godot;
using System;
using System.Collections.Generic;

public partial class IngredientList : ItemList {
	private Texture2D _icon = GD.Load<Texture2D>("res://icon.svg");


	/*a list of strings that stores the order of the vegetables (name only) with a getter*/
	private List<string> _vegetables = new List<string>();
	public List<string> vegetables {
		get { return this._vegetables; }
	}
	private void _ready() {
		PlayerIngredients playerIngredients = GetNode<PlayerIngredients>($"../../PlayerIngerdients");

		playerIngredients.Connect("updateList", new Callable(this, nameof(UpdateIngredientList)));
	}

	private void UpdateIngredientList(string name, int count, int totalCount) {
		bool found = false;

		if(this.ItemCount == 0) {   /*since the list is empty, push the first item first before entering the for loop*/
			this.AddItem(name, this._icon, true);
			this._vegetables.Add(name);
		}

		/* iterate through the entire list first before deciding to add the vegetable. if found, don't add*/
		for(int i = 0; i < this.ItemCount; i++) {
			string itemName = this.GetItemText(i);

			if (itemName == name) {
				if(count == 0) {        /*remove from itemlist and the from the list defined in this code*/
					this.RemoveItem(i); 
					this._vegetables.Remove(name);
				}
				else {
					this.SetItemText(i, name);
					
				}
				found = true;
			}
		}

		if(!found) {
			this.AddItem(name, this._icon, true);
			this._vegetables.Add(name);
		}
		
	}
}
