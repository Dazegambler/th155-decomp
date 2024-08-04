function FreeObjectCommonInit( t )
{
	this.actorType = 8;
	this.initTable = t;
	this.vf = this.Vector3();
	this.va = this.Vector3();
	this.DrawActorPriority(200);
	this.SetEndTakeCallbackFunction(this.KeyActionCheck);
	this.SetEndMotionCallbackFunction(this.ReleaseActor);
	this.SetUpdateFunction(this.FreeObject_Update);
	this.SetTeamFreeObject();

	if (t.init)
	{
		t.init.call(this, t);
	}
}

