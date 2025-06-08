function Boss_Shot_MS1( t )
{
	this.SetMotion(4939, 1);
	this.sx = this.sy = 3.00000000;
	this.alpha = 0.00000000;
	this.rz = t.rot;
	this.flag1 = this.Vector3();
	this.flag1.x = this.sin(this.rz) * this.direction * 0.20000000;
	this.flag1.y = this.cos(this.rz) * 0.20000000;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.80000001;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy -= 0.10000000;
		this.alpha += 0.05000000;

		if (this.sx == 1.00000000)
		{
			this.SetMotion(this.motion, 0);
			this.subState = function ()
			{
				this.AddSpeed_XY(this.flag1.x, this.flag1.y);
			};
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

function Boss_Shot_Lance( t )
{
	this.SetMotion(4919, 0);
	this.cancelCount = 99;
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.FitBoxfromSprite();
	this.SetSpeed_Vec(15.00000000, this.rz, this.direction);
	this.cancelCount = 3;
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_Lance_Fire, t_);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(300.00000000))
		{
			this.ReleaseActor();
		}

		this.count++;

		if (this.count >= 4)
		{
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x + this.rand() % 60 - 30, this.y + this.rand() % 60 - 30, this.direction, this.Boss_Shot_Lance_Trail, t_);
			this.count = 0;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(10);
		}
	};
}

function Boss_Shot_Lance_Fire( t )
{
	this.SetMotion(4919, 3);
	this.rz = t.rot;
	this.sx = this.sy = 0.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (4.00000000 - this.sx) * 0.10000000;
		this.count++;

		if (this.count >= 6)
		{
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Boss_Shot_Lance_Trail( t )
{
	this.SetMotion(4919, 4);
	this.rz = t.rot;
	this.sx = this.sy = 0.50000000 + this.rand() % 21 * 0.10000000;
	this.SetSpeed_Vec(5.00000000, this.rz + 3.14159203, this.direction);
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.98000002;
		this.Vec_Brake(0.50000000, 1.00000000);
		this.count++;

		if (this.count >= 10)
		{
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Boss_Shot_MS1_B( t )
{
	this.SetMotion(4939, 1);
	this.sx = this.sy = 3.00000000;
	this.alpha = 0.00000000;
	this.rz = t.rot;
	this.flag1 = this.Vector3();
	this.flag1.x = this.cos(this.rz) * this.direction * 0.20000000;
	this.flag1.y = this.sin(this.rz) * 0.20000000;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.80000001;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy -= 0.10000000;
		this.alpha += 0.05000000;

		if (this.sx <= 1.00000000)
		{
			this.SetMotion(this.motion, 0);
			this.subState = function ()
			{
				this.AddSpeed_XY(this.flag1.x, this.flag1.y);
				this.count++;

				if (this.count >= 10)
				{
					this.subState = function ()
					{
					};
				}
			};
		}
	};
	this.keyAction = function ()
	{
		this.func[0].call(this);
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

