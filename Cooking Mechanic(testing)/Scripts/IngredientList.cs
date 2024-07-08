using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

public partial class IngredientList : ItemList {
	private Texture2D _icon = GD.Load<Texture2D>("res://icon.svg");


	/*a list of strings that stores the order of the vegetables (name only) with a getter*/
	private List<string> _vegetables = new List<string>();
	private List<RecipeVegetable>  _recipeVegetables = new List<RecipeVegetable>();
	public List<string> vegetables {
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

		//if(this.ItemCount == 0) {   /*since the list is empty, push the first item first before entering the for loop*/
		//	this.AddItem(name, this._icon, true);
		//	this._vegetables.Add(name);
		//	this._recipeVegetables.Add(vegetable);
		//}

		/* iterate through the entire list first before deciding to add the vegetable. if found, don't add*/
		for(int i = 0; i < this.ItemCount; i++) {
			string itemName = this.GetItemText(i);

			if (itemName == name) {
				if(count == 0) {        /*remove from itemlist and the from the list defined in this code*/
					this.RemoveItem(i); 
					this._vegetables.Remove(name);
				}
				else {
					name = name + " x" + vegetable.vegAmount;
					this.SetItemText(i, name);
					this._recipeVegetables[i] = vegetable;
					
				}
				found = true;
			}
		}

		if(!found) {
			name = name + " x" + vegetable.vegAmount;
			this.AddItem(name, this._icon, true);
			this._vegetables.Add(name);
			this._recipeVegetables.Add(vegetable);
		}
		
	}
	
	private void _on_cook_button_pressed(){
		if (this._vegetables == null) return;

		for(int i = 0; i < this._recipeVegetables.Count; i++) {
			GD.Print($"Adding {this._recipeVegetables[i].vegName} x{this._recipeVegetables[i].vegAmount}");
		}
		
		//foreach (string ing in this._vegetables){
		//	GD.Print("Adding " + ing);
		//	this._ingredientAmount[ing]++;
		//}

		//GD.Print("Bok Choy: " + this._ingredientAmount["Bok Choy"]);
	}
}
