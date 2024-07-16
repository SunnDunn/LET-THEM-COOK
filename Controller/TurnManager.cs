using Godot;
using Godot.Collections;
using System;

public partial class TurnManager : Node
{
	public string CurrentTurn = "Player";
	
	private Array<Node> _friendlyUnits;
	private Array<Node> _enemyUnits;

	public int _friendlyEndTurnTracker = 0;
	public int _enemyEndTurnTracker = 0;
	
	public Node CurrentUnitTurn;

	public void TurnChanger(bool isStart)
	{
		Array<Node> currentUnits = this._friendlyUnits;;
		
		if (this.CurrentTurn == "Enemy")
		{
			currentUnits = this._enemyUnits;
		}
		
		foreach (Node unit in currentUnits)
		{
			ITurnHandler handler = unit.GetNode("UnitTurnHandler") as ITurnHandler;
			if (handler != null)
			{
				handler.canMove = isStart;
			}
		}
	}

	public void IncrementTracker()
	{
		//GD.Print("Incrementing " + this.CurrentTurn);
		switch (this.CurrentTurn)
		{
			case "Player":
				this._friendlyEndTurnTracker++;
				break;
			case "Enemy":
				this._enemyEndTurnTracker++;
				break;
		}
	}

	public override void _Ready()
	{
		this._friendlyUnits = GetTree().GetNodesInGroup("FriendlyUnit");
		this._enemyUnits = GetTree().GetNodesInGroup("EnemyUnit");

		this.TurnChanger(true);

		this.CurrentUnitTurn = this._friendlyUnits[0];
	}

	public override void _Process(double _delta)
	{
		//GD.Print("Current turn: " + this.CurrentTurn);
		//GD.Print("Friendly units moved: " + this._friendlyEndTurnTracker);
		switch (this.CurrentTurn)
		{
			case "Player":
				if (this._friendlyEndTurnTracker >= this._friendlyUnits.Count)
				{
					this.TurnChanger(false);
					this._friendlyEndTurnTracker = 0;
					this.CurrentTurn = "Enemy";
					this.TurnChanger(true);
					this.CurrentUnitTurn = this._enemyUnits[0];
				}
				break;
			case "Enemy":
				if (this._enemyEndTurnTracker >= this._enemyUnits.Count)
				{
					this.TurnChanger(false);
					this._enemyEndTurnTracker = 0;
					this.CurrentTurn = "Player";
					this.TurnChanger(true);
					this.CurrentUnitTurn = this._friendlyUnits[0];
				}
				break;
		}
	}
}
