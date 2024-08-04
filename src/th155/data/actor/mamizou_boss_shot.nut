function Boss_Shot_MS1( t )
{
	this.SetMotion(4919, 1);
	this.sx = this.sy = 0,25000000.0;
	this.owner.shot_actor.Add(this);
	this.flag1 = this.Vector3();
	this.flag2 = 0,50000000.0 + this.rand() % 10 * 0,10000000.0;
	this.cancelCount = 1;
	this.subState = function ()
	{
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;

		if (this.sx >= 0,94999999.0)
		{
			this.sx = this.sy = 1,00000000.0;
			this.SetMotion(this.motion, 0);
			this.subState = function ()
			{
			};
		}
	};
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.SetSpeed_Vec(1,00000000.0, r_, this.direction);
			this.flag1.x = this.va.x * 0,10000000.0;
			this.flag1.y = this.va.y * 0,10000000.0;
			this.stateLabel = function ()
			{
				if (this.IsScreen(100))
				{
					this.ReleaseActor();
					return;
				}

				if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
					return;
				}

				this.AddSpeed_XY(this.flag1.x, this.flag1.y);
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

		this.subState();

		if (this.Vec_Brake(0,10000000.0, 0,00000000.0))
		{
			this.stateLabel = function ()
			{
				if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
					return;
				}

				this.subState();
				this.count++;

				if (this.count >= 120)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	};
}

function Boss_Shot_MS2_Leaf( t )
{
	this.SetMotion(4928, 0);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(12,50000000.0, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.subState = function ()
	{
		this.Vec_Brake(0,25000000.0, 1,00000000.0);
		this.count++;

		if (this.count >= 90 || this.team.current == this.team.slave)
		{
			this.func[1].call(this);
		}
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
		},
		function ()
		{
			this.SetMotion(4928, 1);
			this.func[0] = this.func[2];
			this.va.RotateByDegree(90 * this.direction);
			this.subState = function ()
			{
				this.AddSpeed_Vec(0,20000000.0, null, 4,00000000.0, this.direction);
			};
		},
		function ()
		{
			this.SetMotion(4928, 2);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,10000000.0;

				if (this.sx <= 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(50) || this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_MS2_BackFire( t )
{
	this.SetMotion(4929, 0);
	this.DrawActorPriority(189);
	this.cancelCount = 99;
	this.SetParent(this.owner, 0, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(10);
	};
}

