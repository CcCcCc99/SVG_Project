using Godot;
using System;
//using System.IO;
//using System.Text.Json;

public class roomsToJSON : Node
{
	//const string rooms_path = @"res://scenes/Rooms/newRooms/";
	//const string out_path = @"res://rooms.json";

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GD.Print("Ciao");
		//string[] allFiles = Directory.GetFiles(@"/home/carlo/data/Progetti/Godot/ICON_Project/project/scenes/Rooms/newRooms");
		/*
		PackedScene room;
		
		foreach (string r in allFiles) {
			room = (PackedScene)ResourceLoader.Load(r);
			string json_string = JsonSerializer.Serialize();
		}
		
		File.WriteAllText(out_path, json_string);
		GD.Print("Ciao");
		*/
	}

}
