using Godot;
using System;

public partial class TurnLabelHandler : Node
{
	private Label parentLabel;
	private TurnManager _turnManager;
	public override void _Ready()
	{
		this.parentLabel = GetParent() as Label;
		this._turnManager = (TurnManager) GetNode("/root/global");
	}
	
	public override void _Process(double _delta)
	{
		this.parentLabel.Text = this._turnManager.CurrentTurn;
	}
}
