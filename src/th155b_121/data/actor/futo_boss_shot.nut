function Boss_Shot_MS1_Fire( t )
{
	this.SetMotion(4949, 2);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,05000000.0;
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Boss_Shot_MS1( t )
{
	this.SetMotion(4949, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.SetSpeed_Vec(10,00000000.0, t.rot, this.direction);
	this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_MS1_Fire, {});
	this.subState = function ()
	{
		this.Vec_Brake(0,25000000.0);
		this.count++;

		if (this.count >= 120)
		{
			this.func[1].call(this);
		}
	};
	this.func = [
		function ()
		{
			this.PlaySE(1899);
			this.SetMotion(this.motion, 2);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.alpha -= 0,10000000.0;
				this.sx = this.sy *= 0,80000001.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
					return;
				}
			};
		},
		function ()
		{
			this.SetMotion(4949, 1);
			this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_MS1_Fire, {});
			local r_ = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
			this.SetSpeed_Vec(0,20000000.0, r_, this.direction);
			this.flag1 = this.Vector3();
			this.flag1.x = this.va.x;
			this.flag1.y = this.va.y;
			this.count = 0;
			this.subState = function ()
			{
				this.AddSpeed_XY(this.flag1.x, this.flag1.y);
				this.count++;

				if (this.count >= 50)
				{
					this.subState = function ()
					{
					};
				}
			};
		}
	];
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

		this.subState();
	};
}

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
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.IsScreen(400))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_SL3( t )
{
	this.SetMotion(4939, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.sx = this.sy = 0,10000000.0;
	this.flag5 = {};
	this.flag5.v <- this.Vector3();
	this.flag5.v.x = this.cos(t.rot + t.rot2) * this.direction * 0,20000000.0;
	this.flag5.v.y = this.sin(t.rot + t.rot2) * 0,20000000.0;
	this.flag5.vh <- this.Vector3();
	this.flag5.vh.x = this.cos(t.rot) * this.direction * 0,10000000.0;
	this.flag5.vh.y = this.sin(t.rot) * 0,10000000.0;
	this.SetSpeed_Vec(11,00000000.0, t.rot + t.rot2 + 3,14159203.0, this.direction);
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
		this.AddSpeed_XY(this.flag5.v.x + this.flag5.vh.x, this.flag5.v.y + this.flag5.vh.y);
		this.count++;

		if (this.count >= 125)
		{
			this.subState = function ()
			{
				this.AddSpeed_XY(this.flag5.vh.x * 2,00000000.0, this.flag5.vh.y * 2,00000000.0);
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 10 || this.IsScreen(400))
		{
			this.func[0].call(this);
			return;
		}

		if (this.sx < 2,00000000.0)
		{
			this.sx = this.sy += 0,05000000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		}

		this.subState();
	};
}

