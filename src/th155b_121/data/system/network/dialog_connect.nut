function Initialize()
{
	this.Update = ::menu.network.dialog_connect.Update;
}

function Update()
{
	::menu.cursor.SetTarget(this.obj[1].x - 20 + ::graphics.width / 2, this.obj[1].y + 24 + ::graphics.height / 2, 0,69999999.0);
	::menu.network.UpdateWaitClient();
}

