using Godot;
using System;
using System.Runtime.CompilerServices;

public partial class ITurnHandler : Node
{
	public bool canMove = false;

	private TurnManager _turnManager;

	public override void _Ready()
	{
		this._turnManager = (TurnManager) GetNode("/root/TurnManager");
	}

	public void EndTurn()
	{
		this.canMove = false;
		this._turnManager.IncrementTracker();
	}
}
