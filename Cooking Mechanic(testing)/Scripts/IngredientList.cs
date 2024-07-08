using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

public partial class IngredientList : ItemList {
	private Texture2D _icon = GD.Load<Texture2D>("res://icon.svg");


	/*a list of vegettables that stores the order with a getter*/
	private List<RecipeVegetable> _vegetables = new List<RecipeVegetable>();
	public List<RecipeVegetable> vegetables {
		get { return this._vegetables; }
	}

	private Dictionary<string, int> _ingredientAmount = new Dictionary<string, int>();

	private void _ready() {
		PlayerIngredients playerIngredients = GetNode<PlayerIngredients>($"../../PlayerIngerdients");

		playerIngredients.Connect("updateList", new Callable(this, nameof(UpdateIngredientList)));

		//initialize dictionary of ingredient amount
		this._ingredientAmount.Add("Radish", 0);
		this._ingredientAmount.Add("Bok Choy", 0);
		this._ingredientAmount.Add("Cabbage", 0);
		this._ingredientAmount.Add("Lettuce", 0);
	}

	private void UpdateIngredientList(string name, int count, int totalCount) {
		bool found = false;

		RecipeVegetable vegetable = new RecipeVegetable();
		vegetable.vegName = name;
		vegetable.vegAmount = count;

		/* iterate through the entire list first before deciding to add the vegetable. if found, don't add*/
		for(int i = 0; i < this.ItemCount; i++) {
			string itemName = this.GetItemText(i);
			string[] cleaned = itemName.Split(new char[] { ' ' });
			itemName = cleaned[0];

			if (itemName == name) {
				if(count == 0) {        /*remove from itemlist and the from the list defined in this code*/
					this.RemoveItem(i);
					this._vegetables.Remove(this._vegetables[i]);
				}
				else {
					name = name + " x" + vegetable.vegAmount;
					this.SetItemText(i, name);
					this._vegetables[i] = vegetable;
					
				}
				found = true;
			}
		}

		if(!found) {
			name = name + " x" + vegetable.vegAmount;
			this.AddItem(name, this._icon, true);
			this._vegetables.Add(vegetable);
		}
		
	}
	
	private void _on_cook_button_pressed(){
		if (this._vegetables == null) return;

		for(int i = 0; i < this._vegetables.Count; i++) {
			GD.Print($"Adding {this._vegetables[i].vegName} x{this._vegetables[i].vegAmount}");
		}
	}
}
