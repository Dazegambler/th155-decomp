function Shot_1_Kaname( t )
{
	this.SetMotion(4918, 0);
	this.DrawActorPriority(180);
	this.alpha = 0,00000000.0;
	this.owner.shot_actor.Add(this);
	this.rz = -0,78539813.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(4,00000000.0, this.rz, this.direction);
	this.cancelCount = 3;
	this.flag1 = 2,00000000.0;
	this.flag2 = 0,01000000.0;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag1 = 3,00000000.0;
		this.flag2 = 0,02000000.0;
		break;

	case 2:
		this.flag1 = 4,50000000.0;
		this.flag2 = 0,03000000.0;
		break;

	case 3:
	case 4:
		this.flag1 = 6,00000000.0;
		this.flag2 = 0,05000000.0;
		break;
	}

	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.func[1] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 1);
			this.alpha = 1,00000000.0;
			this.HitReset();
			this.cancelCount = 10;
			this.SetSpeed_Vec(2,00000000.0, this.rz, this.direction);
			this.stateLabel = function ()
			{
				if (this.y < ::battle.scroll_top - 128)
				{
					this.ReleaseActor();
				}

				if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
					return;
				}

				this.sx = this.sy += this.flag2;

				if (this.sx > this.flag1)
				{
					this.sx = this.sy = this.flag1;
				}

				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y < ::battle.scroll_top - 128)
		{
			this.ReleaseActor();
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.alpha += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}
	};
}

function Shot_2_Kaname( t )
{
	this.SetMotion(4929, 0);
	this.alpha = 0,00000000.0;
	this.owner.shot_actor.Add(this);
	this.rz = 1,57079601.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(4,00000000.0, this.rz, this.direction);
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 128)
		{
			this.ReleaseActor();
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.alpha += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}
	};
}

function Shot2_Big_Kaname( t )
{
	this.SetMotion(4920, 6);
	this.owner.shot_actor.Add(this);
	this.alpha = 0,00000000.0;
	this.cancelCount = 10;
	this.flag1 = 0;
	this.flag2 = 0;
	this.flag3 = 90;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag1 = 6;
		this.flag2 = 6;
		this.flag3 = 60;
		break;

	case 2:
		this.flag1 = 3;
		this.flag2 = 10;
		this.flag3 = 45;
		break;

	case 3:
	case 4:
		this.flag1 = 1;
		this.flag2 = 15;
		this.flag3 = 30;
		break;
	}

	this.func = [
		function ()
		{
			this.SetMotion(4920, 8);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			::camera.Shake(6,00000000.0);
			this.SetMotion(4920, 7);
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 30)
				{
					this.PlaySE(4225);
					this.SetSpeed_XY(0,00000000.0, 35,00000000.0);
				}

				if (this.y > ::battle.scroll_bottom + 128)
				{
					if (this.flag2 > 0)
					{
						while (this.flag2 > 0)
						{
							this.flag2--;
							this.SetShot(this.x - 64 + this.rand() % 128, this.y - this.rand() % 128, this.direction, this.Shot_2_Kusabi, {});
						}
					}

					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;
		this.count++;

		if (this.count >= this.flag3)
		{
			this.func[1].call(this);
			return;
		}
	};
}

function Shot_2_Kusabi( t )
{
	this.SetMotion(4920, 9);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = (-60 - this.rand() % 60) * 0,01745329.0;
	this.SetSpeed_Vec(3,00000000.0 + this.rand() % 4, this.rz, this.direction);
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Dream2_Fire, {});
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(4920, 10);
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,10000000.0;
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
		if (this.IsCamera(200))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_S2_Kaname( t )
{
	this.SetMotion(4939, 0);
	this.owner.shot_actor.Add(this);
	this.flag1 = 99;
	this.SetSpeed_XY(0,00000000.0, -20,00000000.0 - this.rand() % 10);
	this.cancelCount = 99;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,10000000.0);
				this.alpha = this.red = this.green = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.flag1 = this.cancelCount;
			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.cancelCount < this.flag1 - 3)
				{
					this.cancelCount = this.flag1 - 3;
				}

				if (this.cancelCount < this.flag1)
				{
					if (this.count % 10 == 1)
					{
						this.flag1--;
					}

					this.AddSpeed_XY(0,00000000.0, -0,50000000.0, 0,00000000.0, -4,50000000.0);
				}
				else
				{
					this.AddSpeed_XY(0,00000000.0, 1,50000000.0, 0,00000000.0, -1,00000000.0);
				}

				if (this.IsScreen(200))
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 0);
			this.SetSpeed_XY(0,00000000.0, -25,00000000.0);
			this.stateLabel = function ()
			{
				if (this.IsScreen(200))
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(0,00000000.0, this.va.y * 0,92500001.0);
		this.count++;

		if (this.count >= 45)
		{
			this.func[1].call(this);
			return;
		}
	};
}

function Shot_S3_Sword( t )
{
	this.SetMotion(4949, 0);
	this.DrawActorPriority(180);
	this.owner.shot_actor.Add(this);
	this.SetParent(this.owner, 0, 0);
	this.SetSpeed_Vec(20,00000000.0, 0,52359873.0, this.direction);
	this.flag1 = 2,00000000.0;
	this.flag2 = null;
	this.func = [
		function ()
		{
			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
				this.flag2 = null;
			}

			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha = this.green = this.blue -= 0,10000000.0;
				this.sx = this.sy += 0,05000000.0;
			};
		},
		function ()
		{
			if (this.flag2)
			{
				this.flag2.func[1].call(this.flag2);
				this.flag2 = null;
			}

			this.PlaySE(4243);
			::camera.Shake(15,00000000.0);
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha = this.green = this.blue -= 0,10000000.0;
				this.sx = this.sy += 0,10000000.0;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.flag1 += 0,00500000.0;
		this.sx = this.sy += (this.flag1 - this.sx) * 0,25000000.0;
		this.rx += (1,04719746.0 - this.rx) * 0,30000001.0;
		this.ry = -this.rx * this.direction;

		if (this.Vec_Brake(1,50000000.0))
		{
			::camera.Shake(10,00000000.0);
			this.PlaySE(4238);
			local t_ = {};
			t_.rot <- 1,04719746.0;
			this.flag2 = this.SetShot(this.x, this.y, this.direction, this.Shot_S3_Laser, t_, this.weakref()).weakref();
			this.SetSpeed_XY(0,00000000.0, -0,50000000.0);
			this.stateLabel = function ()
			{
				this.rx -= 0,40000001.0 * 0,01745329.0;
				this.flag2.rz -= 0,40000001.0 * 0,01745329.0;
			};
		}
	};
}

function Shot_S3_Sword_R( t )
{
	this.SetMotion(4949, 0);
	this.DrawActorPriority(180);
	this.owner.shot_actor.Add(this);
	this.SetParent(this.owner, 0, 0);
	this.SetSpeed_Vec(20,00000000.0, -0,78539813.0, this.direction);
	this.flag1 = 2,00000000.0;
	this.flag2 = null;
	this.func = [
		function ()
		{
			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
				this.flag2 = null;
			}

			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha = this.green = this.blue -= 0,10000000.0;
				this.sx = this.sy += 0,05000000.0;
			};
		},
		function ()
		{
			if (this.flag2)
			{
				this.flag2.func[1].call(this.flag2);
				this.flag2 = null;
			}

			this.PlaySE(4243);
			::camera.Shake(15,00000000.0);
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha = this.green = this.blue -= 0,10000000.0;
				this.sx = this.sy += 0,10000000.0;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.flag1 += 0,00500000.0;
		this.sx = this.sy += (this.flag1 - this.sx) * 0,25000000.0;
		this.rx += (-1,04719746.0 - this.rx) * 0,30000001.0;
		this.ry = this.rx * this.direction;

		if (this.Vec_Brake(1,50000000.0))
		{
			::camera.Shake(10,00000000.0);
			this.PlaySE(4238);
			local t_ = {};
			t_.rot <- -1,04719746.0;
			this.flag2 = this.SetShot(this.x, this.y, this.direction, this.Shot_S3_Laser, t_, this.weakref()).weakref();
			this.SetSpeed_XY(0,00000000.0, 0,50000000.0);
			this.stateLabel = function ()
			{
				this.rx += 0,40000001.0 * 0,01745329.0;
				this.flag2.rz += 0,40000001.0 * 0,01745329.0;
			};
		}
	};
}

function Shot_S3_LaserBullet( t )
{
	this.SetMotion(4949, 5);
	this.owner.shot_actor.Add(this);
	this.sx = this.sy = 0,80000001.0 + this.rand() % 21 * 0,01000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(1,50000000.0 + this.rand() % 25 * 0,10000000.0, this.rz, this.direction);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 6);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,92000002.0;
				this.alpha = this.blue = this.green -= 0,05000000.0;
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

		if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_S3_Laser( t )
{
	this.SetMotion(4949, 3);
	this.DrawActorPriority(210);
	this.owner.shot_actor.Add(this);
	this.SetParent(t.pare, 0, 0);
	this.sx = this.sy = 2,00000000.0;
	this.rz = t.rot;
	this.FitBoxfromSprite();
	this.flag1 = this.Vector3();
	this.func = [
		function ()
		{
			this.SetMotion(4949, 7);
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sy *= 0,98000002.0;
				this.alpha = this.blue = this.green -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			for( local i = 0; i < 64; i++ )
			{
				local t_ = {};
				t_.rot <- this.rz + (20 - this.rand() % 41) * 0,01745329.0;
				this.flag1.x = 25 + this.rand() % 1200;
				this.flag1.y = 0,00000000.0;
				this.flag1.RotateByRadian(t_.rot);
				this.team.slave.SetShot(this.x + this.flag1.x * this.direction, this.y + this.flag1.y, this.direction, this.team.slave.Shot_S3_LaserBullet, t_);
			}

			this.SetMotion(4949, 7);
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sy += 0,02500000.0;
				this.alpha = this.blue = this.green -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		::camera.Shake(3,00000000.0);
		this.cancelCount = 99;
		this.HitCycleUpdate(8);
		this.sx += 0,02500000.0;
		this.sy += 0,05000000.0;
		this.FitBoxfromSprite();
	};
}

function Shot_Dream1_Kaname( t )
{
	this.SetMotion(4969, 1);
	this.owner.shot_actor.Add(this);
	this.rz = -135 * 0,01745329.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(4,50000000.0, this.rz + 1,57079601.0, this.direction);
	this.alpha = 0,00000000.0;
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(4969, 0);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.y < ::battle.scroll_top - 128)
		{
			this.ReleaseActor();
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Shot_Dream1_Kaname_Back( t )
{
	this.SetMotion(4969, 0);
	this.DrawActorPriority(100);
	this.owner.shot_actor.Add(this);
	this.rz = -135 * 0,01745329.0;
	this.red = this.green = this.blue = 0,50000000.0;
	this.sx = this.sy = 0,75000000.0 - this.rand() % 10 * 0,01000000.0;
	this.SetSpeed_Vec(4,50000000.0 * this.sx, this.rz + 1,57079601.0, this.direction);
	this.func = [
		function ()
		{
			this.SetMotion(4969, 0);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y < ::battle.scroll_top - 128)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Dream2_Fire( t )
{
	this.SetMotion(4962, 10);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Dream2( t )
{
	this.SetMotion(4962, 9);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(1,50000000.0, this.rz, this.direction);
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Dream2_Fire, {});
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(4962, 10);
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,10000000.0;
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
		if (this.IsCamera(75))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
		}
	};
}

function Shot_Dream2_Kaname( t )
{
	this.SetMotion(4962, 6);
	this.owner.shot_actor.Add(this);
	this.alpha = 0,00000000.0;
	this.flag1 = 1;
	this.cancelCount = 10;
	this.func = [
		function ()
		{
			this.SetMotion(4962, 8);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.initTable.namazu)
			{
				this.Shot_Dream2_Namazu();
				return;
			}

			::camera.Shake(6,00000000.0);
			this.SetMotion(4962, 7);
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 30)
				{
					this.PlaySE(4225);
					this.SetSpeed_XY(0,00000000.0, 35,00000000.0);
				}

				if (this.owner.com_difficulty >= 2)
				{
					if (this.flag1 > 0 && this.count % this.flag1 == 0)
					{
						this.SetShot(this.x - 64 + this.rand() % 128, this.y + this.rand() % 128, this.direction, this.Shot_Dream2, {});
					}
				}

				if (this.y > ::battle.scroll_bottom + 128)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;
		this.SetSpeed_XY((this.target.x - this.x) * 0,10000000.0, 0,00000000.0);
		this.count++;

		if (this.count >= 90)
		{
			this.func[1].call(this);
			return;
		}
	};
}

function Shot_Dream2_Namazu()
{
	::camera.Shake(6,00000000.0);
	this.SetMotion(4962, 11);
	this.count = 0;
	this.sx = this.sy = 2,00000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.rz += 0,05235988.0;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
		this.count++;

		if (this.count == 45)
		{
			this.PlaySE(4225);
			this.SetSpeed_XY(0,00000000.0, 14,50000000.0);
		}

		if (this.flag1 > 0 && this.count % this.flag1 == 0)
		{
			this.SetShot(this.x - 96 + this.rand() % 192, this.y - 64 + this.rand() % 128, this.direction, this.Shot_Dream2, {});
		}

		if (this.y > ::battle.scroll_bottom + 256)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Dream3_CrainNamazu( t )
{
	this.SetMotion(5001, 2);
	this.cancelCount = 9999;
	this.DrawActorPriority(180);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag5 = 0;
	this.sx = this.sy = 0,50000000.0;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.sx = this.sy = 0,69999999.0;
		this.flag5 = 30;
		break;

	case 2:
		this.sx = this.sy = 0,89999998.0;
		this.flag5 = 20;
		break;

	case 3:
	case 4:
		this.sx = this.sy = 1,00000000.0;
		this.flag5 = 10;
		break;
	}

	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(5001, 4);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha = this.red = this.green = this.blue -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(5001, 3);
			this.SetSpeed_XY(2,00000000.0 * this.direction, 12,00000000.0);
			this.subState[1] = function ()
			{
				this.rz += 0,05235988.0;
				this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

				if (this.y > ::battle.scroll_bottom - 64)
				{
					this.PlaySE(4226);
					::camera.Shake(10,00000000.0);
					this.SetMotion(5001, 4);
					this.SetSpeed_XY(this.va.x * 0,20000000.0, this.va.y * 0,20000000.0);
					this.subState[1] = function ()
					{
						this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
						::camera.Shake(2,00000000.0);
						this.rz += 0,01745329.0;
						this.count++;

						if (this.flag5 > 0)
						{
							if (this.count % this.flag5 == 1)
							{
								this.SetShot(this.x - 128 + this.rand() % 256, ::battle.scroll_bottom + 96, this.direction, this.Shot_Dream3_KanameB, {});
							}

							if (this.count % (this.flag5 * 3) == 1)
							{
								this.SetShot(this.x - 128 + this.rand() % 256, ::battle.scroll_bottom + 96, this.direction, this.Shot_Dream3_Kaname, {});
							}
						}

						if (this.y > ::battle.scroll_bottom + 256)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(5001, 3);
			this.SetSpeed_XY(3,00000000.0 * this.direction, -6,00000000.0);
			this.subState[1] = function ()
			{
				this.rz += 0,05235988.0;
				this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
				this.AddSpeed_XY(0,00000000.0, 0,10000000.0);

				if (this.va.y > 0,00000000.0 && this.y > ::battle.scroll_bottom - 64)
				{
					this.PlaySE(4226);
					::camera.Shake(10,00000000.0);
					this.SetMotion(5001, 4);
					this.SetSpeed_XY(this.va.x * 0,20000000.0, this.va.y * 0,20000000.0);
					this.subState[1] = function ()
					{
						this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
						::camera.Shake(2,00000000.0);
						this.rz += 0,01745329.0;
						this.count++;

						if (this.flag5 > 0)
						{
							if (this.count % this.flag5 == 1)
							{
								this.SetShot(this.x - 128 + this.rand() % 256, ::battle.scroll_bottom + 96, this.direction, this.Shot_Dream3_KanameB, {});
							}

							if (this.count % (this.flag5 * 3) == 1)
							{
								this.SetShot(this.x - 128 + this.rand() % 256, ::battle.scroll_bottom + 96, this.direction, this.Shot_Dream3_Kaname, {});
							}
						}

						if (this.y > ::battle.scroll_bottom + 256)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Shot_Dream3_Kaname( t )
{
	this.SetMotion(4969, 4);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(2,00000000.0 + this.rand() % 11 * 0,10000000.0, (-45 - this.rand() % 40) * 0,01745329.0, this.direction);
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(4969, 5);
			this.stateLabel = function ()
			{
				this.rz -= 0,05235988.0;
				this.alpha = this.red = this.green = this.blue -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0 || this.y < ::battle.scroll_top - 64)
		{
			this.func[0].call(this);
			return;
		}

		this.rz -= 0,05235988.0;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	};
}

function Shot_Dream3_KanameB( t )
{
	this.SetMotion(4969, 6);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(4,00000000.0 + this.rand() % 21 * 0,10000000.0, (-45 - this.rand() % 40) * 0,01745329.0, this.direction);
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(4969, 7);
			this.stateLabel = function ()
			{
				this.rz -= 0,10471975.0;
				this.alpha = this.red = this.green = this.blue -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0 || this.y < ::battle.scroll_top - 64)
		{
			this.func[0].call(this);
			return;
		}

		this.rz -= 0,10471975.0;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	};
}

function Shot_Dream3_RideNamazu( t )
{
	this.SetMotion(5000, 1);
	this.cancelCount = 9999;
	this.DrawActorPriority(180);
	this.sx = this.sy = 0,50000000.0;
	this.flag1 = 1,50000000.0;
	this.flag2 = 0;
	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.subState[0] = function ()
	{
		this.sx = this.sy += (this.flag1 - this.sx) * 0,10000000.0;
		local y_ = (800 - (this.y + 180 * this.sy)) * 0,10000000.0;
		this.SetSpeed_XY(0,00000000.0, y_);
	};
	this.func = [
		function ()
		{
			::camera.Shake(30,00000000.0);
			this.SetMotion(5000, 3);
			this.SetSpeed_XY(-1,50000000.0 * this.direction, -4,50000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,10000000.0, null, 3,00000000.0);
			};
		},
		function ()
		{
		},
		function ( s_ )
		{
			this.PlaySE(4253);
			::camera.Shake(20,00000000.0);
			this.flag1 += s_;
			this.HitReset();
			this.SetMotion(5000, 2);
			this.flag2 = 0;
			this.subState[1] = function ()
			{
				this.flag2++;

				if (this.flag2 >= 10)
				{
					this.SetMotion(5000, 1);
					this.subState[1] = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

function Shot_Dream3_NamazuWave( t )
{
	this.SetMotion(4964, 9);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,50000000.0;
		this.alpha -= 0,02500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Dream3_NamazuWaveB, {});
}

function Shot_Dream3_NamazuWaveB( t )
{
	this.SetMotion(4964, 10);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,50000000.0;
		this.alpha -= 0,02000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Dream5_Back( t )
{
	this.SetMotion(4979, 0);
	this.DrawActorPriority(10);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy = 1,00000000.0 / ::camera.zoom;
		this.Warp((::camera.camera2d.left + ::camera.camera2d.right) * 0,50000000.0 - (::camera.target_x - 640) * 0,10000000.0, (::camera.camera2d.bottom + ::camera.camera2d.top) * 0,50000000.0 - (::camera.target_y - 360) * 0,10000000.0);
		this.alpha += 0,05000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy = 1,00000000.0 / ::camera.zoom;
				this.Warp((::camera.camera2d.left + ::camera.camera2d.right) * 0,50000000.0 - (::camera.target_x - 640) * 0,10000000.0, (::camera.camera2d.bottom + ::camera.camera2d.top) * 0,50000000.0 - (::camera.target_y - 360) * 0,10000000.0);
			};
		}
	};
}

function Shot_Dream5_BackBebri( t )
{
	this.SetMotion(4979, 1);
	this.DrawActorPriority(11);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Shot_Dream5_RideNamazu( t )
{
	this.SetMotion(5002, 1);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.cancelCount = 9999;
	this.DrawActorPriority(180);
	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.func = [
		function ()
		{
			::camera.Shake(30,00000000.0);
			this.SetMotion(5002, 3);
			this.SetSpeed_XY(-1,50000000.0 * this.direction, -4,50000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,10000000.0, null, 3,00000000.0);
			};
		},
		function ()
		{
			this.HitReset();
			this.SetMotion(5002, 2);
		},
		function ()
		{
			this.SetMotion(5002, 1);
		},
		function ()
		{
			this.SetMotion(5002, 4);
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
		this.HitCycleUpdate(60);
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

function Shot_Dream5_Fire( t )
{
	this.SetMotion(4971, 7);
	this.sx = this.sy = 1,75000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,92000002.0;
		this.alpha = this.green = this.blue -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Dream5_Barrage( t )
{
	this.SetMotion(4971, 5);
	this.owner.shot_actor.Add(this);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.va.y *= 0,50000000.0;
	this.AddSpeed_XY(4,50000000.0 * this.direction, 0,00000000.0);
	this.rz = this.atan2(this.va.y, this.va.x * this.direction);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 6);
			this.stateLabel = function ()
			{
				this.sy *= 0,92000002.0;
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return true;
		}

		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,07000000.0;
	};
}

function Shot_Dream5_BarrageB( t )
{
	this.SetMotion(4972, 5);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.SetSpeed_Vec(15,00000000.0, t.rot, this.direction);
	this.sx = this.sy = 0,50000000.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.cancelCount = 2;
	this.flag1 = 1,25000000.0;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 6);
			this.stateLabel = function ()
			{
				this.sy *= 0,92000002.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.Vec_Brake(0,50000000.0, 9,00000000.0))
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return true;
		}

		this.subState();
		this.sx = this.sy += (this.flag1 - this.sx) * 0,05000000.0;
		this.flag1 += 0,01000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

function Shot_Dream5_Ring( t )
{
	this.SetMotion(4973, 6);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 3;
	this.SetSpeed_Vec(10,00000000.0, t.rot, this.direction);
	this.hitResult = 128;
	local t_ = {};
	t_.rot <- t.rot;
	this.SetShot(this.x, this.y, this.direction, this.Shot_Dream5_RingB, t_);
	local t_ = {};
	t_.rot <- t.rot;
	this.SetShot(this.x, this.y, this.direction, this.Shot_Dream5_RingC, t_);
	this.func = [
		function ()
		{
			this.SetMotion(4973, 8);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,75000000.0, 0,50000000.0);
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
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 5)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += 0,01000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.HitCycleUpdate(3);
	};
}

function Shot_Dream5_RingB( t )
{
	this.SetMotion(4973, 6);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 3;
	this.SetSpeed_Vec(7,50000000.0, t.rot, this.direction);
	this.hitResult = 128;
	this.func = [
		function ()
		{
			this.SetMotion(4973, 8);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,75000000.0, 0,50000000.0);
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
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 5)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += 0,00750000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.HitCycleUpdate(3);
	};
}

function Shot_Dream5_RingC( t )
{
	this.SetMotion(4973, 6);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 3;
	this.SetSpeed_Vec(5,00000000.0, t.rot, this.direction);
	this.hitResult = 128;
	this.func = [
		function ()
		{
			this.SetMotion(4973, 8);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,75000000.0, 0,50000000.0);
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
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 5)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += 0,00500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.HitCycleUpdate(3);
	};
}

function Shot_Dream6_Back( t )
{
	this.SetMotion(4979, 0);
	this.DrawActorPriority(10);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy = 1,00000000.0 / ::camera.zoom;
		this.Warp((::camera.camera2d.left + ::camera.camera2d.right) * 0,50000000.0 - (::camera.target_x - 640) * 0,10000000.0, (::camera.camera2d.bottom + ::camera.camera2d.top) * 0,50000000.0 - (::camera.target_y - 360) * 0,10000000.0);
		this.alpha += 0,05000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy = 1,00000000.0 / ::camera.zoom;
				this.Warp((::camera.camera2d.left + ::camera.camera2d.right) * 0,50000000.0 - (::camera.target_x - 640) * 0,10000000.0, (::camera.camera2d.bottom + ::camera.camera2d.top) * 0,50000000.0 - (::camera.target_y - 360) * 0,10000000.0);
			};
		}
	};
}

function Shot_Dream6_RideNamazu( t )
{
	this.SetMotion(5003, 0);
	this.isVisible = false;
	this.cancelCount = 9999;
	this.DrawActorPriority(20);
	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.func = [
		function ()
		{
			::camera.Shake(30,00000000.0);
			this.SetMotion(this.motion, 3);
			this.SetSpeed_XY(-1,50000000.0 * this.direction, -4,50000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,10000000.0, null, 3,00000000.0);
			};
		},
		function ()
		{
			this.DrawActorPriority(20);
			this.SetMotion(this.motion, 4);
			this.isVisible = true;
		},
		function ()
		{
			this.DrawActorPriority(180);
			this.SetMotion(this.motion, 5);
			this.isVisible = true;
		},
		function ()
		{
			this.DrawActorPriority(20);
			this.SetMotion(this.motion, 4);
			this.isVisible = false;
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
		this.HitCycleUpdate(10);
	};
}

function Shot_Dream6_Blade( t )
{
	this.SetMotion(4978, 0);
	this.owner.shot_actor.Add(this);
	this.sx = this.sy = 2,00000000.0;
	this.FitBoxfromSprite();
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sy *= 0,98000002.0;
				this.alpha = this.blue = this.green -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.cancelCount = 99;
		this.HitCycleUpdate(20);
		this.sx = this.sy += 0,02500000.0;
		this.FitBoxfromSprite();
		this.count++;

		if (this.count % 2 == 0)
		{
			local t_ = {};
			t_.rot <- this.rz + (15 - this.rand() % 31) * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.Shot_Dream6_Barrage_Red, t_);
		}
	};
}

function Shot_Dream6_BladeB_Trail( t )
{
	this.SetMotion(4978, 6);
	this.rz = t.rot;
	this.sx = this.sy = 2,00000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,03000000.0;
		this.alpha = this.green = this.blue -= 0,07500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Dream6_BladeB( t )
{
	this.SetMotion(4978, 5);
	this.owner.shot_actor.Add(this);
	this.FitBoxfromSprite();
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 6);
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sx *= 0,98000002.0;
				this.sy += 0,07500000.0;
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
		this.cancelCount = 99;
		this.HitCycleUpdate(20);
		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,10000000.0;
		this.FitBoxfromSprite();
		this.count++;

		if (this.count % 4 == 1)
		{
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Dream6_BladeB_Trail, t_);
		}

		if (this.count % 30 <= 18 && this.count % 3 == 1)
		{
			this.PlaySE(870);
			local t_ = {};
			t_.rot <- this.rz - 1,57079601.0;
			this.SetShot(this.x, this.y, this.direction, this.Shot_Dream6_Barrage, t_);
		}
	};
}

function Shot_Dream6_Barrage( t )
{
	this.SetMotion(4978, 3);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.SetSpeed_Vec(2,00000000.0, t.rot, this.direction);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.sx = this.sy = 0,50000000.0;
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 4);
			this.stateLabel = function ()
			{
				this.sy *= 0,92000002.0;
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return true;
		}

		this.sx = this.sy += (1,25000000.0 - this.sx) * 0,07000000.0;
	};
}

function Shot_Dream6_Barrage_Red( t )
{
	this.SetMotion(4978, 7);
	this.DrawActorPriority(190);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.SetSpeed_Vec(1,00000000.0, t.rot, this.direction);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	local r_ = 175 + this.rand() % 681;
	this.Warp(this.x + this.va.x * r_, this.y + this.va.y * r_);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 8);
			this.stateLabel = function ()
			{
				this.sy *= 0,92000002.0;
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return true;
		}
	};
}

