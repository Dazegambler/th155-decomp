function Boss_Shot_M1_Pilar( t )
{
	this.SetMotion(4956, 0);
	this.stateLabel = function ()
	{
		this.sy += 0,05000000.0;
		this.SetCollisionScaling(this.flag1, this.sy, 1,00000000.0);
		this.SetSpeed_XY(0,00000000.0, (::battle.scroll_bottom + 50 - this.y) * 0,10000000.0);
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 1,00000000.0)
		{
			this.callbackGroup = 0;
			this.green = this.blue = this.alpha;
			this.sx *= 0,92000002.0;
			this.sy *= 1,04999995.0;
		}

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
	this.DrawActorPriority(199);
	this.sx = t.scale * (0,89999998.0 + this.rand() % 21 * 0,01000000.0);
	this.sy = 2,00000000.0;
	this.flag1 = t.scale;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.SetCollisionScaling(this.flag1, this.sy, 1,00000000.0);
	this.alpha = 3,00000000.0;
}

function Boss_Shot_M1_Fall( t )
{
	this.SetMotion(4965, 4);
	this.owner.shot_actor.Add(this);
	this.flag1 = this.SetTrail(this.motion, 5, 25, 90).weakref();
	this.AddSpeed_XY(this.direction * (1 + this.rand() % 6), -15 - this.rand() % 3);
	this.sx = this.sy = 0,80000001.0 + this.rand() % 21 * 0,01000000.0;
	this.cancelCount = 3;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 6);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.sx = this.sy = 2,00000000.0;
			this.alpha = 2,00000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;

				if (this.flag1)
				{
					this.flag1.alpha -= 0,10000000.0;
					this.flag1.anime.length *= 0,80000001.0;
					this.flag1.anime.radius0 *= 0,80000001.0;

					if (this.flag1.alpha <= 0,00000000.0)
					{
						this.flag1.ReleaseActor();
					}
				}

				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::camera.bottom + 200)
		{
			this.ReleaseActor();
			return;
		}

		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.rz -= 12,00000000.0 * 0,01745329.0;
		this.vy += 0,15000001.0;
	};
}

function Boss_Shot_M2_FireRing( t )
{
	this.SetMotion(4969, 4);
	this.alpha = 2,00000000.0;
	this.stateLabel = function ()
	{
		this.flag1 += 0,02500000.0;
		this.anime.radius1 += (300 - this.anime.radius1) * 0,10000000.0;
		this.anime.radius0 += (this.anime.radius1 - this.anime.radius0) * 0,07500000.0;
		this.anime.left -= 8;
		this.alpha -= 0,02500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Boss_Shot_M2_BodyFire_Core( t )
{
	this.SetMotion(4969, 7);
	this.cancelCount = 99;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.scale <- 8,00000000.0;
	this.flag5.scaleB <- 20,00000000.0;

	switch(this.owner.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.scale = 12,00000000.0;
		this.flag5.scaleB = 25,00000000.0;
		break;

	case 2:
		this.flag5.scale = 14,50000000.0;
		this.flag5.scaleB = 27,50000000.0;
		break;

	case 3:
		this.flag5.scale = 16,00000000.0;
		this.flag5.scaleB = 36,00000000.0;
		break;

	case 4:
		this.flag5.scale = 17,50000000.0;
		this.flag5.scaleB = 40,00000000.0;
		break;
	}

	this.func = [
		function ()
		{
			this.SetMotion(4969, 11);
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,05000000.0;
				this.alpha = this.red = this.green -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.PlaySE(3273);
			this.stateLabel = function ()
			{
				if (this.subState)
				{
					this.subState();
				}

				this.cancelCount = 99;
				this.SetSpeed_XY(this.initTable.pare.point0_x - this.x, this.initTable.pare.point0_y - this.y);
				this.count++;
				this.sx = this.sy += (this.flag5.scale - this.sx) * 0,05000000.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

				if (this.count % 10 == 1)
				{
					local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_M2_BodyFire, {}, this.weakref());

					if (this.flag2)
					{
						this.flag2.DrawActorPriority();
					}

					this.flag2 = a_;
				}

				this.HitCycleUpdate(30);
			};
		},
		function ()
		{
			this.PlaySE(3290);
			this.stateLabel = function ()
			{
				this.cancelCount = 99;
				::camera.Shake(2,00000000.0);
				this.SetSpeed_XY(this.initTable.pare.point0_x - this.x, this.initTable.pare.point0_y - this.y);
				this.count++;
				local s_ = (this.flag5.scaleB - this.sx) * 0,10000000.0;
				this.sx = this.sy += s_;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

				if (this.count % 10 == 1)
				{
					local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_M2_BodyFire, {}, this.weakref());

					if (this.flag2)
					{
						this.flag2.DrawActorPriority();
					}

					this.flag2 = a_;
				}

				this.HitCycleUpdate(5);
			};
		},
		function ()
		{
			this.subState = function ()
			{
				if (this.count % 6 == 1)
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_M2_Trail, {}, this.weakref());
				}
			};
		}
	];
	this.func[1].call(this);
}

function Boss_Shot_M2_BodyFire( t )
{
	this.SetMotion(4969, 11);
	this.DrawActorPriority(180);
	this.SetParent(t.pare, 0, 0);
	this.flag1 = 1,00000000.0;
	this.flag2 = (0,50000000.0 + this.rand() % 4 * 0,25000000.0) * 0,01745329.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.rz = this.rand() % 360 * 0,01745329.0;
			this.flag1 = 1,00000000.0;
			this.sx = this.sy = this.initTable.pare.sx * this.flag1;
			this.alpha = 2,00000000.0;
			this.stateLabel = function ()
			{
				this.rz += this.flag2;
				this.sx = this.sy = this.initTable.pare.sx * this.flag1;
				this.flag1 += 0,01000000.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha == 1,00000000.0)
				{
					this.DrawActorPriority();
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.func[1].call(this);
}

function Boss_Shot_M2_Trail( t )
{
	this.SetMotion(4969, 12);
	this.DrawActorPriority(179);
	this.flag1 = 1,00000000.0;
	this.flag2 = (0,50000000.0 + this.rand() % 4 * 0,25000000.0) * 0,01745329.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = 1,00000000.0;
	this.sx = this.sy = this.initTable.pare.sx * this.flag1;
	this.alpha = 2,00000000.0;
	this.stateLabel = function ()
	{
		this.rz += this.flag2;
		this.sx = this.sy = this.initTable.pare.sx * this.flag1;
		this.flag1 += 0,01000000.0;
		this.alpha = this.red = this.green -= 0,05000000.0;

		if (this.alpha == 1,00000000.0)
		{
			this.DrawActorPriority();
		}

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Boss_Shot_M2_TrailShot( t )
{
	this.owner.shot_actor.Add(this);
	this.SetMotion(4969, 13);
	this.DrawActorPriority(201);
	this.cancelCount = 3;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 1,00000000.0 + this.rand() % 15 * 0,10000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetSpeed_Vec(2,00000000.0 + this.rand() % 4, this.rz, this.direction);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.red = this.green = this.alpha;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0 && this.count < 180))
		{
			this.func[0].call(this);
			return true;
		}

		this.count++;
	};
}

function Boss_Shot_M2_Big( t )
{
	this.owner.shot_actor.Add(this);
	this.SetMotion(4969, 8);
	this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
	this.sx = this.sy = 3,00000000.0;
	this.SetSpeed_Vec(3,00000000.0, this.rz, this.direction);
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 0);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.sx = this.sy = 3,00000000.0;
			this.alpha = 1,50000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.red = this.green = this.alpha;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(200) && this.hitCount <= 0 && this.grazeCount <= 10))
		{
			this.func[0].call(this);
			return true;
		}

		this.sx = this.sy += (6,00000000.0 - this.sx) * 0,10000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.HitCycleUpdate(60);
	};
}

function Boss_Shot_M2( t )
{
	this.owner.shot_actor.Add(this);
	this.SetMotion(4969, 2);
	this.DrawActorPriority(201);
	this.rz = t.rot;
	this.sx = this.sy = 3,00000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.flag2 = this.Vector3();
	this.flag2.x = this.x;
	this.flag2.y = this.y;
	this.flag3 = this.Vector3();
	this.flag3.x = 1,00000000.0;
	this.flag3.RotateByRadian(this.rz);
	this.flag4 = 1,00000000.0;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 0);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.sx = this.sy = 2,00000000.0;
			this.alpha = 1,50000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.red = this.green = this.alpha;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.HitReset();
			this.hitCount = 0;
			this.grazeCount = 0;
			this.stateLabel = function ()
			{
				if (!(!this.IsScreen(200) && this.hitCount <= 0 && this.grazeCount <= 0))
				{
					this.func[0].call(this);
					return true;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(this.hitCount <= 0 && this.grazeCount <= 10))
		{
			this.func[0].call(this);
			return true;
		}

		local r_ = (200 - this.flag4) * 0,07500000.0;

		if (r_ < 2,00000000.0)
		{
			r_ = 2,00000000.0;
		}

		this.flag4 += r_;
		this.flag3.RotateByDegree(1,00000000.0);
		this.C_SetSpeed_XY(this.va, this.flag2.x + this.flag3.x * this.flag4 * this.direction - this.x, this.flag2.y + this.flag3.y * this.flag4 - this.y);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);
		this.HitCycleUpdate(60);
		this.count++;

		if (this.count >= 90)
		{
			this.func[1].call(this);
		}
	};
}

function Boss_Shot_M2_Reimu( t )
{
	this.owner.shot_actor.Add(this);
	this.SetMotion(4969, 2);
	this.rz = t.rot;
	this.sx = this.sy = 1,00000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetSpeed_Vec(10,00000000.0, this.rz, this.direction);
	this.flag1 = 6,00000000.0;
	this.flag2 = 0,00000000.0;
	this.flag3 = 4,50000000.0;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 0);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.sx = this.sy = 2,00000000.0;
			this.alpha = 1,50000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.red = this.green = this.alpha;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.HitReset();
			this.hitCount = 0;
			this.grazeCount = 0;
			this.stateLabel = function ()
			{
				if (!(!this.IsScreen(200) && this.hitCount <= 0 && this.grazeCount <= 0))
				{
					this.func[0].call(this);
					return true;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.grazeCount > 10)
		{
			this.func[0].call(this);
			return true;
		}

		if (this.flag2 < 270)
		{
			this.flag1 -= 0,07500000.0;

			if (this.flag1 < 1,39999998.0)
			{
				this.flag1 = 1,39999998.0;
			}
		}
		else
		{
			this.flag1 *= 0,98000002.0;
		}

		this.va.RotateByDegree(this.flag1 * this.direction);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);
		this.vx = this.va.x;
		this.vy = this.va.y;
		this.flag2 += this.flag1;
		this.sx = this.sy += (this.flag3 - this.sx) * 0,05000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

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
		if (this.C_Vec_BrakeLimited(this.va, 0,50000000.0, 1,00000000.0))
		{
			this.subState = function ()
			{
				this.count++;

				if (this.count >= 30)
				{
					this.subState = function ()
					{
						this.C_AddFreeSpeed_Vec(this.va, 0,50000000.0, null, 1,00000000.0);
						this.sx = this.sy += 0,02500000.0;
						this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
					};
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(100) && this.hitCount <= 0 && this.cancelCount > 0 && this.grazeCount <= 0))
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
		if (!(!this.IsScreen(100) && this.hitCount <= 0 && this.cancelCount > 0 && this.grazeCount <= 0))
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
		if (!(!this.IsScreen(100) && this.hitCount <= 0 && this.cancelCount > 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += 0,02500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

