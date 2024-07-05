using Godot;
using System;


public partial class TestEnemyHandler : Node
{
	private ITurnHandler turnHandler;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		this.turnHandler = GetNode("UnitTurnHandler") as ITurnHandler;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
	
	
	private void _on_button_pressed()
	{
		// Replace with function body.
		if (!this.turnHandler.canMove) return;
		
		GD.Print("Hello!");
		this.turnHandler.EndTurn();
	}
}


