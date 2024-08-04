function Boss_Shot_SL1( t )
{
	this.SetMotion(4917, 1);
	this.sx = this.sy = 0,25000000.0;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.flag2 = 0,05235988.0;
	this.SetSpeed_Vec(15,00000000.0, t.rot, this.direction);
	this.SetTrail(this.motion, 6, 20, 100);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.linkObject[0].alpha -= 0,10000000.0;
				this.linkObject[0].anime.length *= 0,80000001.0;
				this.linkObject[0].anime.radius0 *= 0,80000001.0;

				if (this.linkObject[0].alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}

				this.sx = this.sy *= 0,80000001.0;
				this.alpha -= 0,04000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.Vec_Brake(0,60000002.0, 0,50000000.0))
		{
			this.subState = function ()
			{
				this.sx = this.sy += (1,50000000.0 - this.sx) * 0,15000001.0;
				this.AddSpeed_Vec(0,50000000.0, null, 20,00000000.0, this.direction);
				this.TargetHoming(this.target, this.flag2);
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_SL2( t )
{
	this.SetMotion(4929, 0);

	if (this.owner.target != this.owner.target.team.slave)
	{
		this.SetMotion(this.motion, 1);
	}

	this.SetSpeed_Vec(3,00000000.0, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x * 0,05000000.0;
	this.flag1.y = this.va.y * 0,05000000.0;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,10000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(this.flag1.x, this.flag1.y);

		if (this.keyTake == 0)
		{
			if (this.owner.target != this.owner.target.team.slave)
			{
				this.SetMotion(this.motion, 1);
			}
		}
		else if (this.owner.target == this.owner.target.team.slave)
		{
			this.SetMotion(this.motion, 0);
		}
	};
}

