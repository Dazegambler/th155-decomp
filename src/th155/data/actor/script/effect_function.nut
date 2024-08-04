function EF_CommonInit( t )
{
	this.actorType = 8;
	this.initTable = t;
	this.SetUpdateFunction(this.EF_CommonUpdate);
	this.SetEndTakeCallbackFunction(this.KeyActionCheck);
	this.SetEndMotionCallbackFunction(function ()
	{
		this.Release();
	});
	this.ConnectRenderSlot(::graphics.slot.actor, 200);

	if (t.init)
	{
		t.init.call(this, t);
	}
}

