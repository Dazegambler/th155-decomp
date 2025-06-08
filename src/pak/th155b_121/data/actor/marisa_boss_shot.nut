function Boss_Tutorial_Info_A( t )
{
	this.SetMotion(4000, 0);
	this.DrawScreenActorPriority(1000);
	this.alpha = 0.00000000;
	this.stateLabel = function ()
	{
		this.alpha += 0.02500000;

		if (this.alpha >= 1.00000000)
		{
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 20)
				{
					this.stateLabel = function ()
					{
						this.alpha -= 0.02500000;

						if (this.alpha <= 0.00000000)
						{
							this.Release();
						}
					};
				}
			};
		}
	};
}

function Boss_Shot_Tutorial( t )
{
	this.SetMotion(4919, 0);
	this.SetSpeed_Vec(10.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.05235988);
	this.subState = function ()
	{
		if (this.Vec_Brake(0.25000000, 2.00000000))
		{
			this.subState = function ()
			{
				this.count++;

				if (this.count >= 20)
				{
					this.subState = function ()
					{
						if (this.AddSpeed_Vec(0.20000000, null, 15.00000000, this.direction))
						{
							this.subState = function ()
							{
							};
						}
					};
				}
			};
		}
	};
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.05000000;

				if (this.sx <= 0.00000000)
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

		this.subState();
	};
}

function Boss_Shot_T_StarFall( t )
{
	this.SetMotion(4919, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_XY(t.vx, t.vy);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.10471975);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.05000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y >= ::battle.scroll_bottom || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0.00000000, 0.10000000);
	};
}

function Boss_Shot_1( t )
{
	this.SetMotion(4919, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_XY(t.vx, t.vy);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.10471975);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.05000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0 || this.IsScreen(100))
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Boss_Shot_2_Core( t )
{
	this.SetMotion(4959, 3);
	this.owner.shot_actor.Add(this);
	this.flag1 = ::manbow.Actor2DProcGroup();

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag2 = 1;
		this.flag5 = 120;
		break;

	case 2:
		this.flag2 = 2;
		this.flag5 = 180;
		break;

	case 3:
	case 4:
		this.flag2 = 3;
		this.flag5 = 180;
		break;

	default:
		this.flag2 = 0;
		this.flag5 = 120;
		break;
	}

	this.flag3 = this.Vector3();
	this.flag3.y = -50.00000000;
	this.flag4 = this.y > 360 ? (this.flag4 = -0.52359873) : 0.52359873;
	this.flag3.RotateByRadian(this.flag4 * this.direction);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 15 == 1)
		{
			local t_ = {};
			t_.rot <- this.flag4;
			this.flag1.Add(this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_2, t_));

			if (this.flag2 > 0)
			{
				for( local i = 1; i <= this.flag2; i++ )
				{
					local t_ = {};
					t_.rot <- this.flag4;
					this.flag1.Add(this.SetShot(this.x + this.flag3.x * i, this.y + this.flag3.y * i, this.direction, this.Boss_Shot_2, t_));
					local t_ = {};
					t_.rot <- this.flag4;
					this.flag1.Add(this.SetShot(this.x + this.flag3.x * -i, this.y + this.flag3.y * -i, this.direction, this.Boss_Shot_2, t_));
				}
			}
		}

		if (this.count >= this.flag5)
		{
			this.flag1.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.ReleaseActor();
		}
	};
}

function Boss_Shot_2( t )
{
	this.SetMotion(4959, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(8.50000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.10471975);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.05000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.subState = function ()
			{
				if (this.Vec_Brake(0.25000000, 1.50000000))
				{
					this.subState = function ()
					{
						this.AddSpeed_XY(0.00000000, 0.20000000);
					};
				}
			};
			this.func[1] = function ()
			{
			};
		}
	];

	if (this.va.y <= 0.00000000)
	{
		this.subState = function ()
		{
			this.va.RotateByRadian(0.50000000 * 0.01745329 * this.direction);
			this.ConvertTotalSpeed();
		};
	}
	else
	{
		this.subState = function ()
		{
			this.va.RotateByRadian(-0.50000000 * 0.01745329 * this.direction);
			this.ConvertTotalSpeed();
		};
	}

	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_SL1( t )
{
	this.SetMotion(4949, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 99;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.keyAction = this.ReleaseActor;
	this.flag1 = 0.00000000;
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.sy = t.scale;
	this.SetCollisionScaling(this.sx, this.sy + this.flag1, 1.00000000);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
			};
			this.SetParent(null, 0, 0);
			this.SetKeyFrame(2);
			this.callbackGroup = 0;
			this.flag1 = false;
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.SetCollisionScaling(this.sx, this.sy + this.flag1, 1.00000000);

		if (this.flag1 == 0.00000000 && this.hitResult & 1)
		{
			this.flag1 = 0.20000000;
		}

		this.HitCycleUpdate(10);
	};
}

function Boss_Shot_SL1_Star( t )
{
	this.SetMotion(4919, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.alpha = 0.00000000;
	this.sx = this.sy = 3.00000000;
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.10471975);
	this.func = [
		function ()
		{
			this.alpha = 1.00000000;
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.05000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0 || this.IsScreen(100))
		{
			this.func[0].call(this);
			return;
		}

		if (this.alpha < 1.00000000)
		{
			this.alpha += 0.10000000;
			this.sx = this.sy -= 0.20000000;
		}
	};
}

function Boss_Shot_SL2( t )
{
	this.SetMotion(4949, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 99;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.keyAction = this.ReleaseActor;
	this.flag1 = 0.00000000;
	this.sy = 0.50000000;
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.sy = t.scale;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
			};
			this.SetParent(null, 0, 0);
			this.SetKeyFrame(2);
			this.callbackGroup = 0;
			this.flag1 = false;
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.HitCycleUpdate(10);
	};
}

