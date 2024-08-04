function AtkHigh_Petal( t )
{
	if (this.sin(t.rot) < 0,00000000.0)
	{
		this.DrawActorPriority(180);
	}
	else
	{
		this.DrawActorPriority(210);
	}

	this.SetMotion(6051, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 8 * 0,10000000.0;
	this.flag1 = (3,00000000.0 - this.rand() % 6) * 0,01745329.0;
	this.SetSpeed_Vec(3 + this.rand() % 8, t.rot, this.direction);
	this.SetSpeed_XY(this.va.x, this.va.y * 0,20000000.0 - 1,00000000.0 - this.rand() % 3);
	local r_ = 6 + this.rand() % 3;
	this.Warp(this.x + this.va.x * r_, this.y + this.va.y * r_);
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0,94000000.0;
		this.VX_Brake(0,10000000.0);
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
		this.sx = this.sy -= 0,02500000.0;

		if (this.sx <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function AtkLow_DashHeart( t )
{
	this.SetMotion(6099, 0);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,50000000.0;
	this.SetSpeed_Vec(7,00000000.0 * this.sx, t.rot, this.direction);
	this.SetSpeed_XY(null, this.va.y * 0,50000000.0);

	if (this.sin(t.rot) < 0)
	{
		this.DrawActorPriority(180);
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0, 2,50000000.0);
		this.sx = this.sy *= 0,92000002.0;

		if (this.sx < 0,50000000.0)
		{
			this.alpha -= 0,05000000.0;
		}

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SetEffect_Koishi( t )
{
	this.SetMotion(6099, t.keyTake);
	this.rz = t.rot;
	this.sx = this.sy = 0,94999999.0 + this.rand() % 10 * 0,01000000.0;
	this.SetSpeed_Vec(15,00000000.0 * this.sx, this.rz, this.direction);
	this.stateLabel = function ()
	{
		this.Vec_Brake(1,00000000.0, 0,50000000.0);
		this.sx = this.sy *= 0,92000002.0;

		if (this.sx < 0,50000000.0)
		{
			this.alpha -= 0,05000000.0;
		}

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Normal( t )
{
	this.SetMotion(2009, t.keyTake);
	this.atk_id = 16384;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	local a_ = this.SetTrail(2009, 2, 50, 50);

	if (this.keyTake == 0)
	{
		a_.blue = 0,00000000.0;
		a_.green = 0,00000000.0;
	}
	else
	{
		a_.red = 0,00000000.0;
		a_.green = 0,00000000.0;
	}

	this.rz = t.rot + t.shotRot;
	this.SetSpeed_Vec(15,00000000.0, this.rz, this.direction);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.cancelCount = 3;
	this.flag5 = this.Vector3();
	this.flag4 = this.Vector3();
	this.flag1 = null;
	this.flag4.x = 15,00000000.0 * this.cos(t.rot);
	this.flag4.y = 15,00000000.0 * this.sin(t.rot);
	this.func = function ()
	{
		if (this.hitTarget)
		{
			if (this.flag1)
			{
				this.flag1.flag1 = null;
				this.flag1 = null;
			}

			local t_ = {};
			t_.keyTake <- this.keyTake;

			for( local i = 0; i < 9; i++ )
			{
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalHit, t_);
			}

			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;
				this.linkObject[0].alpha -= 0,10000000.0;
				this.linkObject[0].anime.length *= 0,89999998.0;
				this.linkObject[0].anime.radius0 *= 0,89999998.0;

				if (this.linkObject[0].alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.subState = function ()
	{
		this.count++;

		if (this.keyTake != 5 && this.count == 27 && this.flag1)
		{
			local t_ = {};
			t_.keyTake <- this.keyTake;

			for( local i = 0; i < 4; i++ )
			{
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalHit, t_);
			}

			this.SetMotion(2009, 5);
			this.subState = function ()
			{
				this.linkObject[0].red += (1,00000000.0 - this.linkObject[0].red) * 0,05000000.0;
				this.linkObject[0].blue += (1,00000000.0 - this.linkObject[0].blue) * 0,05000000.0;
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.grazeCount >= 1)
		{
			if (this.flag1)
			{
				this.flag1.func();
				this.flag1 = null;
			}
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 1 || this.IsScreen(300,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 4))
		{
			this.func();
			return;
		}

		if (this.flag5.y < 0)
		{
			this.flag4.y += 0,75000000.0;
		}
		else if (this.flag5.y > 0)
		{
			this.flag4.y -= 0,75000000.0;
		}

		this.flag5 += this.flag4;
		this.va.x = this.flag4.x;
		this.va.y = this.flag4.y;
		this.va.RotateByRadian(this.initTable.shotRot);
		this.SetSpeed_XY(this.va.x * this.direction, this.va.y);
		this.rz = this.atan2(this.vy, this.vx * this.direction);
		this.subState();
	};
}

function SetEffect_Koishi( t )
{
	this.SetMotion(6099, t.keyTake);
	this.rz = t.rot;
	this.sx = this.sy = 0,94999999.0 + this.rand() % 10 * 0,01000000.0;
	this.SetSpeed_Vec(15,00000000.0 * this.sx, this.rz, this.direction);
	this.stateLabel = function ()
	{
		this.Vec_Brake(1,00000000.0, 0,50000000.0);
		this.sx = this.sy *= 0,92000002.0;

		if (this.sx < 0,50000000.0)
		{
			this.alpha -= 0,05000000.0;
		}

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Normal_B( t )
{
	this.SetMotion(2009, t.keyTake + 3);
	this.atk_id = 16384;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	local a_ = this.SetTrail(2009, 2, 50, 50);

	if (this.keyTake == 3)
	{
		a_.blue = 0,00000000.0;
		a_.green = 0,00000000.0;
	}
	else
	{
		a_.red = 0,00000000.0;
		a_.green = 0,00000000.0;
	}

	this.rz = t.rot + t.shotRot;
	this.SetSpeed_Vec(12,50000000.0, this.rz, this.direction);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.cancelCount = 1;
	this.flag5 = this.Vector3();
	this.flag4 = this.Vector3();
	this.flag1 = null;
	this.flag4.x = 11,50000000.0 * this.cos(t.rot);
	this.flag4.y = 18,50000000.0 * this.sin(t.rot);
	this.func = function ()
	{
		if (this.hitTarget)
		{
			local t_ = {};
			t_.keyTake <- this.keyTake - 3;

			for( local i = 0; i < 9; i++ )
			{
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalHit, t_);
			}

			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;
				this.linkObject[0].alpha -= 0,10000000.0;
				this.linkObject[0].anime.length *= 0,89999998.0;
				this.linkObject[0].anime.radius0 *= 0,89999998.0;

				if (this.linkObject[0].alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.grazeCount >= 1)
		{
			if (this.flag1)
			{
				this.flag1.func();
				this.flag1 = null;
			}
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 1 || this.IsScreen(300,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 4))
		{
			this.func();
			return;
		}

		if (this.flag5.y < 0)
		{
			this.flag4.y += 0,75000000.0;
		}
		else if (this.flag5.y > 0)
		{
			this.flag4.y -= 0,75000000.0;
		}

		this.flag5 += this.flag4;
		this.va.x = this.flag4.x;
		this.va.y = this.flag4.y;
		this.va.RotateByRadian(this.initTable.shotRot);
		this.SetSpeed_XY(this.va.x * this.direction, this.va.y);
		this.rz = this.atan2(this.vy, this.vx * this.direction);
	};
}

function Shot_NormalSub( t )
{
	this.SetMotion(2009, t.keyTake);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	local a_ = this.SetTrail(2009, 2, 50, 20);

	if (this.keyTake == 3)
	{
		a_.blue = 0,00000000.0;
		a_.green = 0,00000000.0;
	}
	else
	{
		a_.red = 0,00000000.0;
		a_.green = 0,00000000.0;
	}

	this.rz = t.rot + t.shotRot;
	this.SetSpeed_Vec(18,00000000.0, this.rz, this.direction);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.cancelCount = 1;
	this.flag5 = this.Vector3();
	this.flag4 = this.Vector3();
	this.flag4.x = 18,00000000.0 * this.cos(t.rot);
	this.flag4.y = 15,00000000.0 * this.sin(t.rot);
	this.func = function ()
	{
		local t_ = {};
		t_.keyTake <- this.keyTake - 2;

		for( local i = 0; i < 3; i++ )
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalHit, t_);
		}

		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,89999998.0;
			this.linkObject[0].alpha -= 0,10000000.0;
			this.linkObject[0].anime.length *= 0,89999998.0;
			this.linkObject[0].anime.radius0 *= 0,89999998.0;

			if (this.linkObject[0].alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.hitResult == 32)
		{
			this.HitReset();
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 1 || this.IsScreen(300,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 4))
		{
			this.func();
			return;
		}

		if (this.flag5.y < 0)
		{
			this.flag4.y += 0,64999998.0;
		}
		else if (this.flag5.y > 0)
		{
			this.flag4.y -= 0,64999998.0;
		}

		this.flag5 += this.flag4;
		this.va = this.Math_RotateVecZ(this.flag4, this.initTable.shotRot);
		this.SetSpeed_XY(this.va.x * this.direction, this.va.y);
		this.rz = this.atan2(this.vy, this.vx * this.direction);
	};
}

function Shot_NormalHit( t )
{
	this.SetMotion(2008, t.keyTake);
	this.sx = this.sy = 0,25000000.0 + this.rand() % 15 * 0,10000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(2 + this.rand() % 8, this.rz, this.direction);
	this.flag1 = 0,02500000.0 + this.rand() % 25 * 0,00100000.0;
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0, 1,00000000.0);
		this.sx = this.sy *= 0,94999999.0;
		this.alpha -= this.flag1;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 0);
	this.sx = 0,00000000.0;
	this.rz = t.rot;
	this.flag2 = 100;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sy *= 0,99000001.0;
			this.sx *= 1,02499998.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
				return;
			}
		};
	};
	this.flag1 = false;
	this.stateLabel = function ()
	{
		if (this.flag1 || this.owner.IsDamage())
		{
			this.func();
			return;
		}

		if (this.sx <= 20,00000000.0)
		{
			this.sx += 0,50000000.0;
		}
		else
		{
			this.sx += 0,02500000.0;
		}

		this.count++;

		if (this.count % 6 == 5)
		{
			if (this.count == 5)
			{
				this.PlaySE(2423);
			}

			local t_ = {};
			t_.rot <- this.rz;
			t_.hit <- this.flag1;
			this.SetShot(this.x + this.flag2 * this.cos(this.rz) * this.direction, this.y + this.flag2 * this.sin(this.rz), this.direction, this.owner.Shot_FrontPulse, t_, this.weakref());
			this.flag2 += 150;
		}

		if (this.count >= 120)
		{
			this.func();
		}
	};
}

function Shot_FrontPulse( t )
{
	this.SetMotion(2019, 1);
	this.atk_id = 65536;
	this.rz = t.rot;
	this.sy = 0,00000000.0;
	this.cancelCount = 3;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

	if (t.hit)
	{
		this.callbackGroup = 0;
	}

	this.subState = function ()
	{
		if (!this.initTable.pare || this.initTable.pare.flag1 || this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.func();
			return true;
		}
	};
	this.func = function ()
	{
		this.SetMotion(2019, 3);
		this.sy = 2,00000000.0;
		this.stateLabel = function ()
		{
			this.sx += 0,25000000.0;
			this.sy *= 0,89999998.0;
			this.alpha = this.blue = this.green -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.flag1 = 30,00000000.0;
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.sy += 0,20000000.0;

		if (this.sy >= 1,00000000.0)
		{
			this.SetMotion(2019, 2);
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				if (this.hitTarget)
				{
					if (this.hitCount > 0 || this.cancelCount <= 0)
					{
						if (this.initTable.pare)
						{
							this.initTable.pare.flag1 = true;
							this.stateLabel = function ()
							{
								this.count++;

								if (this.count >= 4)
								{
									this.func();
									return;
								}
							};
						}
					}
					else
					{
						this.HitReset();
					}
				}

				this.count++;

				if (this.count >= 4)
				{
					this.func();
					return;
				}
			};
		}
	};
}

function Shot_AutoFront( t )
{
	this.SetMotion(2018, 0);
	this.flag1 = false;
	this.sx = 0,00000000.0;
	this.rz = t.rot;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sy *= 0,99000001.0;
			this.sx *= 1,02499998.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
				return;
			}
		};
	};
	this.cancelCount = 10;
	this.stateLabel = function ()
	{
		if (this.flag1)
		{
			this.func();
			return;
		}

		if (this.sx <= 20,00000000.0)
		{
			this.sx += 0,50000000.0;
		}
		else
		{
			this.sx += 0,02500000.0;
		}

		this.count++;

		if (this.count == 5)
		{
			this.PlaySE(2423);
			local hp_ = [
				this.weakref()
			];
			local scale_ = 2,00000000.0;
			local a_;

			for( local i = 100; i < 1350; i = i + 150 )
			{
				local t_ = {};
				t_.rot <- 0,00000000.0;
				t_.scale <- scale_;
				scale_ = scale_ - 0,50000000.0;

				if (scale_ < 1,00000000.0)
				{
					scale_ = 1,00000000.0;
				}

				a_ = this.SetShot(this.x + i * this.cos(this.rz) * this.direction, this.y + i * this.sin(this.rz), this.direction, this.Shot_AutoFrontPulse, t_);
				a_.hitOwner = this.weakref();
			}
		}

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(0);
		}

		if (this.count >= 20)
		{
			this.func();
		}
	};
}

function Shot_AutoFrontPulse( t )
{
	this.SetMotion(2018, 1);
	this.atk_id = 65536;
	this.rz = t.rot;
	this.sy = 0,00000000.0;
	this.cancelCount = 10;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetCollisionScaling(1,00000000.0, t.scale, 1,00000000.0);
	this.func = function ()
	{
		this.SetMotion(2018, 3);
		this.sy = 1,25000000.0;
		this.stateLabel = function ()
		{
			this.sx += 0,25000000.0;
			this.sy *= 0,89999998.0;
			this.alpha = this.blue = this.green -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.flag1 = 30,00000000.0;
	this.stateLabel = function ()
	{
		this.sy += 0,20000000.0 * this.initTable.scale;

		if (this.sy >= 1,00000000.0 * this.initTable.scale)
		{
			this.SetMotion(2018, 2);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 10)
				{
					this.func();
					return;
				}
			};
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2028, this.rand() % 8);
	this.target = this.owner.target.weakref();
	this.rz = t.rot;
	this.initTable.num++;
	this.flag1 = true;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.flag2 = (this.rand() % 5 - 2) * 0,01745329.0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,34999999.0);
				this.rz += this.flag2;

				if (this.red >= 0,10000000.0)
				{
					this.red = this.green = this.blue -= 0,10000000.0;
				}
				else
				{
					this.alpha -= 0,05000000.0;
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
		this.count++;

		if (this.owner.IsDamage())
		{
			this.initTable.num = this.initTable.limit;
			this.flag1 = false;
			this.func[0].call(this);
			return;
		}

		if (this.count == 2 && this.initTable.num < this.initTable.limit)
		{
			local t_ = {};
			t_.num <- this.initTable.num;
			t_.limit <- this.initTable.limit;
			t_.rot <- this.GetTargetAngle(this.target, this.direction);
			t_.rot = this.Math_MinMax(t_.rot, -5,00000000.0 * 0,01745329.0 + this.rz, 5,00000000.0 * 0,01745329.0 + this.rz);
			t_.rot += (15 - this.rand() % 31) * 0,01745329.0;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.owner.Shot_Charge, t_, this.weakref());
		}

		if (this.count == 15 + 30 && this.initTable.num % 2 == 0)
		{
			local t_ = {};
			t_.se <- false;

			if (this.initTable.num == 3)
			{
				t_.se = true;
			}

			this.SetShot(this.x + this.rand() % 60 - 30, this.y + this.rand() % 60 - 30, this.direction, this.owner.Shot_Charge_Rose, t_);
		}

		if (this.count == 60 + 30)
		{
			this.flag1 = false;
			this.func[0].call(this);
		}
	};
}

function Shot_Charge_Rose( t )
{
	if (t.se)
	{
		this.PlaySE(2436);
	}

	this.SetMotion(2029, 0);
	this.atk_id = 131072;
	this.rz = (20 - this.rand() % 40) * 0,01745329.0;
	this.sx = this.sy = 0,10000000.0;
	this.flag1 = 0,75000000.0 + this.rand() % 50 * 0,01000000.0;
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += (this.flag1 - this.sx) * 0,20000000.0;
		this.count++;

		if (this.count >= 10)
		{
			this.SetMotion(2029, 1);
			this.stateLabel = function ()
			{
				if (this.Damage_ConvertOP(this.x, this.y, 2))
				{
					this.ReleaseActor();
					return;
				}
			};
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			this.HitReset();

			for( local i = 0; i < 2; i++ )
			{
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_Charge_Petal, {});
			}

			this.stateLabel = function ()
			{
				this.alpha = this.blue = this.green -= 0,15000001.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}

				this.sx = this.sy += (2,50000000.0 - this.sx) * 0,34999999.0;
			};
		}
	];
}

function Shot_ChargeFull( t )
{
	this.SetMotion(2028, this.rand() % 8);
	this.target = this.owner.target.weakref();
	this.rz = t.rot;
	this.initTable.num++;
	this.flag1 = true;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.flag2 = (this.rand() % 5 - 2) * 0,01745329.0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,34999999.0);
				this.rz += this.flag2;

				if (this.red >= 0,10000000.0)
				{
					this.red = this.green = this.blue -= 0,10000000.0;
				}
				else
				{
					this.alpha -= 0,05000000.0;
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
		this.count++;

		if (this.count == 2 && this.initTable.num < this.initTable.limit)
		{
			local t_ = {};
			t_.num <- this.initTable.num;
			t_.limit <- this.initTable.limit;
			t_.rot <- this.GetTargetAngle(this.target, this.direction);
			t_.rot = this.Math_MinMax(t_.rot, -5,00000000.0 * 0,01745329.0 + this.rz, 5,00000000.0 * 0,01745329.0 + this.rz);
			t_.rot += (15 - this.rand() % 31) * 0,01745329.0;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.owner.Shot_ChargeFull, t_, this.weakref());
		}

		if (this.count == 15 && this.initTable.num % 2 == 0)
		{
			local t_ = {};
			t_.se <- false;

			if (this.initTable.num == 3)
			{
				t_.se = true;
			}

			this.SetShot(this.x + this.rand() % 60 - 30, this.y + this.rand() % 60 - 30, this.direction, this.owner.Shot_ChargeFull_Rose, t_);
		}

		if (this.count == 60)
		{
			this.flag1 = false;
			this.func[0].call(this);
		}
	};
}

function Shot_ChargeFull_Rose( t )
{
	if (t.se)
	{
		this.PlaySE(2436);
	}

	this.SetMotion(2029, 5);
	this.rz = (20 - this.rand() % 40) * 0,01745329.0;
	this.sx = this.sy = 0,10000000.0;
	this.flag1 = 0,75000000.0 + this.rand() % 50 * 0,01000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (this.flag1 - this.sx) * 0,20000000.0;
		this.count++;
		this.HitCycleUpdate(10);

		if (this.count >= 60)
		{
			this.HitReset();
			this.SetMotion(2029, 6);

			for( local i = 0; i < 2; i++ )
			{
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_Charge_Petal, {});
			}

			this.SetCollisionScaling(1,50000000.0, 1,50000000.0, 1,00000000.0);
			this.stateLabel = function ()
			{
				this.alpha = this.blue = this.green -= 0,15000001.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}

				this.sx = this.sy += (3,50000000.0 - this.sx) * 0,34999999.0;
			};
		}
	};
}

function Shot_Charge_Petal( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(2027, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
	this.flag1 = (8,00000000.0 + this.rand() % 6) * 0,01745329.0;
	this.SetSpeed_Vec(3 + this.rand() % 8, this.rand() % 360 * 0,01745329.0, this.direction);
	local r_ = 1 + this.rand() % 3;
	this.Warp(this.x + this.va.x * r_, this.y + this.va.y * r_);
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0,94000000.0;
		this.VX_Brake(0,05000000.0);
		this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
		this.sx = this.sy -= 0,02500000.0;

		if (this.sx <= 0,10000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Barrage_Rose( t )
{
	this.SetMotion(2026, 0);
	this.sx = this.sy = 0,10000000.0;
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.ReleaseActor();
			return true;
		}

		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,10000000.0;
	};
	this.keyAction = function ()
	{
		this.PlaySE(2436);

		for( local i = 0; i < 12; i++ )
		{
			local t_ = {};
			t_.rot <- i * 0,52359873.0;
			this.SetShot(this.x, this.y, this.direction, this.Shot_Barrage, t_);
		}

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
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, 2);
	this.atk_id = 262144;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = t.rot;
	this.SetSpeed_Vec(17,50000000.0, this.rz, this.direction);
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, 3);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.sx = this.sy = 2,00000000.0;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,89999998.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.Vec_Brake(1,50000000.0, 4,00000000.0))
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		this.subState();
		this.count++;

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.count >= 120)
		{
			this.func();
			return true;
		}
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, t.keyTake);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	local a_ = this.SetTrail(3929, 2, 50, 50);

	if (this.keyTake == 0)
	{
		a_.blue = 0,00000000.0;
		a_.green = 0,00000000.0;
	}
	else
	{
		a_.red = 0,00000000.0;
		a_.green = 0,00000000.0;
	}

	this.rz = t.rot;
	this.SetSpeed_Vec(15,00000000.0, this.rz, this.direction);
	this.cancelCount = 3;
	this.flag1 = 3,00000000.0;
	this.func = function ()
	{
		local t_ = {};
		t_.keyTake <- this.keyTake;

		for( local i = 0; i < 9; i++ )
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalHit, t_);
		}

		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,89999998.0;
			this.linkObject[0].alpha -= 0,10000000.0;
			this.linkObject[0].anime.length *= 0,89999998.0;
			this.linkObject[0].anime.radius0 *= 0,89999998.0;

			if (this.linkObject[0].alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.Vec_Brake(0,40000001.0, 2,00000000.0))
		{
			this.subState = function ()
			{
				this.AddSpeed_Vec(0,50000000.0, null, 17,50000000.0, this.direction);
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 1 || this.IsScreen(300,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.func();
			return;
		}

		this.subState();
		this.count++;

		if (this.count >= 60)
		{
			this.flag1 -= 0,25000000.0;
		}

		if (this.flag1 <= 0,50000000.0)
		{
			this.flag1 = 0,50000000.0;
		}

		if (this.TargetHoming(this.team.target, this.flag1 * 0,01745329.0, this.direction))
		{
			this.flag1 = 0,50000000.0;
		}

		this.rz = this.atan2(this.vy, this.vx * this.direction);
	};
}

function Occult_Shot( t )
{
	this.SetMotion(2508, 4);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 2,00000000.0;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.SetMotion(2508, 6);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (this.initTable.scale - this.sx) * 0,20000000.0;
				this.alpha -= 0,15000001.0;

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
	this.keyAction = function ()
	{
		this.sx = this.sy = 0,50000000.0;
		this.stateLabel = function ()
		{
			if (this.owner.IsDamage())
			{
				this.func[0].call(this);
				return;
			}

			this.count++;

			if (this.count == 14)
			{
				this.callbackGroup = 0;
			}

			if (this.count == 15)
			{
				this.SetParent(null, 0, 0);
				this.stateLabel = function ()
				{
					this.alpha -= 0,02500000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}
			else
			{
				this.sx = this.sy += (this.initTable.scale - this.sx) * 0,20000000.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy *= 0,80000001.0;
	};
}

function Occult_AutoPhone_Range( t )
{
	this.SetMotion(2507, 5);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 0,50000000.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,25000000.0;
		this.initTable.scale += 0,00500000.0;
		this.sx = this.sy += (this.initTable.scale - this.sx) * 0,20000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.initTable.scale += 0,00500000.0;
				this.sx = this.sy += (this.initTable.scale - this.sx) * 0,20000000.0;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
					return;
				}
			};
		}
	};
}

function Occult_AutoPhone( t )
{
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag1 = this.y - (this.owner.y + 100);
	this.flag2 = 0,00000000.0;
	this.sx = this.sy = 0,10000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ( s_ )
		{
			this.SetMotion(2507, 2);
			this.count = 0;
			this.flag2 = s_;
			this.SetSpeed_XY(0,00000000.0, -12,50000000.0);
			this.stateLabel = function ()
			{
				if (this.count == 6)
				{
					this.PlaySE(2465);
					local r_ = 1,00000000.0;
					local range_ = this.owner.occultRange;
					range_ = range_ + r_;

					if (range_ >= 12,00000000.0)
					{
						range_ = 12,00000000.0;
					}

					local t_ = {};
					t_.scale <- range_ * 0,92500001.0;
					this.SetShot(this.x, this.y, this.direction, this.owner.Occult_AutoPhone_Range, t_);
				}

				if (this.count % 7 == 6)
				{
					local t_ = {};
					t_.scale <- 0,75000000.0;
					this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Occult_AutoWave, t_);
				}

				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,20000000.0;
				this.rz = 10,00000000.0 * this.sin(this.count * 57 * 0,01745329.0) * 0,01745329.0;
				this.AddSpeed_XY(0,00000000.0, 1,50000000.0);

				if (this.va.y > -0,20000000.0)
				{
					this.SetSpeed_XY(0,00000000.0, -0,20000000.0);
				}

				this.count++;

				if (this.count >= 40)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 1,50000000.0);

						if (this.y > this.owner.y + this.flag1)
						{
							this.func[2].call(this);
						}
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.rz = 0,00000000.0;
			this.SetMotion(2507, 0);
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
	this.func[1].call(this, this.owner.occultRange);
}

function Occult_AutoWave( t )
{
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.SetMotion(2507, 3);
	this.sx = this.sy = 0,50000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.radius0 = 0;
	this.anime.radius1 = 128;
	this.stateLabel = function ()
	{
		this.anime.radius0 += (this.anime.radius1 + 128 - this.anime.radius0) * 0,10000000.0;
		this.sx = this.sy += (this.initTable.scale - this.sx) * 0,25000000.0;
		this.alpha = this.green = this.blue -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Occult_Phone( t )
{
	this.SetMotion(2508, 2);
	this.flag1 = this.y - this.owner.y;
	this.flag2 = 0,00000000.0;
	this.sx = this.sy = 0,10000000.0;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ( s_ )
		{
			this.SetMotion(2508, 2);
			this.count = 0;
			this.flag2 = s_;
			this.SetSpeed_XY(0,00000000.0, -12,50000000.0);
			this.stateLabel = function ()
			{
				if (this.count == 6)
				{
					local t_ = {};
					t_.scale <- s_;
					this.owner.flag5.wave = this.SetShot(this.x, this.y, this.direction, this.Occult_Shot, t_).weakref();
					this.PlaySE(2596);
				}

				if (this.count % 7 == 6)
				{
					local t_ = {};
					t_.scale <- this.flag2;
					this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Occult_Wave, t_);
				}

				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,20000000.0;
				this.rz = 10,00000000.0 * this.sin(this.count * 57 * 0,01745329.0) * 0,01745329.0;
				this.AddSpeed_XY(0,00000000.0, 1,50000000.0);

				if (this.va.y > -0,20000000.0)
				{
					this.SetSpeed_XY(0,00000000.0, -0,20000000.0);
				}

				this.count++;

				if (this.count >= 40)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 1,50000000.0);

						if (this.y > this.owner.y + this.flag1)
						{
							this.func[2].call(this);
						}
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.rz = 0,00000000.0;
			this.SetMotion(2508, 0);
			this.stateLabel = function ()
			{
			};
		}
	];
	this.func[1].call(this, this.owner.occultRange);
}

function Occult_Wave( t )
{
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.SetMotion(2508, 3);
	this.sx = this.sy = 0,50000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, function ( t )
	{
		this.SetMotion(2508, 7);
		this.sx = this.sy = 1,50000000.0 + this.rand() % 6 * 0,10000000.0;
		this.stateLabel = function ()
		{
			this.sx = this.sy -= 0,05000000.0;
			this.alpha -= 0,15000001.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	}, {});
	a_.SetParent(this, 0, 0);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.radius0 = 0;
	this.anime.radius1 = 110;
	this.stateLabel = function ()
	{
		this.anime.radius0 += (this.anime.radius1 + 28 - this.anime.radius0) * 0,10000000.0;
		this.sx = this.sy += (this.initTable.scale - this.sx) * 0,44999999.0;
		this.alpha = this.green = this.blue -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Occult_Call( t )
{
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag1 = this.y - this.owner.y;
	this.flag2 = 0,00000000.0;
	this.sx = this.sy = 0,10000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ( s_ )
		{
			this.SetMotion(2508, 2);
			this.count = 0;
			this.flag2 = s_;
			this.SetSpeed_XY(0,00000000.0, -12,50000000.0);
			this.stateLabel = function ()
			{
				if (this.count == 6)
				{
					this.PlaySE(2596);
				}

				if (this.count % 7 == 6)
				{
					local t_ = {};
					t_.scale <- this.flag2;
					this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Occult_Wave, t_);
				}

				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,20000000.0;
				this.rz = 10,00000000.0 * this.sin(this.count * 57 * 0,01745329.0) * 0,01745329.0;
				this.AddSpeed_XY(0,00000000.0, 1,50000000.0);

				if (this.va.y > -0,20000000.0)
				{
					this.SetSpeed_XY(0,00000000.0, -0,20000000.0);
				}

				this.count++;

				if (this.count >= 40)
				{
					this.func[0].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.rz = 0,00000000.0;
			this.SetMotion(2508, 0);
			this.stateLabel = function ()
			{
			};
		}
	];
	this.func[1].call(this, this.owner.occultRange);
}

function Occult_TelLine( t )
{
	this.SetMotion(2508, 10);
	this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
	this.flag1 = this.Vector3();
	this.sx = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.flag1.x = this.owner.target.x - this.x;
		this.flag1.y = this.owner.target.y - this.y;
		this.sx = this.flag1.LengthXY() / 128,00000000.0;
		this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
	};
}

function Occult_HitEffect( t )
{
	this.SetMotion(2508, 8);
	this.sx = this.sy = 3,00000000.0;
	this.SetFreeObject(this.x, this.y, this.direction, function ( t )
	{
		this.SetMotion(2508, 7);
		this.DrawActorPriority(180);
		this.sx = this.sy = 2,50000000.0 + this.rand() % 6 * 0,10000000.0;
		this.stateLabel = function ()
		{
			this.sx = this.sy -= 0,05000000.0;
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	}, {});
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,80000001.0;

		if (this.sx <= 0,25000000.0)
		{
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Occult_Koishi( t )
{
	this.SetMotion(2509, 0);
	this.DrawActorPriority(170);
	this.SetParent(this.owner.target, 100,00000000.0, 0,00000000.0);
	this.alpha = this.red = this.green = this.blue = 0,00000000.0;
	this.SetSpeed_Vec(15,00000000.0, -160 * 0,01745329.0, this.direction);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(this.va.x * this.direction < 0,50000000.0 ? 0,75000000.0 * this.direction : 0,00000000.0, this.va.y < 0,25000000.0 ? 0,15000001.0 : 0,00000000.0);
		this.alpha += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.red = this.green = this.blue = this.alpha;
	};
}

function SPShot_B( t )
{
	this.SetMotion(6010, t.keyTake);
	this.Warp(this.owner.point0_x + 100,00000000.0 * this.cos(this.initTable.rot) * this.direction, this.owner.point0_y + 20,00000000.0 * this.sin(this.initTable.rot));
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,98000002.0;
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion == 3010 || this.owner.motion == 3011)
		{
			if (this.owner.keyTake <= 2)
			{
				this.initTable.rot += 10,00000000.0 * 0,01745329.0;
				this.Warp(this.owner.point0_x + 100,00000000.0 * this.cos(this.initTable.rot) * this.direction, this.owner.point0_y + 20,00000000.0 * this.sin(this.initTable.rot));
				this.count++;

				if (this.count % 2 == 0)
				{
					local t_ = {};
					t_.keyTake <- this.keyTake;
					t_.priority <- 200;

					if (this.sin(this.initTable.rot) > 0,00000000.0)
					{
						t_.priority <- 180;
					}

					this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_Trail, t_);
				}
			}
			else
			{
				this.func();
			}
		}
		else
		{
			this.func();
		}
	};
}

function SPShot_B_Trail( t )
{
	this.DrawActorPriority(t.priority);
	this.SetMotion(6010, t.keyTake);
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,99000001.0;
		this.alpha -= 0,03000000.0;
		this.AddSpeed_XY(0,00000000.0, 0,05000000.0);

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_B_Effect( t )
{
	this.priority = 200;
	this.SetMotion(6010, 2);
	this.rz = t.rz;
	this.sx = this.sy = t.scale;
	this.ry = 75,00000000.0 * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02000000.0;

		if (this.alpha <= 0,05000000.0)
		{
			this.ReleaseActor();
		}
		else
		{
			this.alpha -= 0,05000000.0;
		}
	};
}

function SPShot_C( t )
{
	this.priority = 190;
	this.SetMotion(6020, this.rand() % 8);
	this.rz = t.rot;
	this.initTable.num++;
	this.flag1 = true;
	this.func = function ()
	{
		this.flag2 = (this.rand() % 5 - 2) * 0,01745329.0;
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0,00000000.0, 0,34999999.0);
			this.rz += this.flag2;

			if (this.red >= 0,10000000.0)
			{
				this.red = this.green = this.blue -= 0,10000000.0;
			}
			else
			{
				this.alpha -= 0,05000000.0;
			}

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion == 3020)
		{
			if (this.owner.keyTake <= 3 && ::actor[this.initTable.name].flag1)
			{
				this.Warp(::actor[this.initTable.name].point0_x, ::actor[this.initTable.name].point0_y);
			}
			else
			{
			}
		}
		else
		{
		}

		this.count++;

		if (this.count == 2 && this.initTable.num < this.initTable.limit)
		{
			local t_ = {};
			t_.num <- this.initTable.num;
			t_.limit <- this.initTable.limit;
			t_.name <- this.name;
			t_.rot <- this.GetTargetAngle(this.target, this.direction);
			t_.rot = this.Math_MinMax(t_.rot, -5,00000000.0 * 0,01745329.0 + this.rz, 5,00000000.0 * 0,01745329.0 + this.rz);
			t_.rot += (15 - this.rand() % 31) * 0,01745329.0;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.owner.SPShot_C, t_);
		}

		if (this.count == 15 && this.initTable.num % 2 == 0)
		{
			local t_ = {};
			t_.se <- false;

			if (this.initTable.num == 3)
			{
				t_.se = true;
			}

			this.SetShot(this.x + this.rand() % 60 - 30, this.y + this.rand() % 60 - 30, this.direction, this.owner.SPShot_C_Rose, t_);
		}

		if (this.count == 60)
		{
			this.flag1 = false;
			this.func();
		}
	};
}

function SPShot_C_Rose( t )
{
	if (t.se)
	{
		this.PlaySE(2436);
	}

	this.SetMotion(6021, 0);
	this.rz = (20 - this.rand() % 40) * 0,01745329.0;
	this.sx = this.sy = 0,10000000.0;
	this.flag1 = 0,75000000.0 + this.rand() % 50 * 0,01000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (this.flag1 - this.sx) * 0,20000000.0;
		this.count++;

		if (this.count >= 10)
		{
			this.SetMotion(6021, 1);
			this.stateLabel = function ()
			{
			};
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			this.sx = this.sy = 1,50000000.0;
			this.FitBoxfromSprite();
			this.HitReset();

			for( local i = 0; i < 4; i++ )
			{
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_C_Petal, {});
			}

			this.stateLabel = function ()
			{
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}

				this.sx = this.sy += 0,05000000.0;
			};
		}
	];
}

function SPShot_C_Petal( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(6022, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
	this.flag1 = (8,00000000.0 + this.rand() % 6) * 0,01745329.0;
	this.SetSpeed_Vec(3 + this.rand() % 8, this.rand() % 360 * 0,01745329.0, this.direction);
	local r_ = 1 + this.rand() % 3;
	this.Warp(this.x + this.va.x * r_, this.y + this.va.y * r_);
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0,94000000.0;
		this.VX_Brake(0,05000000.0);
		this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
		this.sx = this.sy -= 0,02500000.0;

		if (this.sx <= 0,10000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_D_Petal( t )
{
	if (this.sin(t.rot) < 0,00000000.0)
	{
		this.DrawActorPriority(180);
	}
	else
	{
		this.DrawActorPriority(210);
	}

	this.SetMotion(6051, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 1,00000000.0 + this.rand() % 10 * 0,10000000.0;
	this.flag1 = (3,00000000.0 - this.rand() % 6) * 0,01745329.0;
	this.SetSpeed_Vec(8 + this.rand() % 10, t.rot, this.direction);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y);
	local r_ = 8 + this.rand() % 6;
	this.Warp(this.x + this.va.x * r_, this.y + this.va.y * r_);
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0,94000000.0;
		this.VX_Brake(0,10000000.0);
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
		this.sx = this.sy -= 0,02500000.0;

		if (this.sx <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_D_Arm( t )
{
	this.SetMotion(3039, 0);
	this.stateLabel = function ()
	{
		if (this.owner.motion != 3031 && this.owner.motion != 3036)
		{
			this.func();
		}
	};
	this.func = function ()
	{
		this.ReleaseActor();
		return;
	};
}

function SPShot_D_WireA( t )
{
	this.sx = 0,00000000.0;
	this.SetMotion(3039, 3);
	this.stateLabel = function ()
	{
		if (this.owner.motion != 3031 && this.owner.motion != 3036)
		{
			this.func();
		}
	};
	this.func = function ()
	{
		this.ReleaseActor();
		return;
	};
}

function SPShot_D_WireB( t )
{
	this.sx = 0,00000000.0;
	this.SetMotion(3039, 4);
	this.stateLabel = function ()
	{
		if (this.owner.motion != 3031 && this.owner.motion != 3036)
		{
			this.func();
		}
	};
	this.func = function ()
	{
		this.ReleaseActor();
		return;
	};
}

function SPShot_E( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(6040, 1);
	this.sx = 0,00000000.0;
	this.rz = t.rot;
	this.flag1 = null;
	this.flag2 = false;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.flag5 = false;
	local t_ = {};
	t_.rot <- this.rz;
	this.linkObject = [
		this.SetFreeObject(-this.sqrt(this.GetTargetDist(this.owner.target)), this.y, this.direction, this.SPShot_E_Pulse, t_, this.weakref()).weakref()
	];
	this.cancelCount = 99;
	this.subState = function ()
	{
		if (this.team.current.IsDamage() || this.flag5)
		{
			this.func();
			this.owner.skillE_line = null;
			this.owner.CommonAutoAttackReset(2);
			return true;
		}
		else
		{
			this.Warp(this.team.current.x, this.team.current.y - 60);
		}

		return false;
	};
	this.func = function ()
	{
		this.linkObject[0].func.call(this.linkObject[0]);
		this.stateLabel = function ()
		{
			this.sy *= 0,99000001.0;
			this.sx *= 1,02499998.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
				return;
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.count++;

		if (this.flag2)
		{
			this.initTable.rotSpeed *= 0,89999998.0;
		}

		this.rz += this.initTable.rotSpeed;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

		if (this.abs(this.rz) > 3,14159203.0)
		{
			this.owner.CommonAutoAttackReset(2);
			this.func();
			return;
		}

		local dist_ = this.sqrt(this.GetTargetDist(this.owner.target));

		if (dist_ < 200,00000000.0)
		{
			dist_ = 200,00000000.0;
		}

		this.linkObject[0].Warp(this.x + dist_ * this.cos(this.rz) * this.direction, this.y + dist_ * this.sin(this.rz));
		this.linkObject[0].rz = this.rz;
		this.sy -= 0,10000000.0;

		if (this.sy < 0,50000000.0)
		{
			this.sy = 5,00000000.0;
		}

		this.sx += 0,50000000.0;

		if (this.sx >= 20,00000000.0)
		{
			this.sx = 0,00000000.0;
		}
	};
}

function SPShot_E_Pulse( t )
{
	this.SetMotion(6040, 2);
	this.target = this.owner.target.weakref();
	this.rz = t.rot;
	this.flag1 = 0;
	this.flag2 = 0;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sy *= 0,89999998.0;
		};
	};
	this.stateLabel = function ()
	{
		this.count++;
		this.sy += 0,05000000.0 - this.rand() % 10 * 0,01000000.0;

		if (this.owner.motion == 3040 && this.owner.keyTake == 1)
		{
			this.sy = 1,50000000.0;
			this.stateLabel = function ()
			{
				this.sy *= 0,98000002.0;
				this.flag3++;

				if (this.flag3 % 6 == 1 && this.flag2 < 6)
				{
					if (this.flag2 == 0)
					{
						this.PlaySE(2443);
					}

					this.SetShot(this.x + this.rand() % 80 - 40, this.y + this.rand() % 80 - 40, this.direction, this.SPShot_E_PulseB, {});
					this.flag2++;
				}

				if (this.flag2 >= 6)
				{
					if (this.initTable.pare)
					{
						this.initTable.pare.flag5 = true;
					}
				}
			};
		}

		if (this.flag1 <= 0)
		{
			this.sy = 0,25000000.0 * this.sin(this.count * 9 * 0,01745329.0);

			if (this.team.current == this.owner && this.GetTargetDist(this.owner.target) <= 10000,00000000.0)
			{
				this.flag1 = 30;
				this.owner.skillE_react = true;

				if (this.initTable.pare)
				{
					this.initTable.pare.flag2 = true;
				}
			}
		}
		else
		{
			this.flag1--;
			this.sy *= 0,98000002.0;
		}
	};
}

function SPShot_E_PulseB( t )
{
	this.SetMotion(6040, 3);
	this.atk_id = 16777216;
	this.rz = 0,01745329.0 * this.rand() % 360;
	this.sx = this.sy = 0,00000000.0;
	this.stateLabel = function ()
	{
		local x_ = (1,00000000.0 - this.sx) * 0,20000000.0;

		if (x_ < 0,01000000.0)
		{
			x_ = 0,01000000.0;
			this.alpha = this.green = this.blue -= 0,01800000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
				return;
			}
		}

		this.sx = this.sy += x_;
	};
}

function SPShot_F( t )
{
	this.SetMotion(6050, 0);
	this.atk_id = 33554432;
	this.flag1 = this.Vector3();
	this.flag2 = 0;
	this.flag3 = this.Vector3();
	this.cancelCount = 3;
	this.rz = 0,01745329.0 * (-45 + this.rand() % 90);
	this.SetSpeed_Vec(1,00000000.0, t.rot, this.direction);
	this.flag3.x = this.va.x;
	this.flag3.y = this.va.y;
	local v_ = t.vec;
	this.SetSpeed_XY(this.va.x * v_, this.va.y * v_);
	this.SetParent(this.owner, 0, 0);
	this.DrawActorPriority(180);
	this.alpha = 0,00000000.0;
	this.target = this.owner.target.weakref();
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(6050, 1);
			this.SetParent(null, 0, 0);
			this.flag2 = 30 + this.count / 6;

			if (this.flag2 >= 60)
			{
				this.flag2 = 60;
			}

			this.count = 0;
			this.stateLabel = function ()
			{
				this.alpha += 0,10000000.0;

				if (this.owner.IsDamage())
				{
					this.func[1].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,89999998.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(6052, 1);
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha += 0,10000000.0;

				if (this.owner.IsDamage())
				{
					this.func[1].call(this);
					return;
				}
			};
			this.keyAction[1] = function ()
			{
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
				local t_ = {};
				t_.rot <- this.rz;
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_F_FlashB, t_);
				this.stateLabel = function ()
				{
					if (this.hitCount == 0)
					{
						this.HitCycleUpdate(10);
					}
				};
			};
		}
	];
	this.keyAction = [
		null,
		function ()
		{
			this.SetSpeed_XY(this.flag3.x * 9, this.flag3.y * 9);
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_F_Flash, t_);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				this.SetSpeed_XY(this.va.x * 0,89999998.0, this.va.y * 0,89999998.0);

				if (this.count >= this.flag2)
				{
					this.func[1].call(this);
				}
			};
		},
		function ()
		{
			this.func[1].call(this);
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.func[1].call(this);
			return;
		}

		this.count++;

		if (this.count < 180)
		{
			this.Vec_Brake(0,50000000.0, 1,00000000.0);
		}
		else if (this.count == 180)
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		}
	};
}

function SPShot_F_Flash( t )
{
	this.SetMotion(6050, 4);
	this.DrawActorPriority(180);
	this.rz = t.rot;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,50000000.0 - this.sx) * 0,25000000.0;
		this.alpha -= 0,15000001.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_F_FlashB( t )
{
	this.SetMotion(6052, 4);
	this.DrawActorPriority(180);
	this.sx = this.sy = 2,00000000.0;
	this.rz = t.rot;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (3,00000000.0 - this.sx) * 0,25000000.0;
		this.alpha -= 0,15000001.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_F_Petal( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(6051, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
	this.flag1 = (8,00000000.0 + this.rand() % 6) * 0,01745329.0;
	this.SetSpeed_Vec(3 + this.rand() % 8, this.rand() % 360 * 0,01745329.0, this.direction);
	local r_ = 1 + this.rand() % 3;
	this.Warp(this.x + this.va.x * r_, this.y + this.va.y * r_);
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0,94000000.0;
		this.VX_Brake(0,05000000.0);
		this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
		this.sx = this.sy -= 0,02500000.0;

		if (this.sx <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_G( t )
{
	this.SetMotion(6060, t.keyTake);
	this.atk_id = 1073741824;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,99800003.0;
			this.alpha -= 0,02000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion != 3060 && this.owner.motion != 3061)
		{
			this.func();
		}
		else
		{
			if (this.hitResult & 13)
			{
				this.owner.flag2 = true;
			}

			if (this.owner.keyTake <= 2)
			{
				this.Warp(this.owner.x, this.owner.y);
			}
		}
	};
}

function SpellShot_A( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(7000, 0);
	this.atk_id = 67108864;
	this.atkRate_Pat = t.rate;
	this.sx = this.sy = 0,01000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,98000002.0;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion == 4000)
		{
			if (this.owner.keyTake <= 2)
			{
				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,15000001.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
				this.HitCycleUpdate(5);
				this.Warp(this.owner.x, this.owner.y);
				this.count++;

				if (this.count % 12 == 1)
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_A_Ring, {});
				}

				if (this.count % 2 == 1)
				{
					local v_ = 600 + this.rand() % 400;
					local r_ = this.rand() % 360 * 0,01745329.0;
					this.SetFreeObject(this.x + v_ * this.cos(r_), this.y + v_ * this.sin(r_), this.direction, this.owner.SpellShot_A_Heart, {});
				}
			}
			else
			{
				this.func[0].call(this);
				return;
			}
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A_Ring( t )
{
	this.SetMotion(7000, 1);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 6,00000000.0;
	this.alpha = 0,00000000.0;
	this.subState = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha -= 0,07500000.0;

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
		if (this.owner.motion == 4000)
		{
			if (this.owner.keyTake == 2)
			{
				this.Warp(this.owner.x, this.owner.y);
			}
		}

		this.sx = this.sy *= 0,92000002.0;

		if (this.subState())
		{
			return;
		}
	};
}

function SpellShot_A_Heart( t )
{
	this.SetMotion(7000, 2);
	this.sx = this.sy = 1,89999998.0 + this.rand() % 20 * 0,01000000.0;
	this.alpha = 0,00000000.0;
	this.SetSpeed_XY((this.owner.x - this.x) * 0,10000000.0, (this.owner.y - this.y) * 0,10000000.0);
	this.FitRotatefromVec();
	this.subState = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}
	};
	this.stateLabel = function ()
	{
		this.SetSpeed_XY((this.owner.x - this.x) * 0,05000000.0, (this.owner.y - this.y) * 0,05000000.0);
		this.FitRotatefromVec();
		this.count++;
		this.sx = this.sy *= 0,99000001.0;

		if (this.count == 30)
		{
			this.subState = function ()
			{
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
					return true;
				}
			};
		}

		if (this.subState())
		{
			return;
		}
	};
}

function SpellShot_B( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(7010, 0);
	this.sx = this.sy = 0,00000000.0;
	this.flag1 = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,98000002.0;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion == 4010)
		{
			if (this.owner.keyTake <= 4)
			{
				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,07500000.0;
				this.Warp(this.owner.x, this.owner.y);
				this.count++;

				if (this.count % 12 == 1)
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_B_Ring, {});
				}

				if (this.count % 15 == 1)
				{
					local g_ = [];
					local a_;
					local b_;

					for( local i = 0; i < 360; i = i + 40 )
					{
						local t_ = {};
						t_.rot <- i * 0,01745329.0 + this.flag1;
						t_.v <- 10;
						t_.rate <- this.initTable.rate;

						if (i == 0)
						{
							a_ = this.SetShot(this.x, this.y, this.direction, this.owner.SpellShot_B_Heart, t_);
							b_ = this.SetShot(this.x, this.y, -this.direction, this.owner.SpellShot_B_Heart, t_);
							b_.hitOwner = a_;
						}
						else
						{
							b_ = this.SetShot(this.x, this.y, this.direction, this.owner.SpellShot_B_Heart, t_);

							if (a_)
							{
								b_.hitOwner = a_;
							}

							b_ = this.SetShot(this.x, this.y, -this.direction, this.owner.SpellShot_B_Heart, t_);

							if (a_)
							{
								b_.hitOwner = a_;
							}
						}
					}

					this.flag1 += 18 * 0,01745329.0;
				}
			}
			else
			{
				this.func[0].call(this);
				return;
			}
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_B_Ring( t )
{
	this.SetMotion(7010, 1);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,00000000.0;
	this.alpha = 0,00000000.0;
	this.subState = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha -= 0,07500000.0;

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
		if (this.owner.motion == 4010)
		{
			if (this.owner.keyTake <= 4)
			{
				this.Warp(this.owner.x, this.owner.y);
			}
		}

		this.sx = this.sy += 0,10000000.0;

		if (this.subState())
		{
			return;
		}
	};
}

function SpellShot_B_Heart( t )
{
	this.SetMotion(7010, 2);
	this.atk_id = 67108864;
	this.sx = this.sy = 1,00000000.0;
	this.alpha = 0,00000000.0;
	this.flag1 = this.Vector3();
	this.flag1.x = this.x;
	this.flag1.y = this.y;
	this.rz = t.rot;
	this.cancelCount = 3;
	this.SetSpeed_Vec(25,00000000.0, this.rz, this.direction);
	this.FitRotatefromVec();
	this.subState = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 180 || this.hitResult != 0)
		{
			this.callbackGroup = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.subState = function ()
			{
				this.alpha -= 0,15000001.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
					return true;
				}
			};
		}

		this.subState();
	};
}

function SpellShot_C( t )
{
	this.DrawActorPriority(170);
	this.SetMotion(7020, 0);
	this.sx = this.sy = 0,00000000.0;
	this.flag3 = this.initTable.scale;
	this.flag1 = 35 + this.rand() % 15;
	this.func = [
		function ()
		{
			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.stateLabel = function ()
			{
				this.sx *= 0,97000003.0;
				this.sy *= 1,04999995.0;
				this.alpha = this.green = this.red -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ( rate_ )
		{
			this.atkRate_Pat = rate_;

			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.count = 0;
			this.stateLabel = function ()
			{
				this.initTable.wait--;

				if (this.initTable.wait <= 0)
				{
					this.stateLabel = function ()
					{
						this.count++;
						this.sx *= 0,98000002.0;
						this.sy *= 1,10000002.0;
						this.alpha = this.green = this.red -= 0,05000000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.alpha = this.green = this.red = 0,00000000.0;
						}

						if (this.count >= 40)
						{
							local t_ = {};
							t_.rate <- this.atkRate_Pat;
							this.SetShot(this.x, ::battle.scroll_top - 0, this.owner.direction, this.owner.SpellShot_C_Fall, t_);
							this.PlaySE(2507);
							this.ReleaseActor();
						}
					};
				}
			};
		}
	];
	local t_ = {};
	t_.scale <- this.flag3;
	this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
	{
		this.SetMotion(7020, 0);
		this.sx = this.sy = 1,50000000.0 * t_.scale;
		this.DrawActorPriority(170);
		this.alpha = 0,00000000.0;
		this.flag1 = this.Vector3();
		this.flag1.x = 0,00250000.0 + this.rand() % 3 * 0,00010000.0;
		this.flag1.y = 0,00330000.0 + this.rand() % 5 * 0,00010000.0;
		this.func = [
			function ()
			{
				this.stateLabel = function ()
				{
					this.alpha -= 0,05000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			},
			function ()
			{
				this.subState = function ()
				{
					this.alpha += 0,05000000.0;

					if (this.alpha >= 0,50000000.0)
					{
						this.alpha = 0,50000000.0;
						this.subState = function ()
						{
							this.alpha -= 0,01000000.0;

							if (this.alpha <= 0,00000000.0)
							{
								this.sx = this.sy = 1,50000000.0 * this.initTable.scale;
								this.alpha = 0,00000000.0;
								this.func[1].call(this);
							}
						};
					}
				};
			}
		];
		this.func[1].call(this);
		this.stateLabel = function ()
		{
			this.sx += this.flag1.x;
			this.sy += this.flag1.y;
			this.subState();
		};
	}, t_).weakref();
	this.subState = function ()
	{
		this.SetSpeed_XY(0,00000000.0, 1,00000000.0 * this.sin(this.count * 0,01745329.0 * 2));
	};
	this.stateLabel = function ()
	{
		this.count++;
		this.subState();
		this.sx = this.sy += (1,50000000.0 * this.flag3 - this.sx) * 0,15000001.0;

		if (this.sx >= 1,45000005.0 * this.flag3)
		{
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count % this.flag1 == 1)
				{
					local t_ = {};
					t_.scale <- this.flag3;
					this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
					{
						this.SetMotion(7020, 1 + this.rand() % 2);
						this.sx = this.sy = 0,50000000.0 * t_.scale;
						this.DrawActorPriority(170);
						this.alpha = 0,00000000.0;
						this.flag1 = this.Vector3();
						this.flag1.x = 0,02500000.0 + this.rand() % 3 * 0,00100000.0;
						this.flag1.y = 0,05000000.0 + this.rand() % 5 * 0,00100000.0;
						this.ry = this.rand() % 360 * 0,01745329.0;
						this.subState = function ()
						{
							this.alpha += 0,05000000.0;

							if (this.alpha >= 1,00000000.0)
							{
								this.alpha = 1,00000000.0;
								this.subState = function ()
								{
									this.alpha -= 0,02000000.0;

									if (this.alpha <= 0,00000000.0)
									{
										this.ReleaseActor();
									}
								};
							}
						};
						this.stateLabel = function ()
						{
							this.sx += this.flag1.x;
							this.sy += this.flag1.y;
							this.subState();
						};
					}, t_);
				}

				this.subState();
				this.sx = this.sy += (1,50000000.0 * this.flag3 - 0,05000000.0 * this.sin((this.count + this.flag1) * 3 * 0,01745329.0) - this.sx) * 0,10000000.0;
				this.alpha = this.green = this.red = 0,89999998.0 + 0,10000000.0 * this.sin(this.count * 0,01745329.0 * 3);
			};
		}
	};
}

function SpellShot_C_Fall( t )
{
	this.SetMotion(7021, 0);
	this.atk_id = 67108864;
	this.rz = this.GetTargetAngle(this.target, this.direction);
	this.sx = 0,10000000.0;
	this.FitBoxfromSprite();
	this.atkRate_Pat = t.rate;
	this.cancelCount = 3;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx += 0,20000000.0;
			this.sy *= 0,89999998.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.team.spell_enable_end = true;
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 2 == 1)
		{
			local t_ = {};
			t_.rot <- this.rz - 90 * 0,01745329.0;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, function ( t_ )
			{
				this.SetMotion(7020, 1 + this.rand() % 2);
				this.rz = t_.rot;
				this.stateLabel = function ()
				{
					this.sy += 0,20000000.0;
					this.sx += 0,10000000.0;
					this.alpha -= 0,05000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}, t_);
		}

		this.sx += 0,20000000.0;
		this.sy *= 0,98000002.0;
		this.FitBoxfromSprite();

		if (this.hitCount <= 2)
		{
			this.HitCycleUpdate(1);
		}

		if (this.count > 30 || this.cancelCount <= 0)
		{
			this.func();
		}
	};
}

function Climax_Shot( t )
{
	this.SetMotion(4908, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.atkRate_Pat = t.rate;
	this.cancelCount = 99;
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			if (this.owner.IsDamage())
			{
				this.SetParent(null, 0, 0);
				this.callbackGroup = 0;
				this.stateLabel = function ()
				{
					this.sx = this.sy += (2,00000000.0 - this.sx) * 0,10000000.0;
					this.alpha -= 0,03300000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}

			this.sx = this.sy += (2,00000000.0 - this.sx) * 0,10000000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			this.count++;

			if (this.count == 10)
			{
				this.callbackGroup = 0;
			}

			if (this.count >= 20)
			{
				this.alpha -= 0,03300000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			}
		};
	};
}

function Climax_ShotB( t )
{
	this.SetMotion(4908, 2);
	this.target = this.owner.target.weakref();
	this.atkRate_Pat = t.rate;
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(5);
		this.count++;

		if (this.count % 4 == 1)
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_Blade, {});
		}

		if (this.count >= 30)
		{
			this.ReleaseActor();
			return;
		}
	};
}

function Climax_Blade( t )
{
	this.SetMotion(4908, 3);
	this.rz = (-20 - this.rand() % 5) * 0,01745329.0;
	this.SetSpeed_Vec(15,00000000.0, this.rz, this.direction);
	this.sy = 2,50000000.0 + this.rand() % 10 * 0,10000000.0;
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,75000000.0, 1,00000000.0);
		this.sx += (3,00000000.0 - this.sx) * 0,10000000.0;
		this.sy *= 0,95999998.0;
		this.count++;

		if (this.count >= 15)
		{
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_Font( t )
{
	this.SetMotion(4909, t.take);
	this.DrawScreenActorPriority(300);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4909, 4);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(-10,00000000.0, 0,00000000.0);

				if (this.x < -1280)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4909, 7);
			this.SetSpeed_XY(-6,00000000.0, -1,00000000.0);
			this.SetFreeObject(this.x, this.y, this.direction, this.Climax_SliceFont, {});
			this.SetFreeObject(640, 320, this.direction, this.Climax_FontSliceEffect, {});
			this.stateLabel = function ()
			{
				this.alpha -= 0,01500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
					return;
				}

				this.AddSpeed_XY(0,00000000.0, 0,05000000.0);
				this.rz += (4,00000000.0 * 0,01745329.0 - this.rz) * 0,01000000.0;
			};
		}
	];
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}
	};
}

function Climax_SliceFont( t )
{
	this.SetMotion(4909, 8);
	this.SetSpeed_XY(-6,00000000.0, 0,50000000.0);
	this.DrawScreenActorPriority(300);
	this.stateLabel = function ()
	{
		this.alpha -= 0,01500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,05000000.0);
		this.rz += (-4,00000000.0 * 0,01745329.0 - this.rz) * 0,01000000.0;
	};
}

function Climax_FontSliceEffect( t )
{
	this.SetMotion(4908, 3);
	this.DrawScreenActorPriority(300);
	this.SetSpeed_XY(-3,00000000.0, 0,00000000.0);
	this.sy = 8,00000000.0;
	this.stateLabel = function ()
	{
		this.sy *= 0,89999998.0;
		this.sx *= 1,25000000.0;
		this.count++;

		if (this.count >= 30)
		{
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_Face( t )
{
	this.SetMotion(4909, 6);
	this.DrawScreenActorPriority(290);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,02500000.0;
		this.x += -this.x * 0,25000000.0;

		if (this.x < 0)
		{
		}
	};
}

function Climax_Walk( t )
{
	this.SetMotion(4909, 0);
	this.DrawScreenActorPriority(100);
	this.red = this.green = this.blue = this.sx = this.sy = t.scale;
	this.flag1 = this.Vector3();
	this.flag1.x = this.x;
	this.flag1.y = this.y;
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

	if (t.scale >= 1,20000005.0)
	{
		this.SetSpeed_XY(-0,75000000.0, 0,00000000.0);
	}
	else
	{
		this.SetSpeed_XY(0,30000001.0, 0,00000000.0);
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,00500000.0;
		this.count++;
		this.flag1 = this.flag1 + this.va;
		this.rz = 2,00000000.0 * this.sin(this.count * 2 * 0,01745329.0) * 0,01745329.0;

		if (this.count % 2 == 1)
		{
			this.x = this.flag1.x + (1 - this.rand() % 3) * this.sx * 0,50000000.0;
			this.y = this.flag1.y + (1 - this.rand() % 3) * this.sy * 0,50000000.0;
		}

		if (this.count % 20 == 10)
		{
			local t_ = {};
			t_.scale <- this.sx;
			this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Climax_WalkShadow, t_));
		}
	};
}

function Climax_WalkShadow( t )
{
	this.SetMotion(4909, 0);
	this.DrawScreenActorPriority(99);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = (0,80000001.0 + this.rand() % 5 * 0,10000000.0) * t.scale;
	this.SetSpeed_Vec(0,50000000.0 + this.rand() % 5 * 0,10000000.0, this.rand() % 360 * 0,01745329.0, this.direction);
	this.SetSpeed_XY(this.va.x * 2, null);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha >= 0,30000001.0)
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0,00500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

