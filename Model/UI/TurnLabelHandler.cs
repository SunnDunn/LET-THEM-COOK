using Godot;
using System;

public partial class TurnLabelHandler : Label
{
	private TurnManager _turnManager;
	
	public override void _Ready()
	{
		this._turnManager = (TurnManager) GetNode("/root/TurnManager");
	}
	
	public override void _Process(double _delta)
	{
		if (this._turnManager == null)
		{
			GD.Print("No turn manager found!");
			return;
		}
		
		this.Text = this._turnManager.CurrentTurn;
		
	}
}
