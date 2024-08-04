function Boss_Shot_M1_Laser( t )
{
	this.SetMotion(4919, 4);
	this.rz = t.rot;
	this.sx = 2,00000000.0;
	this.SetCollisionScaling(this.sx, 1,00000000.0, 1,00000000.0);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.owner.shot_actor.Add(this);
	this.sy = 0,01000000.0;
	this.flag1 = t.count;
	this.func = [
		function ()
		{
			this.SetMotion(4919, 5);
			this.alpha = 2,00000000.0;
			this.stateLabel = function ()
			{
				this.sy *= 0,89999998.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 1,00000000.0)
				{
					this.blue = this.green = this.alpha;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.cancelCount = 3;
			this.SetMotion(4919, 3);
			this.stateLabel = function ()
			{
				if (this.hitCount > 0 || this.cancelCount <= 0 || this.count >= this.flag1)
				{
					this.func[0].call(this);
					return;
				}

				this.sy += (1,00000000.0 - this.sy) * 0,25000000.0;
				this.HitCycleUpdate(10);
				this.count++;
			};
		}
	];
	this.subState = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);

		if (this.va.y > 6,50000000.0)
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		this.sy += (0,50000000.0 - this.sy) * 0,05000000.0;
	};
}

function Boss_Shot_M2_Trail( t )
{
	this.SetMotion(4929, 1);
	this.rz = t.rot;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx *= 0,89999998.0;
			this.sy *= 0,89999998.0;
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.sx += (1,25000000.0 - this.sx) * 0,10000000.0;
	};
}

function Boss_Shot_M2_Sword( t )
{
	this.SetMotion(4929, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = t.rot;
	this.sx = this.sy -= this.rand() % 20 * 0,01000000.0;
	this.FitBoxfromSprite();
	this.SetSpeed_Vec(t.v, this.rz, this.direction);
	local t_ = {};
	t_.rot <- this.rz;
	this.flag1 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_M2_Trail, t_).weakref();
	this.SetParent.call(this.flag1, this, 0, 0);
	this.DrawActorPriority(200);
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func();
			}

			this.flag1 = null;
			this.SetMotion(4929, 3);
			this.stateLabel = function ()
			{
				this.sy *= 0,89999998.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 200)
		{
			if (this.flag1)
			{
				this.flag1.func();
			}

			this.flag1 = null;
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return true;
		}
	};
}

function Boss_Shot_M2_Light( t )
{
	this.SetMotion(4929, 2);
	this.DrawActorPriority(180);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.sy = 0,00000000.0;
	this.alpha = 0,50000000.0;
	this.flag1 = 0,00000000.0;
	this.flag5 = {};
	this.flag5.cycle <- 45;
	this.flag5.way <- 9;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= this.flag5.cycle)
		{
			this.PlaySE(2115);
			this.flag1 = (-10 + this.rand() % 21) * 0,01745329.0;
			local t_ = {};
			t_.rot <- this.rz + this.flag1;
			t_.v <- 8,00000000.0;
			this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M2_Sword, t_);

			for( local i = 1; i < this.flag5.way + 1; i++ )
			{
				local t_ = {};
				t_.rot <- this.rz + this.flag1 + 0,05235988.0 * i;
				t_.v <- 8,00000000.0 - 0,25000000.0 * i;
				this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M2_Sword, t_);
				local t_ = {};
				t_.rot <- this.rz + this.flag1 - 0,05235988.0 * i;
				t_.v <- 8,00000000.0 - 0,25000000.0 * i;
				this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M2_Sword, t_);
			}

			this.count = 0;
		}

		this.sy += (3,00000000.0 - this.sy) * 0,05000000.0;
	};
}

function Boss_Shot_M2_LightB( t )
{
	this.SetMotion(4929, 2);
	this.rz = t.rot;
	this.sy = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.sy += (1,00000000.0 - this.sy) * 0,15000001.0;
		this.alpha -= 0,03300000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

