function Boss_Shot_MS1_Flash( t )
{
	this.SetMotion(2009, 3);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = 1,25000000.0 + this.rand() % 8 * 0,10000000.0;
	this.sx = this.sy = 0,50000000.0;
	this.SetSpeed_XY(0,00000000.0, -2,50000000.0);
	this.subState = function ()
	{
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += (this.flag1 - this.sx) * 0,25000000.0;
		this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
		this.subState();
	};
}

function Boss_Shot_MS1( t )
{
	this.SetMotion(4939, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0, 0, (-6,50000000.0 - this.rand() % 65 * 0,10000000.0) * 0,01745329.0);
	this.SetSpeed_Vec(17,50000000.0, t.rot, this.direction);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4939, 1);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;
				this.alpha -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.C_Vec_BrakeLimited(this.va, 0,50000000.0, 0,50000000.0))
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		this.count++;

		if (!(!this.IsScreen(100) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[1].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_MS1B( t )
{
	this.SetMotion(4939, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0, 0, (-6,50000000.0 - this.rand() % 65 * 0,10000000.0) * 0,01745329.0);
	this.SetSpeed_Vec(12,50000000.0, t.rot, this.direction);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4939, 1);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;
				this.alpha -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.C_Vec_BrakeLimited(this.va, 0,20000000.0, 0,50000000.0))
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		this.count++;

		if (!(!this.IsScreen(100) && this.count < 90 && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[1].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_MS1C( t )
{
	this.SetMotion(4939, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = (-6,50000000.0 - this.rand() % 65 * 0,10000000.0) * 0,01745329.0;
	this.SetSpeed_Vec(17,50000000.0, t.rot, this.direction);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4939, 1);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;
				this.alpha -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_MS1_Flash, {});
			this.SetSpeed_XY(2,00000000.0 - this.rand() % 41 * 0,10000000.0, -10,00000000.0 - this.rand() % 50 * 0,10000000.0);
			this.flag1 = (10,00000000.0 + this.rand() % 11) * 0,01745329.0;

			if (this.rand() % 100 <= 49)
			{
				this.flag1 *= -1,00000000.0;
			}

			this.sx = this.sy += 0,50000000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			this.cancelCount = 3;
			this.atkRate_Pat += 0,25000000.0;
			this.stateLabel = function ()
			{
				if (this.y > ::battle.scroll_bottom + 100)
				{
					this.ReleaseActor();
					return;
				}

				if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
				{
					this.func[1].call(this);
					return;
				}

				this.vy += 0,50000000.0;

				if (this.vy > 15,00000000.0)
				{
					this.vy = 15,00000000.0;
				}

				this.flag1 *= 0,98000002.0;
				this.rz += this.flag1;
			};
		}
	];
	this.subState = function ()
	{
		if (this.C_Vec_BrakeLimited(this.va, 0,50000000.0, 0,50000000.0))
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		this.count++;

		if (!(!this.IsScreen(100) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[1].call(this);
			return;
		}

		this.rz += this.flag1;
		this.subState();
	};
}

function Boss_Shot_SL1( t )
{
	this.SetMotion(4919, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0, 0, (-6,50000000.0 - this.rand() % 65 * 0,10000000.0) * 0,01745329.0);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(100) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.vy += 0,05000000.0;
	};
}

function Shot_S3_LaserBullet( t )
{
	this.SetMotion(4949, 0);
	this.owner.shot_actor.Add(this);
	this.sx = this.sy = 0,80000001.0 + this.rand() % 21 * 0,01000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(5,00000000.0 + this.rand() % 50 * 0,10000000.0, this.rz, this.direction);
	this.SetTaskAddRotation(0, 0, 0,06981317.0);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,92000002.0;
				this.alpha = this.blue = this.green -= 0,05000000.0;
			};
		}
	];
	this.subState = function ()
	{
		this.count++;
		this.C_SetSpeed_XY(this.va, this.va.x * 0,94999999.0, this.va.y * 0,94999999.0);

		if (this.count == 20)
		{
			this.subState = function ()
			{
				this.vy += 0,05000000.0;
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
		}

		this.subState();
	};
}

