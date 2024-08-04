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

function Boss_Shot_M3( t )
{
	this.SetMotion(4945, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 3;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.rx = 45 * 0,01745329.0 * this.direction;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,15000001.0;
			};
			this.keyAction = this.ReleaseActor;
		},
		function ()
		{
		},
		function ( r_, dir_ )
		{
		}
	];
	this.stateLabel = function ()
	{
		if (this.count >= 120 || this.IsScreen(200 * this.sx) || this.hitCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;
		this.rz += 18,00000000.0 * 0,01745329.0;
		this.sx = this.sy += 0,01000000.0;
		this.SetCollisionScaling(this.sx, this.sy * 1,50000000.0, 1,00000000.0);
		this.HitCycleUpdate(1);
	};
}

function Boss_Shot_M3_Mini( t )
{
	this.SetMotion(4945, 3);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.sx = this.sy = 0,25000000.0 + this.rand() % 26 * 0,01000000.0;
	this.rx = 45 * 0,01745329.0 * this.direction;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,05000000.0;
				this.alpha -= 0,05000000.0;
			};
			this.keyAction = this.ReleaseActor;
		},
		function ()
		{
			this.func[1] = function ()
			{
			};
			this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
		},
		function ( r_, dir_ )
		{
			this.func[1] = function ()
			{
			};
			this.flag1 = this.Vector3();
			this.flag1.x = this.cos(r_) * dir_ * 0,10000000.0;
			this.flag1.y = this.sin(r_) * 0,10000000.0;
			this.stateLabel = function ()
			{
				if (this.IsScreen(400) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
					return;
				}

				this.count++;
				this.rz += 18,00000000.0 * 0,01745329.0;
				this.AddSpeed_XY(this.flag1.x, this.flag1.y);
				this.SetCollisionScaling(this.sx, this.sy * 1,50000000.0, 1,00000000.0);
				this.HitCycleUpdate(1);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(400) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;
		this.rz += 18,00000000.0 * 0,01745329.0;
		this.SetCollisionScaling(this.sx, this.sy * 1,50000000.0, 1,00000000.0);
		this.HitCycleUpdate(1);
	};
}

function Boss_Shot_D1_PreBlade( t )
{
	this.SetMotion(4918, 2);
	this.sy = 0,00000000.0;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sy *= 0,89999998.0;
				this.alpha = this.green = this.blue -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sy += 0,00250000.0;
	};
}

function Boss_Shot_D1_Blade( t )
{
	this.SetMotion(4918, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.cancelCount = 99;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha -= 0,10000000.0;
				this.sx *= 1,04999995.0;
				this.sy *= 0,89999998.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.flag1 = 0,03000000.0;
		this.sy = 1,75000000.0;
		break;

	case 1:
		this.flag1 = 0,06000000.0;
		this.sy = 2,50000000.0;
		break;

	case 2:
		this.flag1 = 0,09000000.0;
		this.sy = 3,50000000.0;
		break;

	case 3:
	case 4:
		this.flag1 = 0,15000001.0;
		this.sy = 5,00000000.0;
		break;
	}

	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.stateLabel = function ()
	{
		this.sx += this.flag1;
		this.sy *= 0,92000002.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.hitCount <= 2)
		{
			this.HitCycleUpdate(5);
		}
	};
}

function Boss_Shot_D1_Laser( t )
{
	this.SetMotion(4919, 4);
	this.rz = t.rot;
	this.sx = 2,00000000.0;
	this.SetCollisionScaling(this.sx, 1,00000000.0, 1,00000000.0);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.owner.shot_actor.Add(this);
	this.hitResult = 128;
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
				if (this.hitCount > 0 || this.cancelCount <= 0 || this.count >= this.flag1 || this.grazeCount >= 5)
				{
					this.func[0].call(this);
					return;
				}

				this.sy += (1,00000000.0 - this.sy) * 0,25000000.0;
				this.HitCycleUpdate(2);
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

function Boss_Shot_S3_Laser( t )
{
	this.SetMotion(4919, 4);
	this.rz = t.rot;
	this.sx = 2,00000000.0;
	this.SetCollisionScaling(this.sx, 1,00000000.0, 1,00000000.0);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.owner.shot_actor.Add(this);
	this.hitResult = 128;
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
				if (this.hitCount > 0 || this.cancelCount <= 0 || this.count >= this.flag1 || this.grazeCount >= 1)
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

function Boss_Shot_S4_BladeFlash( t )
{
	this.SetMotion(4918, 2);
	this.rz = (35 - this.rand() % 71) * 0,01745329.0;
	this.sy = 0,50000000.0 + this.rand() % 11 * 0,10000000.0;
	this.flag1 = (3 - this.rand() % 6) * 0,01745329.0;
	this.flag2 = 0,02500000.0 + this.rand() % 25 * 0,01000000.0;
	this.stateLabel = function ()
	{
		this.sy *= 0,99500000.0;
		this.rz += this.flag1;
		this.alpha = this.green = this.blue -= this.flag2;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Boss_Shot_S4_Blade( t )
{
	this.SetMotion(4918, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.cancelCount = 99;

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.flag1 = 0,03000000.0;
		this.sy = 1,75000000.0;
		break;

	case 1:
		this.flag1 = 0,06000000.0;
		this.sy = 2,50000000.0;
		break;

	case 2:
		this.flag1 = 0,09000000.0;
		this.sy = 3,50000000.0;
		break;

	case 3:
	case 4:
		this.flag1 = 0,15000001.0;
		this.sy = 5,00000000.0;
		break;
	}

	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha -= 0,10000000.0;
				this.sx *= 1,04999995.0;
				this.sy *= 0,89999998.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.stateLabel = function ()
	{
		this.sx += this.flag1;
		this.sy *= 0,92000002.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.count++;

		if (this.count >= 30)
		{
			this.func[0].call(this);
			return;
		}

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(0);
		}
	};
}

function Boss_Shot_S5_Back( t )
{
	this.SetMotion(4979, 0);
	this.owner.shot_actor.Add(this);
	this.DrawActorPriority(180);
	this.sx = this.sy = 0,00000000.0;
	this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_S5_SunRing, {});
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,92000002.0;
				this.alpha = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion == 4970)
		{
			if (this.owner.keyTake <= 3)
			{
				this.count++;

				if (this.count % 20 == 1)
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_S5_Ring, {});
				}

				this.Warp(this.owner.x, this.owner.y);
				this.sx = this.sy += (2,00000000.0 - this.sx) * 0,05000000.0;

				if (this.count % 6 == 0)
				{
					this.rz = 0,01745329.0 * this.rand() % 360;
				}
			}
			else
			{
				this.func[0].call(this);
			}
		}
		else
		{
			this.func[0].call(this);
		}
	};
}

function Boss_Shot_S5_Ray( t )
{
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.cancelCount = 1;
	this.SetMotion(4979, 4);
	this.sy = 0,00000000.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetParent(this.owner, 0, 0);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 4);
			this.stateLabel = function ()
			{
				this.sy *= 0,89999998.0;
				this.alpha = this.green = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sy += 0,05000000.0;

		if (this.sy >= 0,10000000.0)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				if (this.hitCount == 0)
				{
					this.HitCycleUpdate(1);
				}

				this.count++;
				this.sy += (2,00000000.0 - this.sy) * 0,10000000.0;
				this.SetCollisionScaling(this.sx, this.sy * 2, 1,00000000.0);

				if (this.count >= 30 || this.cancelCount <= 0)
				{
					this.func[0].call(this);
				}
			};
		}
	};
}

function Boss_Shot_S5_SunRing( t )
{
	this.SetMotion(4979, 2);
	this.sx = this.sy = 1,00000000.0;
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,01500000.0;
				this.alpha = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion == 4970)
		{
			if (this.owner.keyTake <= 3)
			{
				this.alpha += 0,07500000.0;

				if (this.alpha > 1,00000000.0)
				{
					this.alpha = 1,00000000.0;
				}

				this.Warp(this.owner.x, this.owner.y);
				this.sx = this.sy += (2,00000000.0 - this.sx) * 0,05000000.0;
			}
			else
			{
				this.func[0].call(this);
			}
		}
		else
		{
			this.func[0].call(this);
		}
	};
}

function Boss_Shot_S5_Ring( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(4979, 1);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,39999998.0 - this.sx) * 0,10000000.0;
		this.alpha = this.blue -= 0,02500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

