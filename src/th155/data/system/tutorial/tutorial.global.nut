function OnCreate()
{
	this.action <- ::menu.tutorial.weakref();
}

function Init()
{
	local item_table = ::menu.common.LoadItemText("data/system/tutorial/item.csv");
	::menu.common.InitializeLayout.call(this, this.gl, item_table);
}

function Terminate()
{
	::input.SetDeviceAssign(0, ::battle.team[0].device_id, ::battle.team[0].input);
	::menu.common.TerminateLayout.call(this);
}

function Update()
{
	::menu.common.UpdateLayout.call(this, this.gl);
}

function Draw()
{
}

