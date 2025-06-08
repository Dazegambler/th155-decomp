function Boss_Shot_MS1( t )
{
	this.SetMotion(4919, 0);
	this.owner.shot_actor.Add(this);
	this.rz = (45 - this.rand() % 90) * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.cancelCount = 1;
	this.SetSpeed_Vec(12.50000000, this.rz, this.direction);
	this.Warp(this.x + this.va.x * 8, this.y + this.va.y * 8);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 2);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(this.va.x * 0.80000001, this.va.y * 0.80000001);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.Vec_Brake(0.25000000, 5.00000000))
		{
			this.stateLabel = function ()
			{
				if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	};
}

