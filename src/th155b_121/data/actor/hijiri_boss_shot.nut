function Boss_Shot_MS1( t )
{
	this.SetMotion(4939, 1);
	this.sx = this.sy = 3,00000000.0;
	this.alpha = 0,00000000.0;
	this.rz = t.rot;
	this.flag1 = this.Vector3();
	this.flag1.x = this.sin(this.rz) * this.direction * 0,20000000.0;
	this.flag1.y = this.cos(this.rz) * 0,20000000.0;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
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
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy -= 0,10000000.0;
		this.alpha += 0,05000000.0;

		if (this.sx == 1,00000000.0)
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
	this.SetSpeed_Vec(15,00000000.0, this.rz, this.direction);
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
		if (this.IsScreen(300,00000000.0))
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
	this.sx = this.sy = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (4,00000000.0 - this.sx) * 0,10000000.0;
		this.count++;

		if (this.count >= 6)
		{
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
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
	this.sx = this.sy = 0,50000000.0 + this.rand() % 21 * 0,10000000.0;
	this.SetSpeed_Vec(5,00000000.0, this.rz + 3,14159203.0, this.direction);
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,98000002.0;
		this.Vec_Brake(0,50000000.0, 1,00000000.0);
		this.count++;

		if (this.count >= 10)
		{
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Shot_Boss_MS2( t )
{
	this.SetMotion(4949, 0);
	this.SetSpeed_Vec(35, t.rot, this.direction);
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(4949, 4);
			this.SetSpeed_XY(-3 + this.rand() % 7, -5 - this.rand() % 3);
			this.stateLabel = function ()
			{
				this.rz -= 3,00000000.0 * 0,01745329.0;
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.PlaySE(870);
			this.SetMotion(4949, 1);
			this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction) + this.initTable.rot2;
			this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Boss_MS2_Line, t_);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.count = 0;
			this.keyAction = function ()
			{
				this.stateLabel = function ()
				{
					if (this.IsScreen(100))
					{
						this.ReleaseActor();
						return;
					}

					this.AddSpeed_Vec(0,50000000.0, this.rz, 30,00000000.0, this.direction);

					if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0)
					{
						this.func[0].call(this);
						return;
					}
				};
			};
			this.stateLabel = function ()
			{
				if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(3,00000000.0, 0,50000000.0);
		this.count++;
		this.rz += 24,00000000.0 * 0,01745329.0;

		if (this.count >= this.initTable.wait)
		{
			this.func[1].call(this);
			return;
		}
	};
}

function Shot_Boss_MS2_Line( t )
{
	this.SetMotion(4949, 3);
	this.rz = t.rot;
	this.alpha = 2,00000000.0;
	this.stateLabel = function ()
	{
		this.sx += 1,00000000.0;
		this.sy *= 0,89999998.0;
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Boss_Shot_MS4( t )
{
	this.owner.shot_actor.Add(this);
	this.SetMotion(4929, 2);
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(t.v, this.rz, this.direction);
	this.cancelCount = 2;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 3);
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
		if (this.IsScreen(200))
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

function Boss_Shot_MS5_Mini( t )
{
	this.owner.shot_actor.Add(this);
	this.SetMotion(4979, 6);
	this.rz = t.rot;
	this.sx = this.sy = 0,50000000.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(3,00000000.0, this.rz, this.direction);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(4979, 7);
			this.stateLabel = function ()
			{
				this.sy *= 0,89999998.0;
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
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;

		if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
		}
	};
}

function Boss_Shot_MS5_Aura( t )
{
	this.SetMotion(4979, 4);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha -= 0,10000000.0;
				this.sx = this.sy *= 0,98500001.0;

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

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}
	};
}

function Boss_Shot_MS5_BladeFire( t )
{
	this.SetMotion(4979, 2);
	this.rz = t.rot;
	this.sx = this.sy = 0,10000000.0;
	this.stateLabel = function ()
	{
		this.alpha = this.green = this.blue -= 0,03300000.0;
		this.sx = this.sy += 0,30000001.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Boss_Shot_MS5_BladeLine( t )
{
	this.SetMotion(4979, 8);
	this.sy = 0,00000000.0;
	this.func = [
		function ()
		{
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
		this.sy += (1,00000000.0 - this.sy) * 0,05000000.0;
	};
}

function Boss_Shot_MS5_Blade( t )
{
	this.SetMotion(4979, 1);
	this.rz = t.rot;
	this.sx = this.sy = 0,10000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.cancelCount = 99;
	this.hitResult = 128;
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_MS5_BladeFire, t_);
	this.flag1 = null;
	this.func = [
		function ()
		{
			this.SetMotion(4979, 2);

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.flag1 = null;
			this.stateLabel = function ()
			{
				this.alpha = this.green = this.blue -= 0,10000000.0;
				this.sx = this.sy *= 0,89999998.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.hitCount = 0;

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.flag1 = null;
			this.stateLabel = function ()
			{
				this.cancelCount = 99;
				this.HitCycleUpdate(6);
				this.sx = this.sy += (6,00000000.0 - this.sx) * 0,25000000.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			};
		},
		function ()
		{
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_MS5_BladeLine, {}).weakref();
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,15000001.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.flag1)
		{
			this.flag1.Warp(this.x, this.y);
			this.flag1.rz = this.rz;
		}
	};
	this.stateLabel = function ()
	{
		this.cancelCount = 99;
		this.HitCycleUpdate(30);
		this.subState();
	};
}

function Boss_Shot_MS5( t )
{
	this.SetMotion(4979, 0);
	this.rz = t.rot;
	this.flag1 = this.Vector3();
	this.flag1.x = 1,00000000.0;
	this.flag1.y = 0,00000000.0;
	this.flag1.RotateByRadian(t.rot);
	this.flag2 = 0,00000000.0;
	this.flag3 = null;
	this.flag4 = null;
	this.flag5 = 0,10471975.0;
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}

			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			this.flag3 = null;
			this.flag4 = null;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha = this.red = this.green = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		},
		function ()
		{
			this.flag3 = this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_MS5_Aura, {}).weakref();
			this.flag3.SetParent(this, 0, 0);
		},
		function ()
		{
			if (this.flag4)
			{
				if (this.flag4)
				{
					this.flag4.func[0].call(this.flag4);
				}
			}

			local t_ = {};
			t_.rot <- this.rz;
			this.flag4 = this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_MS5_Blade, t_).weakref();
		},
		function ()
		{
			this.SetSpeed_Vec(12,50000000.0, this.rz, this.direction);
			this.flag4.func[1].call(this.flag4);
			this.count = 0;
			this.flag4.hitCount = 0;
			this.flag4.grazeCount = 0;
			this.flag4.hitResult = 128;
			this.stateLabel = function ()
			{
				if (this.flag4.hitCount >= 3 || this.flag4.hitResult & 1 || this.flag4.grazeCount >= 5)
				{
					this.func[0].call(this);
					return;
				}

				this.subState();

				if (this.flag4)
				{
					this.flag4.Warp(this.point0_x, this.point0_y);
					this.flag4.rz = this.rz;
					this.flag4.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
				}
			};
			this.subState = function ()
			{
				this.Vec_Brake(1,00000000.0, 0,50000000.0);
				this.count++;

				if (this.count >= 45)
				{
					this.subState = function ()
					{
						this.AddSpeed_Vec(0,75000000.0, this.rz, 20,00000000.0, this.direction);

						if (this.flag4.point0_x < ::battle.scroll_left && this.va.x < 0,00000000.0 || this.flag4.point0_x > ::battle.scroll_right && this.va.x > 0,00000000.0 || this.flag4.point0_y < ::battle.scroll_top && this.va.y < 0,00000000.0 || this.flag4.point0_y > ::battle.scroll_bottom && this.va.y > 0,00000000.0)
						{
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
							::camera.Shake(4,00000000.0);
							this.PlaySE(1622);
							this.subState = function ()
							{
							};
						}
					};
				}
			};
		},
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func[2].call(this.flag4);
			}

			this.subState = function ()
			{
				this.flag1.RotateByRadian(this.flag5);
				this.flag2 += (150,00000000.0 - this.flag2) * 0,07500000.0;
				this.flag5 *= 0,89999998.0;
			};
		},
		function ()
		{
			local t_ = {};
			t_.rot <- this.rz;
			this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_MS5_Mini, t_);
		}
	];
	this.subState = function ()
	{
		this.flag1.RotateByRadian(this.flag5);
		this.flag2 += (150,00000000.0 - this.flag2) * 0,07500000.0;
		this.flag5 *= 0,95999998.0;

		if (this.flag5 < 0,01745329.0)
		{
			this.flag5 = 0,01745329.0;
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.Warp(this.owner.x + this.flag2 * this.flag1.x * this.direction, this.owner.y + this.flag2 * this.flag1.y);
		this.rz = this.atan2(this.flag1.y, this.flag1.x);

		if (this.flag4)
		{
			this.flag4.Warp(this.point0_x, this.point0_y);
			this.flag4.rz = this.rz;
			this.flag4.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
		}
	};
}

function Boss_Shot_DS1( t )
{
	this.SetMotion(4939, 3);
	this.sx = this.sy = 3,00000000.0;
	this.alpha = 0,00000000.0;
	this.rz = t.rot;
	this.SetSpeed_Vec(0,25000000.0, this.rz, this.direction);
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x;
	this.flag1.y = this.va.y;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
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
		this.sx = this.sy -= 0,10000000.0;
		this.alpha += 0,05000000.0;

		if (this.sx <= 1,00000000.0)
		{
			local m_ = this.owner.com_difficulty;

			if (m_ >= 4)
			{
				m_ = 3;
			}

			this.SetMotion(this.motion, 7 + m_);
			this.subState = function ()
			{
				this.AddSpeed_XY(this.flag1.x, this.flag1.y);
				this.count++;
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

function Boss_Shot_DS1_Line( t )
{
	this.SetMotion(4939, 6);
	this.rz = t.rot;
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,34000000.0;
		this.sy *= 0,92000002.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Boss_Shot_DS1_B( t )
{
	this.SetMotion(4939, 3);
	this.sx = this.sy = 3,00000000.0;
	this.alpha = 0,00000000.0;
	this.rz = t.rot;
	this.SetSpeed_Vec(0,25000000.0, this.rz, this.direction);
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x;
	this.flag1.y = this.va.y;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
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
		this.sy -= 0,10000000.0;
		this.sx += (2,00000000.0 - this.sx) * 0,15000001.0;
		this.alpha += 0,05000000.0;

		if (this.sy <= 0,50000000.0)
		{
			this.SetMotion(this.motion, 0);
			this.subState = function ()
			{
				this.AddSpeed_XY(this.flag1.x, this.flag1.y);
				this.count++;

				if (this.count >= 5)
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

function Boss_Shot_MS1_B( t )
{
	this.SetMotion(4939, 1);
	this.sx = this.sy = 3,00000000.0;
	this.alpha = 0,00000000.0;
	this.rz = t.rot;
	this.flag1 = this.Vector3();
	this.flag1.x = this.cos(this.rz) * this.direction * 0,20000000.0;
	this.flag1.y = this.sin(this.rz) * 0,20000000.0;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
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
		this.sx = this.sy -= 0,10000000.0;
		this.alpha += 0,05000000.0;

		if (this.sx <= 1,00000000.0)
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

