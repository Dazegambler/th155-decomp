function BeginBattle_Smoke( t )
{
	this.SetMotion(9001, 0);
}

function ShotRaccoonKO()
{
	this.owner.Lost_Raccoon(1);
	this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.CommonSmoke_Core, {});
	this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.FallRaccoon, {});
}

function AttackObject( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(5999, 0);
	this.stateLabel = function ()
	{
		local o_ = this.owner;
		this.x = o_.x;
		this.y = o_.y;

		if (o_.motion == 1230)
		{
			if (o_.keyTake >= 2)
			{
				this.SetMotion(5999, 1);
				this.stateLabel = function ()
				{
				};
			}
		}
		else
		{
			this.ReleaseActor();
			return;
		}
	};
}

function AttackObject_Mid( t )
{
	this.SetMotion(5997, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec();
}

function CommonSmoke_Demo( t )
{
	this.SetMotion(5997, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(this.rand() % 3, this.rz, this.direction);
	this.sx = this.sy = 2,00000000.0;
	local st_ = function ( t_ )
	{
		this.SetMotion(5997, this.rand() % 4);
		this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
		this.rz = this.rand() % 360 * 0,01745329.0;
		this.SetSpeed_Vec(4 + this.rand() % 8, t_.rot, this.direction);
		this.SetSpeed_XY(null, this.va.y * 0,50000000.0);
		local r_ = 3 + this.rand() % 5;
		this.Warp(this.x + this.va.x * r_, this.y + this.va.y * r_);
		this.flag1 = 0,04000000.0 + this.rand() % 20 * 0,00100000.0;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,97000003.0;
			this.VX_Brake(0,44999999.0);
			this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
			this.alpha -= this.flag1;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};

	for( local i = 0; i < 360; i = i + 45 )
	{
		local t_ = {};
		t_.rot <- (i + this.rand() % 30) * 0,01745329.0;
		this.owner.demoObject.append(this.SetFreeObject(this.x, this.y, this.direction, st_, t_).weakref());
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,98000002.0;
		this.VX_Brake(0,44999999.0);
		this.AddSpeed_XY(0,00000000.0, -0,44999999.0);
		this.alpha -= 0,07500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function CommonSmoke_Core( t )
{
	this.SetMotion(5997, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(this.rand() % 3, this.rz, this.direction);
	this.sx = this.sy = 2,00000000.0;
	local st_ = function ( t_ )
	{
		this.SetMotion(5997, this.rand() % 4);
		this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
		this.rz = this.rand() % 360 * 0,01745329.0;
		this.SetSpeed_Vec(14 + this.rand() % 8, t_.rot, this.direction);
		this.SetSpeed_XY(null, this.va.y * 0,50000000.0);
		local r_ = 3 + this.rand() % 5;
		this.Warp(this.x + this.va.x * r_, this.y + this.va.y * r_);
		this.flag1 = 0,12500000.0 + this.rand() % 20 * 0,00100000.0;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,93000001.0;
			this.VX_Brake(0,44999999.0);
			this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
			this.alpha -= this.flag1;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};

	for( local i = 0; i < 360; i = i + 45 )
	{
		local t_ = {};
		t_.rot <- (i + this.rand() % 30) * 0,01745329.0;
		this.SetFreeObject(this.x, this.y, this.direction, st_, t_);
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,89999998.0;
		this.VX_Brake(0,44999999.0);
		this.AddSpeed_XY(0,00000000.0, -0,44999999.0);
		this.alpha -= 0,07500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function FallRaccoon( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(5996, this.rand() % 5);
	this.SetSpeed_XY((-6,00000000.0 - this.rand() % 4) * this.direction, -12,00000000.0);
	this.stateLabel = function ()
	{
		this.rz -= 8,00000000.0 * 0,01745329.0;
		this.VX_Brake(0,10000000.0);
		this.AddSpeed_XY(0,00000000.0, 0,40000001.0);

		if (this.IsScreen(100))
		{
			this.ReleaseActor();
		}
	};
}

function NormalShot( t )
{
	this.SetMotion(2009, 0);
	this.atk_id = 16384;
	this.flag1 = t.count;
	this.flag2 = (-80 + this.rand() % 160) * 0,01745329.0;
	this.flag3 = t.shotRot;
	this.flag4 = 0;
	this.cancelCount = 1;
	this.SetSpeed_Vec(14,50000000.0, t.rot, this.direction);
	this.rz = t.rot;
	this.func = function ()
	{
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.stateLabel = null;
		this.SetMotion(this.motion, 6);
		this.keyAction = this.ReleaseActor;
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		this.SetSpeed_XY(this.va.x * 0,85000002.0, this.va.y * 0,85000002.0);
		this.rz += this.flag2;
		this.flag2 *= 0,89999998.0;
		this.count++;

		if (this.count >= this.flag1)
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurst, {});
			this.PlaySE(2620);
			this.count = 0;
			this.flag4 = (5 - this.rand() % 10) * 0,01745329.0;
			this.rz = this.flag4 + this.flag3;
			this.SetSpeed_Vec(5,00000000.0, this.rz, this.direction);
			this.SetMotion(2009, 1);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 1))
				{
					this.ReleaseActor();
					return true;
				}

				this.count++;
				this.AddSpeed_Vec(0,20000000.0, this.rz, 10,00000000.0, this.direction);
				this.sy = 1,00000000.0 + 0,10000000.0 * this.sin(0,01745329.0 * this.count * 18);

				if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 1)
				{
					this.func();
					return;
				}

				this.TargetHoming(this.owner.target, 0,25000000.0 * 0,01745329.0, this.direction);
			};
		}
	};
}

function Common_SmokeBurst( t )
{
	this.SetMotion(2009, 6);
	this.keyAction = this.ReleaseActor;
}

function Common_SmokeBurstB( t )
{
	this.SetMotion(2019, 4);
	this.keyAction = this.ReleaseActor;
}

function NormalShot_Smoke( t )
{
	this.SetMotion(7012, this.rand() % 4);
	this.sx = this.sy = 0,25000000.0 + this.rand() % 25 * 0,01000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = 3 + this.rand() % 4;
	this.flag2 = 0;
	this.flag3 = 0,03500000.0 + this.rand() % 15 * 0,01000000.0;
	this.SetSpeed_Vec(this.flag1, t.rot, this.direction);
	this.stateLabel = function ()
	{
		this.flag1 -= 0,50000000.0;

		if (this.flag1 < 1,00000000.0)
		{
			this.flag1 = 1,00000000.0;
		}

		this.flag2 -= 0,20000000.0;
		this.SetSpeed_Vec(this.flag1, this.initTable.rot, this.direction);
		this.AddSpeed_XY(0,00000000.0, this.flag2);
		this.alpha -= this.flag3;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}

		this.AddSpeed_XY(0,00000000.0, -0,50000000.0);
	};
}

function NormalShot_SmokeCore( t )
{
	this.SetMotion(7012, this.rand() % 4);
	this.sx = this.sy = 0,75000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	local i = 0;

	while (i < 3)
	{
		i++;
		local t_ = {};
		t_.rot <- this.rand() % 360 * 0,01745329.0;
		t_.range <- 10 + this.rand() % 20;
		this.SetFreeObject(this.x + t_.range * this.cos(t_.rot) * this.direction, this.y + t_.range * this.sin(t_.rot), this.direction, this.NormalShot_Smoke, t_);
	}

	this.stateLabel = function ()
	{
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}

		this.AddSpeed_XY(0,00000000.0, -0,50000000.0);
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, this.rand() % 4);
	this.atk_id = 65536;
	this.flag2 = 5;
	this.AddSpeed_Vec(25,00000000.0, t.rot, null, this.direction);
	this.sx = this.sy = 0,89999998.0 + this.rand() % 20 * 0,01000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = (6 + this.rand() % 14) * 0,01745329.0;
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		this.count++;
		this.rz += this.flag1;
		this.flag1 *= 0,94999999.0;
		this.SetSpeed_XY(this.va.x * 0,87500000.0, this.va.y * 0,87500000.0);
		this.HitCycleUpdate();

		if (this.count >= 40 || this.cancelCount <= 0 || this.hitCount >= 1 || this.grazeCount >= this.flag2 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.callbackGroup = 0;
			this.SetMotion(2019, this.rand() % 4);
			this.rz = this.rand() % 360 * 0,01745329.0;
			local i = 0;

			while (i < 3)
			{
				i++;
				local t_ = {};
				t_.rot <- this.rand() % 360 * 0,01745329.0;
				t_.range <- 10 + this.rand() % 20;
				this.SetFreeObject(this.x + t_.range * this.cos(t_.rot) * this.direction, this.y + t_.range * this.sin(t_.rot), this.direction, this.NormalShot_Smoke, t_);
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,05000000.0;
				this.SetSpeed_XY(this.va.x * 0,87500000.0, this.va.y * 0,87500000.0);

				if (this.alpha > 0,05000000.0)
				{
					this.alpha -= 0,05000000.0;
				}
				else
				{
					this.ReleaseActor();
				}
			};
			return;
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2029, 0);
	this.atk_id = 131072;
	this.SetSpeed_XY(6,00000000.0 * this.direction, -6,00000000.0);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = 0;
	this.flag2 = 0;
	this.flag4 = 10,00000000.0 * 0,01745329.0;
	this.func = function ()
	{
		this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurstB, {});
		this.ReleaseActor();
		return;
	};
	this.subState = function ()
	{
		if (this.IsScreen(150,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.grazeCount >= 5 || this.hitCount > 0 || this.owner.motion == 2020 && this.owner.keyTake == 0)
		{
			this.func();
			return true;
		}

		this.HitCycleUpdate(0);
		return false;
	};
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,25000000.0);
		this.AddSpeed_XY(0,00000000.0, this.va.y < 0,00000000.0 ? 0,50000000.0 : 0,10000000.0);

		if (this.va.x > 0 && this.x > ::battle.corner_right - 20)
		{
			this.x = ::battle.corner_right - 20;
			this.SetSpeed_XY(0,00000000.0, null);
		}

		if (this.va.x < 0 && this.x < ::battle.corner_left + 20)
		{
			this.x = ::battle.corner_left + 20;
			this.SetSpeed_XY(0,00000000.0, null);
		}

		this.count++;
		this.rz += this.flag4;
		this.flag4 *= 0,98000002.0;
		this.flag5 = {};
		this.flag5.scale <- 1,00000000.0;
		this.flag5.t_scale <- 1,00000000.0;

		if (this.count >= 30)
		{
			this.rz = 0,00000000.0;
			this.PlaySE(2634);
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurst, {});

			switch(this.initTable.type)
			{
			case 8:
				this.SetMotion(this.motion, 1);
				this.SetSpeed_XY(-5,00000000.0 * this.direction, -5,00000000.0);
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.flag5.scale += (this.flag5.t_scale - this.flag5.scale) * 0,10000000.0;
					this.sx = 1,00000000.0 + this.sin(this.count * 12 * 0,01745329.0) * 0,15000001.0;
					this.sy = (2,00000000.0 - this.sx) * this.flag5.scale;
					this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
					this.count++;
					this.ry += 9,00000000.0 * 0,01745329.0;

					if (this.va.y > 0,00000000.0 && this.y + 25 >= ::camera.camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 25 <= ::camera.camera2d.top)
					{
						this.SetSpeed_XY(this.va.x, -this.va.y);
					}

					if (this.va.x * this.direction < 0,00000000.0)
					{
						if (this.direction == 1,00000000.0 && this.x - 25 <= ::camera.camera2d.left || this.direction == -1,00000000.0 && this.x + 25 >= ::camera.camera2d.right)
						{
							this.SetSpeed_XY(-this.va.x, this.va.y);
						}
					}
				};
				break;

			case 2:
				this.SetMotion(this.motion, 1);
				this.SetSpeed_XY(-5,00000000.0 * this.direction, 5,00000000.0);
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.flag5.scale += (this.flag5.t_scale - this.flag5.scale) * 0,10000000.0;
					this.sx = 1,00000000.0 + this.sin(this.count * 12 * 0,01745329.0) * 0,15000001.0;
					this.sy = (2,00000000.0 - this.sx) * this.flag5.scale;
					this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
					this.count++;
					this.ry += 9,00000000.0 * 0,01745329.0;

					if (this.va.y > 0,00000000.0 && this.y + 25 >= ::camera.camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 25 <= ::camera.camera2d.top)
					{
						this.SetSpeed_XY(this.va.x, -this.va.y);
					}

					if (this.va.x * this.direction < 0,00000000.0)
					{
						if (this.direction == 1,00000000.0 && this.x - 25 <= ::camera.camera2d.left || this.direction == -1,00000000.0 && this.x + 25 >= ::camera.camera2d.right)
						{
							this.SetSpeed_XY(-this.va.x, this.va.y);
						}
					}
				};
				break;

			default:
				this.SetSpeed_XY(4,00000000.0 * this.direction, -10,00000000.0);
				this.flag3 = 0;
				this.flag1 = this.y + 150;
				this.SetMotion(this.motion, 2);
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.sx = 1,00000000.0 + this.sin(this.count * 12 * 0,01745329.0) * 0,15000001.0;
					this.sy = 2,00000000.0 - this.sx;
					this.count++;
					this.ry += 9,00000000.0 * 0,01745329.0;

					if (this.flag3 == 0)
					{
						this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

						if (this.va.y > 0,00000000.0 && this.y >= this.flag1)
						{
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
							this.Warp(this.x, this.flag1);
							this.flag3 = 10;
						}
					}
					else
					{
						this.flag3--;

						if (this.flag3 <= 0)
						{
							this.SetSpeed_XY(4,00000000.0 * this.direction, -15,00000000.0);
						}
					}

					if (this.IsScreen(150,00000000.0))
					{
						this.ReleaseActor();
						return;
					}
				};
				break;
			}
		}
	};
}

function Shot_Barrage_Fire( t )
{
	this.SetMotion(2026, 2 + this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,10000000.0;
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, 0);
	this.atk_id = 262144;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Barrage_Fire, {});
	this.SetSpeed_Vec(1,00000000.0, t.rot, this.direction);
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x * 0,10000000.0;
	this.flag1.y = this.va.y * 0,10000000.0;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, 1);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.keyAction = this.ReleaseActor;
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,05000000.0;
			this.alpha -= 0,10000000.0;
		};
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		this.AddSpeed_XY(this.flag1.x, this.flag1.y);

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}
	};
}

function Shot_Okult( t )
{
	this.SetMotion(2508, t.type);
	this.atk_id = 524288;
	this.SetSpeed_Vec(15,00000000.0, t.rot, this.direction);
	this.cancelCount = 3;
	this.flag1 = false;
	this.func = [
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurstB, {});
			this.ReleaseActor();
		},
		function ()
		{
			this.PlaySE(2697);
			local n_ = 3;

			if (this.owner.alien.len() >= n_)
			{
				this.owner.alien[0].func[0].call(this.owner.alien[0]);
			}

			this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});

			switch(this.initTable.type)
			{
			case 1:
				this.owner.alien.append(this.SetObject(this.point0_x, this.point0_y, this.direction, this.Occult_AlienB, {}).weakref());
				break;

			case 2:
				this.owner.alien.append(this.SetObject(this.point0_x, this.point0_y, this.direction, this.Occult_AlienC, {}).weakref());
				break;

			default:
				this.owner.alien.append(this.SetObject(this.point0_x, this.point0_y, this.direction, this.Occult_AlienA, {}).weakref());
				break;
			}
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.team.current.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		if (this.flag1)
		{
			this.count++;

			if (this.count >= 10 && this.hitTarget)
			{
				this.callbackGroup = 0;
			}
		}

		this.rz -= 15,00000000.0 * 0,01745329.0;
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

		if (this.va.x > 6,00000000.0 && this.x >= ::battle.corner_right || this.va.x < -6,00000000.0 && this.x <= ::battle.corner_left)
		{
			this.SetSpeed_XY(-this.va.x * 0,50000000.0, null);
			this.flag1 = true;
		}

		if (this.va.y > 0,00000000.0)
		{
			if (this.y >= this.owner.centerY && this.initTable.ground == false)
			{
				this.func[1].call(this);
				this.ReleaseActor();
			}

			if (this.y >= ::battle.scroll_bottom && this.initTable.ground)
			{
				this.PlaySE(2697);

				if (this.va.y > 20,00000000.0)
				{
					this.va.y = 20,00000000.0;
				}

				this.SetSpeed_XY(this.va.x * 0,66000003.0, -this.va.y);
				this.initTable.ground = false;
				this.callbackGroup = 0;
				this.flag1 = true;
			}
		}
	};
	this.keyAction = function ()
	{
		this.func[1].call(this);
		this.ReleaseActor();
	};
}

function Occult_AlienA( t )
{
	this.SetMotion(2505, 0);
	this.DrawActorPriority(180);
	this.target = this.owner.target.weakref();
	this.func = [
		function ()
		{
			foreach( val, a in this.owner.alien )
			{
				if (a == this)
				{
					this.owner.alien.remove(val);
				}
			}

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurst, {});
			this.ReleaseActor();
		},
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.owner.ShotRaccoonKO();
			this.ReleaseActor();
		},
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurst, {});
			this.SetMotion(2505, 1);
			this.DrawActorPriority(200);

			if ((this.owner.target.x - this.x) * this.direction < 0)
			{
				this.direction = -this.direction;
			}

			this.count = 0;
			this.flag3 = 5;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 90 || this.team.current.IsDamage())
				{
					this.func[0].call(this);
				}

				this.SetSpeed_XY(1,50000000.0 * this.cos(this.count * 2 * 0,01745329.0) * this.direction, 1,50000000.0 * this.cos(this.count * 4 * 0,01745329.0));

				if (this.life <= 0)
				{
					this.func[1].call(this);
					return;
				}

				if (this.flag3 > 0 && this.count % 14 == 1)
				{
					this.flag3--;
					this.PlaySE(2701);
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Occult_BeamB, {});
				}

				if (this.count == 60)
				{
					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}
				}
			};
		}
	];
	this.life = 1;
	this.stateLabel = function ()
	{
		this.count++;
		this.SetSpeed_XY(1,50000000.0 * this.cos(this.count * 2 * 0,01745329.0) * this.direction, 1,50000000.0 * this.cos(this.count * 4 * 0,01745329.0));
	};
}

function Occult_BeamB( t )
{
	this.SetMotion(2505, 3);
	this.atk_id = 524288;
	this.cancelCount = 1;
	this.rz = (-10 + this.rand() % 21) * 0,01745329.0;
	this.SetSpeed_Vec(12,00000000.0, this.rz, this.direction);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.sx = this.sy = 0,10000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,75000000.0;

			if (this.sx <= 0,01000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += 0,10000000.0;

		if (this.sx > 1,00000000.0)
		{
			this.sx = this.sy = 1,00000000.0;
		}

		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func();
			return;
		}
	};
}

function Occult_Beam( t )
{
	this.SetMotion(2505, 2);
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
	this.anime.left = 0;
	this.anime.height = 128;
	this.anime.width = 0;
	this.anime.center_x = 0;
	this.anime.center_y = 64;
	this.sy = 0,20000000.0;
	this.SetCollisionScaling(0,10000000.0, 1,00000000.0, 1,00000000.0);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.anime.left += 50;
				this.anime.width += 20;
				this.sy -= 0,02000000.0;

				if (this.sy <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.anime.left += 50;
		this.anime.width += 20;
		this.HitCycleUpdate(12);
		this.SetCollisionScaling(this.anime.width / 128,00000000.0, 1,00000000.0, 1,00000000.0);
	};
}

function Occult_AlienB( t )
{
	this.SetMotion(2506, 0);
	this.atk_id = 524288;
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			foreach( val, a in this.owner.alien )
			{
				if (a == this)
				{
					this.owner.alien.remove(val);
				}
			}

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurstB, {});
			this.ReleaseActor();
		},
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.owner.ShotRaccoonKO();
			this.ReleaseActor();
		},
		function ()
		{
			this.DrawActorPriority(200);
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurstB, {});
			this.PlaySE(2703);

			if ((this.owner.target.x - this.x) * this.direction < 0)
			{
				this.direction = -this.direction;
			}

			this.SetMotion(2506, 1);
			this.count = 0;
			this.SetSpeed_XY(6,00000000.0 * this.direction, 2,00000000.0);
			this.keyAction = function ()
			{
				if (this.life > 0)
				{
					this.flag1 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Occult_AlienB_Effect, {}).weakref();
					this.SetParent.call(this.flag1, this, this.flag1.x - this.x, this.flag1.y - this.y);
					this.stateLabel = function ()
					{
						if (this.x > ::battle.corner_right && this.va.x > 0,00000000.0 || this.x < ::battle.corner_left && this.va.x < 0,00000000.0)
						{
							this.SetSpeed_XY(0,00000000.0, null);
						}

						this.count++;

						if (this.life <= 0)
						{
							this.func[1].call(this);
							return;
						}

						this.HitCycleUpdate(10);

						if (this.count >= 45)
						{
							this.AddSpeed_XY(0,05000000.0 * this.direction, this.va.y > -17,50000000.0 ? -0,75000000.0 : 0,00000000.0);
						}
						else
						{
							this.AddSpeed_XY(null, -0,05000000.0);
							this.VX_Brake(0,05000000.0);
						}

						if (this.count >= 135)
						{
							this.func[0].call(this);
						}
					};
				}
			};
			this.stateLabel = function ()
			{
				this.count++;

				if (this.life <= 0)
				{
					this.func[1].call(this);
					return;
				}

				this.HitCycleUpdate(10);
				this.AddSpeed_XY(null, -0,05000000.0);
				this.VX_Brake(0,05000000.0);

				if (this.x > ::battle.corner_right && this.va.x > 0,00000000.0 || this.x < ::battle.corner_left && this.va.x < 0,00000000.0)
				{
					this.SetSpeed_XY(0,00000000.0, null);
				}
			};
		}
	];
	this.life = 200;
	this.flag5 = this.y;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 30 == 1)
		{
			this.SetSpeed_XY(0,00000000.0, -7,50000000.0);
		}

		this.AddSpeed_XY(0,00000000.0, 0,75000000.0);

		if (this.y >= this.flag5 && this.va.y > 0,00000000.0)
		{
			this.y = this.flag5;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		}
	};
}

function Occult_AlienC_Effect( t )
{
	this.SetMotion(2507, 3);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
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

function Occult_AlienB_Effect( t )
{
	this.SetMotion(2506, 3);
	this.rx = -55 * 0,01745329.0;
	this.ry = -10 * 0,01745329.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.SetTaskAddRotation(0, 0, -25,00000000.0 * 0,01745329.0);
}

function Occult_AlienC( t )
{
	this.SetMotion(2507, 0);
	this.atk_id = 524288;
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			foreach( val, a in this.owner.alien )
			{
				if (a == this)
				{
					this.owner.alien.remove(val);
				}
			}

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurstB, {});
			this.ReleaseActor();
		},
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.owner.ShotRaccoonKO();
			this.ReleaseActor();
		},
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurstB, {});
			this.PlaySE(2705);

			if ((this.owner.target.x - this.x) * this.direction < 0)
			{
				this.direction = -this.direction;
			}

			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(2507, 1);
			this.DrawActorPriority(200);
			this.count = 0;
			this.keyAction = function ()
			{
				this.count = 0;
				this.stateLabel = function ()
				{
					if (this.count % 10 == 1)
					{
						this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Occult_AlienC_Effect, {}).weakref();
					}

					this.count++;

					if (this.life <= 0)
					{
						this.func[1].call(this);
						return;
					}

					if (this.hitCount <= 3)
					{
						this.HitCycleUpdate(5);
					}

					this.AddSpeed_XY(this.va.x * this.direction <= 12,50000000.0 ? 0,75000000.0 * this.direction : 0,00000000.0, 0,00000000.0);

					if (this.count >= 90)
					{
						this.func[0].call(this);
					}
				};
			};
			this.stateLabel = function ()
			{
				this.count++;

				if (this.life <= 0)
				{
					this.func[1].call(this);
					return;
				}

				this.AddSpeed_XY(0,10000000.0 * this.direction, 0,00000000.0);
			};
		}
	];
	this.life = 200;
	this.stateLabel = function ()
	{
		this.count++;
		this.SetSpeed_XY(0,00000000.0, 1,00000000.0 * this.cos(this.count * 6 * 0,01745329.0));
	};
}

function Shot_Change_Core( t )
{
	this.SetSpeed_Vec(15,00000000.0, t.rot, this.direction);
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		this.count++;

		if (this.count % 4 == 3)
		{
			local t_ = {};
			t_.v <- 0,10000000.0;
			t_.rot <- this.initTable.rot2;
			this.SetShot(this.x, this.y, this.direction, this.Shot_Change, t_);
			local t_ = {};
			t_.v <- 0,20000000.0;
			t_.rot <- this.initTable.rot2;
			this.SetShot(this.x, this.y, this.direction, this.Shot_Change, t_);
			local t_ = {};
			t_.v <- 0,30000001.0;
			t_.rot <- this.initTable.rot2;
			this.SetShot(this.x, this.y, this.direction, this.Shot_Change, t_);
			this.flag1++;

			if (this.flag1 >= 6)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.atk_id = 536870912;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = 0,52359873.0;
	this.flag2 = this.Vector3();
	this.cancelCount = 3;
	this.sx = this.sy = 0,50000000.0 + this.rand() % 11 * 0,10000000.0;
	this.func = [
		function ()
		{
			this.keyAction = this.ReleaseActor;
			this.SetMotion(this.motion, 6);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.sx = this.sy = 1,00000000.0;
			this.rz = this.initTable.rot;
			this.SetSpeed_Vec(1,00000000.0, this.rz, this.direction);
			this.flag2.x = this.va.x * this.initTable.v;
			this.flag2.y = this.va.y * this.initTable.v;
			this.SetMotion(this.motion, 1);
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurst, {});
			this.PlaySE(2620);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 3))
				{
					this.ReleaseActor();
					return true;
				}

				this.AddSpeed_XY(this.flag2.x, this.flag2.y);
				this.sy = 1,00000000.0 + 0,10000000.0 * this.sin(0,01745329.0 * this.count * 18);

				if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
					return true;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 3))
		{
			this.ReleaseActor();
			return true;
		}

		this.rz += this.flag1;
		this.flag1 *= 0,89999998.0;
		this.count++;

		if (this.count >= 20)
		{
			this.func[1].call(this);
		}
	};
}

function SPShot_A_Smoke( t )
{
	this.priority = 200;
	this.SetMotion(6000, 0);
	this.keyAction = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function SPShot_A_Dummy( t )
{
	this.priority = 200;
	this.SetMotion(6000, 1);
	this.SetShot(this.x, this.y, this.direction, this.SPShot_A_Smoke, {});
	this.stateLabel = function ()
	{
		if (this.owner.motion != 3000)
		{
			this.SetShot(this.x, this.y, this.direction, this.SPShot_A_Smoke, {});
			this.ReleaseActor();
		}
		else if (this.owner.keyTake != 2)
		{
			this.SetShot(this.x, this.y, this.direction, this.SPShot_A_Smoke, {});
			this.ReleaseActor();
		}
	};
}

function SPShot_A_Shot( t )
{
	this.SetMotion(3009, this.rand() % 4);
	this.atk_id = 1048576;
	this.flag2 = 5;
	this.AddSpeed_Vec(25,00000000.0, t.rot, null, this.direction);
	this.sx = this.sy = 0,89999998.0 + this.rand() % 20 * 0,01000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = (6 + this.rand() % 14) * 0,01745329.0;
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		this.count++;
		this.rz += this.flag1;
		this.flag1 *= 0,94999999.0;
		this.SetSpeed_XY(this.va.x * 0,87500000.0, this.va.y * 0,87500000.0);
		this.HitCycleUpdate();

		if (this.count >= 40 || this.cancelCount <= 0 || this.hitCount >= 1 || this.grazeCount >= this.flag2 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.callbackGroup = 0;
			this.SetMotion(2019, this.rand() % 4);
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurstB, {});
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,05000000.0;
				this.SetSpeed_XY(this.va.x * 0,87500000.0, this.va.y * 0,87500000.0);

				if (this.alpha > 0,05000000.0)
				{
					this.alpha -= 0,05000000.0;
				}
				else
				{
					this.ReleaseActor();
				}
			};
			return;
		}
	};
}

function SPShot_B( t )
{
	this.SetMotion(6010, 1);
	this.atk_id = 2097152;
	this.cancelCount = 3;
	this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurst, {});
	this.SetSpeed_XY(t.vx * this.direction, t.vy);
	this.flag1 = (6,00000000.0 + this.rand() % 3) * 0,01745329.0;
	this.flag2 = [];
	this.flag4 = this.Vector3();
	this.sx = this.sy = 0,00000000.0;
	this.func = function ()
	{
		this.SetMotion(this.motion, 1);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

		for( local i = 0; i < 6; i++ )
		{
			local t_ = {};
			t_.scale <- this.sx;
			this.SetFreeObject(this.x + this.rand() % 50 - 25, this.y + this.rand() % 50 - 25, this.direction, this.SPShot_B_Particle, t_);
		}

		this.stateLabel = function ()
		{
			this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
			this.sx = this.sy *= 0,89999998.0;
			this.alpha = this.green = this.red -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		this.rz += this.flag1;

		if (this.count >= 60)
		{
			this.sx = this.sy += (1,00000000.0 - this.sx) * 0,33000001.0;
		}
		else
		{
			this.sx = this.sy += (0,25000000.0 - this.sx) * 0,15000001.0;
		}

		this.count++;

		if (this.count % 4 == 1)
		{
			local t_ = {};
			t_.scale <- this.sx;
			this.SetFreeObject(this.x + this.rand() % 50 - 25, this.y + this.rand() % 50 - 25, this.direction, this.SPShot_B_Particle, t_);
		}

		if (this.count % 12 == 1)
		{
			local t_ = {};
			t_.scale <- this.sx;
			local a_ = this.SetFreeObject(this.x + this.rand() % 20 - 10, this.y + this.rand() % 20 - 10, this.direction, this.SPShot_B2, t_);
			a_.SetParent(this, this.x - a_.x, this.y - a_.y);
		}

		if (this.IsScreen(275,00000000.0))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.owner.motion == 3010 && this.owner.keyTake == 0 || this.Damage_ConvertOP(this.x, this.y, 3))
		{
			this.func();
			return;
		}
	};
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,75000000.0);

		if (this.count >= 30)
		{
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,25000000.0);

				if (this.count >= 60)
				{
					this.SetMotion(6010, 0);
					this.flag3 = this.GetTargetAngle(this.owner.target, this.direction);
					this.flag4.x = this.cos(this.flag3);
					this.flag4.y = this.sin(this.flag3);
					this.SetSpeed_Vec(1,50000000.0, this.flag3, this.direction);
					this.stateLabel = function ()
					{
						this.TargetHoming(this.owner.target, 0,01745329.0 * 1,25000000.0, this.direction);
						this.AddSpeed_Vec(1,50000000.0, null, 25,00000000.0, this.direction);
						this.subState();
					};
				}

				this.subState();
			};
		}

		this.subState();
	};
}

function SPShot_B2( t )
{
	this.SetMotion(6010, 1);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,50000000.0 + this.rand() % 5 * 0,10000000.0 * t.scale;
	this.alpha = this.green = this.red = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0 * this.initTable.scale;
		this.alpha = this.green = this.red += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = this.green = this.red = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,02500000.0 * this.initTable.scale;
				this.alpha = this.green = this.red -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_B_Particle( t )
{
	this.SetMotion(6010, 2 + this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = 1,75000000.0 + this.rand() % 175 * 0,01000000.0 * t.scale;
	this.sy = 1,75000000.0 + this.rand() % 175 * 0,01000000.0 * t.scale;
	this.SetSpeed_Vec(2 + this.rand() % 3, this.rz, this.direction);
	this.flag1 = (-6,00000000.0 + this.rand() % 13) * 0,01745329.0;
	this.flag2 = 0,02500000.0 + this.rand() % 25 * 0,00100000.0;
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0,85000002.0;
		this.VX_Brake(0,34999999.0);
		this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
		this.sx = this.sy *= 0,94999999.0;
		this.alpha -= this.flag2;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_C( t )
{
	this.SetMotion(6020, 0);
	this.SetSpeed_XY(6,00000000.0 * this.direction, -6,00000000.0);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = 0;
	this.flag2 = 0;
	this.flag4 = 10,00000000.0 * 0,01745329.0;
	this.func = function ()
	{
		this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurst, {});
		this.ReleaseActor();
		return;
	};
	this.subState = function ()
	{
		if (this.IsScreen(150,00000000.0))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.life <= 0 || this.grazeCount >= 5 || this.hitCount > 0 || this.team.current.IsDamage() || this.owner.motion == 3020 && this.owner.keyTake == 0)
		{
			this.func();
			return true;
		}

		if (this.hitResult == 32)
		{
			this.HitReset();
		}
		else if (this.hitResult)
		{
			this.flag2++;

			if (this.flag2 >= 5)
			{
				this.HitReset();
				this.flag2 = 0;
			}
		}

		return false;
	};
	this.cancelCount = 6;
	this.life = 1;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,25000000.0);
		this.AddSpeed_XY(0,00000000.0, this.va.y < 0,00000000.0 ? 0,50000000.0 : 0,10000000.0);
		this.count++;
		this.rz += this.flag4;
		this.flag4 *= 0,98000002.0;
		this.flag5 = {};
		this.flag5.scale <- 1,00000000.0;
		this.flag5.t_scale <- 1,00000000.0;

		if (this.count >= 30)
		{
			this.rz = 0,00000000.0;
			this.PlaySE(2634);
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurst, {});

			switch(this.initTable.type)
			{
			case 8:
				this.SetMotion(this.motion, 1);
				this.SetSpeed_XY(-5,00000000.0 * this.direction, -5,00000000.0);
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.flag5.scale += (this.flag5.t_scale - this.flag5.scale) * 0,10000000.0;
					this.sx = 1,00000000.0 + this.sin(this.count * 12 * 0,01745329.0) * 0,15000001.0;
					this.sy = (2,00000000.0 - this.sx) * this.flag5.scale;
					this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
					this.count++;
					this.ry += 9,00000000.0 * 0,01745329.0;

					if (this.va.y > 0,00000000.0 && this.y + 25 >= ::camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 25 <= ::camera2d.top)
					{
						this.SetSpeed_XY(this.va.x, -this.va.y);
					}

					if (this.va.x * this.direction < 0,00000000.0)
					{
						if (this.direction == 1,00000000.0 && this.x - 25 <= ::camera2d.left || this.direction == -1,00000000.0 && this.x + 25 >= ::camera2d.right)
						{
							this.SetSpeed_XY(-this.va.x, this.va.y);
						}
					}
				};
				break;

			case 2:
				this.SetMotion(this.motion, 1);
				this.SetSpeed_XY(-5,00000000.0 * this.direction, 5,00000000.0);
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.flag5.scale += (this.flag5.t_scale - this.flag5.scale) * 0,10000000.0;
					this.sx = 1,00000000.0 + this.sin(this.count * 12 * 0,01745329.0) * 0,15000001.0;
					this.sy = (2,00000000.0 - this.sx) * this.flag5.scale;
					this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
					this.count++;
					this.ry += 9,00000000.0 * 0,01745329.0;

					if (this.va.y > 0,00000000.0 && this.y + 25 >= ::camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 25 <= ::camera2d.top)
					{
						this.SetSpeed_XY(this.va.x, -this.va.y);
					}

					if (this.va.x * this.direction < 0,00000000.0)
					{
						if (this.direction == 1,00000000.0 && this.x - 25 <= ::camera2d.left || this.direction == -1,00000000.0 && this.x + 25 >= ::camera2d.right)
						{
							this.SetSpeed_XY(-this.va.x, this.va.y);
						}
					}
				};
				break;

			default:
				this.SetSpeed_XY(4,00000000.0 * this.direction, -10,00000000.0);
				this.flag3 = 0;
				this.flag1 = this.y + 150;
				this.SetMotion(this.motion, 2);
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.sx = 1,00000000.0 + this.sin(this.count * 12 * 0,01745329.0) * 0,15000001.0;
					this.sy = 2,00000000.0 - this.sx;
					this.count++;
					this.ry += 9,00000000.0 * 0,01745329.0;

					if (this.flag3 == 0)
					{
						this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

						if (this.va.y > 0,00000000.0 && this.y >= this.flag1)
						{
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
							this.Warp(this.x, this.flag1);
							this.flag3 = 10;
						}
					}
					else
					{
						this.flag3--;

						if (this.flag3 <= 0)
						{
							this.SetSpeed_XY(4,00000000.0 * this.direction, -15,00000000.0);
						}
					}

					if (this.IsScreen(150,00000000.0))
					{
						this.ReleaseActor();
						return;
					}
				};
				break;
			}
		}
	};
}

function SPShot_E( t )
{
	this.SetMotion(6040, 0);
	this.atk_id = 16777216;
	this.func = function ()
	{
		this.owner.ShotRaccoonKO();
		this.ReleaseActor();
	};

	if (this.direction == 1,00000000.0 && this.x > 1200 || this.direction == -1,00000000.0 && this.x < 80)
	{
		this.Warp(640 + 560 * this.direction, this.y);
	}

	this.PlaySE(2640);
	this.SetSpeed_XY(10,00000000.0 * this.direction, -40,00000000.0);
	this.life = 600;
	this.flag2 = 0;
	this.flag3 = 0;
	this.subState = function ()
	{
		if (this.IsScreen(300))
		{
			this.ReleaseActor();
			return;
		}

		if (this.life <= 0)
		{
			this.func();
			return true;
		}

		return false;
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 1,54999995.0);
		this.VX_Brake(0,05000000.0);

		if (this.direction == 1,00000000.0 && this.x > 1200 || this.direction == -1,00000000.0 && this.x < 80)
		{
			this.VX_Brake(20,00000000.0);
		}

		if (this.va.y >= 0,00000000.0)
		{
			this.HitReset();
			this.SetSpeed_XY(null, 0,50000000.0);
			this.PlaySE(2641);
			this.SetMotion(6040, 1);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,05000000.0);
				this.VX_Brake(0,50000000.0);

				if (this.va.x * this.direction <= 1,50000000.0)
				{
					this.SetSpeed_XY(1,50000000.0 * this.direction, null);
				}

				if (this.direction == 1,00000000.0 && this.x > 1200 || this.direction == -1,00000000.0 && this.x < 80)
				{
					this.VX_Brake(20,00000000.0);
				}

				if (this.subState())
				{
					return;
				}

				this.count++;

				if (this.count >= 60)
				{
					this.SetMotion(6040, 6);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,64999998.0);

						if (this.direction == 1,00000000.0 && this.x > 1200 || this.direction == -1,00000000.0 && this.x < 80)
						{
							this.VX_Brake(20,00000000.0);
						}

						if (this.subState())
						{
							return;
						}
					};
				}
			};
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			this.life = 1;
		},
		null,
		function ()
		{
			this.flag3--;
			this.HitReset();
			this.SetSpeed_XY(5,00000000.0 * this.direction, -8,00000000.0);
			this.PlaySE(2641);
			this.SetMotion(6040, 1);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,85000002.0);

				if (this.subState())
				{
					return;
				}

				if (this.va.y >= 0,00000000.0)
				{
					this.count = 0;
					this.SetSpeed_XY(null, 0,50000000.0);
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,05000000.0);
						this.VX_Brake(0,75000000.0);

						if (this.subState())
						{
							return;
						}

						this.count++;

						if (this.count >= 25)
						{
							if (this.flag3 <= 0)
							{
								this.SetMotion(6040, 6);
							}
							else
							{
								this.SetMotion(6040, 3);
							}

							this.count = 0;
							this.stateLabel = function ()
							{
								this.AddSpeed_XY(0,00000000.0, 0,64999998.0);

								if (this.subState())
								{
									return;
								}
							};
						}
					};
				}
			};
		}
	];
}

function SPShot_E2( t )
{
	this.SetMotion(6050, 0);
	this.atk_id = 16777216;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = 100 * 0,01745329.0;
	this.flag1 = 5 * 0,01745329.0;
	this.flag2 = 0,12500000.0 * 0,01745329.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.life = 400;
	this.subState = function ()
	{
		if (this.rz >= 0,00000000.0)
		{
			this.flag1 += this.flag2;

			if (this.flag1 >= 6 * 0,01745329.0)
			{
				this.flag1 = 6 * 0,01745329.0;
			}
		}
		else
		{
			if (this.rz <= -60 * 0,01745329.0)
			{
				this.life = 1;
				this.SetMotion(this.motion, 4);
			}

			this.flag1 -= this.flag2 * 2,00000000.0;

			if (this.flag1 <= 0,50000000.0 * 0,01745329.0)
			{
				this.subState = function ()
				{
					this.count++;
					this.flag1 -= 0,10000000.0 * 0,01745329.0;
				};
			}
		}
	};
	this.stateLabel = function ()
	{
		if (this.life <= 0)
		{
			this.owner.ShotRaccoonKO();
			this.ReleaseActor();
			return;
		}

		this.subState();

		if (this.abs(this.point0_x - this.owner.x) <= 100 && this.abs(this.point0_y - this.owner.y) <= 100 && (this.point0_x - this.owner.x) * this.direction < 0,00000000.0)
		{
			if (this.owner.motion == 3050)
			{
				this.owner.func.call(this.owner);
			}
		}

		this.rz -= this.flag1;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

		if (this.count >= 45)
		{
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_G_SmokeCore, {});
			this.ReleaseActor();
		}
	};
}

function SPShot_E3( t )
{
	this.SetMotion(6050, 1);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.life = 1;
	this.SetSpeed_XY(0,00000000.0, 15,00000000.0);

	if (this.x < ::battle.scroll_left + 100)
	{
		this.Warp(::battle.scroll_left + 100, this.y);
	}

	if (this.x > ::battle.scroll_right - 100)
	{
		this.Warp(::battle.scroll_right - 100, this.y);
	}

	this.stateLabel = function ()
	{
		if (this.life <= 0)
		{
			this.owner.ShotRaccoonKO();
			this.ReleaseActor();
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,75000000.0);

		if (this.y >= ::battle.scroll_bottom + 128)
		{
			this.PlaySE(2644);
			this.Warp(this.x, ::battle.scroll_bottom + 128);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			::camera.shake_radius = 3,00000000.0;
			this.SetMotion(6050, 2);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.abs(this.x - this.owner.target.x) <= 100 && this.count >= 90 || this.count >= 360 || this.owner.motion == 3051 && this.owner.keyTake == 0)
				{
					this.HitReset();

					if (this.owner.motion == 3051 && this.owner.keyTake == 0)
					{
					}
					else
					{
						this.SetMotion(6050, 3);
					}

					this.SetSpeed_XY(0,00000000.0, -25,00000000.0);
					this.stateLabel = function ()
					{
						if (this.life <= 0)
						{
							this.owner.ShotRaccoonKO();
							this.ReleaseActor();
							return;
						}

						if (this.y <= ::battle.scroll_top - 100)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		}
	};
}

function SPShot_G_SmokeCore( t )
{
	this.SetMotion(7012, this.rand() % 4);
	this.sx = this.sy = 1,25000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	local i = 0;

	while (i < 8)
	{
		i++;
		local t_ = {};
		t_.rot <- this.rand() % 360 * 0,01745329.0;
		t_.range <- 10 + this.rand() % 20;
		this.SetFreeObject(this.x + t_.range * this.cos(t_.rot) * this.direction, this.y + t_.range * this.sin(t_.rot), this.direction, this.SPShot_G_Smoke, t_);
	}

	this.stateLabel = function ()
	{
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}

		this.AddSpeed_XY(0,00000000.0, -0,50000000.0);
	};
}

function SPShot_G_Smoke( t )
{
	this.SetMotion(7012, this.rand() % 4);
	this.sx = this.sy = 1,00000000.0 + this.rand() % 25 * 0,01000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = 10 + this.rand() % 4;
	this.flag2 = 0;
	this.flag3 = 0,03500000.0 + this.rand() % 15 * 0,00100000.0;
	this.flag4 = (-10 + this.rand() % 21) * 0,01745329.0;
	this.SetSpeed_Vec(this.flag1, t.rot, this.direction);
	this.stateLabel = function ()
	{
		this.flag1 -= 0,50000000.0;

		if (this.flag1 < 1,00000000.0)
		{
			this.flag1 = 1,00000000.0;
		}

		this.flag2 -= 0,34999999.0;
		this.rz += this.flag4;
		this.flag4 *= 0,89999998.0;
		this.SetSpeed_Vec(this.flag1, this.initTable.rot, this.direction);
		this.AddSpeed_XY(0,00000000.0, this.flag2);
		this.sx = this.sy *= 0,98000002.0;
		this.alpha -= this.flag3;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}

		this.AddSpeed_XY(0,00000000.0, -0,50000000.0);
	};
}

function SPShot_G( t )
{
	this.SetMotion(6062, 0);
	this.flag1 = this.rand() % 3;
	this.SetSpeed_XY(4,00000000.0 * this.direction, -6,00000000.0);
	this.flag2 = this.owner.y;
	this.DrawActorPriority(180);
	this.life = 1;
	this.PlaySE(2676);
	this.subState = function ()
	{
		if (this.life <= 0)
		{
			this.owner.ShotRaccoonKO();
			this.ReleaseActor();
			return true;
		}

		if (this.va.x > 0,00000000.0 && this.x > ::battle.corner_right - 50 || this.va.x < 0,00000000.0 && this.x < ::battle.corner_left + 50)
		{
			this.SetSpeed_XY(0,00000000.0, this.va.y);
		}

		return false;
	};
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

		if (this.subState())
		{
			return;
		}

		if (this.y >= this.flag2)
		{
			this.SetMotion(this.motion, 2);
			this.SetSpeed_XY(null, this.va.y * 0,10000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.AddSpeed_XY(0,00000000.0, -0,50000000.0);

				if (this.subState())
				{
					return;
				}

				if (this.va.y + this.y <= this.flag2)
				{
					this.Warp(this.x, this.flag2);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
				}
			};
		}
	};

	switch(this.flag1)
	{
	case 1:
		this.keyAction = [
			null,
			null,
			function ()
			{
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.VX_Brake(0,50000000.0);
				};
				this.SetMotion(6063, 0);
				this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
				this.keyAction = [
					function ()
					{
						this.SetSpeed_XY(7,50000000.0 * this.direction, 0,00000000.0);
						this.PlaySE(2600);
					},
					null,
					function ()
					{
						this.SetSpeed_XY(10,00000000.0 * this.direction, -6,50000000.0);
						this.HitReset();
						this.PlaySE(2615);
						this.stateLabel = function ()
						{
							this.VX_Brake(0,25000000.0);
							this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

							if (this.subState())
							{
								return;
							}

							if (this.va.y >= 6,50000000.0)
							{
								this.stateLabel = function ()
								{
									this.VX_Brake(0,50000000.0);
									this.VY_Brake(1,00000000.0);

									if (this.subState())
									{
										return;
									}
								};
							}
						};
					},
					function ()
					{
						this.stateLabel = function ()
						{
							this.VX_Brake(0,75000000.0);
							this.VY_Brake(1,00000000.0);

							if (this.subState())
							{
								return;
							}
						};
					},
					function ()
					{
						this.PlaySE(2676);
						this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_G_SmokeCore, {});
						this.ReleaseActor();
					}
				];
			}
		];
		break;

	case 2:
		this.SetSpeed_XY(4,50000000.0 * this.direction, -12,50000000.0);
		this.SetMotion(6064, 0);
		this.keyAction = [
			null,
			function ()
			{
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.AddSpeed_XY(0,00000000.0, 0,75000000.0);

					if (this.y >= ::battle.corner_bottom)
					{
						this.PlaySE(2607);
						this.SetMotion(this.motion, 3);
						this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
						::camera.shake_radius = 6,00000000.0;
						this.stateLabel = function ()
						{
							if (this.subState())
							{
								return;
							}
						};
					}
				};
			},
			null,
			function ()
			{
				this.SetSpeed_XY(-4,00000000.0 * this.direction, -15,00000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(null, 0,50000000.0);
				};
			},
			function ()
			{
				this.PlaySE(2676);
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_G_SmokeCore, {});
				this.ReleaseActor();
			}
		];
		break;

	default:
		this.keyAction = [
			null,
			null,
			function ()
			{
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}
				};
				this.SetMotion(6065, 0);
				this.SetSpeed_XY(-12,00000000.0 * this.direction, 0,00000000.0);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,75000000.0);
				};
				this.keyAction = [
					function ()
					{
						this.PlaySE(2617);
						this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
					},
					function ()
					{
						this.count = 0;
						this.stateLabel = function ()
						{
							if (this.subState())
							{
								return;
							}

							this.count++;

							if (this.count >= 30)
							{
								this.SetMotion(this.motion, 3);
								this.stateLabel = function ()
								{
									if (this.subState())
									{
										return;
									}

									this.VX_Brake(0,30000001.0);
								};
								return;
							}

							this.HitCycleUpdate(6);
						};
					},
					null,
					function ()
					{
						this.PlaySE(2676);
						this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_G_SmokeCore, {});
						this.ReleaseActor();
					}
				];
			}
		];
		break;
	}
}

function SPShot_TaikoBeat( t )
{
	this.SetMotion(3079, 2);
	this.keyAction = this.ReleaseActor;
}

function SPShot_TaikoShot( t )
{
	this.SetMotion(3079, 3);
	this.atk_id = 33554432;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(20,00000000.0, (40 + this.rand() % 25) * 0,01745329.0, this.direction);
	this.cancelCount = 1;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 41 * 0,01000000.0;
	this.func = function ()
	{
		this.SetMotion(3079, 5);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,10000000.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return;
		}

		this.count++;

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 1 || this.count >= 90)
		{
			this.func();
			return;
		}

		if (this.va.y > 0 && this.y > ::battle.corner_bottom)
		{
			this.SetSpeed_XY(this.va.x, -this.va.y);
		}

		this.Vec_Brake(0,50000000.0, 6,00000000.0);
		this.rz += 0,05235988.0;
	};
}

function SPShot_Taiko( t )
{
	this.SetMotion(3079, 0);
	this.DrawActorPriority(190);
	this.SetParent(this.owner, 0, 0);
	this.SetFreeObject(this.x, this.y, this.direction, this.owner.Common_SmokeBurstB, {});
	this.func = [
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Common_SmokeBurstB, {});
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(3079, 1);
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.owner.ShotRaccoonKO();
			this.func[0].call(this);
			return;
		}

		if (this.owner.motion != 3070)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function SpellA_SmokeCore( t )
{
	this.SetMotion(5997, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(this.rand() % 3, this.rz, this.direction);
	this.sx = this.sy = 4,00000000.0;
	local st_ = function ( t_ )
	{
		this.SetMotion(5997, this.rand() % 4);
		this.sx = this.sy = 2,00000000.0 + this.rand() % 5 * 0,10000000.0;
		this.rz = this.rand() % 360 * 0,01745329.0;
		this.SetSpeed_Vec(6 + this.rand() % 8, t_.rot, this.direction);
		local r_ = 5 + this.rand() % 6;
		this.Warp(this.x + this.va.x * r_, this.y + this.va.y * r_);
		this.flag1 = 0,04000000.0 + this.rand() % 20 * 0,00100000.0;
		this.flag2 = (4,00000000.0 - this.rand() % 9) * 0,01745329.0;
		this.stateLabel = function ()
		{
			this.rz += this.flag2;
			this.flag2 *= 0,98000002.0;
			this.sx = this.sy *= 0,97000003.0;
			this.VX_Brake(0,60000002.0);
			this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
			this.alpha -= this.flag1;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};

	for( local i = 0; i < 360; i = i + 45 )
	{
		local t_ = {};
		t_.rot <- (i + this.rand() % 30) * 0,01745329.0;
		this.SetFreeObject(this.x, this.y, this.direction, st_, t_);
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,98000002.0;
		this.VX_Brake(0,44999999.0);
		this.AddSpeed_XY(0,00000000.0, -0,44999999.0);
		this.alpha -= 0,07500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellA_SmokeB( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(5997, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.sx = this.sy = 1,00000000.0 + this.rand() % 8 * 0,10000000.0;
	this.flag1 = 0,04000000.0 + this.rand() % 20 * 0,00100000.0;
	this.flag2 = (4,00000000.0 - this.rand() % 9) * 0,01745329.0;
	this.alpha = 0,00000000.0;
	this.subState = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha -= this.flag1;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.rz += this.flag2;
		this.flag2 *= 0,98000002.0;
		this.sx = this.sy *= 0,91000003.0;
		this.SetSpeed_XY(this.va.x * 0,98000002.0, this.va.y * 0,98000002.0);
		this.subState();
	};
}

function SpellA_Steam( t )
{
	this.atk_id = 67108864;
	this.SetMotion(4009, 0);
	this.atkRate_Pat = t.rate;
	this.keyAction = this.ReleaseActor;
	this.SetParent(this.owner, 0, 0);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.owner.motion == 4000 && this.owner.keyTake == 5)
		{
			this.HitCycleUpdate(7);
		}
		else if (this.count > 2)
		{
			this.SetParent(null, 0, 0);
			this.callbackGroup = 0;
			this.SetKeyFrame(1);
			this.stateLabel = function ()
			{
			};
		}
	};
}

function SpellShot_B_Shot( t )
{
	this.SetMotion(7011, t.type);
	this.atk_id = 67108864;
	this.atkRate_Pat = t.rate;
	this.SetSpeed_XY((12,00000000.0 + this.rand() % 40 * 0,10000000.0) * this.direction, 0,00000000.0);
	this.sx = this.sy = 0,50000000.0;
	this.stateLabel = function ()
	{
		::camera.shake_radius = 4,00000000.0;

		if (this.sx < 1,00000000.0)
		{
			this.sx = this.sy += 0,02500000.0;
		}

		this.count++;

		if (this.count % 5 == 1)
		{
			local t_ = {};
			t_.scale <- 0,75000000.0 + this.rand() % 5 * 0,02500000.0;
			this.SetFreeObject(this.x + this.direction * this.rand() % 50, this.y + this.rand() % 40, this.direction, this.SpellShot_B_Smoke, t_);
		}

		if (this.IsScreen(300,00000000.0))
		{
			this.ReleaseActor();
			return;
		}

		if (this.life <= 0)
		{
			local t_ = {};
			t_.scale <- this.sx;
			this.SetShot(this.x, this.y, this.direction, this.SpellShot_B_Smoke, t_);
			this.ReleaseActor();
			return;
		}
	};
}

function SpellShot_B_Torii( t )
{
	this.SetMotion(7010, 4);
	this.DrawActorPriority(201);
	local st_ = function ( t_ )
	{
		this.SetMotion(7010, 5);
	};
	this.option = this.SetFreeObject(this.x, this.y, this.direction, st_, {}).weakref();
	this.linkObject = [
		this.option.weakref()
	];
	local t_ = {};
	t_.scale <- 2,00000000.0;
	this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_B_GateSmokeCore, t_);
	this.EnableTimeStop(false);
	this.func = [
		function ()
		{
			this.PlaySE(2649);
			local t_ = {};
			t_.scale <- 2,00000000.0;
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_B_Smoke, t_);
			this.ReleaseActor();
			return;
		},
		function ()
		{
			this.PlaySE(2650);
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.Warp(this.owner.x, this.owner.y);

				if (this.option)
				{
					this.option.Warp(this.owner.x, this.owner.y);
				}

				this.count++;

				if (this.count % 11 == 1)
				{
					local t_ = {};
					t_.type <- this.owner.hyakki;
					t_.rate <- this.initTable.rate;
					this.owner.hyakki++;

					if (this.owner.hyakki >= 18)
					{
						this.owner.hyakki = 0;
					}

					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_B_Shot, t_);
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.Warp(this.owner.x, this.owner.y);

				if (this.option)
				{
					this.option.Warp(this.owner.x, this.owner.y);
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.owner.motion != 4010)
		{
			this.func[0].call(this);
			return true;
		}

		return false;
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.Warp(this.owner.x, this.owner.y);

		if (this.option)
		{
			this.option.Warp(this.owner.x, this.owner.y);
		}
	};
}

function SpellShot_B_Smoke( t )
{
	this.DrawActorPriority(202);
	this.sx = this.sy = t.scale;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetMotion(7012, this.rand() % 4);
	this.EnableTimeStop(false);
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,05000000.0;
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_B_GateSmokeCore( t )
{
	this.DrawActorPriority(202);
	this.SetMotion(7012, this.rand() % 4);
	this.EnableTimeStop(false);
	this.sx = this.sy = 3,00000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	local i = 0;

	while (i < 10)
	{
		i++;
		local t_ = {};
		t_.rot <- this.rand() % 360 * 0,01745329.0;
		t_.range <- 25 + this.rand() % 75;
		this.SetFreeObject(this.x + t_.range * this.cos(t_.rot) * this.direction, this.y + t_.range * this.sin(t_.rot), this.direction, this.SpellShot_B_GateSmoke, t_);
	}

	this.stateLabel = function ()
	{
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}

		this.AddSpeed_XY(0,00000000.0, -0,50000000.0);
	};
}

function SpellShot_B_GateSmoke( t )
{
	this.DrawActorPriority(202);
	this.SetMotion(7012, this.rand() % 4);
	this.EnableTimeStop(false);
	this.sx = this.sy = 0,75000000.0 + this.rand() % 6 * 0,10000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = 10 + this.rand() % 6;
	this.flag2 = 0;
	this.SetSpeed_Vec(this.flag1, t.rot, this.direction);
	this.stateLabel = function ()
	{
		this.flag1 -= 0,75000000.0;

		if (this.flag1 < 1,00000000.0)
		{
			this.flag1 = 1,00000000.0;
		}

		this.flag2 -= 0,25000000.0;
		this.SetSpeed_Vec(this.flag1, this.initTable.rot, this.direction);
		this.AddSpeed_XY(0,00000000.0, this.flag2);
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}

		this.AddSpeed_XY(0,00000000.0, -0,50000000.0);
	};
}

function SpellShot_C( t )
{
	this.SetMotion(7020, 0);
	this.sx = this.sy = 0,10000000.0;
	this.FitBoxfromSprite();
	this.flag1 = this.point0_x;
	this.flag2 = 15 * 0,01745329.0;
	this.cancelCount = 4;
	this.atkRate_Pat = t.rate;
	this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_SmokeRingB, {});
	this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_SmokeRingB, {});
	this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_SmokeRingB, {});
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2,50000000.0 - this.sx) * 0,15000001.0;
				this.SetSpeed_XY(-this.point0_x + this.flag1, 0,00000000.0);
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
		if (this.owner.motion != 4020)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(0);
		this.sx = this.sy += (2,50000000.0 - this.sx) * 0,15000001.0;
		this.FitBoxfromSprite();
		this.SetSpeed_XY(-this.point0_x + this.flag1, 0,00000000.0);
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_C_SmokeCore( t )
{
	this.SetMotion(7020, 5);
	this.func = function ()
	{
		for( local i = 0; i < 10; i++ )
		{
			local t_ = {};
			t_.rot <- (i * 36 + this.rand() % 18) * 0,01745329.0;
		}

		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 3 == 1)
		{
			local st_ = function ( t_ )
			{
				this.SetMotion(5997, this.rand() % 4);
				this.sx = this.sy = 1,00000000.0 + this.rand() % 5 * 0,10000000.0;
				this.rz = this.rand() % 360 * 0,01745329.0;
				this.SetSpeed_Vec(3 + this.rand() % 3, t_.rot, this.direction);
				this.SetSpeed_XY(null, this.va.y * 0,50000000.0);
				this.alpha = 0,00000000.0;
				local r_ = 3 + this.rand() % 5;
				this.Warp(this.x + this.va.x * r_, this.y + this.va.y * r_);
				this.flag1 = 0,08000000.0 + this.rand() % 20 * 0,00100000.0;
				this.subState = function ()
				{
					this.alpha += 0,20000000.0;

					if (this.alpha >= 1,00000000.0)
					{
						this.alpha = 1,00000000.0;
						this.subState = function ()
						{
							this.alpha -= this.flag1;
						};
					}
				};
				this.stateLabel = function ()
				{
					this.subState();
					this.sx = this.sy += 0,05000000.0;
					this.VX_Brake(0,44999999.0);
					this.AddSpeed_XY(0,00000000.0, -0,10000000.0);
					this.alpha -= this.flag1;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			};
			local t_ = {};
			t_.rot <- this.rand() % 360 * 0,01745329.0;
			this.SetFreeObject(this.x, this.y, this.direction, st_, t_);
		}

		if (this.count == 15)
		{
			this.owner.target.isVisible = false;
		}
	};
}

function SpellShot_C_SmokeRing( t )
{
	this.SetMotion(7020, 6);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,50000000.0;
	this.alpha = 0,00000000.0;
	this.flag1 = 20,00000000.0 * 0,01745329.0;
	this.flag2 = 0,05000000.0 + this.rand() % 10 * 0,00100000.0;
	this.subState = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
					return true;
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0,85000002.0;
		this.sx = this.sy += this.flag2;
		this.flag2 *= 0,99000001.0;
		this.subState();
	};
}

function SpellShot_C_SmokeRingB( t )
{
	this.SetMotion(7020, 6);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.rx = (-60 + this.rand() % 121) * 0,01745329.0;
	this.ry = (-60 + this.rand() % 121) * 0,01745329.0;
	this.sx = this.sy = 0,50000000.0;
	this.alpha = 0,00000000.0;
	this.flag1 = 20,00000000.0 * 0,01745329.0;
	this.flag2 = 2,50000000.0 + this.rand() % 15 * 0,10000000.0;
	this.flag3 = 0,05000000.0 + this.rand() % 15 * 0,00100000.0;
	this.subState = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha -= this.flag3;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
					return true;
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0,92000002.0;
		local s_ = this.sx;
		this.sx = this.sy += (this.flag2 - this.sx) * 0,15000001.0;
		this.SetSpeed_XY((this.sx - s_) * 88 * this.direction, 0,00000000.0);
		this.subState();
	};
}

function Climax_SmokeCore( t )
{
	this.sx = this.sy = 0,50000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ( s_ )
		{
			local sr_ = (this.sx + s_) / this.sx;
			this.sx = this.sy += s_;
			this.flag2.Foreach(function ( srb_ = sr_ )
			{
				this.sx = this.sy *= srb_;
			});
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 8)
				{
					this.count = 0;
					this.flag1++;
					local t_ = {};
					t_.pos <- this.Vector3();
					t_.pos.x = -128 + this.rand() % 257;
					t_.pos.y = -this.rand() % 128;
					t_.priority <- this.flag1 % 2 == 1 ? 210 : 180;
					t_.scale <- this.sx;
					this.flag2.Add(this.SetFreeObject(640 + t_.pos.x, 360 + t_.pos.y, this.direction, this.Climax_SmokeFront, t_));
					this.func[1].call(this, 0,50000000.0);
				}
			};
		}
	];
	this.flag1 = 0;
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 4)
		{
			this.count = 0;
			this.flag1++;
			local t_ = {};
			t_.pos <- this.Vector3();
			t_.pos.x = -64 + this.rand() % 129;
			t_.pos.y = -this.rand() % 64;
			t_.priority <- this.flag1 % 2 == 1 ? 210 : 180;
			t_.scale <- this.sx;
			this.flag2.Add(this.SetFreeObject(this.x + t_.pos.x, this.y + t_.pos.y, this.direction, this.Climax_Smoke, t_));
			this.func[1].call(this, 0,05000000.0);
		}
	};
}

function Climax_Smoke( t )
{
	this.SetMotion(4908, 5 + this.rand() % 4);
	this.alpha = 0,00000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.DrawActorPriority(t.priority);
	this.SetSpeed_XY(t.pos.x * 0,10000000.0, t.pos.y * 0,02000000.0);
	this.sx = this.sy = 0,50000000.0 * t.scale;
	this.flag1 = 0,15000001.0 * t.scale;
	this.flag2 = 2,50000000.0 * 0,01745329.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, -0,20000000.0);
		this.rz += this.flag2;
		this.flag2 *= 0,92000002.0;
		this.sx = this.sy += this.flag1;
		this.flag1 -= 0,03000000.0 * this.initTable.scale;

		if (this.flag1 < 0,03000000.0 * this.initTable.scale)
		{
			this.flag1 = 0,03000000.0 * this.initTable.scale;
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
		else
		{
			this.alpha += 0,50000000.0;

			if (this.alpha > 1,00000000.0)
			{
				this.alpha = 1,00000000.0;
			}
		}
	};
}

function Climax_SmokeFront( t )
{
	this.SetMotion(4908, 5 + this.rand() % 4);
	this.alpha = 0,00000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.DrawScreenActorPriority(200);
	this.SetSpeed_XY(t.pos.x * 0,10000000.0, t.pos.y * 0,02000000.0);
	this.sx = this.sy = t.scale;
	this.flag1 = 0,15000001.0 * t.scale;
	this.flag2 = 2,50000000.0 * 0,01745329.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, -0,20000000.0 * this.initTable.scale);
		this.rz += this.flag2;
		this.flag2 *= 0,92000002.0;
		this.sx = this.sy += this.flag1;
		this.flag1 -= 0,03000000.0 * this.initTable.scale;

		if (this.flag1 < 0,06000000.0 * this.initTable.scale)
		{
			this.flag1 = 0,06000000.0 * this.initTable.scale;
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
		else
		{
			this.alpha += 0,30000001.0;

			if (this.alpha > 1,00000000.0)
			{
				this.alpha = 1,00000000.0;
			}
		}
	};
}

function Climax_Back( t )
{
	this.SetMotion(4909, 3);
	this.DrawScreenActorPriority(180);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_Cut( t )
{
	this.SetMotion(4909, 0);
	this.DrawScreenActorPriority(190);
	this.red = this.green = this.blue = 0,00000000.0;
	this.flag1 = ::manbow.Actor2DProcGroup();
	local a_ = this.SetFreeObject(640, 360, 1,00000000.0, this.Climax_CutLight, {});
	a_.SetParent(this, a_.x - this.x, a_.y - this.y);
	this.SetSpeed_XY(0,25000000.0 * this.direction, -0,10000000.0);
	this.sx = this.sy = 1,20000005.0;
	this.PlaySE(2708);
	this.flag1.Add(a_);
	this.func = [
		function ()
		{
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.red = this.green = this.blue += (1,00000000.0 - this.red) * 0,02500000.0;
				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;
			};
		},
		function ()
		{
			this.PlaySE(2707);
			local a_ = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Climax_CutFlash, {});
			a_.SetParent(this, a_.x - this.x, a_.y - this.y);
			this.flag1.Add(a_);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.red = this.green = this.blue += (1,00000000.0 - this.red) * 0,07500000.0;
				this.count++;

				if (this.count == 10)
				{
					local a_ = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Climax_CutFlashB, {});
					a_.SetParent(this, a_.x - this.x, a_.y - this.y);
					this.flag1.Add(a_);
				}
			};
		}
	];
}

function Climax_CutLight( t )
{
	this.SetMotion(4909, 1);
	this.DrawScreenActorPriority(190);
	this.alpha = this.red = this.green = this.blue = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.alpha = this.red = this.green = this.blue += (1,00000000.0 - this.red) * 0,00500000.0;
	};
}

function Climax_CutFlash( t )
{
	this.SetMotion(4909, 2);
	this.DrawScreenActorPriority(190);
	this.alpha = this.red = this.green = this.blue = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.alpha = this.red = this.green = this.blue += (1,00000000.0 - this.red) * 0,15000001.0;
	};
}

function Climax_CutFlashB( t )
{
	this.SetMotion(4909, 4);
	this.DrawScreenActorPriority(190);
	this.alpha = this.red = this.green = this.blue = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.alpha = this.red = this.green = this.blue += (1,00000000.0 - this.red) * 0,33000001.0;
		this.sx = this.sy += 4,00000000.0;
	};
}

function Climax_CutScene( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 4);
	this.EraceBackGround();
	this.owner.target.DamageGrab_Common(308, 0, -this.direction);
	this.demoObject = [
		null,
		null
	];
	this.count = 0;
	this.demoObject[0] = this.SetFreeObject(640, 360, 1,00000000.0, this.Climax_Back, {}).weakref();
	this.stateLabel = function ()
	{
		if (this.count == 2)
		{
			this.demoObject[1] = this.SetFreeObject(640, 360, 1,00000000.0, this.Climax_Cut, {}).weakref();
		}

		if (this.count == 10)
		{
			this.demoObject[1].func[1].call(this.demoObject[1]);
		}

		if (this.count == 30)
		{
		}

		if (this.count == 90)
		{
			this.demoObject[1].func[2].call(this.demoObject[1]);
		}

		if (this.count == 150)
		{
			foreach( a in this.demoObject )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 60);
			this.BackFadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 120);
			this.EraceBackGround(false);
			this.Climax_Finish(null);
			return;
		}
	};
}

