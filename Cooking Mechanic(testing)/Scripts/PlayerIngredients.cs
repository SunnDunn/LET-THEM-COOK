using Godot;
using System;
using System.Collections.Generic;
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

		for(int i = 0; i < vegList.Count; i++) {
			this._clickCounts.Add(0);
		}

		this.Connect("item_clicked", new Callable(this, nameof(OnItemClicked))); /*connects a signal to a callable (make the function callable)
																				   so that every time the siglan is active, it calls the function*/
		this._initVegList = this._vegList;
	}

	private void OnItemClicked(int index, Vector2 at_position, int button_index) {
		string name = this.GetItemText(index);

		/* for selecting with left mouse button*/
		if (button_index == 1 && this._clickCounts[index] < this._vegList[index].vegAmount) {
			this._clickCounts[index] = this._clickCounts[index] + 1;
	
			 this.UpdateText(name, index);
		  
			//GD.Print($"Ingredient {name} added {this._clickCounts[index]} times.");

		} 
		/* for deselecting with right mouse button AND if click counter is less than the amount*/
		else if(button_index == 2 && this._clickCounts[index] > 0) {
			this._clickCounts[index] = this._clickCounts[index] - 1;
			
			this.UpdateText(name, index);

			//GD.Print($"Ingredient {name} subtracted {_clickCounts[index]} times.");
		}
		/* return if anything else */
		else{
			return;
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
		EmitSignal(SignalName.updateList, this._vegList[index].vegName, this._clickCounts[index], this._vegList[index].vegAmount);  /*emit signal to selected ingredient list*/

		amount = this._vegList[index].vegAmount - this._clickCounts[index]; 

		name = this._vegList[index].vegName + " x" + amount;
		this.SetItemText(index, name);
	}

	public void _on_reset_button_pressed(){
		for (int i = 0; i < this._vegList.Count; i++) {
			if (this._clickCounts[i] != 0) { 
				this._clickCounts[i] = 0;

				this.UpdateText(this._vegList[i].vegName, i);
				
			}
		}
	}

}
