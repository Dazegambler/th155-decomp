function Boss_S1_Particle( t )
{
	this.SetMotion(4919, 2);
	this.sx = this.sy = 1,00000000.0 + this.rand() % 11 * 0,10000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,99000001.0;
		this.AddSpeed_XY(0,00000000.0, -0,20000000.0);
	};
}

function Boss_S2_Shot( t )
{
	this.SetMotion(4929, 1);
	this.cancelCount = 1;
	this.rz = t.rot;
	this.keyAction = this.ReleaseActor;
	this.SetSpeed_Vec(10,00000000.0, this.rz, this.direction);
	this.subState = function ()
	{
		if (this.Vec_Brake(0,50000000.0, 1,00000000.0))
		{
			this.subState = function ()
			{
				this.count++;

				if (this.count >= 30)
				{
					this.subState = function ()
					{
						this.AddSpeed_Vec(0,50000000.0, null);
						this.sx = this.sy += 0,02500000.0;
						this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
					};
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_S2_FireBall( t )
{
	this.SetMotion(4929, 0);
	this.cancelCount = 99;
	this.keyAction = this.ReleaseActor;
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 0,10000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha = this.blue = this.green -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Warp(this.owner.x, this.owner.y);
		this.rz += 0,10471975.0;
		this.count++;
		this.sx = this.sy += (6,00000000.0 - this.sx) * 0,05000000.0;
		this.alpha += 0,05000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.HitCycleUpdate(10);

		if (this.count >= 20)
		{
			this.count = 0;
			local t_ = {};
			t_.scale <- this.sx * 0,85000002.0;
			this.SetFreeObject(this.x, this.y, this.direction, this.Boss_S2_FireBall_Sub, t_, this.weakref());
		}
	};
}

function Boss_S2_FireBall_Sub( t )
{
	this.SetMotion(4929, 2);
	this.alpha = 0,00000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = t.scale;
	this.subState = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.subState = function ()
			{
				this.alpha -= 0,05000000.0;
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.initTable.pare)
		{
			this.Warp(this.initTable.pare.x, this.initTable.pare.y);
		}

		this.subState();
		this.sx = this.sy += (this.initTable.scale * 1,29999995.0 - this.sx) * 0,07500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Boss_S2_FireShot( t )
{
	this.SetMotion(4929, 3);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.keyAction = this.ReleaseActor;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(4,00000000.0 + this.rand() % 6, this.rz, this.direction);
	this.func = [
		function ()
		{
			this.rz = this.rand() % 360 * 0,01745329.0;
			this.SetMotion(4929, 4);
			this.alpha = 2,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 1,00000000.0)
				{
					this.blue = this.green = this.alpha;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}

				this.sx = this.sy += 0,01000000.0;
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

		this.sx = this.sy += 0,02500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

function Boss_S2_FireShot_B( t )
{
	this.SetMotion(4929, 3);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.keyAction = this.ReleaseActor;
	this.rz = t.rot + this.rand() % 15 * 0,01745329.0;
	this.SetSpeed_Vec(4,00000000.0 + this.rand() % 6, this.rz, this.direction);
	this.func = [
		function ()
		{
			this.rz = this.rand() % 360 * 0,01745329.0;
			this.SetMotion(4929, 4);
			this.alpha = 2,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 1,00000000.0)
				{
					this.blue = this.green = this.alpha;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}

				this.sx = this.sy += 0,01000000.0;
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

		this.sx = this.sy += 0,02500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

