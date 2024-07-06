using Godot;
using System;

public partial class RecipeVegetable : Node {
    private string _vegName;
    private int _vegAmount;

    public string vegName {
        get { return this._vegName; }
        set { this._vegName = value; }
    }
    public int vegAmount {
        get { return this._vegAmount; }
        set { this._vegAmount = value; }
    }
}
