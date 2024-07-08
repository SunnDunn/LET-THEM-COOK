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

	[Export] private Label _successLabel;

	private void _ready() {
		this._successLabel.Text = "";
	}


	private void _on_player_ingerdients_update_list(string name, long count, long totalCount) {
		bool found = false;

		RecipeVegetable vegetable = new RecipeVegetable();
		vegetable.vegName = name;
		vegetable.vegAmount = (int)count;

		/* iterate through the entire list first before deciding to add the vegetable. if found, don't add*/
		for (int i = 0; i < this.ItemCount; i++) {
			string itemName = this.GetItemText(i);
			string[] cleaned = itemName.Split(new char[] { ' ' });
			itemName = cleaned[0];

			if (itemName == name) {
				if (count == 0) {        /*remove from itemlist and the from the list defined in this code*/
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

		if (!found && count != 0) {
			name = name + " x" + vegetable.vegAmount;
			this.AddItem(name, this._icon, true);
			this._vegetables.Add(vegetable);
		}

	}
	private void _on_cook_button_pressed(){
		if (this._vegetables == null) return;

		// for(int i = 0; i < this._vegetables.Count; i++) {
		// 	GD.Print($"Adding {this._vegetables[i].vegName} x{this._vegetables[i].vegAmount}");
		// }

		if (this._vegetables.Count == 1){
			this._successLabel.Text = "Success";
			return;
		}

		float totalVeggies = 0;
		foreach (RecipeVegetable veggie in this._vegetables){
			totalVeggies += veggie.vegAmount;
		}

		//GD.Print("Total veggies: " + totalVeggies);

		bool cookSuccessfull = true;
		foreach (RecipeVegetable veggie in this._vegetables){
			//GD.Print(veggie.vegName + " x" + veggie.vegAmount);
			if (veggie.vegAmount > (totalVeggies / 2) + 0.5f) cookSuccessfull = false;
		}

		if (cookSuccessfull) this._successLabel.Text = "Success";
		else this._successLabel.Text = "FAILURE!";

	}

	private void _on_reset_button_pressed(){
		this._successLabel.Text = "";
		this._vegetables.Clear();
	}
}


