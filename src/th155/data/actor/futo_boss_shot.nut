function Boss_Shot_SL1( t )
{
	this.SetMotion(4939, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = (-10 + this.rand() % 21) * 0,01745329.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.sx = this.sy = 1,50000000.0 + this.rand() % 101 * 0,01000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.count = this.rand() % 31;
	this.func = [
		function ()
		{
			this.SetMotion(4939, 1);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
				this.sx = this.sy += 0,05000000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.Vec_Brake(0,25000000.0, 0,10000000.0))
		{
			this.count--;

			if (this.count <= 0)
			{
				this.TargetHoming(this.team.target, 3,14159203.0, this.direction);
				this.subState = function ()
				{
					this.AddSpeed_Vec(0,20000000.0, null, 10,00000000.0, this.direction);
				};
			}
		}
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

