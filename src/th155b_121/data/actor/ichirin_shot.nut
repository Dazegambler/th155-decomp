function BattleBeginObjectA( t )
{
	this.SetMotion(9009, 0);
	this.stateLabel = function ()
	{
		this.Warp(this.owner.x, this.owner.y);

		if (this.owner.keyTake >= 2)
		{
			this.PlaySE(1471);
			this.ReleaseActor();

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				local r_ = 30 + this.rand() % 45;
				t_.rot <- (i * 45 + this.rand() % 30) * 0,01745329.0;
				this.owner.demoObject.append(this.SetFreeObject(this.point0_x + r_ * this.cos(t_.rot) * this.direction, this.point0_y + r_ * this.sin(t_.rot), this.direction, this.BattleBeginObjectB, t_).weakref());
			}
		}
	};
}

function BattleBeginObjectB( t )
{
	this.SetMotion(9009, 1 + this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,75000000.0 + this.rand() % 6 * 0,10000000.0;
	this.flag1 = (2 - this.rand() % 5) * 0,01745329.0;
	this.SetSpeed_Vec(2,00000000.0 + this.rand() % 7, t.rot, this.direction);
	this.owner.demoObject.append(this.weakref());
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(this.va.x * 0,89999998.0, this.va.y * 0,89999998.0);
		this.count++;
		this.rz += this.flag1;
		this.sx = this.sy += 0,01000000.0;

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

function unzanAuraEffect( t )
{
	this.SetMotion(6999, 0);
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.Warp(this.owner.x, this.owner.y);
		this.direction = this.owner.direction;
		this.count++;

		if (this.owner.flagState & -2147483648)
		{
			this.alpha = 0,00000000.0;
		}
		else if (!this.owner.unzan && ::battle.state == 8)
		{
			if (this.count % 20 == 0)
			{
				this.SetFreeObject(this.x + 50 - this.rand() % 100, this.y - 30 + this.rand() % 60, 1,00000000.0, this.unzanAuraEffectB, {});
			}
		}
		else
		{
		}
	};
}

function unzanAuraEffectB( t )
{
	this.SetMotion(6999, 1 + this.rand() % 2);
	this.alpha = 0,00000000.0;

	if (this.rand() % 100 <= 50)
	{
		this.direction = -this.direction;
	}

	this.sx = 0,75000000.0 + this.rand() % 6 * 0,10000000.0;
	this.sy = 0,75000000.0 + this.rand() % 6 * 0,10000000.0;
	this.SetSpeed_XY(-2,00000000.0 + this.rand() % 4, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.sx += 0,00500000.0;
		this.alpha += 0,07500000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.sx += 0,00250000.0;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Shot_Normal( t )
{
	this.SetMotion(2009, 0);
	this.flag1 = t.rot;
	this.SetSpeed_Vec(10,00000000.0, this.flag1, this.direction);
	this.cancelCount = 3;
	this.atk_id = 16384;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,10000000.0);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,10000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,10000000.0);
	};
}

function Shot_Normal_Mini( t )
{
	this.SetMotion(2009, 1);
	this.flag1 = t.rot;
	this.SetSpeed_Vec(10,00000000.0, this.flag1, this.direction);
	this.cancelCount = 1;
	this.atk_id = 16384;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,10000000.0);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,10000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,10000000.0);
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 0);
	this.SetSpeed_Vec(25,00000000.0, 0,00000000.0, this.direction);
	this.cancelCount = 6;
	this.atk_id = 65536;
	this.rx = 70 * 0,01745329.0;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.rz += 8,00000000.0 * 0,01745329.0;
				this.sx = this.sy *= 0,94999999.0;
				this.alpha -= 0,07500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.cancelCount > 3)
			{
				this.cancelCount = 3;
			}

			this.SetFreeObject(this.x, this.y, this.direction, function ( a_ )
			{
				this.SetMotion(2019, 2);
				this.rx = 70 * 0,01745329.0;
				this.stateLabel = function ()
				{
					this.rz += 8,00000000.0 * 0,01745329.0;
					this.sx = this.sy += 0,10000000.0;
					this.alpha -= 0,10000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}, {});
			this.SetMotion(2019, 1);
			this.target = this.owner.weakref();
			this.direction = -this.direction;
			this.PlaySE(1541);
			this.stateLabel = function ()
			{
				if (this.Damage_ConvertOP(this.x, this.y, 5))
				{
					this.ReleaseActor();
					return;
				}

				this.AddSpeed_Vec(0,30000001.0, null, 15,00000000.0);
				this.TargetHoming(this.team.current, 3,14159203.0, 1,00000000.0);
				this.rz += 16,00000000.0 * 0,01745329.0;

				if (this.cancelCount <= 0 || this.hitCount >= 2 || this.grazeCount >= 5 || this.team.current.IsDamage() || this.owner.motion == 2010 && this.owner.keyTake == 0)
				{
					this.func[0].call(this);
					return true;
				}

				this.HitCycleUpdate(5);

				if (this.GetTargetDist(this.team.current) <= 900,00000000.0)
				{
					this.callbackGroup = 0;
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = function ()
					{
						this.rz += 8,00000000.0 * 0,01745329.0;
						this.sx = this.sy += 0,10000000.0;
						this.alpha -= 0,10000000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.ReleaseActor();
						}
					};
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.rz += 8,00000000.0 * 0,01745329.0;

		if (this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 5 || this.team.current.IsDamage() || this.owner.motion == 2010 && this.owner.keyTake == 0)
		{
			this.func[0].call(this);
			return true;
		}

		this.HitCycleUpdate(10);

		if (this.VX_Brake(0,75000000.0))
		{
			this.func[1].call(this);
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2028, 0);
	this.sx = this.sy = t.scale;
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.FitBoxfromSprite();
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 10))
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha -= 0,15000001.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	return true;
}

function Shot_FullCharge_Core( t )
{
	this.SetMotion(2028, 1);
	this.flag1 = 1,00000000.0;
	this.flag3 = 2;
	this.func = [
		function ()
		{
			this.sx = this.sy = 2,00000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	local t_ = {};
	t_.scale <- this.flag1;
	t_.take <- 0;
	this.SetShot(this.x, this.y, this.direction, this.Shot_FullCharge, t_);
	this.flag1 += 0,50000000.0;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 11 == 1)
		{
			if (this.flag2 > 2)
			{
				this.PlaySE(1555);
				local t_ = {};
				t_.scale <- this.flag1;
				t_.take <- this.flag3;

				if (this.flag2 == 5)
				{
					this.SetShot(this.x, this.y, this.direction, this.Shot_FullChargeFinish, t_);
				}
				else
				{
					this.SetShot(this.x, this.y, this.direction, this.Shot_FullCharge, t_);
				}

				this.flag1 += 0,50000000.0;
				this.flag3++;
			}

			this.flag2++;

			if (this.flag2 >= 6)
			{
				this.func[0].call(this);
			}
		}
	};
	return true;
}

function Shot_FullChargeFinish( t )
{
	this.SetMotion(2029, 5);
	this.sx = this.sy = t.scale;
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.FitBoxfromSprite();
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
	};
	return true;
}

function Shot_FullCharge( t )
{
	this.SetMotion(2029, t.take);
	this.sx = this.sy = t.scale;
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.FitBoxfromSprite();
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
	};
	return true;
}

function Shot_Barrage_Unzan( t )
{
	this.SetMotion(2040, 0);
	this.DrawActorPriority(189);
	this.flag1 = [
		null,
		null
	];
	this.func = [
		function ()
		{
			if (this.flag1[0])
			{
				this.flag1[0].func();
				this.flag1[0] = null;
			}

			if (this.flag1[1])
			{
				this.flag1[1].func();
				this.flag1[1] = null;
			}

			this.SetMotion(2040, 2);
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
	this.keyAction = [
		function ()
		{
			this.flag1[0] = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Shot_Barrage_UnzanEye, {}).weakref();
			this.flag1[1] = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Shot_Barrage_UnzanEye, {}).weakref();
			this.stateLabel = function ()
			{
				this.Warp(this.owner.x, this.owner.y);

				if (this.flag1[0])
				{
					this.flag1[0].Warp(this.point0_x, this.point0_y);
				}

				if (this.flag1[1])
				{
					this.flag1[1].Warp(this.point1_x, this.point1_y);
				}

				this.count++;

				if (this.owner.motion == 2025 && this.owner.team.mp > 0)
				{
					if (this.count % 60 == 1)
					{
						this.PlaySE(1444);
						local pos_ = this.Vector3();
						pos_.x = this.point0_x;
						pos_.y = this.point0_y;

						for( local i = 0; i < 6,28318548.0; i = i + 0,26179937.0 )
						{
							local t_ = {};
							t_.rot <- i;
							this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Barrage, t_);
						}

						local pos_ = this.Vector3();
						pos_.x = this.point1_x;
						pos_.y = this.point1_y;

						for( local i = 0; i < 6,28318548.0; i = i + 0,26179937.0 )
						{
							local t_ = {};
							t_.rot <- i;
							this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Barrage, t_);
						}
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Warp(this.owner.x, this.owner.y);

		if (this.flag1[0])
		{
			this.flag1[0].Warp(this.point0_x, this.point0_y);
		}

		if (this.flag1[1])
		{
			this.flag1[1].Warp(this.point1_x, this.point1_y);
		}
	};
}

function Shot_Barrage_UnzanEye( t )
{
	this.SetMotion(2040, 3);
	this.sx = this.sy = 0,10000000.0;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,93000001.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2040, 4);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = t.rot;
	this.SetSpeed_Vec(4,00000000.0, this.rz, this.direction);
	this.keyAction = this.ReleaseActor;
	this.sx = this.sy = 0,10000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetCollisionRotation(0, 0, this.rz);
	this.cancelCount = 1;
	this.atk_id = 262144;
	this.func = function ()
	{
		this.SetMotion(this.motion, 5);
		this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
		this.stateLabel = function ()
		{
			this.sy *= 0,92000002.0;
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(50) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.sx < 1,00000000.0)
		{
			this.sx = this.sy += 0,05000000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}
	};
}

function Bullet_Okult( t )
{
	this.SetMotion(2507, 0);
	this.SetFreeObject(this.x, this.y, this.direction, this.Bullet_OkultFire, {});
	this.rz = t.rot;
	this.SetSpeed_Vec(1,50000000.0, this.rz, this.direction);
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x * 0,20000000.0;
	this.flag1.y = this.va.y * 0,20000000.0;
	this.cancelCount = 1;
	this.atk_id = 524288;
	this.func = function ()
	{
		this.SetMotion(2507, 1);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy -= 0,05000000.0;
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
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.team.current.IsDamage())
		{
			this.func();
			return;
		}

		if (this.owner.occult_in == false)
		{
			this.stateLabel = function ()
			{
				if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.team.current.IsDamage())
				{
					this.func();
					return;
				}

				this.AddSpeed_XY(this.flag1.x, this.flag1.y);
			};
		}
	};
}

function Bullet_OkultFire( t )
{
	this.SetMotion(2507, 2);
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

function Shot_Okult( t )
{
	this.SetMotion(2508, 0);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (3,00000000.0 - this.sx) * 0,10000000.0;
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

function Shot_Okult_Field( t )
{
	this.SetMotion(2508, 4);
	this.target = this.owner.target.weakref();
	this.flag1 = [];
	this.flag2 = t.scale;
	this.flag3 = this.Vector3();
	this.flag3.x = 1,00000000.0;
	this.flag4 = 0,00000000.0;
	this.flag5 = {};
	this.flag5.count <- 60;
	this.flag5.pos <- this.Vector3();
	this.PlaySE(1548);
	this.func = [
		function ()
		{
			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.func();
				}
			}

			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,00500000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.sx = this.sy = this.flag2;
			this.rz = this.rand() % 360;
			this.alpha = 0,00000000.0;
			this.stateLabel = function ()
			{
				this.subState();
				this.sx = this.sy -= 0,00500000.0;
				this.alpha += 0,20000000.0;

				if (this.alpha > 1,00000000.0)
				{
					this.alpha = 1,00000000.0;
					this.stateLabel = function ()
					{
						this.subState();
						this.sx = this.sy += 0,00250000.0;
						this.alpha -= 0,05000000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.func[1].call(this);
						}
					};
				}
			};
		},
		function ()
		{
			this.SetShot(this.owner.target.x, this.owner.target.y, this.direction, this.Shot_Okult_Exp, {});
			this.func[0].call(this);
		}
	];
	this.subState = function ()
	{
		this.flag5.pos.x = this.owner.target.x - this.x;
		this.flag5.pos.y = this.owner.target.y - this.y;

		if (this.flag5.pos.Length() <= 50 * this.flag2)
		{
			this.owner.occult_in = true;
		}
		else
		{
			this.owner.occult_in = false;
		}

		if (this.count <= this.flag5.count && this.count % 3 == 1)
		{
			this.flag3.RotateByRadian(0,17453292.0);
			this.flag4 += 0,17453292.0;
			local range_ = this.flag2 * 45;
			local r_ = this.flag4;
			local t_ = {};
			t_.rot <- this.flag4 + 1,04719746.0;
			this.flag4 += 1,57079601.0;
			this.SetShot(this.x + this.flag3.x * range_ * this.direction, this.y + this.flag3.y * range_, this.direction, this.Bullet_Okult, t_);
			local r_ = this.flag4;
			local t_ = {};
			t_.rot <- this.flag4 + 1,04719746.0;
			this.flag4 += 1,57079601.0;
			this.SetShot(this.x - this.flag3.y * range_ * this.direction, this.y + this.flag3.x * range_, this.direction, this.Bullet_Okult, t_);
			local r_ = this.flag4;
			local t_ = {};
			t_.rot <- this.flag4 + 1,04719746.0;
			this.flag4 += 1,57079601.0;
			this.SetShot(this.x - this.flag3.x * range_ * this.direction, this.y - this.flag3.y * range_, this.direction, this.Bullet_Okult, t_);
			local r_ = this.flag4;
			local t_ = {};
			t_.rot <- this.flag4 + 1,04719746.0;
			this.flag4 += 1,57079601.0;
			this.SetShot(this.x + this.flag3.y * range_ * this.direction, this.y - this.flag3.x * range_, this.direction, this.Bullet_Okult, t_);
		}

		this.count++;

		if (this.count >= this.flag5.count)
		{
			this.func[0].call(this);
		}
	};
	this.func[1].call(this);
}

function Shot_Okult_FieldB( t )
{
	this.SetMotion(2508, 2);
	this.sx = this.sy = 0,20000000.0;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,98000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
}

function Shot_Okult_Exp( t )
{
	this.SetMotion(2508, 5);
	this.atk_id = 524288;
	this.keyAction = function ()
	{
		this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Okult_Spark, {});
		this.stateLabel = function ()
		{
			this.sx = this.sy += (this.sx - 3,00000000.0) * 0,15000001.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
}

function Shot_Okult_Spark( t )
{
	this.SetMotion(2508, 7);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 4 == 3)
		{
			this.rz = this.rand() % 360 * 0,01745329.0;
			this.sx = this.sy = 2,50000000.0 + this.rand() % 5 * 0,10000000.0;
		}

		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Okult_OptionBack( t )
{
	this.SetMotion(2509, 4);
	this.DrawActorPriority(179);
	this.sx = 0,80000001.0 + this.rand() % 31 * 0,01000000.0;
	this.sy = 0,69999999.0 + this.rand() % 11 * 0,01000000.0;
	this.flag1 = this.Vector3();
	this.flag1.x = 0,00500000.0;
	this.flag1.y = 0,01000000.0;
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -0,15000001.0);
				this.sx += this.flag1.x;
				this.sy += this.flag1.y;
				this.alpha -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, -0,10000000.0);
		this.sx += this.flag1.x;
		this.sy += this.flag1.y;
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -0,10000000.0);
				this.sx += this.flag1.x;
				this.sy += this.flag1.y;
				this.alpha -= 0,04000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Okult_Option( t )
{
	this.SetMotion(2509, 0);
	this.PlaySE(1528);
	this.target = this.owner.target.weakref();
	this.DrawActorPriority(180);
	this.alpha = 0,00000000.0;
	this.sx = 0,10000000.0;
	this.sy = 3,00000000.0;
	this.flag1 = 0,00000000.0;
	this.flag2 = this.y;
	this.y -= 400;
	this.flag3 = this.y;
	this.flag5 = {};
	this.flag5.option <- ::manbow.Actor2DProcGroup();
	this.flag5.baria <- null;
	this.flag5.scale <- 6,00000000.0;
	this.flag5.v <- 8,00000000.0;
	this.flag5.count <- 200;
	this.flag5.k <- t.k;
	this.flag5.level <- 4;
	this.func = [
		function ()
		{
			if (this.flag5.baria)
			{
				this.flag5.baria.func[0].call(this.flag5.baria);
			}

			this.flag5.option.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy += 0,15000001.0;
				this.alpha -= 0,05000000.0;
				this.SetSpeed_XY(0,00000000.0, -15 * this.sy);

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			local t_ = {};
			t_.scale <- this.flag5.scale;
			t_.v <- this.flag5.v;
			t_.ball <- this.flag5.level;
			local x_ = 0;

			if (this.flag5.k > 0,00000000.0)
			{
				x_ = 150;
			}

			if (this.flag5.k < 0,00000000.0)
			{
				x_ = -150;
			}

			if (this.owner.target.x + x_ > ::battle.corner_right || this.owner.target.x + x_ < ::battle.corner_left)
			{
				x_ = 0;
			}

			this.flag5.baria = this.SetShot(this.owner.target.x + x_, this.owner.target.y, this.direction, this.Shot_Okult_Field, t_, this.weakref()).weakref();
			this.PlaySE(1529);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.team.current.IsDamage())
				{
					this.func[0].call(this);
					return;
				}

				if (this.count >= this.flag5.count || this.flag5.baria == null)
				{
					this.func[0].call(this);
					return;
				}

				if (this.count % 20 == 1)
				{
					this.flag5.option.Add(this.SetFreeObject(this.x, this.y + 20, this.direction, this.Okult_OptionBack, {}));
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.flag1 += 0,06000000.0;

		if (this.flag1 > 1,00000000.0)
		{
			this.flag1 = 1,00000000.0;
		}

		this.sx = this.Math_Bezier(0,10000000.0, 1,00000000.0, 0,89999998.0, this.flag1);
		this.sy = this.Math_Bezier(3,00000000.0, 1,00000000.0, 1,20000005.0, this.flag1);
		this.y = this.Math_Bezier(this.flag3, this.flag2, this.flag2 - 20, this.flag1);
		this.alpha += 0,10000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		if (this.count == 20)
		{
			this.func[1].call(this);
		}
	};
}

function Shot_Okult_Front( t )
{
	this.SetMotion(2509, 0);
	this.DrawActorPriority(170);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(17,50000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.hitResult & 1)
				{
					this.flag1 = true;
				}

				this.HitCycleUpdate(7);
				this.count++;

				if (this.count >= 30)
				{
					this.SetMotion(2509, 2);
					this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);

					if (this.flag1)
					{
						local t_ = {};
						t_.scale <- 4,00000000.0;
						this.SetShot(this.owner.target.x, this.owner.target.y, this.direction, this.Shot_Okult_Field, t_);
					}

					this.stateLabel = function ()
					{
						this.VX_Brake(0,10000000.0);
						this.alpha -= 0,05000000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.owner.unzan = true;
							this.ReleaseActor();
						}
					};
				}
			};
		}
	];
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.SetSpeed_Vec(20,00000000.0, t.rot, this.direction);
	this.cancelCount = 3;
	this.atk_id = 536870912;
	this.rx = 70 * 0,01745329.0;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.rz += 8,00000000.0 * 0,01745329.0;
				this.sx = this.sy *= 0,94999999.0;
				this.alpha -= 0,07500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, function ( a_ )
			{
				this.SetMotion(2019, 2);
				this.rx = 70 * 0,01745329.0;
				this.stateLabel = function ()
				{
					this.rz += 8,00000000.0 * 0,01745329.0;
					this.sx = this.sy += 0,10000000.0;
					this.alpha -= 0,10000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}, {});
			this.SetMotion(this.motion, 1);
			this.direction = -this.direction;
			this.stateLabel = function ()
			{
				if (this.Damage_ConvertOP(this.x, this.y, 3) || this.direction == 1,00000000.0 && this.x > ::battle.scroll_right + 100 || this.direction == -1,00000000.0 && this.x < ::battle.scroll_left - 100)
				{
					this.ReleaseActor();
					return;
				}

				this.AddSpeed_XY(0,30000001.0 * this.direction, 0,00000000.0, 10,00000000.0 * this.direction, null);
				this.VY_Brake(0,33000001.0);
				this.rz += 16,00000000.0 * 0,01745329.0;

				if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 1)
				{
					this.func[0].call(this);
					return true;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.rz += 8,00000000.0 * 0,01745329.0;

		if (this.Damage_ConvertOP(this.x, this.y, 3))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 1)
		{
			this.func[0].call(this);
			return true;
		}

		if (this.VX_Brake(0,40000001.0))
		{
			this.func[1].call(this);
		}
	};
}

function SPShot_A( t )
{
	this.SetMotion(6000, 0);
	this.cancelCount = 10;
	this.atk_id = 1048576;
	this.SetSpeed_XY(0,00000000.0, 45,00000000.0);
	this.DrawActorPriority(180);
	this.subState = function ()
	{
		if (this.cancelCount <= 0 || this.Damage_ConvertOP(this.x, this.y, 10))
		{
			this.func[0].call(this);
			return true;
		}
	};
	this.func = [
		function ()
		{
			this.SetMotion(6000, 1);
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(0,00000000.0, this.va.y * 0,85000002.0);

				if (this.alpha > 0,05000000.0)
				{
					this.alpha -= 0,05000000.0;
				}
				else
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.count++;

		if (this.count == 15)
		{
			this.SetMotion(6000, 1);
			this.SetSpeed_XY(0,00000000.0, 10,00000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				this.SetSpeed_XY(0,00000000.0, this.va.y * 0,85000002.0);

				if (this.count >= 20)
				{
					this.func[0].call(this);
				}
			};
		}
	};
}

function SPShot_B( t )
{
	this.flag3 = 0;
	this.priority = 200;
	this.SetMotion(6010, 0);
	this.SetSpeed_XY(t.vx * this.direction, t.vy);
	this.cancelCount = 3;
	this.flag1 = {};
	this.flag1.x <- t.ax;
	this.flag1.y <- t.ay;
	this.flag2 = function ()
	{
		this.SetMotion(this.motion, 1);
		this.stateLabel = function ()
		{
			this.SetSpeed_XY(this.va.x * 0,97000003.0, this.va.y * 0,97000003.0);
			this.sx = this.sy *= 0,99500000.0;
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.sx = this.sy = 0,50000000.0;
	this.func = function ()
	{
		if (this.IsScreen(300,00000000.0))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount >= 4 || this.cancelCount <= 0)
		{
			this.flag2();
			return;
		}

		this.HitCyleUpdate(3);
		this.AddSpeed_XY(this.flag1.x * this.direction, this.flag1.y);
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,10000000.0;

		if (this.sx >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,02000000.0;
				this.func();
			};
		}

		this.func();
	};
}

function SPShot_C( t )
{
	this.priority = 180;
	this.SetMotion(6020, 0);
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1554);
			local t_ = {};
			t_.point <- 0;
			t_.pare <- this.name;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_C_SparkPre, t_);
			local t_ = {};
			t_.point <- 1;
			t_.pare <- this.name;
			this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.SPShot_C_SparkPre, t_);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.hitResult)
				{
					if (this.hitResult & 32)
					{
						this.HitReset();
					}
					else
					{
						this.flag1++;

						if (this.flag1 >= 5)
						{
							this.flag1 = 0;
							this.HitReset();
						}
					}
				}

				if (this.count >= 60)
				{
					this.count = 0;
					this.SetMotion(6020, 3);
					this.stateLabel = null;
				}
			};
		},
		null,
		null,
		function ()
		{
			this.owner.unzan = true;
			this.ReleaseActor();
		}
	];
}

function SPShot_C_SparkPre( t )
{
	this.priority = 200;
	this.SetMotion(6021, 1);
	this.flag1 = {};
	this.flag1.point <- t.point;
	this.flag1.pare <- t.pare;
	this.stateLabel = function ()
	{
		if (::actor[this.flag1.pare].motion == 3020 || ::actor[this.flag1.pare].motion == 6020)
		{
			if (::actor[this.flag1.pare].keyTake != 1)
			{
				this.ReleaseActor();
			}
			else if (this.flag1.point == 0)
			{
				this.Warp(::actor[this.flag1.pare].point0_x, ::actor[this.flag1.pare].point0_y);
			}
			else
			{
				this.Warp(::actor[this.flag1.pare].point1_x, ::actor[this.flag1.pare].point1_y);
			}
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_C_Spark( t )
{
	this.SetMotion(t.motion, 0);
	this.keyAction = this.ReleaseActor;
}

function SPShot_C_SparkB( t )
{
	this.SetMotion(6022, 0);
	this.sx = this.sy = 1,50000000.0;
	this.FitBoxfromSprite();
	this.keyAction = this.ReleaseActor;
}

function SPShot_D( t )
{
	this.actorType = 4;
	this.atkOwner = this.owner.weakref();
	this.SetMotion(3039, 0);
	this.flag1 = 0;
	this.atk_id = 4194304;
	this.sy = this.sx = 0,60000002.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.stateLabel = function ()
	{
		if (this.owner.motion == 3030)
		{
			if (this.hitResult)
			{
				this.owner.hitResult = this.hitResult;
			}

			if (this.owner.keyTake <= 1)
			{
				this.count++;

				if (this.count % 15 == 1)
				{
					this.PlaySE(1553);
				}

				this.Warp(this.owner.x + 50 * this.direction, this.owner.y);
				this.HitCycleUpdate(8);
			}
			else
			{
				this.callbackGroup = 0;
				this.ReleaseActor();
			}
		}
		else
		{
			this.callbackGroup = 0;
			this.ReleaseActor();
		}
	};
}

function SPShot_D_Alone( t )
{
	this.SetMotion(6031, 0);
	this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
	this.atk_id = 4194304;
	this.flag1 = null;
	this.func = function ()
	{
		if (this.team.current.IsDamage())
		{
			this.stateLabel = null;
			this.SetMotion(6031, 2);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.flag1 = null;
		}
	};
	this.keyAction = [
		function ()
		{
			this.flag1 = this.SetShot(this.x, this.y, this.direction, this.SPShot_D_Fist, {}).weakref();
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0, 3,00000000.0);

				if (this.flag1)
				{
					this.Warp.call(this.flag1, this.x + 100 * this.direction, this.y);
				}

				if (this.direction == 1,00000000.0 && this.x > ::battle.corner_right - 100,00000000.0 || this.direction == -1,00000000.0 && this.x < ::battle.corner_left + 100,00000000.0)
				{
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
				}

				this.count++;

				if (this.count >= 60)
				{
					this.count = 0;
					this.stateLabel = function ()
					{
						this.count++;

						if (this.count >= 9)
						{
							if (this.alpha >= 0,10000000.0)
							{
								this.alpha -= 0,10000000.0;
							}
						}
					};
					this.SetMotion(6031, 2);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

					if (this.flag1)
					{
						this.flag1.ReleaseActor();
					}

					this.flag1 = null;
				}
				else
				{
					this.func();
				}
			};
		},
		function ()
		{
		},
		function ()
		{
			this.ReleaseActor();
			this.owner.unzanReload = 90;
		}
	];
	this.stateLabel = function ()
	{
		this.func();

		if (this.direction == 1,00000000.0 && this.x > ::battle.corner_right - 100,00000000.0 || this.direction == -1,00000000.0 && this.x < ::battle.corner_left + 100,00000000.0)
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		}
	};
}

function SPShot_D_Fist( t )
{
	this.SetMotion(6031, 3);
	this.flag1 = 0;
	this.sy = this.sx = 0,60000002.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 15 == 1)
		{
			this.PlaySE(1553);
		}

		if (this.hitResult)
		{
			this.flag1++;

			if (this.flag1 >= 10)
			{
				this.flag1 = 0;
				this.HitTargetReset();
			}
		}
	};
}

function SPShot_E( t )
{
	this.SetMotion(6040, 3);
	this.option = this.SetShot(this.x, this.y, this.direction, this.SPShot_E_Line, t).weakref();
	this.sx = this.sy = 0,00000000.0;
	this.flag1 = true;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,89999998.0;

			if (this.sx <= 0,05000000.0)
			{
				this.ReleaseActor();
			}
		};

		if (this.option)
		{
			this.option.func.call(this.option);
		}
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,20000000.0;

		if (this.initTable.pare)
		{
			this.x = this.initTable.pare.point0_x;
			this.y = this.initTable.pare.point0_y;
		}

		if (this.option)
		{
			if (this.option.flag1 == false)
			{
				this.flag1 = false;
			}
		}
	};
}

function SPShot_E_Line( t )
{
	this.SetMotion(6040, 4);
	this.rz = t.rot;
	this.sy = 0,00000000.0;
	this.sx = 20,00000000.0;
	this.SetCollisionScaling(this.sx, 1,00000000.0, 1,00000000.0);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.cancelCount = 6;
	this.atk_id = 8388608;
	this.flag1 = true;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sy *= 0,89999998.0;
			this.alpha = this.green = this.blue -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0)
		{
			this.func();
			return;
		}

		if (this.hitResult & 13 || this.grazeCount > 0)
		{
			this.flag1 = false;
		}

		if (this.flag1)
		{
			this.rz *= 0,92000002.0;
		}
		else
		{
			this.rz *= 0,99000001.0;
		}

		this.SetCollisionScaling(this.sx, 2,00000000.0, 1,00000000.0);
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
		local t_ = {};
		t_.rot <- this.rz;
		this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E_Trail, t_, this.weakref());
		this.sy += 0,20000000.0;

		if (this.sy > 4,00000000.0)
		{
			this.sy = 4,00000000.0;
		}

		this.HitCycleUpdate(5);
	};
}

function SPShot_E_Trail( t )
{
	this.SetMotion(6040, 5);
	this.rz = t.rot;
	this.sx = 20,00000000.0;
	this.stateLabel = function ()
	{
		if (this.initTable.pare)
		{
			this.x = this.initTable.pare.x;
			this.y = this.initTable.pare.y;
		}

		this.sy *= 0,89999998.0;
		this.alpha = this.green = this.blue -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_E_Unzan( t )
{
	this.SetMotion(6040, 0);
	this.DrawActorPriority(180);
	this.option = [];
	this.flag1 = t.rot;
	this.subState = function ()
	{
		if (this.team.current.IsDamage() > 0)
		{
			this.SetMotion(this.motion, 2);

			if (this.option.len() > 0)
			{
				foreach( a in this.option )
				{
					if (a)
					{
						a.func();
					}
				}
			}

			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 30)
				{
					this.alpha -= 0,05000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.owner.unzanReload = 60;
						this.ReleaseActor();
						return true;
					}
				}
			};
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.subState())
				{
					return;
				}

				if (this.count >= 50)
				{
					foreach( a in this.option )
					{
						if (a)
						{
							if (a.flag1)
							{
								this.SetMotion(this.motion, 2);
								this.keyAction[1].call(this);
								return;
							}
						}
					}
				}
			};
			this.PlaySE(1556);
			local t_ = {};
			t_.rot <- this.flag1;
			this.option.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_E, t_, this.weakref()).weakref());
		},
		function ()
		{
			foreach( a in this.option )
			{
				if (a)
				{
					a.func();
				}
			}

			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 30)
				{
					this.alpha -= 0,05000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.owner.unzanReload = 60;
						this.ReleaseActor();
						return true;
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}
	};
}

function SPShot_F( t )
{
	this.SetMotion(6050, 0);
	this.SetSpeed_Vec(10,00000000.0, t.rot, this.direction);
	this.cancelCount = 6;
	this.sx = this.sy = 0,25000000.0;
	this.FitBoxfromSprite();
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx *= 0,98000002.0;
			this.sy *= 0,89999998.0;
			this.alpha -= 0,10000000.0;
			this.Vec_Brake(0,50000000.0);

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(300,00000000.0))
		{
			this.ReleaseActor();
			return;
		}

		this.VX_Brake(this.va.x * this.direction >= 2,00000000.0 ? 0,10000000.0 : 0,00000000.0);
		this.AddSpeed_XY(0,00000000.0, -0,10000000.0);
		this.count++;
		local s_ = (this.cancelCount + 6) / 12;
		this.sx = this.sy += (s_ - this.sx) * 0,10000000.0;
		this.FitBoxfromSprite();

		if (this.cancelCount <= 0 || this.hitCount >= 3 || this.count >= 60 || this.grazeCount >= 20)
		{
			this.func();
			return;
		}

		this.HitCycleUpdate(6);
	};
}

function SPShot_F2( t )
{
	this.SetMotion(6051, 0);
	this.SetSpeed_Vec(10,00000000.0, t.rot, this.direction);
	this.cancelCount = 6;
	this.stateLabel = function ()
	{
		if (this.IsScreen(300,00000000.0))
		{
			this.ReleaseActor();
			return;
		}

		this.VX_Brake(this.va.x * this.direction >= 2,00000000.0 ? 0,10000000.0 : 0,00000000.0);
		this.AddSpeed_XY(0,00000000.0, -0,10000000.0);
		this.count++;

		if (this.cancelCount <= 0 || this.hitCount >= 2 || this.count >= 60 || this.grazeCount >= 10)
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha -= 0,10000000.0;
				this.Vec_Brake(0,50000000.0);

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			return;
		}

		this.HitCycleUpdate(6);
	};
}

function SPShot_RingFlight_A( t )
{
	this.SetMotion(3079, 0);
	this.DrawActorPriority(190);
	this.rx = 26 * 0,01745329.0 * this.direction;
	this.ry = 62 * 0,01745329.0;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.alpha = 0,00000000.0;
	this.blue = 0,00000000.0;
	this.sx = this.sy = 1,89999998.0;
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.alpha = this.blue = 1,00000000.0;
		this.stateLabel = function ()
		{
			this.rz += 0,17453292.0;
			this.sx = this.sy += 0,10000000.0;
			this.alpha = this.blue = this.green -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.rz += 0,34906584.0;

		if (this.alpha < 1,00000000.0)
		{
			this.alpha = this.blue += 0,25000000.0;
		}
	};
}

function SPShot_RingFlight_B( t )
{
	this.SetMotion(3079, 1);
	this.DrawActorPriority(189);
	this.rx = -24 * 0,01745329.0 * this.direction;
	this.ry = -0,52359873.0;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.sx = this.sy = 1,75000000.0;
	this.alpha = 0,00000000.0;
	this.blue = 0,00000000.0;
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.alpha = this.blue = 1,00000000.0;
		this.stateLabel = function ()
		{
			this.rz -= 0,17453292.0;
			this.sx = this.sy += 0,10000000.0;
			this.alpha = this.blue = this.green -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.rz -= 0,34906584.0;

		if (this.alpha < 1,00000000.0)
		{
			this.alpha = this.blue += 0,25000000.0;
		}
	};
}

function SpellShot_A( t )
{
	this.SetMotion(7000, 0);
	this.flag1 = 0;
	this.atk_id = 67108864;
	this.sy = this.sx = 0,75000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.stateLabel = function ()
	{
		if (this.owner.motion == 4000)
		{
			if (this.owner.keyTake == 3)
			{
				this.count++;

				if (this.count % 15 == 1)
				{
					this.PlaySE(1553);
				}

				this.Warp(this.owner.x + 100 * this.direction, this.owner.y);

				if (this.hitResult)
				{
					this.owner.hitResult = 1;
					this.flag1++;

					if (this.flag1 >= 10)
					{
						this.flag1 = 0;
						this.HitReset();
					}
				}
			}
			else
			{
				this.callbackGroup = 0;
				this.stateLabel = function ()
				{
					this.alpha -= 0,20000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}
		}
		else
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_B( t )
{
	this.SetMotion(7000, 0);
	this.alpha = 0,00000000.0;
	this.flag1 = 0,01000000.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.sx = this.sy += this.flag1;
		this.rz -= 0,05000000.0;
		this.count++;

		if (this.count == 30)
		{
			local t = {};
			t.scale <- this.sx;
			t.rot <- this.rz;
			this.SetShot(this.x, this.y, this.direction, this.SpellShot_A_Fist, t);
		}

		if (this.count == 60)
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.rz -= 0,10000000.0;
				this.sx = this.sy += 0,05000000.0;
				this.alpha -= 0,07500000.0;

				if (this.alpha < 0,00000000.0)
				{
					this.ReleaseActor();
					return;
				}
			};
		}
	};
}

function SpellShot_B_Fist( t )
{
	this.SetMotion(7010, 1);
	this.alpha = 0,00000000.0;
	this.flag1 = 350,00000000.0;
	this.flag2 = 700,00000000.0;
	this.flag3 = this.Vector3();
	this.rz = t.rot * 0,50000000.0;
	this.sx = this.sy = this.flag1 / this.flag2;
	this.flag3.x = t.vec * this.cos(t.rot) * 1,25000000.0;
	this.flag3.y = t.vec * this.sin(t.rot) * 0,50000000.0;
	this.subState = function ()
	{
		this.sx = this.sy = this.flag1 / this.flag2;
		this.SetSpeed_XY(this.flag3.x * this.sx * this.direction, this.flag3.y * this.sy);
	};
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.flag1 += 35;
		this.subState();

		if (this.flag1 >= this.flag2)
		{
			this.count = 0;
			local t_ = {};
			t_.rate <- this.initTable.rate;
			this.SetShot(this.x, this.y, this.direction, this.SpellShot_B_Hit, t_);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.flag3.x *= -0,01000000.0;
			this.flag3.y *= -0,01000000.0;
			this.stateLabel = function ()
			{
				this.count++;
				this.flag1 -= 1;
				this.subState();

				if (this.count >= 6)
				{
					this.alpha -= 0,10000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
						return;
					}
				}
			};
		}
	};
}

function SpellShot_B_Hit( t )
{
	this.SetMotion(7010, 2);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.rz = 0,01745329.0 * this.rand() % 360;
	this.PlaySE(1489);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
}

function SpellShot_C( t )
{
	this.flag1 = t.rot;

	if (this.flag1 < 0,00000000.0)
	{
		this.SetMotion(7021, 0);
	}
	else
	{
		this.SetMotion(7020, 0);
	}

	this.rz = this.flag1 - 3,14159203.0 * 0,50000000.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(45,00000000.0, this.flag1, this.direction);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 15)
		{
			this.SetMotion(this.motion, 1);
			this.SetSpeed_Vec(10,00000000.0, this.flag1, this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				this.SetSpeed_XY(this.va.x * 0,85000002.0, this.va.y * 0,85000002.0);

				if (this.count >= 20)
				{
					this.stateLabel = function ()
					{
						if (this.alpha > 0,05000000.0)
						{
							this.alpha -= 0,05000000.0;
						}
						else
						{
							this.ReleaseActor();
						}
					};
				}
			};
		}
	};
}

function SpellShot_C_Core( t )
{
	this.priority = 200;
	this.SetMotion(7022, 0);
	this.flag1 = 20;
	this.stateLabel = function ()
	{
		this.flag1++;

		if (this.flag1 % 20 == 1)
		{
			::camera.shake_radius = 7,00000000.0;
			this.PlaySE(1572);

			if (this.flag2 % 2 == 0)
			{
				local t = {};
				t.rot <- 80 * 0,01745329.0;
				this.SetShot(this.x + this.flag1 * 6,00000000.0 * this.direction, 0,00000000.0, this.direction, this.SpellShot_C, t);
			}
			else
			{
				local t = {};
				t.rot <- -80 * 0,01745329.0;
				this.SetShot(this.x + this.flag1 * 6,00000000.0 * this.direction, 768,00000000.0, this.direction, this.SpellShot_C, t);
			}

			this.flag2++;
		}

		if (this.flag2 >= 4)
		{
			this.ReleaseActor();
			return;
		}
	};
}

function SpellShot_D( t )
{
	this.priority = 200;
	this.flag1 = t.rot;
	this.SetMotion(7030, 0);
	this.rz = this.flag1 - 3,14159203.0 * 0,50000000.0;
	this.SetSpeed_Vec(15,00000000.0, this.flag1, this.direction);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.stateLabel = function ()
	{
		if (this.hitResult)
		{
			this.flag2++;

			if (this.flag2 >= 10)
			{
				this.flag2 = 0;
				this.HitReset();
			}
		}

		if (this.y + this.va.y >= ::battle.corner_bottom)
		{
			this.PlaySE(1574);
			this.ConnectRenderSlot(::graphics.slot.actor, 190);
			this.SetMotion(this.motion, 1);
			::camera.shake_radius = 20,00000000.0;
			this.SetSpeed_Vec(3,00000000.0, this.flag1, this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,00010000.0;

				if (this.alpha > 0,01000000.0)
				{
					this.alpha -= 0,01000000.0;
				}
				else
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_F( t )
{
	this.SetMotion(7050, 0);
	this.DrawActorPriority(180);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.rz = -10,00000000.0 * 0,01745329.0;
	this.flag1 = this.Vector3();
	this.flag2 = this.y;
	this.Warp(this.direction == 1,00000000.0 ? ::camera.camera2d.left : ::camera.camera2d.right, this.flag2);
	this.SetSpeed_Vec(5,00000000.0, this.rz, this.direction);
	this.flag3 = this.Vector3();
	this.flag3.x = this.va.x;
	this.flag3.y = this.va.y;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.count = -1;
	this.cancelCount = 99;
	this.stateLabel = function ()
	{
		this.flag3.Mul(1,10000002.0);
		this.flag1 += this.flag3;
		this.Warp(this.direction == 1,00000000.0 ? ::camera.camera2d.left + this.flag1.x : ::camera.camera2d.right + this.flag1.x, this.flag2 + this.flag1.y);

		if (this.hitCount <= 0)
		{
			this.HitCycleUpdate(10);
		}

		if (this.abs(this.flag1.x) >= 850)
		{
			this.PlaySE(1481);
			this.SetMotion(this.motion, 1);
			::camera.shake_radius = 20,00000000.0;
			this.SetSpeed_Vec(1,00000000.0, -5 * 0,01745329.0, this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				this.AddSpeed_Vec(0,10000000.0, this.rz + 3,14159203.0, null, this.direction);

				if (this.count >= 45)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_Vec(1,50000000.0, this.rz + 3,14159203.0, null, this.direction);

						if (this.alpha > 0,05000000.0)
						{
							this.alpha -= 0,05000000.0;
						}
						else
						{
							this.ReleaseActor();
						}
					};
				}
			};
		}
	};
}

function SPShot_RingFlight_HitBox( t )
{
	this.SetMotion(3078, 0);
	this.atk_id = 33554432;
	this.SetParent(this.owner, 0, 0);
	this.func = this.ReleaseActor;
	this.hitOwner = this.owner.weakref();
	this.stateLabel = function ()
	{
	};
}

function SPShot_RingFlight_CounterBox( t )
{
	this.SetMotion(3078, 1);
	this.atk_id = 33554432;
	this.SetParent(this.owner, 0, 0);
	this.cancelCount = 12;
	this.func = this.ReleaseActor;
	this.stateLabel = function ()
	{
	};
}

function Climax_BackShot( t )
{
	this.SetMotion(4909, 3);
	this.atkRate_Pat = t.rate;
	local t_ = {};
	t_.rate <- this.atkRate_Pat;
	this.atk_id = 134217728;
	this.flag2 = this.SetShotStencil(this.owner.x, this.owner.y, this.direction, this.Climax_BackShotMask, t_).weakref();
	this.flag2.hitOwner = this;
	this.anime.stencil = this.flag2;
	this.DrawActorPriority(200);
	this.func = [
		function ()
		{
			if (this.flag2)
			{
				this.ReleaseActor.call(this.flag2);
			}

			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,00500000.0;
		this.alpha -= 0,02500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.func[0].call(this);
		}
	};
}

function Climax_BackShotMask( t )
{
	this.SetMotion(4909, 5);
	this.atkRate_Pat = t.rate;
	this.anime.is_write = true;
	this.sx = this.sy = 1,00000000.0;
	this.SetParent(this.owner, 0, 0);
	this.DrawActorPriority(200);
	this.stateLabel = function ()
	{
		if (this.team.current.IsDamage())
		{
			this.SetParent(null, 0, 0);
		}

		this.sx = this.sy += 0,00100000.0;
	};
}

function Climax_OptionBack( t )
{
	this.SetMotion(4908, 4);
	this.DrawActorPriority(188);
	this.sx = 0,80000001.0 + this.rand() % 31 * 0,01000000.0;
	this.sy = 0,80000001.0 + this.rand() % 31 * 0,01000000.0;
	this.flag1 = this.Vector3();
	this.flag1.x = 0,00500000.0;
	this.flag1.y = 0,01500000.0;
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -0,15000001.0);
				this.sx += this.flag1.x;
				this.sy += this.flag1.y;
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
		this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
		this.sx += this.flag1.x;
		this.sy += this.flag1.y;
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
				this.sx += this.flag1.x;
				this.sy += this.flag1.y;
				this.alpha -= 0,03300000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Climax_Option( t )
{
	this.SetMotion(4908, 2);
	this.DrawActorPriority(189);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 1,00000000.0;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4908, 3);
			this.SetParent(null, 0, 0);
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -1,25000000.0);
				this.sx *= 0,94999999.0;
				this.sy *= 1,04999995.0;
				this.alpha -= 0,07500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[1] = null;
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 13 == 1)
		{
			this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Climax_OptionBack, {}));
		}

		this.alpha += 0,10000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}
	};
}

function Climax_Shot( t )
{
	this.SetMotion(4909, 2);
	this.DrawActorPriority(180);
	this.alpha = 1,00000000.0;
	this.sx = this.sy = 10,00000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
	{
		this.SetMotion(4909, 1);
		this.sx = this.sy = 0,50000000.0;
		this.alpha = 1,50000000.0;
		this.DrawActorPriority(200);
		this.SetTaskAddColor(-0,03300000.0, 0, 0, 0);
		this.SetTaskAddRotation(0, 0, -5 * 0,01745329.0);
		this.SetCallbackColorA(function ()
		{
			this.ReleaseActor();
		}, 0,00000000.0, false);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 1,04999995.0;
		};
	}, {});
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.rz += 2,00000000.0 * 0,01745329.0;
				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,05000000.0;
				this.alpha -= 0,07500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.rz += 2,00000000.0 * 0,01745329.0;
		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,05000000.0;
		this.count++;

		if (this.count % 15 == 1)
		{
			local t_ = {};
			t_.scale <- this.sx;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_Vortex, t_);
		}

		if (this.count % 30 == 1)
		{
			local t_ = {};
			t_.scale <- this.sx * 2;
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_Vortex, t_);
		}
	};
}

function Climax_CutSmile( t )
{
	this.SetMotion(4907, 7);
	this.DrawScreenActorPriority(1000);
	this.sx = this.sy = 2,00000000.0;
	this.alpha = 0,00000000.0;
	this.flag1 = 1,00000000.0;
	this.subState = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.subState = function ()
			{
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.flag1 += (1,25000000.0 - this.flag1) * 0,04000000.0;

		if (this.initTable.pare)
		{
			this.sx = this.sy = this.flag1 * this.initTable.pare.sx;
			this.x = this.initTable.pare.point0_x;
			this.y = this.initTable.pare.point0_y;
		}

		this.subState();
	};
}

function Climax_CutAura( t )
{
	this.SetMotion(4907, 2);
	this.alpha = 0,00000000.0;
	this.DrawScreenActorPriority(999);
	this.SetParent(this.initTable.pare, 0, 0);
	this.flag1 = 1,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.subState = function ()
	{
		this.alpha += 0,02500000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.subState = function ()
			{
				this.alpha = this.red -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.AddSpeed_XY(0,00000000.0, -0,02500000.0);
		this.flag1 += 0,00250000.0;

		if (this.initTable.pare)
		{
			this.sx = this.sy = this.flag1 * this.initTable.pare.sx;
		}
	};
}

function Climax_Cut( t )
{
	this.SetMotion(4907, 0);
	this.DrawScreenActorPriority(1000);
	this.red = this.green = this.blue = 0,00000000.0;
	this.EnableTimeStop(false);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = null;
	this.sx = this.sy = 3,00000000.0;
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
			this.flag2 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Climax_CutSmile, {}, this.weakref()).weakref();
			this.red = 0,25000000.0;
			this.count = 0;
			this.subState = function ()
			{
				if (this.red >= 0,01500000.0)
				{
					this.red -= 0,01500000.0;
				}
			};
		},
		function ()
		{
			this.SetMotion(4907, 1);
			this.sx = this.sy = 4,00000000.0;
			this.x = 640;
			this.y = 360;
			this.subState = function ()
			{
				if (this.red >= 0,00500000.0)
				{
					this.red -= 0,00500000.0;
				}

				if (this.count % 15 == 1)
				{
					this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Climax_CutAura, {}, this.weakref()));
				}
			};
			this.stateLabel = function ()
			{
				if (this.red < 1,00000000.0)
				{
					this.red = this.green = this.blue += 0,05000000.0;
				}

				local s_ = (1,00000000.0 - this.sx) * 0,10000000.0;

				if (s_ >= -0,00100000.0)
				{
					s_ = -0,00100000.0;
				}

				this.sx = this.sy += s_;
				this.count++;

				if (this.count >= 30)
				{
					::camera.shake_radius = 5,00000000.0;

					if (this.count % 8 == 1)
					{
						local pos_ = this.Vector3();
						this.GetPoint(1, pos_);
						this.flag1.Add(this.SetFreeObject(pos_.x, pos_.y, this.direction, this.Climax_CutAuraA, {}));
						this.GetPoint(2, pos_);
						this.flag1.Add(this.SetFreeObject(pos_.x, pos_.y, -this.direction, this.Climax_CutAuraB, {}));
					}
				}

				if (this.count >= 85)
				{
				}
				else
				{
					this.x += (640 - 240 * this.direction - this.x) * 0,10000000.0;
					this.y += (360 + 100 - this.y) * 0,10000000.0;
				}

				this.subState();
			};
		}
	];
	this.subState = function ()
	{
		this.red = this.green = this.blue += 0,02500000.0;

		if (this.red >= 1,00000000.0)
		{
			this.red = this.green = this.blue = 1,00000000.0;
			this.subState = function ()
			{
			};
		}
	};
	this.subState = function ()
	{
	};
	this.sx = this.sy = 1,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;
		this.sx = this.sy += 0,00100000.0;
		this.subState();
	};
}

function Climax_Back( t )
{
	this.SetMotion(4907, 4);
	this.DrawScreenActorPriority(990);
	this.EnableTimeStop(false);
	this.red = this.green = this.blue = 0,00000000.0;
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.func = [
		function ()
		{
			this.flag2.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.ReleaseActor();
		},
		function ()
		{
			this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Climax_BackScreen, {}));
			this.stateLabel = function ()
			{
				if (this.red < 1,00000000.0)
				{
					this.red = this.green = this.blue += 0,02500000.0;
				}

				this.count++;

				if (this.count == 25)
				{
					this.count = 0;
					this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Climax_BackScreen, {}));
				}
			};
		}
	];
}

function Climax_BackScreen( t )
{
	this.SetMotion(4907, 4);
	this.DrawScreenActorPriority(990);
	this.EnableTimeStop(false);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.alpha = this.red = this.green = this.blue = 0,00000000.0;
	this.flag1 = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;
		this.flag1 += 0,04000000.0;
		this.sx = this.sy = this.Math_Bezier(1,00000000.0, 1,25000000.0, 1,23000002.0, this.flag1);

		if (this.count >= 20)
		{
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
		else
		{
			this.alpha = this.red = this.green = this.blue += 0,05000000.0;

			if (this.red >= 1,00000000.0)
			{
				this.alpha = this.red = this.green = this.blue = 1,00000000.0;
			}
		}
	};
}

function Climax_BackB( t )
{
	this.SetMotion(4907, 4);
	this.isVisible = false;
	this.EnableTimeStop(false);
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.func = [
		function ()
		{
			this.flag2.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.ReleaseActor();
		}
	];
	this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Climax_BackScreenB, {}));
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 25)
		{
			this.count = 0;
			this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Climax_BackScreenB, {}));
		}
	};
}

function Climax_BackScreenB( t )
{
	this.SetMotion(4907, 4);
	this.DrawBackActorPriority(100);
	this.rz = (-10 + this.rand() % 20) * 0,01745329.0;
	this.EnableTimeStop(false);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.alpha = this.red = this.green = this.blue = 0,00000000.0;
	this.flag1 = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;
		this.flag1 += 0,02000000.0;
		this.sx = this.sy = this.Math_Bezier(1,00000000.0, 1,25000000.0, 1,23000002.0, this.flag1);

		if (this.count >= 20)
		{
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
		else
		{
			this.alpha = this.red = this.green = this.blue += 0,05000000.0;

			if (this.red >= 1,00000000.0)
			{
				this.alpha = this.red = this.green = this.blue = 1,00000000.0;
			}
		}
	};
}

function Climax_CutAuraA( t )
{
	this.SetMotion(4907, 5);
	this.EnableTimeStop(false);
	this.DrawScreenActorPriority(1010);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.sx = this.sy = 1,00000000.0;
	this.rz = (15 + this.rand() % 30) * 0,01745329.0;
	this.flag1 = this.rz;
	this.flag2 = this.rz + 180 * 0,01745329.0;
	this.flag3 = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.flag3 += 0,03300000.0;
		this.rz = this.Math_Bezier(this.flag1, this.flag2, this.flag2 - 6 * 0,01745329.0, this.flag3);
		this.sx = this.sy = this.Math_Bezier(1,00000000.0, 8,00000000.0, 6,90000010.0, this.flag3);
		this.count++;
		this.alpha = this.red -= 0,02000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_CutAuraB( t )
{
	this.SetMotion(4907, 5);
	this.ry = 30 * 0,01745329.0;
	this.EnableTimeStop(false);
	this.DrawScreenActorPriority(1010);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.sx = this.sy = 1,00000000.0;
	this.rz = (15 + this.rand() % 45) * 0,01745329.0;
	this.flag1 = this.rz;
	this.flag2 = this.rz + 180 * 0,01745329.0;
	this.flag3 = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.flag3 += 0,04000000.0;
		this.rz = this.Math_Bezier(this.flag1, this.flag2, this.flag2 - 6 * 0,01745329.0, this.flag3);
		this.sx = this.sy = this.Math_Bezier(1,00000000.0, 8,00000000.0, 4,90000010.0, this.flag3);
		this.count++;
		this.x += -8,00000000.0 * this.direction * this.sx;
		this.y += 1,00000000.0 * this.sx;
		this.alpha = this.red -= 0,02000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_Vortex( t )
{
	this.DrawActorPriority(179);
	this.SetMotion(4909, 1);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = t.scale;
	this.flag1 = this.sx * 0,02000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.alpha = 0,00000000.0;
			this.subState = function ()
			{
				this.alpha += 0,10000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.alpha = 1,00000000.0;
					this.subState = function ()
					{
						this.alpha -= 0,05000000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.ReleaseActor();
							return;
						}
					};
				}
			};
		}
	];
	this.func[1].call(this);
	this.stateLabel = function ()
	{
		this.rz += 3,00000000.0 * 0,01745329.0;
		this.sx = this.sy -= this.flag1;
		this.subState();
	};
}

