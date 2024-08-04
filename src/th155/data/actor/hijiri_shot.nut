function Chant_Counter( t )
{
	this.SetMotion(3008, 0);
	this.sx = this.sy = 0,00000000.0;
	this.flag1 = this.Vector3();
	this.flag1.x = 125,00000000.0;
	this.flag1.RotateByRadian(t.rot);
	this.flag2 = false;
	this.func = [
		function ()
		{
			if (this.flag2)
			{
				this.sx = this.sy = 1,00000000.0;
				this.subState = function ()
				{
					this.sx = this.sy *= 0,80000001.0;
					this.alpha -= 0,10000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.alpha = 0,00000000.0;
					}
				};
				this.flag2 = false;
			}
		},
		function ()
		{
			if (this.flag2 == false)
			{
				this.sx = this.sy = 0,00000000.0;
				this.alpha = 1,00000000.0;
				this.subState = function ()
				{
					if (::battle.state & (32 | 128))
					{
						this.func[0].call(this);
					}

					this.sx = this.sy += (1,00000000.0 - this.sx) * 0,15000001.0;
				};
				this.flag2 = true;
			}
		}
	];
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 0,00000000.0;
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		this.flag1.RotateByDegree(2,00000000.0);
		this.x += (this.team.current.x + this.flag1.x * this.direction - this.x) * 0,40000001.0;
		this.y += (this.team.current.y + this.flag1.y - this.y) * 0,40000001.0;
		this.subState();
	};
}

function BeginBattle_Kasa( t )
{
	this.SetMotion(9000, 2);
	this.SetSpeed_XY(-12,50000000.0 * this.direction, -3,00000000.0);
	this.func = function ()
	{
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(-0,10000000.0 * this.direction, -0,10000000.0);

		if (this.IsScreen(100))
		{
			this.ReleaseActor();
		}
	};
}

function AtkHighUnder_Effect( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(5999, 0);
	this.flag1 = true;
	this.sx = this.sy = 0,10000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,40000001.0;

		if (this.owner.motion >= 1210 && this.owner.motion <= 1213 || this.owner.motion == 1710)
		{
			if (this.owner.keyTake == 2 && this.flag1)
			{
				this.Warp(this.owner.point0_x, this.owner.point0_y);
			}
			else
			{
				this.flag1 = false;
			}
		}
		else
		{
			this.ReleaseActor();
		}
	};
	this.keyAction = this.ReleaseActor;
}

function AtkHighUnder_C_Effect( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(5999, 0);
	this.flag1 = true;
	this.sx = this.sy = 0,10000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,50000000.0 - this.sx) * 0,40000001.0;

		if (this.owner.motion >= 1210 && this.owner.motion <= 1213 || this.owner.motion == 1710)
		{
			if (this.owner.keyTake == 2 && this.flag1)
			{
				this.Warp(this.owner.point0_x, this.owner.point0_y);
			}
			else
			{
				this.flag1 = false;
			}
		}
		else
		{
			this.ReleaseActor();
		}
	};
	this.keyAction = this.ReleaseActor;
}

function AtkAir_Effect( t )
{
	if (this.sin(t.rot) >= 0,00000000.0)
	{
		this.DrawActorPriority(200);
	}
	else
	{
		this.DrawActorPriority(180);
	}

	this.SetMotion(5999, 1);
	this.flag2 = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,15000001.0;

				if (this.sx <= 0,15000001.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.flag2 += 0,15000001.0;

		if (this.flag2 > 1,00000000.0)
		{
			this.flag2 = 1,00000000.0;
		}

		this.initTable.rot -= 8,00000000.0 * 0,01745329.0;
		this.Warp(this.owner.point0_x + 80 * this.flag2 * this.cos(this.initTable.rot) * this.direction, this.owner.point0_y + 20 * this.flag2 * this.sin(this.initTable.rot));

		if (this.sin(this.initTable.rot) >= 0,00000000.0)
		{
			this.DrawActorPriority(200);
		}
		else
		{
			this.DrawActorPriority(180);
		}
	};
	this.stateLabel = function ()
	{
		this.count++;
		this.subState();
	};
}

function AtkLowDash_Effect( t )
{
	if (this.sin(t.rot) >= 0,00000000.0)
	{
		this.DrawActorPriority(200);
	}
	else
	{
		this.DrawActorPriority(180);
	}

	this.SetMotion(5999, 1);
	this.flag2 = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.initTable.rot -= 8,00000000.0 * 0,01745329.0;
				this.Warp(this.owner.point0_x + 130 * this.flag2 * this.cos(this.initTable.rot) * this.direction, this.owner.point0_y + 20 * this.flag2 * this.sin(this.initTable.rot));

				if (this.sin(this.initTable.rot) >= 0,00000000.0)
				{
					this.DrawActorPriority(200);
				}
				else
				{
					this.DrawActorPriority(180);
				}

				this.sx = this.sy -= 0,15000001.0;

				if (this.sx <= 0,15000001.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.flag2 += 0,15000001.0;

		if (this.flag2 > 1,00000000.0)
		{
			this.flag2 = 1,00000000.0;
		}

		this.initTable.rot -= 8,00000000.0 * 0,01745329.0;
		this.Warp(this.owner.point0_x + 130 * this.flag2 * this.cos(this.initTable.rot) * this.direction, this.owner.point0_y + 20 * this.flag2 * this.sin(this.initTable.rot));

		if (this.sin(this.initTable.rot) >= 0,00000000.0)
		{
			this.DrawActorPriority(200);
		}
		else
		{
			this.DrawActorPriority(180);
		}
	};
	this.stateLabel = function ()
	{
		this.count++;
		this.subState();
	};
}

function Shot_Normal( t )
{
	this.SetMotion(2009, 0);
	this.cancelCount = 3;
	this.atk_id = 16384;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.func = [
		function ()
		{
			this.SetMotion(2009, 1);
			this.SetSpeed_XY(this.va.x * -0,50000000.0, -10,00000000.0 + this.va.y);
			this.HitReset();
			this.SetEnemyTeamShot();
			this.attackTarget = this.owner.weakref();
			this.hitCount = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.rz += 22,50000000.0 * 0,01745329.0;

				if (this.va.y >= 0,00000000.0)
				{
					this.SetMotion(2009, 2);
					this.stateLabel = function ()
					{
						if (this.y > ::battle.scroll_bottom + 100)
						{
							this.ReleaseActor();
							return;
						}

						this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
						this.rz += 22,50000000.0 * 0,01745329.0;

						if (this.hitResult & 1)
						{
							this.owner.shotNum++;

							if (this.owner.shotNum > 2)
							{
								this.owner.shotNum = 2;
							}

							this.PlaySE(1625);
							this.ReleaseActor();
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 4))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.rz -= 36,00000000.0 * 0,01745329.0;
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 0);
	this.DrawActorPriority(210);
	this.cancelCount = 6;
	this.atk_id = 65536;
	this.flag1 = [];
	this.flag2 = [];
	this.flag3 = 1,00000000.0;

	for( local i = 0; i < 360; i = i + 40 )
	{
		local t_ = {};
		t_.rot <- i * 0,01745329.0;
		this.flag1.append(this.SetShot(this.x, this.y, this.direction, this.ShotFront_PetalB, t_));
	}

	for( local i = 0; i < 360; i = i + 40 )
	{
		local t_ = {};
		t_.rot <- i * 0,01745329.0;
		this.flag2.append(this.SetShot(this.x, this.y, this.direction, this.ShotFront_PetalA, t_));
	}

	this.SetSpeed_XY(17,50000000.0 * this.direction, 0,00000000.0);
	this.subState = function ()
	{
		this.SetCollisionScaling(this.flag3, this.flag3, 1,00000000.0);

		foreach( a in this.flag1 )
		{
			a.Warp(this.x, this.y);
			a.sx += (0,85000002.0 - a.sx) * 0,05000000.0;
			a.rz = this.rz + a.initTable.rot;
		}

		foreach( a in this.flag2 )
		{
			a.Warp(this.x, this.y);
			a.sx += (0,75000000.0 - a.sx) * 0,05000000.0;
			a.rz = -this.rz + a.initTable.rot;
		}
	};
	this.stateLabel = function ()
	{
		this.rz += 2,00000000.0 * 0,01745329.0;
		this.flag3 += (2,50000000.0 - this.flag3) * 0,05000000.0;
		this.subState();
		this.count++;

		if (this.hitResult & 8)
		{
			this.HitCycleUpdate(2);
		}
		else
		{
			this.HitCycleUpdate(4);
		}

		if (this.hitResult)
		{
			this.Vec_Brake(15,00000000.0, 1,00000000.0);
		}
		else
		{
			this.Vec_Brake(0,75000000.0, 1,00000000.0);
		}

		if (this.count >= 45 || this.hitCount >= 4 || this.cancelCount <= 0 || this.grazeCount >= 1 || this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 3);

			foreach( a in this.flag1 )
			{
				a.func.call(a);
			}

			foreach( a in this.flag2 )
			{
				a.func.call(a);
			}

			this.flag1 = this.flag2 = null;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;

				if (this.sx <= 0,01000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function ShotFront_PetalA( t )
{
	this.SetMotion(2019, 1);
	this.DrawActorPriority(205);
	this.rz = t.rot;
	this.sx = 0,00000000.0;
	this.sy = 0,75000000.0;
	this.func = function ()
	{
		this.SetSpeed_Vec(3,00000000.0 + this.rand() % 21 * 0,10000000.0, this.rz, this.direction);
		this.flag3 = 0,98000002.0 + this.rand() % 10 * 0,00100000.0;
		this.flag2 = (3,00000000.0 - this.rand() % 7) * 0,01745329.0;
		this.flag1 = 0,10000000.0 + this.rand() % 10 * 0,01000000.0;
		this.stateLabel = function ()
		{
			this.rz += this.flag2;
			this.AddSpeed_XY(0,00000000.0, this.flag1);
			this.sx *= this.flag3;
			this.sy *= this.flag3;
			this.alpha -= 0,01000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
}

function ShotFront_PetalB( t )
{
	this.SetMotion(2019, 2);
	this.DrawActorPriority(205);
	this.rz = t.rot;
	this.sx = 0,00000000.0;
	this.func = function ()
	{
		this.SetSpeed_Vec(6,00000000.0 + this.rand() % 21 * 0,10000000.0, this.rz, this.direction);
		this.flag3 = 0,98000002.0 + this.rand() % 10 * 0,00100000.0;
		this.flag2 = (3,00000000.0 - this.rand() % 7) * 0,01745329.0;
		this.flag1 = 0,10000000.0 + this.rand() % 10 * 0,01000000.0;
		this.stateLabel = function ()
		{
			this.rz += this.flag2;
			this.AddSpeed_XY(0,00000000.0, this.flag1);
			this.sx *= this.flag3;
			this.sy *= this.flag3;
			this.alpha -= 0,01000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2029, t.keyTake);
	this.rz = t.rot;
	this.FitBoxfromSprite();
	this.SetSpeed_Vec(30,00000000.0, this.rz, this.direction);
	this.cancelCount = 3;
	this.atk_id = 131072;
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E_Ring, t_);
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
		if (this.IsScreen(300,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 10))
		{
			this.ReleaseActor();
		}

		this.count++;

		if (this.count >= 4)
		{
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x + this.rand() % 60 - 30, this.y + this.rand() % 60 - 30, this.direction, this.SPShot_E_Trail, t_);
			this.count = 0;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(1);
		}
	};
}

function Shot_FullChargeRing( t )
{
	this.SetMotion(2028, 8);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (6,50000000.0 - this.sx) * 0,15000001.0;
		this.alpha -= 0,02500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_FullCharge( t )
{
	this.SetMotion(2028, t.keyTake);
	this.rz = t.rot;
	this.FitBoxfromSprite();
	this.SetSpeed_Vec(t.v, this.rz, this.direction);
	this.cancelCount = 3;
	this.atk_id = 131072;

	if (t.flash)
	{
		local t_ = {};
		t_.rot <- this.rz;
		this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_E_Ring, t_);
	}

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
		},
		function ()
		{
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Shot_FullChargeRing, {});
			this.HitReset();
			this.PlaySE(1616);
			this.SetMotion(2028, 6);
			::camera.shake_radius = 10,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.count = 0;
			this.hitCount = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 60)
				{
					this.func[0].call(this);
					return;
				}

				this.HitCycleUpdate(10);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(300,00000000.0))
		{
			this.ReleaseActor();
		}

		local t_ = {};
		t_.rot <- this.rz;
		this.SetFreeObject(this.x + this.rand() % 60 - 30, this.y + this.rand() % 60 - 30, this.direction, this.SPShot_E_Trail, t_);

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.va.x > 0,00000000.0 && this.x > ::battle.scroll_right - 300 || this.va.x < 0,00000000.0 && this.x < ::battle.scroll_left + 300)
		{
			this.func[1].call(this);
			return;
		}

		this.HitCycleUpdate(3);
	};
}

function HighFrontShot( t )
{
	this.SetMotion(5020, 0);
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		if (this.owner.motion == 2510 && this.owner.keyTake <= 2)
		{
			this.Warp(this.owner.point0_x, this.owner.point0_y);
		}
		else
		{
			this.SetMotion(5020, 2);
			this.stateLabel = null;
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			this.SetSpeed_XY(15,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.sy *= 0,92000002.0;
				this.sx *= 1,04999995.0;
			};
		}
	];
}

function ChantName( t )
{
	this.SetMotion(6999, t.type);
	this.flag1 = this.Vector3();
	this.sx = this.sy = 2,00000000.0;
	this.SetSpeed_XY(0,00000000.0, -0,50000000.0);
	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0,10000000.0;

		if (this.sx <= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 30)
				{
					this.alpha -= 0,07500000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				}
			};
		}
	};
}

function Okult_DummyBike( t )
{
	this.SetMotion(2509, 4);
	this.DrawActorPriority(180);
	this.alpha = 0,00000000.0;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.SetSpeed_XY(17,50000000.0 * this.direction, 0,00000000.0);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.ReleaseActor();
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.alpha = 1,00000000.0;
			this.stateLabel = function ()
			{
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
		this.alpha += 0,10000000.0;
	};
}

function Okult_BikeSpark( t )
{
	this.SetMotion(2509, 3);
	this.DrawActorPriority(180);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,10000000.0;
	this.flag1 = 1,50000000.0 + this.rand() % 12 * 0,10000000.0;
	this.SetSpeed_XY(-(this.rand() & 6) * this.direction, -5,00000000.0);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,40000001.0);
		this.sx = this.sy += (this.flag1 - this.sx) * 0,15000001.0;
		this.alpha = this.green = this.blue -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function OkultShot_Bike( t )
{
	this.SetMotion(2509, 0);
	this.atk_id = 524288;

	if (!t.enableHit)
	{
		this.callbackGroup = 0;
	}

	this.rz = -40 * 0,01745329.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_XY(t.vx * 0,50000000.0, t.vy);
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.Damage_ConvertOP(this.x, this.y, 10, 1))
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.rz += (-55 * 0,01745329.0 - this.rz) * 0,10000000.0;
				this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
				this.alpha = this.red = this.green = this.blue -= 0,25000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}

		this.rz += (-55 * 0,01745329.0 - this.rz) * 0,10000000.0;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
		this.AddSpeed_XY(0,00000000.0, 0,75000000.0);

		if (this.y > ::battle.scroll_bottom + 200)
		{
			this.ReleaseActor();
			return;
		}
	};
}

function Shot_Change_Core( t )
{
	this.SetMotion(3929, 4);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.SetSpeed_XY(7,50000000.0 * this.direction, 0,00000000.0);
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		this.count++;

		if (this.count % 4 == 1)
		{
			this.SetShot(this.x - this.rand() % 128, this.y, this.direction, this.Shot_Change, {});
			this.SetShot(this.x + this.rand() % 128, this.y - this.rand() % 64, this.direction, this.Shot_Change, {});
		}

		if (this.count >= 50)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Change_HitBox( t )
{
	this.SetMotion(3929, 3);
	this.SetTeamCheckTarget();
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Shot_ChangeSelf( t )
{
	this.SetMotion(3929, 2);
	this.SetParent(t.pare, 0, 0);
	this.SetTeamCheck();
	this.stateLabel = function ()
	{
		if (this.hitResult != 0)
		{
			this.SetParent(null, 0, 0);

			if (this.initTable.pare && this.initTable.pare.func[0])
			{
				this.initTable.pare.func[0].call(this.initTable.pare);
			}

			this.ReleaseActor();
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
	this.rz = (6 - this.rand() % 13) * 0,01745329.0;
	this.SetSpeed_Vec(30,00000000.0, this.rz + 1,57079601.0, this.direction);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.linkObject = [
		this.SetShot(this.x, this.y, this.direction, this.Shot_ChangeSelf, {}, this.weakref()).weakref()
	];
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			if (this.linkObject[0])
			{
				this.ReleaseActor.call(this.linkObject[0]);
			}

			this.SetMotion(this.motion, 1);
			this.SetSpeed_XY(this.va.x * 0,10000000.0, this.va.y * 0,10000000.0);
			this.stateLabel = function ()
			{
				this.sx *= 0,80000001.0;
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
		if (this.y > ::battle.scroll_bottom + 64 || this.Damage_ConvertOP(this.x, this.y, 1))
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

function Shot_Barrage( t )
{
	this.SetMotion(2026, 0);
	this.rz = t.rot;
	this.SetSpeed_Vec(17,50000000.0, this.rz, this.direction);
	this.atk_id = 262144;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, 1);
		this.SetSpeed_XY(this.va.x * 0,20000000.0, this.va.y * 0,20000000.0);
		this.stateLabel = function ()
		{
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.keyAction = this.func;
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}

		this.Vec_Brake(0,75000000.0, 6,00000000.0);
	};
}

function SPShot_A( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(5999, 0);
	this.flag1 = true;
	this.sx = this.sy = 0,10000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,50000000.0 - this.sx) * 0,40000001.0;

		if (this.owner.motion == 3004)
		{
			if (this.owner.keyTake == 2 && this.flag1)
			{
				this.Warp(this.owner.point0_x, this.owner.point0_y);
			}
			else
			{
				this.flag1 = false;
			}
		}
		else
		{
			this.ReleaseActor();
		}
	};
	this.keyAction = this.ReleaseActor;
}

function SPShot_B( t )
{
	switch(t.k)
	{
	case 6:
	case 4:
		this.SetMotion(6011, 0);
		break;

	default:
		this.SetMotion(6010, 0);
		break;
	}

	this.cancelCount = 100;
	this.atk_id = 2097152;
	this.stateLabel = function ()
	{
		if (this.hitResult)
		{
			if (this.hitCount == 0)
			{
				this.HitReset();
			}
		}
	};
	this.keyAction = this.ReleaseActor;
}

function SPShot_B_Chant( t )
{
	this.SetMotion(6019, 0);
	this.cancelCount = 100;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,15000001.0;
		this.FitBoxfromSprite();
	};
}

function SPShot_C_Core( t )
{
	this.SetMotion(6020, 3);
	this.flag1 = [];
	this.flag2 = {};
	this.flag2.range <- 0,00000000.0;
	this.flag2.rot <- 0,00000000.0;

	for( local i = 0; i < 8; i++ )
	{
		local t_ = {};
		this.flag1.append(this.SetShot(this.x, this.y, this.direction, this.SPShot_C, t_).weakref());
	}

	this.subState = function ()
	{
		for( local i = 0; i < 8; i++ )
		{
			this.flag1[i].Warp(this.x + this.flag2.range * this.cos(this.flag2.rot + 45 * i * 0,01745329.0) * this.direction, this.y + this.flag2.range * this.sin(this.flag2.rot + 45 * i * 0,01745329.0) * 0,20000000.0);

			if (this.sin(this.flag2.rot + 45 * i * 0,01745329.0) >= 0,00000000.0)
			{
				this.flag1[i].DrawActorPriority(200);
			}
			else
			{
				this.flag1[i].DrawActorPriority(180);
			}
		}
	};
	this.func = [
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.flag2.rot += 5 * 0,01745329.0;
		this.flag2.range += (200 - this.flag2.range) * 0,25000000.0;
		this.count++;

		if (this.count <= this.initTable.count)
		{
			if (this.owner.motion == 3020 && this.owner.keyTake == 0 || this.Damage_ConvertOP(this.x, this.y, 8))
			{
				for( local i = 0; i < 8; i++ )
				{
					this.flag1[i].func.call(this.flag1[i]);
				}

				this.ReleaseActor();
				return;
			}
		}
		else
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.owner.motion == 3020 && this.owner.keyTake == 0 || this.Damage_ConvertOP(this.x, this.y, 8))
				{
					for( local i = 0; i < 8; i++ )
					{
						this.flag1[i].func.call(this.flag1[i]);
					}

					this.ReleaseActor();
					return;
				}

				this.flag2.rot += 10 * 0,01745329.0;
				this.SetSpeed_XY((this.owner.target.x - this.x) * 0,20000000.0, 0,00000000.0);

				if (this.va.x * this.direction >= 25)
				{
					this.SetSpeed_XY(25 * this.direction, 0,00000000.0);
				}

				if (this.va.x * this.direction <= 0)
				{
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
				}

				this.SetSpeed_XY(this.va.x, this.va.x * this.initTable.vy * this.direction);
				this.flag2.range *= 0,89999998.0;
				this.count++;

				if (this.count >= 15)
				{
					this.SetShot(this.x, this.y, this.direction, this.SPShot_C_Lightning, {});

					for( local i = 0; i < 8; i++ )
					{
						this.flag1[i].Warp(this.x, this.y);
						this.flag1[i].SetSpeed_Vec(20,00000000.0, i * 45 * 0,01745329.0, this.direction);
						this.flag1[i].func.call(this.flag1[i]);
					}

					this.flag1 = null;
					this.ReleaseActor();
					return;
				}

				this.subState();
			};
		}

		this.subState();
	};
}

function SPShot_C_Chant( t )
{
	this.SetMotion(6020, 5);
	this.func = [
		function ()
		{
			if (this.hitTarget)
			{
				this.callbackGroup = 0;
				this.SetMotion(6020, 5);
				this.stateLabel = function ()
				{
					this.sx = this.sy *= 0,89999998.0;
					this.alpha -= 0,10000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}
		},
		function ()
		{
			if (this.hitTarget)
			{
				this.SetMotion(6020, 6);
				local t_ = {};
				t_.priority <- this.drawPriority;
				this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_C_SparkSol, t_);
				this.stateLabel = function ()
				{
				};
			}
		}
	];
}

function SPShot_C_Sol( t )
{
	this.SetMotion(6020, 7);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
		this.alpha -= 0,03300000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_C_SparkSol( t )
{
	this.DrawActorPriority(t.priority);
	this.SetMotion(6020, 7);
	this.sx = this.sy = 2,00000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
		this.alpha -= 0,03300000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_C( t )
{
	this.SetMotion(6020, 0);
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,89999998.0;
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
}

function SPShot_C_Lightning( t )
{
	this.PlaySE(1707);
	this.SetMotion(6020, 4);
	this.atk_id = 4194304;
	this.keyAction = this.ReleaseActor;
}

function SPShot_C_LightningB( t )
{
	this.PlaySE(1707);
	this.SetMotion(6020, 8);
	this.atk_id = 4194304;
	this.keyAction = this.ReleaseActor;
}

function SPShot_D( t )
{
	this.SetMotion(3039, 0);
	this.atk_id = 8388608;

	switch(t.type)
	{
	case 1:
		this.count = 7;
		this.hitCount = 1;
		break;

	case 2:
		break;

	default:
		this.count = 15;
		this.hitCount = 2;
		break;
	}

	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 30 || this.hitCount >= 5)
		{
			this.ReleaseActor();
		}

		this.HitCycleUpdate(4);
		this.x = this.owner.target.x;
		this.y = this.owner.target.y;
	};
}

function BossB_Trail( t )
{
	this.SetMotion(7920, 0);
	this.DrawActorPriority(180);
	this.stateLabel = function ()
	{
		this.alpha = this.green = this.red -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_E_Ring( t )
{
	this.SetMotion(6040, 3);
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

function SPShot_E_Trail( t )
{
	this.SetMotion(6040, 4);
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

function SPShot_F( t )
{
	this.SetMotion(6060, 0);
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,80000001.0;
		this.count++;

		if (this.count >= 6)
		{
			this.SetMotion(6060, 1);
			local t_ = {};
			t_.rot <- -45 * 0,01745329.0;
			this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_F_Flash, t_);
			this.SetFreeObject(this.x, this.y, -this.direction, this.SPShot_F_Flash, t_);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (3,00000000.0 - this.sx) * 0,50000000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_F_Flash( t )
{
	this.SetMotion(6060, 2);
	this.rz = t.rot;
	this.sy = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.sy += (5,00000000.0 - this.sy) * 0,33000001.0;
		this.sx *= 0,89999998.0;
		this.alpha = this.blue = this.green -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_F_Main( t )
{
	this.keyAction = this.ReleaseActor;
	this.sx = this.sy = t.scale;
	this.SetMotion(6060, 3);
	this.atk_id = 33554432;
	local t_ = {};
	t_.scale <- t.scale;
	this.flag1 = this.SetShot(this.x, this.y, this.direction, this.SPShot_F_Pare, t_, this.weakref()).weakref();
	this.flag1.hitOwner = this.weakref();
	this.FitBoxfromSprite();
	this.stateLabel = function ()
	{
		if (this.hitResult & 13 && this.owner.motion == 3064)
		{
			this.owner.hitResult = this.hitResult;
		}

		if (this.flag1)
		{
			this.flag1.Warp(this.x, this.y);
		}
	};
}

function SPShot_F_Pare( t )
{
	this.SetMotion(6060, 5);
	this.atk_id = 33554432;
	this.keyAction = this.ReleaseActor;
}

function SPShot_F_Aura( t )
{
	this.SetMotion(6061, this.rand() % 2);
	this.alpha = 0,00000000.0;
	this.sx = 0,50000000.0 + this.rand() % 6 * 0,10000000.0;
	this.sy = 0,50000000.0 + this.rand() % 6 * 0,10000000.0;
	this.subState = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha -= 0,10000000.0;

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
		this.sx += 0,20000000.0;
		this.sy += 0,40000001.0;

		if (this.owner.motion >= 3060 && this.owner.motion <= 3062)
		{
			this.Warp(this.owner.x, this.owner.y + 75);
		}

		if (this.subState())
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_G( t )
{
	this.SetMotion(3079, 0);
	this.atk_id = 1073741824;
	this.rz = -1,57079601.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_XY(0,00000000.0, -40,00000000.0);
	this.cancelCount = 3;
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
		},
		function ()
		{
			this.Warp(this.x + 200 * this.direction, ::battle.scroll_top - 392);

			if (this.x > ::battle.corner_right)
			{
				this.Warp(::battle.corner_right, this.y);
			}

			if (this.x < ::battle.corner_left)
			{
				this.Warp(::battle.corner_left, this.y);
			}

			this.SetMotion(3079, 2);
			this.rz = 1,57079601.0;
			this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
			this.SetSpeed_XY(0,00000000.0, 40,00000000.0);
			this.cancelCount = 3;
			this.HitReset();
			this.stateLabel = function ()
			{
				if (this.Damage_ConvertOP(this.x, this.y, 10) || this.y >= ::battle.scroll_bottom + 128)
				{
					this.ReleaseActor();
					return;
				}

				this.count++;

				if (this.count >= 2)
				{
					local t_ = {};
					t_.rot <- this.rz;
					this.SetFreeObject(this.x + this.rand() % 60 - 30, this.y + this.rand() % 60 - 30, this.direction, this.SPShot_E_Trail, t_);
					this.count = 0;
				}

				if (this.cancelCount <= 0)
				{
					this.func[0].call(this);
					return;
				}

				if (this.hitCount == 0)
				{
					this.HitCycleUpdate(1);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 10))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;

		if (this.count >= 20)
		{
			this.func[1].call(this);
			return;
		}

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(1);
		}
	};
}

function SpellShot_A( t )
{
	this.SetMotion(7000, 0);
	this.SetSpeed_XY(35,00000000.0 * this.direction, 0,00000000.0);
	this.cancelCount = 10;
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.stateLabel = function ()
	{
		if (this.IsScreen(200,00000000.0) || this.cancelCount <= 0)
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitResult & 1)
		{
			if (this.owner.motion == 4000 && this.owner.keyTake == 3)
			{
				this.owner.hitResult = 1;
			}

			this.Warp(this.owner.target.x - 40 * this.direction, this.owner.target.y - 20);
			this.SetMotion(7000, 1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.owner.motion == 4000)
				{
					if (this.owner.keyTake >= 4 || this.target.damageStopTime <= 0)
					{
						this.ReleaseActor();
					}
				}
				else if (this.owner.motion != 4001)
				{
					this.ReleaseActor();
				}
				else if (this.owner.keyTake >= 2)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_A2( t )
{
	this.SetMotion(4002, 3);
	this.rz = t.rot;
	this.sy = 0,50000000.0 + this.rand() % 10 * 0,10000000.0;
	this.SetSpeed_Vec(120, this.rz, this.direction);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 2)
		{
			this.sy *= 0,80000001.0;

			if (this.sy <= 0,01000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SpellShot_B( t )
{
	this.EnableTimeStop(false);
	this.DrawActorPriority(180);
	this.SetMotion(7010, 3);
	local i_ = function ( t )
	{
		this.EnableTimeStop(false);
		this.DrawActorPriority(180);
		this.SetMotion(7010, 1);
		this.stateLabel = function ()
		{
			this.Warp(this.owner.x, this.owner.point0_y);
			this.sx = this.sy += (2,50000000.0 - this.sx) * 0,10000000.0;
			this.alpha -= 0,01600000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.SetFreeObject(this.x, this.y, this.direction, i_, {});
	local i_ = function ( t )
	{
		this.sx = this.sy = 0,50000000.0;
		this.EnableTimeStop(false);
		this.DrawActorPriority(180);
		this.SetMotion(7010, 0);
		this.alpha = 0,00000000.0;
		this.stateLabel = function ()
		{
			this.Warp(this.owner.x, this.owner.point0_y);
			this.count++;
			this.sx = this.sy += 0,01000000.0;
			this.alpha += 0,03300000.0;

			if (this.alpha > 1,00000000.0)
			{
				this.alpha = 1,00000000.0;
			}

			if (this.count >= 70)
			{
				this.ReleaseActor();
			}
		};
	};
	this.SetFreeObject(this.x, this.y, this.direction, i_, {});
	this.stateLabel = function ()
	{
		this.sx += 0,05000000.0;
		this.sy *= 0,80000001.0;
		this.Warp(this.owner.x, this.owner.point0_y);
		this.count++;

		if (this.count >= 40)
		{
			this.alpha = this.blue = this.green -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SpellShot_B_Wing( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(7010, 2);
	this.sx = this.sy = 0,00000000.0;
	this.ry = -30 * 0,01745329.0;
	this.EnableTimeStop(false);
	this.stateLabel = function ()
	{
		this.rz += (this.initTable.rot - this.rz) * 0,10000000.0;
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;
		this.Warp(this.owner.x, this.owner.point0_y);

		if (this.owner.motion != 4011 || this.owner.keyTake >= 3)
		{
			this.stateLabel = function ()
			{
				this.sx *= 0,92000002.0;
				this.sy += 0,10000000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_B_Back( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(7010, 0);
	this.sx = this.sy = 1,00000000.0;
	this.EnableTimeStop(false);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
		this.Warp(this.owner.x, this.owner.point0_y);

		if (this.owner.motion != 4011 || this.owner.keyTake >= 3)
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 1,10000002.0;
				this.alpha = this.blue = this.green -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_B_Beam( t )
{
	if (t.type == false)
	{
		this.SetMotion(7011, 2);
	}
	else
	{
		this.SetMotion(7011, 0);
	}

	this.sy = 0,01000000.0;
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.EnableTimeStop(false);
	this.FitBoxfromSprite();
	this.cancelCount = 99;
	this.flag1 = function ( t_ )
	{
		this.SetMotion(7010, 1);
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,10000000.0;
			this.alpha -= 0,08000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.count++;
		this.sy += (1,00000000.0 - this.sy) * 0,10000000.0;
		this.FitBoxfromSprite();
		this.Warp(this.owner.point0_x, this.owner.point0_y);
		this.HitCycleUpdate(6);

		if (this.count % 16 == 1)
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.flag1, {});
		}

		if (this.owner.motion != 4011 || this.owner.keyTake >= 3)
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sy *= 0,89999998.0;
				this.alpha = this.blue = this.green -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_C( t )
{
	this.SetMotion(7020, 0);
	this.SetSpeed_XY(0,00000000.0, 150,00000000.0);
	this.DrawActorPriority(180);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(75,00000000.0, 0,00000000.0);
				this.alpha -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}

		if (this.y >= this.owner.centerY + 50)
		{
			this.SetMotion(this.motion, 1);
			::camera.shake_radius = 30,00000000.0;
			this.SetFreeObject(this.x, ::battle.scroll_bottom, this.direction, function ( t_ )
			{
				this.SetMotion(7020, 2);
				this.keyAction = this.ReleaseActor;
			}, {});
			this.stateLabel = function ()
			{
				this.Vec_Brake(75,00000000.0, 0,00000000.0);
				this.count++;

				if (this.count >= 20)
				{
					::camera.shake_radius = 30,00000000.0;
					this.PlaySE(1746);
					local t_ = {};
					t_.rate <- this.atkRate_Pat;
					this.SetShot(this.x, ::battle.scroll_bottom, this.direction, this.SpellShot_C_Pilar, t_);
					this.stateLabel = function ()
					{
						this.alpha -= 0,05000000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		}
	};
}

function SpellShot_C_Pilar( t )
{
	this.SetMotion(7020, 3);
	this.DrawActorPriority(191);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.keyAction = this.ReleaseActor;
	this.cancelCount = 99;
	this.stateLabel = function ()
	{
		if (this.hitCount == 0)
		{
			this.HitCycleUpdate();
		}
	};
}

function Climax_Back( t )
{
	this.SetMotion(4909, 1);
	this.EnableTimeStop(false);
	this.DrawActorPriority(1000);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4909, 0);
		}
	];
}

function Climax_Actor( t )
{
	this.SetMotion(4909, 7);
	this.EnableTimeStop(false);
	this.DrawActorPriority(1000);
	this.flag1 = null;
	this.flag2 = this.SetFreeObject(0, 0, 1,00000000.0, this.Climax_Spark, {}).weakref();
	this.red = this.green = this.blue = 0,75000000.0;
	this.flag5 = {};
	this.flag5.v <- this.Vector3();
	this.flag5.v.x = -80,00000000.0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 1260;
	this.flag5.pos.z = 900;
	this.flag5.cPos <- this.Vector3();
	this.flag5.cPos.x = 600;
	this.flag5.cPos.y = 840 + 150;
	this.flag5.vPos <- this.Vector3();
	this.flag5.vPos.x = 600;
	this.flag5.vPos.y = 300;
	this.flag5.vec <- this.Vector3();
	this.flag5.vec.z = -1,00000000.0;
	this.sx = this.sy = 0,50000000.0;
	this.subState = function ()
	{
		this.flag5.vPos.x += (180 - this.flag5.vPos.x) * 0,10000000.0;
		this.flag5.pos = this.flag5.pos + this.flag5.vec;
		this.sx = this.sy = (1200 - this.flag5.pos.z) / 1200,00000000.0 * ((1200 - this.flag5.pos.z) / 1200,00000000.0) * 0,50000000.0;
		this.x = this.flag5.vPos.x + (this.flag5.cPos.x - this.flag5.vPos.x + this.flag5.pos.x) * this.sx;
		this.y = this.flag5.vPos.y + (this.flag5.cPos.y - this.flag5.vPos.y + this.flag5.pos.y) * this.sy;
	};
	this.subState();
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			if (this.flag2)
			{
				this.flag2.ReleaseActor();
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4909, 3);
			this.flag1 = this.SetFreeObject(0, 0, 1,00000000.0, this.Climax_Light, {}).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 10)
				{
					this.flag1.func[1].call(this.flag1);
				}

				this.flag5.vec.z -= 5;
				this.rz *= 0,80000001.0;
				this.subState();
				this.red = this.green = this.blue += (1,00000000.0 - this.blue) * 0,10000000.0;

				if (this.flag1)
				{
					this.flag1.x = this.point0_x;
					this.flag1.y = this.point0_y;
					this.flag1.sx = this.flag1.sy = this.sx;
				}
			};
		},
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.flag5.pos.x *= 0,89999998.0;
		this.subState();

		if (this.flag1)
		{
			this.flag1.x = this.point0_x;
			this.flag1.y = this.point0_y;
			this.flag1.sx = this.flag1.sy = this.sx;
		}

		if (this.flag2)
		{
			local pos_ = this.Vector3();
			this.GetPoint(1, pos_);
			this.flag2.x = pos_.x;
			this.flag2.y = pos_.y;

			if (this.count == 40)
			{
				this.flag2.func[1].call(this.flag2);
				this.flag2 = null;
			}
		}
	};
}

function Climax_Light( t )
{
	this.SetMotion(4909, 4);
	this.EnableTimeStop(false);
	this.DrawActorPriority(1000);
	this.flag1 = 1,00000000.0;
	this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_LightB, {}).weakref();
	this.func = [
		function ()
		{
			if (this.flag2)
			{
				this.flag2.ReleaseActor();
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.flag2.func[1].call(this.flag2);
			this.stateLabel = function ()
			{
				this.alpha -= 0,02500000.0;
				this.flag1 += 0,05000000.0;
				this.sx = this.sy *= this.flag1;
				this.flag2.sx = this.flag2.sy = this.sx;
				this.flag2.x = this.x - 100 * this.sx;
				this.flag2.y = this.y + 100 * this.sy;
			};
		}
	];
}

function Climax_LightB( t )
{
	this.SetMotion(4909, 5);
	this.EnableTimeStop(false);
	this.DrawActorPriority(1000);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha += 0,20000000.0;
			};
		}
	];
}

function Climax_Spark( t )
{
	this.SetMotion(4909, 2);
	this.EnableTimeStop(false);
	this.DrawActorPriority(1000);
	this.flag1 = 1,00000000.0;
	this.sx = this.sy = 2,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,92000002.0;
				this.alpha -= 0,05000000.0;
				this.blue = this.green -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,99000001.0;
	};
}

