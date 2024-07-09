using Godot;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Xml.Linq;

public partial class PlayerIngredients : Godot.ItemList {
	

	/*User defined signal for updating the (ItemList)SelectedIngredients*/
	[Signal]
	public delegate void updateListEventHandler(string name, int count, int totalCount);

	private Texture2D _icon = GD.Load<Texture2D>("res://icon.svg");
	private List<int> _clickCounts = new List<int>();

	/*a list that stores the order of the vegetables with a getter*/
	private List<RecipeVegetable> _vegList = new List<RecipeVegetable>();
	public List<RecipeVegetable> vegList {
		get { return this._vegList; }
		set { this._vegList = value; }
	}

	private List<RecipeVegetable> _initVegList = new List<RecipeVegetable>();
	
	private void _ready() {
		this._vegList = this.addToList();

		string name;

		for(int i = 0; i < vegList.Count; i++) {
			name = vegList[i].vegName + " x" + (vegList[i].vegAmount);
			this.AddItem(name, this._icon, true);
		}

		for (int i = 0; i < vegList.Count; i++) {
			this._clickCounts.Add(0);
		}

		this._initVegList = this._vegList;
	}
	private void _on_item_selected(long i) {
		int index = (int)i;

		string name = this.GetItemText(index);

		/* for selecting with left mouse button*/
		if (Input.IsMouseButtonPressed(MouseButton.Left) && this._clickCounts[index] < this._vegList[index].vegAmount) {
			this._clickCounts[index] = this._clickCounts[index] + 1;

			//GD.Print($"Ingredient {name} added {this._clickCounts[index]} times.");

		}
		/* for deselecting with right mouse button AND if click counter is less than the amount*/
		else if (Input.IsMouseButtonPressed(MouseButton.Right) && this._clickCounts[index] > 0) {
			this._clickCounts[index] = this._clickCounts[index] - 1;


			//GD.Print($"Ingredient {name} subtracted {_clickCounts[index]} times.");
		}

		this.UpdateText(name, index);
		EmitSignal(SignalName.updateList, this._vegList[index].vegName, this._clickCounts[index], this._vegList[index].vegAmount);  /*emit signal to selected ingredient list*/
	}
	public void _on_reset_button_pressed() {
		for (int i = 0; i < this._vegList.Count; i++) {
			if (this._clickCounts[i] != 0) {
				this._clickCounts[i] = 0;

				this.UpdateText(this._vegList[i].vegName, i);
				EmitSignal(SignalName.updateList, this._vegList[i].vegName, this._clickCounts[i], this._vegList[i].vegAmount);  /*emit signal to selected ingredient list*/
	
			}
		}
	}
	private void _on_cook_button_pressed() {
		for (int j = 0; j < 2; j++) {
			for (int i = 0; i < this._vegList.Count; i++) {
				this._vegList[i].vegAmount -= this._clickCounts[i];
				this._clickCounts[i] = 0;

				if (this._vegList[i].vegAmount == 0) {
					this._vegList.RemoveAt(i);
					this._clickCounts.RemoveAt(i);
					this.RemoveItem(i);
				}
				else {
					this.UpdateText(this._vegList[i].vegName, i);
				}
			}
		}
	}
	private List<RecipeVegetable> addToList() {
		RecipeVegetable veg = new RecipeVegetable();

		veg.vegName = "BokChoy";
		veg.vegAmount = 5;
		vegList.Add(veg);

		veg = new RecipeVegetable();

		veg.vegName = "Radish";
		veg.vegAmount = 2;
		vegList.Add(veg);

		veg = new RecipeVegetable();

		veg.vegName = "Cabbage";
		veg.vegAmount = 1;
		vegList.Add(veg);

		veg = new RecipeVegetable();

		veg.vegName = "Lettuce";
		veg.vegAmount = 3;
		vegList.Add(veg);

		return vegList;
	}

	private void UpdateText(string name, int index){
		int amount;
		
		amount = this._vegList[index].vegAmount - this._clickCounts[index]; 

		name = this._vegList[index].vegName + " x" + amount;
		this.SetItemText(index, name);
	}

}
