function AtkHighFront_Object( t )
{
	this.DrawActorPriority(180);

	if (t.type == 1)
	{
		this.SetMotion(5998, 1);
	}
	else
	{
		this.SetMotion(5998, 0);
	}

	this.keyAction = this.ReleaseActor;
	this.SetParent(this.owner, this.owner.x - this.x, this.owner.y - this.y);
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.SetKeyFrame(1);
		this.stateLabel = null;
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion == 1230 || this.owner.motion == 1231 || this.owner.motion == 1235 || this.owner.motion == 1236 || this.owner.motion == 1730 || this.owner.motion == 1731 || this.owner.motion == 1735 || this.owner.motion == 1736 || this.owner.motion == 1740 || this.owner.motion == 1741 || this.owner.motion == 1750 || this.owner.motion == 1751)
		{
			if (this.owner.keyTake != 2 && this.owner.keyTake != 3)
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

function AtkHighFrontCharge_Object( t )
{
	this.DrawActorPriority(180);

	if (t.type == 1)
	{
		this.SetMotion(5999, 1);
	}
	else
	{
		this.SetMotion(5999, 0);
	}

	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.alpha = this.green = this.blue -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.count++;

		if (this.owner.motion == 1235 || this.owner.motion == 1236)
		{
			this.Warp(this.owner.x, this.owner.y);

			if (this.count >= 15)
			{
				this.alpha = this.green = this.blue -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			}

			if (this.owner.keyTake != 2)
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

function CommonSmoke_Core( t )
{
	this.SetMotion(7961, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(this.rand() % 3, this.rz, this.direction);
	this.sx = this.sy = t.scale;
	local st_ = function ( t_ )
	{
		this.SetMotion(7961, this.rand() % 4);
		this.sx = this.sy = (0,80000001.0 + this.rand() % 5 * 0,10000000.0) * t_.scale;
		this.rz = this.rand() % 360 * 0,01745329.0;
		this.SetSpeed_Vec((4 + this.rand() % 8) * t_.scale, t_.rot, this.direction);
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
		t_.scale <- this.initTable.scale;
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

function CommonSmoke( t )
{
	this.SetMotion(7961, this.rand() % 4);
	this.sx = this.sy = (0,80000001.0 + this.rand() % 5 * 0,10000000.0) * t.scale;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec((4 + this.rand() % 8) * t.scale, t.rot, this.direction);
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
}

function Shot_Normal( t )
{
	this.SetMotion(2009, 5);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.sx = this.sy = 0,50000000.0;
	this.flag2 = t.rot;
	this.SetSpeed_Vec(5,00000000.0, this.flag2, this.direction);
	this.atk_id = 16384;
	this.cancelCount = 3;
	local t_ = {};
	t_.ring <- false;
	this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalFlash, t_);
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.SetSpeed_XY(this.va.x * 0,20000000.0, this.va.y * 0,20000000.0);
			this.rz += 0,05235988.0;
			this.sx = this.sy *= 0,89999998.0;
			this.alpha = this.blue = this.green -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		this.flag1 += 10,00000000.0;
		this.AddSpeed_Vec(this.flag1, this.flag2, null, this.direction);

		if (this.va.LengthXY() >= 40,00000000.0)
		{
			this.flag1 = 0;
			this.subState = function ()
			{
				this.sx *= 0,89999998.0;
				this.SetSpeed_XY(this.va.x * 0,20000000.0, this.va.y * 0,20000000.0);
				this.flag1++;

				if (this.flag1 >= 10)
				{
					this.PlaySE(2051);
					local t_ = {};
					t_.ring <- true;
					this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalFlash, t_);

					if (this.initTable.style == 2)
					{
						for( local i = 0; i < 5; i++ )
						{
							local t_ = {};
							t_.style <- this.initTable.style;
							t_.rot <- this.flag2 + (-20 + 10 * i) * 0,01745329.0;
							this.SetShot(this.x, this.y, this.direction, this.owner.Shot_NormalSplash, t_);
						}
					}
					else
					{
						for( local i = 0; i < 5; i++ )
						{
							local t_ = {};
							t_.style <- this.initTable.style;
							t_.rot <- this.flag2 + (-20 + 10 * i) * 0,01745329.0;
							this.SetShot(this.x, this.y, this.direction, this.owner.Shot_NormalSplash, t_);
						}
					}

					this.ReleaseActor();
					return true;
				}

				return false;
			};
		}

		return false;
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.ReleaseActor();
			return true;
		}

		this.rz += this.va.LengthXY() / 48 + 0,10471975.0;

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 10)
		{
			this.func();
			return;
		}

		this.HitCycleUpdate(10);

		if (this.subState())
		{
			return;
		}

		this.sx += this.va.LengthXY() / 48;
		this.sx *= 0,89999998.0;
		this.sy = this.sx;
	};
}

function Shot_NormalSplash( t )
{
	this.SetMotion(2009, 1);

	if (t.style == 2)
	{
		this.cancelCount = 2;
		this.flag2 = 4,50000000.0;
		this.flag3 = 3;
	}
	else
	{
		this.cancelCount = 1;
		this.flag2 = 2,00000000.0;
		this.flag3 = 1;
	}

	this.atk_id = 16384;
	this.sx = 0,00000000.0;
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(5,00000000.0, this.rz, this.direction);
	this.func = function ()
	{
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.callbackGroup = 0;
		local t_ = {};
		t_.ring <- false;
		this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalFlash, t_);
		this.stateLabel = function ()
		{
			this.sx *= 0,75000000.0;
			this.alpha = this.blue = this.green -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		this.flag1 += 5,00000000.0;
		this.AddSpeed_Vec(this.flag1, this.rz, null, this.direction);

		if (this.va.LengthXY() >= 20,00000000.0)
		{
			this.flag1 = 0;
			this.subState = function ()
			{
				this.flag1++;
				return false;
			};
		}

		return false;
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.IsScreen(300) || this.grazeCount >= this.flag3 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.func();
			return;
		}

		if (this.subState())
		{
			return;
		}

		this.HitCycleUpdate(0);
		this.sx += this.va.LengthXY() / 48;

		if (this.sx > this.flag2)
		{
			this.sx = this.flag2;
		}

		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

function Shot_NormalFlash( t )
{
	local state_ = function ( t_ )
	{
		this.SetMotion(2009, 3);
		this.rz = 0,01745329.0 * this.rand() % 360;
		this.stateLabel = function ()
		{
			this.rz += 6,00000000.0 * 0,01745329.0;
			this.sx = this.sy += (2,50000000.0 - this.sx) * 0,25000000.0;
			this.alpha = this.blue = this.green -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.SetMotion(2009, 2);
	this.rz = 0 * 0,01745329.0;

	if (t.ring)
	{
		this.SetFreeObject(this.x, this.y, this.direction, state_, {});
	}

	this.alpha = 2,00000000.0;
	this.stateLabel = function ()
	{
		this.sx *= 0,94000000.0;
		this.sy += (3,00000000.0 - this.sy) * 0,10000000.0;
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
}

function Shot_Front( t )
{
	this.rz = t.rot;
	this.flag1 = 0;
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

	if (t.style == 2)
	{
		this.SetMotion(2018, 0);
	}
	else
	{
		this.SetMotion(2019, 0);
	}

	this.cancelCount = 6;
	this.atk_id = 65536;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.flag2.Foreach(function ()
			{
				this.func();
			});
			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 2);
			this.keyAction = function ()
			{
				this.ReleaseActor();
			};
			this.stateLabel = function ()
			{
				this.sy *= 0,99000001.0;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 20 || this.cancelCount <= 0 || this.Damage_ConvertOP(this.x, this.y, 10))
		{
			this.func[0].call(this);
			return;
		}

		if (this.owner.motion != 2010 && this.owner.motion != 2011 && this.owner.motion != 2015 && this.owner.motion != 2016)
		{
			this.func[0].call(this);
			return;
		}

		if (this.motion == 2018)
		{
			this.sy += (1,50000000.0 - this.sy) * 0,15000001.0;
			this.SetCollisionScaling(1,00000000.0, this.sy, 1,00000000.0);
		}

		if (this.count % 3 == 1 && this.count <= 15)
		{
			local t_ = {};
			t_.rot <- (10,00000000.0 + this.rand() % 10) * 0,01745329.0;
			t_.baseRot <- this.rz;

			if (this.rand() % 100 <= 50)
			{
				t_.rot *= -1;
			}

			t_.rot += this.rz;
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_Front_Line, t_);
			this.flag2.Add(a_);
			a_.SetParent(this, 0, 0);
		}

		if (this.hitCount < 6)
		{
			this.HitCycleUpdate(3);
		}
	};
}

function Shot_Front_High( t )
{
	this.SetMotion(5010, 0);
	this.cancelCount = 9;
	this.atk_id = 65536;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.owner.motion != 2500 || this.count >= 40)
		{
			this.SetMotion(5010, 2);
			this.keyAction = function ()
			{
				this.ReleaseActor();
			};
			this.stateLabel = function ()
			{
				this.sy *= 0,99000001.0;
			};
		}
		else
		{
			this.Warp(this.owner.point0_x, this.owner.point0_y);

			if (this.count % 3 == 1 && this.count <= 15)
			{
				local t_ = {};
				t_.rot <- (10,00000000.0 + this.rand() % 10) * 0,01745329.0;
				t_.baseRot <- this.rz;

				if (this.rand() % 100 <= 50)
				{
					t_.rot *= -1;
				}

				t_.rot += this.rz;
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.HighShot_Line, t_);
			}

			this.HitCycleUpdate(3);
		}
	};
}

function Shot_Front_Line( t )
{
	this.SetMotion(2019, 3);
	this.rz = t.baseRot;
	this.subState = function ()
	{
		this.rz += (this.initTable.rot - this.rz) * 0,10000000.0;
	};
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.subState();
			this.alpha = this.blue = this.green -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.count++;

		if (this.count >= 10)
		{
			this.func();
		}
	};
}

function Shot_Barrage_Fire( t )
{
	this.SetMotion(2026, 3);
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,98000002.0;
		this.alpha = this.green -= 0,10000000.0;
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, 0);
	this.atk_id = 262144;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.sy = 0,01000000.0;
	this.subState = function ()
	{
		this.sy += (1,00000000.0 - this.sy) * 0,10000000.0;
	};
	this.cancelCount = 2;
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.SetMotion(this.motion, 2);
		this.stateLabel = function ()
		{
			this.sy *= 0,89999998.0;
			this.alpha = this.blue = this.green -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.keyAction = [
		function ()
		{
			this.sy = 3,00000000.0;
			this.subState = function ()
			{
				this.sy *= 0,89999998.0;
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sy *= 0,89999998.0;
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
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.func();
			return true;
		}

		this.subState();
	};
}

function Shot_Charge( t )
{
	this.target = this.owner.target.weakref();
	this.atk_id = 131072;
	this.flag5 = {};
	this.flag5.preWait <- 90;
	this.flag5.hitNum <- 1;
	this.flag5.grazeNum <- 1;
	this.flag5.traceCount <- 1;
	this.flag5.traceScale <- 2,00000000.0;
	this.flag5.vec <- this.Vector3();
	this.flag5.vecR <- 0;
	this.flag5.v <- 0;

	if (t.charge)
	{
		this.SetMotion(2029, 0);
		this.flag5.traceScale = 2,50000000.0;
		this.flag5.hitNum = 8;
		this.flag5.grazeNum = 30;
		this.flag5.preWait = 360;
		this.flag5.traceCount = 240;
		this.cancelCount = 9;

		if (t.style == 2)
		{
			this.flag5.traceScale = 3,00000000.0;
			this.flag5.hitNum = 10;
			this.flag5.grazeNum = 30;
			this.flag5.preWait = 420;
			this.flag5.traceCount = 300;
			this.cancelCount = 3;
		}
	}
	else
	{
		this.SetMotion(2028, 0);
		this.flag5.hitNum = 3;
		this.flag5.grazeNum = 1;
		this.flag5.preWait = 240;
		this.flag5.traceCount = 150;
		this.cancelCount = 3;

		if (t.style == 2)
		{
			this.flag5.traceScale = 2,50000000.0;
			this.flag5.hitNum = 4;
			this.flag5.grazeNum = 1;
			this.flag5.preWait = 300;
			this.flag5.traceCount = 150;
			this.cancelCount = 3;
		}
	}

	this.func = [
		function ()
		{
			local t_ = {};
			t_.scale <- this.sx;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_Charge_Hit, t_);
			this.ReleaseActor();
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.owner.motion == 2020 && this.owner.keyTake == 0 || this.hitCount >= this.flag5.hitNum || this.grazeCount >= this.flag5.grazeNum || this.cancelCount <= 0 || this.IsScreen(300,00000000.0))
				{
					this.func[0].call(this);
					return;
				}

				this.sx = this.sy += (-this.flag5.traceScale - this.sx) * 0,10000000.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
				this.Vec_Brake(4,00000000.0);

				if (this.count >= 20)
				{
					this.PlaySE(2106);
					this.flag2 = 180,00000000.0 * 0,01745329.0;
					this.flag5.vecR = this.GetTargetAngle(this.target, 1,00000000.0);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.owner.motion == 2020 && this.owner.keyTake == 0 || this.hitCount >= this.flag5.hitNum || this.grazeCount >= this.flag5.grazeNum || this.cancelCount <= 0 || this.IsScreen(300,00000000.0) || this.count >= this.flag5.traceCount)
						{
							this.func[0].call(this);
							return;
						}

						this.count++;

						if (this.GetTargetDist(this.target) <= 2500,00000000.0)
						{
							this.SetSpeed_XY(this.va.x * 0,89999998.0, this.va.y * 0,89999998.0);
						}
						else
						{
							this.AddSpeed_Vec(0,20000000.0, null, 6,00000000.0);
							this.TargetHoming(this.target, this.flag2, this.direction);
						}

						this.subState();
					};
					return;
				}

				this.subState();
			};
		}
	];
	this.SetSpeed_Vec(1,00000000.0, this.initTable.rot, this.direction);
	this.flag5.vec.x = this.va.x;
	this.flag5.vec.y = this.va.y;
	this.flag5.v = 3,00000000.0;
	this.SetSpeed_XY(this.flag5.vec.x * this.flag5.v, this.flag5.vec.y * this.flag5.v);
	this.subState = function ()
	{
		if (!this.initTable.charge && this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.func[0].call(this);
			return;
		}

		this.count++;

		if (this.count % 4 == 0)
		{
			this.SetFreeObject(this.x - 20 + this.rand() % 40, this.y + 20 - this.rand() % 40, this.direction, this.owner.Shot_Charge_Aura, {});
		}

		if (this.hitTarget.len() > 0)
		{
			this.Vec_Brake(100,00000000.0, 2,00000000.0);
		}

		if (this.motion == 2028)
		{
			this.HitCycleUpdate(2);
		}
		else
		{
			this.HitCycleUpdate(6);
		}
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion == 2020 && this.owner.keyTake == 0 || this.hitCount >= this.flag5.hitNum || this.grazeCount >= this.flag5.grazeNum || this.cancelCount <= 0 || this.IsScreen(300,00000000.0) || this.count >= this.flag5.preWait)
		{
			this.func[0].call(this);
			return;
		}

		this.flag5.v += 0,10000000.0;

		if (this.flag5.v >= 17,50000000.0)
		{
			this.flag5.v = 17,50000000.0;
		}

		this.SetSpeed_XY(this.flag5.vec.x * this.flag5.v, this.flag5.vec.y * this.flag5.v + 2,00000000.0 * this.sin(this.count * 3 * 0,01745329.0));
		this.count++;

		if (this.GetTargetDist(this.target) <= 40000,00000000.0 && this.count >= 30)
		{
			this.func[1].call(this);
		}

		if (this.hitCount >= this.flag5.hitNum || this.grazeCount >= this.flag5.grazeNum || this.cancelCount <= 0 || this.IsScreen(300,00000000.0) || this.count >= this.flag5.preWait)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(6);
		this.subState();
	};
}

function Shot_Charge_Aura( t )
{
	this.SetMotion(2028, 4 + this.rand() % 4);
	this.sx = 1,50000000.0 + this.rand() % 9 * 0,10000000.0;
	this.sy = 1,50000000.0 + this.rand() % 9 * 0,10000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.alpha = 0,00000000.0;
	this.red = this.rand() % 11 * 0,10000000.0;
	this.green = this.rand() % 11 * 0,10000000.0;
	this.blue = this.rand() % 11 * 0,10000000.0;
	this.SetSpeed_XY(0,00000000.0, this.rand() % 20 * -0,10000000.0);
	this.stateLabel = function ()
	{
		this.sx += 0,05000000.0;
		this.sy += 0,05000000.0;
		this.alpha += 0,20000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.sx += 0,05000000.0;
				this.sy += 0,05000000.0;
				this.alpha -= 0,07500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Shot_Charge_Hit( t )
{
	this.SetMotion(2028, 2);
	this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
	{
		this.SetMotion(2028, 3);
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,02500000.0;
			this.alpha -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	}, {});
	this.sx = this.sy = t.scale;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,92000002.0;
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function HighShot_Dash( t )
{
	this.SetMotion(1319, 2);
	this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
	this.cancelCount = 3;
	this.atk_id = 8192;
	this.sx = this.sy = 1,20000005.0;
	this.func = function ()
	{
		this.SetMotion(1319, 3);
		this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y);
		this.stateLabel = function ()
		{
			this.rz += 8,00000000.0 * 0,01745329.0;
			this.sx = this.sy += 0,05000000.0;
			this.VX_Brake(0,25000000.0);
			this.alpha -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.rx = -75 * 0,01745329.0;
	this.ry = -30,00000000.0 * this.direction * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.VX_Brake(1,25000000.0, 1,50000000.0 * this.direction);
		this.count++;
		this.rz += 16,00000000.0 * 0,01745329.0;
		this.HitCycleUpdate(1);

		if (this.count >= 30 || this.IsScreen(200) || this.hitCount >= 3 || this.cancelCount <= 0)
		{
			this.func();
		}
	};
}

function HighShot_DashB( t )
{
	this.SetMotion(1319, 0);
	this.SetSpeed_XY(15,00000000.0 * this.direction, t.vy);
	this.cancelCount = 3;
	this.atk_id = 8192;
	this.sx = this.sy = 1,20000005.0;
	this.func = function ()
	{
		this.SetMotion(1319, 1);
		this.SetSpeed_XY(this.va.x * 0,50000000.0, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.rz += 8,00000000.0 * 0,01745329.0;
			this.sx = this.sy += 0,05000000.0;
			this.VX_Brake(0,25000000.0);
			this.alpha -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.rx = -75 * 0,01745329.0;
	this.ry = -30,00000000.0 * this.direction * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.VX_Brake(1,25000000.0, 1,50000000.0 * this.direction);
		this.count++;
		this.rz += 16,00000000.0 * 0,01745329.0;
		this.HitCycleUpdate(1);

		if (this.count >= 30 || this.IsScreen(200) || this.hitCount >= 4 || this.cancelCount <= 0)
		{
			this.func();
		}
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.flag1 = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
	this.flag1 = this.Math_MinMax(this.flag1, -0,87266457.0, 0,87266457.0);
	this.rz -= 6,28318548.0;
	this.sy = 0,00000000.0;
	this.cancelCount = 3;
	this.func = function ()
	{
		this.SetMotion(3929, 2);
		this.sy -= 0,20000000.0;

		if (this.sy <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 3))
		{
			this.ReleaseActor();
			return;
		}

		this.rz += (this.flag1 - this.rz) * 0,20000000.0;
		this.sy += 0,10000000.0;

		if (this.sy > 1,00000000.0)
		{
			this.sy = 1,00000000.0;
		}

		this.count++;

		if (this.count == 20)
		{
			this.rz = this.flag1;
			this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
			this.SetMotion(3929, 1);
			this.PlaySE(2006);
			this.SetSpeed_Vec(30, this.rz, this.direction);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 3))
				{
					this.ReleaseActor();
					return;
				}

				if (this.cancelCount <= 0 || this.grazeCount > 0)
				{
					this.func();
					return;
				}
			};
		}
	};
}

function Shot_Change_Back( t )
{
	this.Shot_Change(t);
	this.DrawActorPriority(180);
}

function Grab_Hit_Effect( t )
{
	this.SetMotion(6010, 1);
	this.sx = this.sy = 0,25000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (4,50000000.0 - this.sx) * 0,10000000.0 < 0,01000000.0 ? 0,01000000.0 : (4,50000000.0 - this.sx) * 0,10000000.0;
		this.count++;

		if (this.count >= 12)
		{
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
	this.keyAction = [
		null,
		function ()
		{
		}
	];
}

function Okult_TimeAura( t )
{
	this.SetMotion(2509, t.type);
	this.rx = 125 * 0,01745329.0;
	this.DrawActorPriority(189);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				if (this.owner.flagState & -2147483648)
				{
					this.isVisible = false;
				}
				else
				{
					this.isVisible = true;
				}

				this.AddSpeed_XY(0,00000000.0, -0,05000000.0);
				this.rz += 7,50000000.0 * 0,01745329.0;
				this.sx = this.sy += 0,00500000.0;
				this.alpha -= 0,12500000.0;
				this.anime.radius1 += (-this.anime.radius1 + this.anime.radius0) * 0,04000000.0;
				this.anime.length *= 0,98000002.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.owner.styleTime <= 0)
			{
				this.ReleaseActor();
				return;
			}

			this.SetParent(this.owner, 0, 50);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.anime.length = 32;
			this.alpha = 0,00000000.0;
			this.ry = (25 - this.rand() % 51) * 0,01745329.0;
			this.rz = this.rand() % 360 * 0,01745329.0;
			this.anime.radius1 = 4;

			if (this.owner.styleTime >= 900)
			{
				this.sx = this.sy = 1,50000000.0;
			}
			else
			{
				this.sx = this.sy = 0,50000000.0 + this.owner.styleTime / 900,00000000.0;
			}

			this.stateLabel = function ()
			{
				if (this.owner.flagState & -2147483648)
				{
					this.isVisible = false;
				}
				else
				{
					this.isVisible = true;
				}

				this.AddSpeed_XY(0,00000000.0, -0,05000000.0);
				this.rz += 7,50000000.0 * 0,01745329.0;
				this.alpha += 0,02500000.0;
				this.sx = this.sy += 0,00500000.0;
				this.anime.radius1 += (-this.anime.radius1 + this.anime.radius0) * 0,04000000.0;
				this.anime.length *= 0,98000002.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.stateLabel = function ()
					{
						if (this.owner.flagState & -2147483648)
						{
							this.isVisible = false;
						}
						else
						{
							this.isVisible = true;
						}

						this.AddSpeed_XY(0,00000000.0, -0,05000000.0);
						this.rz += 7,50000000.0 * 0,01745329.0;
						this.sx = this.sy += 0,00500000.0;
						this.alpha -= 0,12500000.0;
						this.anime.radius1 += (-this.anime.radius1 + this.anime.radius0) * 0,04000000.0;
						this.anime.length *= 0,98000002.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.func[1].call(this);
						}
					};
				}
			};
		}
	];
	this.flag1 = 1,00000000.0;
	this.func[1].call(this);
}

function Okult_Aura( t )
{
	this.SetMotion(2509, t.take);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 0,50000000.0 + this.rand() % 33 * 0,01000000.0;
	this.sx *= 1,00000000.0 + this.rand() % 11 * 0,10000000.0;
	this.rz = (-10 + this.rand() % 31) * 0,01745329.0;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,15000001.0;
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
		this.alpha += 0,15000001.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.subState = function ()
			{
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, -0,10000000.0);
		this.subState();
		this.sx = this.sy *= 1,01499999.0;
	};
}

function Okult_AuraFront( t )
{
	this.SetMotion(2509, t.take);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 0,25000000.0;
	this.flag1 = 0,75000000.0 + this.rand() % 4 * 0,10000000.0;
	this.flag2 = 0,00000000.0;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,15000001.0;
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
		this.alpha += 0,25000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.subState = function ()
			{
				this.alpha -= 0,05000000.0;

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
		this.sx += (this.flag1 - this.sx) * 0,05000000.0;
		this.sy *= 1,14999998.0;
	};
}

function Okult_SelectEnd( t )
{
	if (t.rev)
	{
		if (this.direction == 1,00000000.0)
		{
			if (t.fake)
			{
				this.SetMotion(2505, ::config.lang == 0 ? 2 : 6);
			}
			else
			{
				this.SetMotion(2507, ::config.lang == 0 ? 2 : 6);
			}
		}
		else if (t.fake)
		{
			this.SetMotion(2505, ::config.lang == 0 ? 3 : 7);
		}
		else
		{
			this.SetMotion(2507, ::config.lang == 0 ? 3 : 7);
		}
	}
	else if (this.direction == 1,00000000.0)
	{
		if (t.fake)
		{
			this.SetMotion(2506, ::config.lang == 0 ? 2 : 6);
		}
		else
		{
			this.SetMotion(2508, ::config.lang == 0 ? 2 : 6);
		}
	}
	else if (t.fake)
	{
		this.SetMotion(2506, ::config.lang == 0 ? 3 : 7);
	}
	else
	{
		this.SetMotion(2508, ::config.lang == 0 ? 3 : 7);
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,10000000.0;
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Okult_Select( t )
{
	if (t.rev)
	{
		if (this.direction == 1,00000000.0)
		{
			if (t.fake)
			{
				this.SetMotion(2505, ::config.lang == 0 ? 0 : 4);
			}
			else
			{
				this.SetMotion(2507, ::config.lang == 0 ? 0 : 4);
			}
		}
		else
		{
			this.SetMotion(2507, ::config.lang == 0 ? 1 : 5);

			if (t.fake)
			{
				this.SetMotion(2505, ::config.lang == 0 ? 1 : 5);
			}
		}
	}
	else if (this.direction == 1,00000000.0)
	{
		if (t.fake)
		{
			this.SetMotion(2506, ::config.lang == 0 ? 0 : 4);
		}
		else
		{
			this.SetMotion(2508, ::config.lang == 0 ? 0 : 4);
		}
	}
	else
	{
		this.SetMotion(2508, ::config.lang == 0 ? 1 : 5);

		if (t.fake)
		{
			this.SetMotion(2506, ::config.lang == 0 ? 1 : 5);
		}
	}

	this.DrawActorPriority(300);

	if (this.y < ::battle.scroll_top + 200)
	{
		this.Warp(this.x, ::battle.scroll_top + 200);
	}

	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.red = this.green = this.blue = 0,50000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,15000001.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			local t_ = {};
			t_.fake <- this.initTable.fake;
			t_.rev <- this.initTable.rev;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Okult_SelectEnd, t_);
			this.red = this.green = this.blue = 2,00000000.0;
			this.sx = this.sy = 2,00000000.0;
			this.count = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,15000001.0;

				if (this.red > 1,00000000.0)
				{
					this.red = this.green = this.blue -= 0,05000000.0;
				}

				this.count++;

				if (this.count == 60)
				{
					this.stateLabel = function ()
					{
						this.red = this.green = this.blue += 0,05000000.0;
						this.sx += 0,25000000.0;
						this.sy *= 0,80000001.0;
						this.alpha -= 0,05000000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.sx < 1,00000000.0)
				{
					this.sx = this.sy += 0,10000000.0;
				}

				if (this.red < 1,00000000.0)
				{
					this.red = this.green = this.blue += 0,10000000.0;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.sx > 0,69999999.0)
				{
					this.sx = this.sy -= 0,10000000.0;
				}

				if (this.red > 0,50000000.0)
				{
					this.red = this.green = this.blue -= 0,10000000.0;
				}
			};
		}
	];
	this.sx = this.sy = 0,69999999.0;
	this.stateLabel = function ()
	{
		if (this.sx < 1,00000000.0)
		{
			this.sx = this.sy += 0,10000000.0;
		}
	};
}

function SPShot_A( t )
{
	this.SetMotion(6000, 0);
	this.keyAction = this.ReleaseActor;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.stateLabel = function ()
	{
		if (!(this.owner.motion == 3000 && this.owner.keyTake <= 1))
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = null;
		}
	};
}

function SPShot_A_Dummy( t )
{
	this.SetMotion(6001, 0);
	this.DrawActorPriority(190);
}

function SPShot_B( t )
{
	this.SetMotion(6010, 1);
	this.cancelCount = 3;
	this.atk_id = 2097152;
	this.sx = this.sy = 0,25000000.0;
	this.flag1 = t.type;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (4,50000000.0 - this.sx) * 0,10000000.0 < 0,01000000.0 ? 0,01000000.0 : (4,50000000.0 - this.sx) * 0,10000000.0;
		this.count++;

		if (this.count >= 12)
		{
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			switch(this.flag1)
			{
			case 2:
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_B3_Slash, {});
				break;

			case 1:
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_B2_Slash, {});
				break;

			default:
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_B_Slash, {});
				break;
			}
		}
	];
}

function SPShot_B_Slash( t )
{
	this.SetMotion(6010, 0);
	this.rz = -45,00000000.0 * 0,01745329.0;
	this.sx = this.sy = 0,00000000.0;
	this.flag1 = 0;
	this.flag2 = 8;
	this.flag3 = 8;

	if (this.owner.style == 2)
	{
		this.flag3 = 2;
		this.flag4 = true;
	}

	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,98000002.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.owner.IsDamage())
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

		this.sx = this.sy += (1,50000000.0 - this.sx) * 0,30000001.0 < 0,00500000.0 ? 0,00500000.0 : (1,50000000.0 - this.sx) * 0,30000001.0;
		this.count++;

		if (this.count >= this.flag3)
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.sx = this.sy += (1,50000000.0 - this.sx) * 0,30000001.0 < 0,00500000.0 ? 0,00500000.0 : (1,50000000.0 - this.sx) * 0,30000001.0;
				this.count++;

				if (this.count % 2 == 1 && this.flag1 <= this.flag2)
				{
					if (this.flag1 == 0)
					{
						this.PlaySE(2103);
						local t_ = {};
						t_.rot <- 0,00000000.0;
						t_.style <- this.flag4;
						this.SetShot(this.x, this.y, this.direction, this.owner.SPShot_B_Laser, t_);
						this.flag1++;
					}
					else
					{
						local t_ = {};
						t_.rot <- this.flag1 * 0,01745329.0;
						t_.style <- this.flag4;
						this.SetShot(this.x + 5 * this.flag1 * this.direction, this.y + 5 * this.flag1, this.direction, this.owner.SPShot_B_Laser, t_);
						local t_ = {};
						t_.rot <- -this.flag1 * 0,01745329.0;
						t_.style <- this.flag4;
						this.SetShot(this.x - 5 * this.flag1 * this.direction, this.y - 5 * this.flag1, this.direction, this.owner.SPShot_B_Laser, t_);
						this.flag1++;
					}
				}

				if (this.count == 30)
				{
					this.func();
				}
			};
		}
	};
}

function SPShot_B2_Slash( t )
{
	this.SetMotion(6010, 0);
	this.rz = -45,00000000.0 * 0,01745329.0;
	this.sx = this.sy = 0,00000000.0;
	this.flag1 = 0;
	this.flag2 = 8;

	if (this.owner.popularLevel == -1)
	{
		this.flag2 = 6;
	}

	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,98000002.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.owner.IsDamage())
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

		this.sx = this.sy += (1,50000000.0 - this.sx) * 0,30000001.0 < 0,00500000.0 ? 0,00500000.0 : (1,50000000.0 - this.sx) * 0,30000001.0;
		this.count++;

		if (this.count >= 8)
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.count++;

				if (this.count % 2 == 1 && this.flag1 <= this.flag2)
				{
					if (this.flag1 == 0)
					{
						this.PlaySE(2103);
						local t_ = {};
						t_.rot <- 0,00000000.0;
						this.SetShot(this.x, this.y, this.direction, this.owner.SPShot_B_Laser, t_);
						this.flag1++;
					}
					else
					{
						local t_ = {};
						t_.rot <- 0,00000000.0;
						this.SetShot(this.x + 5 * this.flag1 * this.direction, this.y + 5 * this.flag1, this.direction, this.owner.SPShot_B_Laser, t_);
						local t_ = {};
						t_.rot <- 0,00000000.0;
						this.SetShot(this.x - 5 * this.flag1 * this.direction, this.y - 5 * this.flag1, this.direction, this.owner.SPShot_B_Laser, t_);
						this.flag1++;
					}
				}

				if (this.count == 30)
				{
					this.stateLabel = function ()
					{
						this.sx = this.sy *= 0,98000002.0;
						this.alpha = this.green = this.blue -= 0,07500000.0;

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

function SPShot_B3_Slash( t )
{
	this.SetMotion(6010, 0);
	this.rz = -45,00000000.0 * 0,01745329.0;
	this.sx = this.sy = 0,00000000.0;
	this.flag1 = 0;
	this.flag2 = 8;

	if (this.owner.popularLevel == -1)
	{
		this.flag2 = 6;
	}

	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,98000002.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.owner.IsDamage())
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

		this.sx = this.sy += (1,50000000.0 - this.sx) * 0,30000001.0 < 0,00500000.0 ? 0,00500000.0 : (1,50000000.0 - this.sx) * 0,30000001.0;
		this.count++;

		if (this.count >= 8)
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.count++;

				if (this.count % 2 == 1 && this.flag1 <= this.flag2)
				{
					if (this.flag1 == 0)
					{
						this.PlaySE(2103);
						local t_ = {};
						t_.rot <- 0,00000000.0;
						this.SetShot(this.x, this.y, this.direction, this.owner.SPShot_B_Laser, t_);
						this.flag1++;
					}
					else
					{
						local t_ = {};
						t_.rot <- this.flag1 * 0,01745329.0 * 2;
						this.SetShot(this.x + 5 * this.flag1 * this.direction, this.y + 5 * this.flag1, this.direction, this.owner.SPShot_B_Laser, t_);
						local t_ = {};
						t_.rot <- -this.flag1 * 0,01745329.0 * 2;
						this.SetShot(this.x - 5 * this.flag1 * this.direction, this.y - 5 * this.flag1, this.direction, this.owner.SPShot_B_Laser, t_);
						this.flag1++;
					}
				}

				if (this.count == 30)
				{
					this.stateLabel = function ()
					{
						this.sx = this.sy *= 0,98000002.0;
						this.alpha = this.green = this.blue -= 0,07500000.0;

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

function SPShot_B_Laser( t )
{
	this.rz = t.rot;
	this.sy = 0,00000000.0;
	this.cancelCount = 1;
	this.atk_id = 2097152;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

	if (t.style)
	{
		this.SetMotion(6012, 4);
	}
	else
	{
		this.SetMotion(6011, 4);
	}

	this.stateLabel = function ()
	{
		this.count++;
		this.sy += 0,10000000.0;

		if (this.count >= 8)
		{
			this.count = 0;
			this.SetMotion(this.motion, 3);
			this.sy = 3,00000000.0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 5 || this.cancelCount <= 0)
				{
					this.callbackGroup = 0;
					this.stateLabel = function ()
					{
						this.sy *= 0,92500001.0;
						this.alpha = this.green = this.blue -= 0,02500000.0;

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

function SPShot_C( t )
{
	this.SetMotion(3039, t.type);
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	local t_ = {};
	t_.rot <- this.rz;
	this.atk_id = 4194304;
	this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_C_Sol, t_);
	this.func = function ()
	{
		this.SetMotion(3039, 8);
		this.callbackGroup = 0;
		this.keyAction = this.ReleaseActor;
	};
}

function SPShot_C_Root( t )
{
	this.SetMotion(3039, 7);
	this.keyAction = this.ReleaseActor;
	this.cancelCount = 3;
	this.atk_id = 4194304;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.cancelCount <= 0 || this.owner.IsDamage() || this.count >= 30)
		{
			foreach( a in this.initTable.list )
			{
				if (a)
				{
					a.func();
				}
			}

			this.ReleaseActor();
			return;
		}
	};
}

function SPShot_C_Sol( t )
{
	this.SetMotion(3039, 6);
	this.DrawActorPriority(195);
	this.rz = t.rot;
	this.flag1 = 0,34999999.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += this.flag1;
		this.flag1 *= 0,89999998.0;
		this.count++;

		if (this.count >= 20)
		{
			this.alpha -= 0,03000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SPShot_D( t )
{
	this.SetMotion(3049, 0);
	this.flag1 = [];
	this.option = [];
	this.cancelCount = 3;
	this.atk_id = 8388608;

	for( local i = 0; i < 6; i++ )
	{
		local t_ = {};
		t_.rot <- i * 60,00000000.0 * 0,01745329.0;
		t_.range <- 150,00000000.0;
		t_.style <- 0;
		local a_ = this.SetShot(this.x + 150,00000000.0 * this.cos(t_.rot) * this.direction, this.y + 150,00000000.0 * this.sin(t_.rot), this.direction, this.SPShot_D_Ring, t_, this.weakref());
		a_.hitOwner = this.weakref();
		this.option.append(a_);
	}

	this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_D_Flash, {});
	this.func = function ()
	{
		foreach( a in this.option )
		{
			a.func();
		}

		this.SetKeyFrame(1);
		this.count = 0;
		this.stateLabel = function ()
		{
			this.count++;

			if (this.count >= 30)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.flag2 += 8,50000000.0 * 0,01745329.0;
		this.HitCycleUpdate(12);
		this.count++;

		if (this.cancelCount <= 0 || this.count >= 60 || this.owner.motion == 3040 && this.owner.keyTake == 0 || this.Damage_ConvertOP(this.x, this.y, 10))
		{
			this.func();
		}
	};
}

function SPShot_D_High( t )
{
	this.SetMotion(3049, 0);
	this.flag1 = [];
	this.flag2 = 0,00000000.0;
	this.sx = this.sy = 1,20000005.0;
	this.option = [];
	this.cancelCount = 3;
	this.atk_id = 8388608;

	for( local i = 0; i < 6; i++ )
	{
		local t_ = {};
		t_.rot <- i * 60,00000000.0 * 0,01745329.0;
		t_.range <- 180,00000000.0;
		t_.style <- 2;
		local a_ = this.SetShot(this.x + t_.range * this.cos(t_.rot) * this.direction, this.y + t_.range * this.sin(t_.rot), this.direction, this.SPShot_D_Ring, t_, this.weakref());
		a_.hitOwner = this.weakref();
		this.option.append(a_);
	}

	for( local i = 0; i < 6; i++ )
	{
		local t_ = {};
		t_.rot <- i * 60,00000000.0 * 0,01745329.0;
		t_.range <- 150,00000000.0;
		t_.style <- 2;
		local a_ = this.SetShot(this.x + t_.range * this.cos(t_.rot) * this.direction, this.y + t_.range * this.sin(t_.rot), this.direction, this.SPShot_D_Ring, t_, this.weakref());
		a_.hitOwner = this.weakref();
		this.option.append(a_);
	}

	this.func = function ()
	{
		foreach( a in this.option )
		{
			a.func();
		}

		this.count = 0;
		this.SetKeyFrame(1);
		this.stateLabel = function ()
		{
			this.count++;

			if (this.count >= 30)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.flag2 += 8,50000000.0 * 0,01745329.0;
		this.HitCycleUpdate(12);
		this.count++;

		if (this.cancelCount <= 0 || this.count >= 90 || this.owner.motion == 3040 && this.owner.keyTake == 0 || this.Damage_ConvertOP(this.x, this.y, 10))
		{
			this.func();
		}
	};
}

function SPShot_D_Ring( t )
{
	if (t.style == 2)
	{
		this.SetMotion(3049, 5);
	}
	else
	{
		this.SetMotion(3049, 1);
	}

	this.cancelCount = 3;
	this.atk_id = 8388608;
	this.flag1 = 0;
	this.rz = this.initTable.pare.rz + this.initTable.rot;
	this.func = function ()
	{
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
		this.rz = this.initTable.pare.flag2 + this.initTable.rot;
		this.Warp(this.initTable.pare.x + this.initTable.range * this.cos(this.rz) * this.direction, this.initTable.pare.y + this.initTable.range * this.sin(this.rz));
	};
}

function SPShot_D_Pure( t )
{
	this.SetMotion(3049, 3);
	this.sx = this.sy = t.scale;
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		if (this.owner.motion == 3040)
		{
			this.Warp(this.owner.point0_x, this.owner.point0_y);
		}
	};
}

function SPShot_D_Flash( t )
{
	this.SetMotion(3049, 4);
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

function SPShot_E( t )
{
	if (t.type == 0)
	{
		this.SetMotion(6060, 0);
		this.cancelCount = 1;
	}
	else
	{
		this.SetMotion(6061, 0);
		this.cancelCount = 2;
	}

	this.rz = t.rot;
	this.sx = this.sy -= this.rand() % 20 * 0,01000000.0;
	this.FitBoxfromSprite();
	this.SetSpeed_Vec(40,00000000.0, this.rz, this.direction);
	this.cancelCount = 1;
	this.atk_id = 16777216;
	local t_ = {};
	t_.rot <- this.rz;
	this.flag1 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, function ( t_ )
	{
		this.SetMotion(6060, 1);
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
			this.sx += (2,00000000.0 - this.sx) * 0,10000000.0;
		};
	}, t_).weakref();
	this.flag1.SetParent(this, 0, 0);
	this.DrawActorPriority(200);
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func();
			}

			this.flag1 = null;
			this.callbackGroup = 0;
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

		if (this.cancelCount <= 0 || this.Damage_ConvertOP(this.x + this.va.x * 10, this.y + this.va.y * 10, 1))
		{
			this.func[0].call(this);
			return true;
		}
	};
}

function SPShot_E_Light( t )
{
	this.SetMotion(6060, 2);
	this.rz = t.rot;
	this.sy = 0,00000000.0;
	this.flag1 = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sy += (1,00000000.0 - this.sy) * 0,15000001.0;
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
		if (this.owner.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		this.count++;

		if (this.count == this.initTable.count)
		{
			this.PlaySE(2115);
		}

		if (this.count >= this.initTable.count && this.initTable.num > 0)
		{
			this.initTable.num--;
			local t_ = {};
			t_.rot <- this.rz + this.flag1;
			t_.type <- this.initTable.type;
			this.SetShot(this.x, this.y, this.direction, this.SPShot_E, t_);
			this.flag1 += this.flag1 < 0,00000000.0 ? -this.flag1 * 2,00000000.0 : -(this.flag1 + 1,50000000.0 * 0,01745329.0) * 2;
		}

		this.sy += (1,00000000.0 - this.sy) * 0,15000001.0;
		this.alpha -= 0,03300000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_E_LightB( t )
{
	this.SetMotion(6060, 2);
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

function SPShot_F( t )
{
	this.SetMotion(3079, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.cancelCount = 3;
	this.sx = this.sy = 0,30000001.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetKeyFrame(3);
		},
		function ()
		{
			this.HitReset();
			this.SetKeyFrame(2);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (3,00000000.0 - this.sx) * 0,25000000.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.sx = this.sy += 0,02000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.hitCount <= 2)
		{
			this.HitCycleUpdate(5);
		}
	};
}

function SPShot_F_Blue( t )
{
	this.SetMotion(3079, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.cancelCount = 3;
	this.sx = this.sy = 0,50000000.0;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetKeyFrame(3);
		},
		function ()
		{
			this.HitReset();
			this.SetKeyFrame(2);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2,50000000.0 - this.sx) * 0,25000000.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.sx = this.sy += (2,50000000.0 - this.sx) * 0,07500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.hitCount <= 2)
		{
			this.HitCycleUpdate(5);
		}
	};
}

function SpellShot_B( t )
{
	this.SetMotion(7010, 0);
	this.DrawActorPriority(180);
	this.sx = this.sy = 0,00000000.0;
	this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_B_SunRing, {});
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
		if (this.owner.motion == 4010)
		{
			if (this.owner.keyTake <= 3)
			{
				this.count++;

				if (this.count % 20 == 1)
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_B_Ring, {});
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

function SpellShot_B_Ray( t )
{
	this.rz = t.rot;
	this.cancelCount = 1;
	this.atk_id = 67108864;

	if (this.sin(this.rz) > 0,00000000.0)
	{
		this.SetMotion(7010, 3);
	}
	else
	{
		this.SetMotion(7010, 4);
	}

	this.sy = 0,00000000.0;
	this.atkRate_Pat = t.rate;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.flag1 = this.callbackGroup;
	this.callbackGroup = 0;
	this.func = [
		function ()
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
		}
	];
	this.stateLabel = function ()
	{
		this.sy += 0,05000000.0;

		if (this.sy >= 0,10000000.0)
		{
			this.callbackGroup = this.flag1;
			this.stateLabel = function ()
			{
				if (this.hitCount == 0)
				{
					this.HitCycleUpdate(1);
				}

				this.count++;
				this.sy += (1,00000000.0 - this.sy) * 0,10000000.0;
				this.SetCollisionScaling(this.sx, this.sy * 2, 1,00000000.0);

				if (this.owner.motion == 4010)
				{
					this.Warp(this.owner.x, this.owner.y);
				}
				else
				{
					this.func[0].call(this);
				}

				if (this.count >= 30 || this.cancelCount <= 0)
				{
					this.func[0].call(this);
				}
			};
		}
	};
}

function SpellShot_B_SunRing( t )
{
	this.SetMotion(7010, 2);
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
		if (this.owner.motion == 4010)
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

function SpellShot_B_Ring( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(7010, 1);
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

function SpellShot_C( t )
{
	this.SetMotion(7020, 0);
	this.EnableTimeStop(false);
	this.flag1 = [];
	local t_ = {};
	this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_Cb, t_, this.weakref());
	this.flag3 = t.rate;
	this.flag4 = 0;
	this.sx = this.sy = 0,10000000.0;
	this.subState = function ()
	{
		if (this.count % 10 == 0)
		{
			this.flag4++;
			local t_ = {};
			t_.rate <- this.flag3;
			t_.rot <- this.owner.spellB_Pat[this.flag4 % 24].z;
			t_.range <- this.owner.spellB_Pat[this.flag4 % 24].x;
			t_.y <- this.owner.spellB_Pat[this.flag4 % 24].y;
			t_.rotSpeed <- 2,00000000.0 * 0,01745329.0;
			this.flag1.append(this.SetShot(this.x, this.y, this.direction, this.SpellShot_C_Star, t_, this.weakref()).weakref());
		}
	};
	this.func = [
		function ()
		{
			this.team.spell_enable_end = true;

			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			this.EnableTimeStop(true);
			this.flag2.EnableTimeStop(true);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,97000003.0;
				this.flag2.sx = this.flag2.sy = this.sx;
				this.flag2.alpha = this.alpha -= 0,05000000.0;

				if (this.flag2)
				{
					this.flag2.sx = this.flag2.sy = this.sx;
					this.Warp.call(this.flag2, this.x, this.y);
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor.call(this.flag2);
					this.flag2 = null;
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.flag3 = this.owner.atkRate_Pat;
			this.EnableTimeStop(true);
			this.flag2.EnableTimeStop(true);
			this.stateLabel = function ()
			{
				this.count++;
				this.AddSpeed_Vec(0,25000000.0, 20,00000000.0 * 0,01745329.0, 3,00000000.0, this.direction);
				this.subState();

				if (this.count >= 360)
				{
					this.func[0].call(this);
				}

				if (this.flag2)
				{
					this.flag2.sx = this.flag2.sy = this.sx;
					this.Warp.call(this.flag2, this.x, this.y);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion == 4020)
		{
			this.sx += (1,00000000.0 - this.sx) * 0,02500000.0;
			this.sy = this.sx;

			if (this.owner.keyTake >= 2)
			{
				this.subState();
			}

			this.SetSpeed_XY((this.owner.point0_x - this.x) * 0,05000000.0, (this.owner.point0_y - this.y) * 0,05000000.0);
		}
		else
		{
			this.func[0].call(this);
		}

		if (this.flag2)
		{
			this.flag2.sx = this.flag2.sy = this.sx;
			this.Warp.call(this.flag2, this.x, this.y);
		}
	};
}

function SpellShot_Cb( t )
{
	this.EnableTimeStop(false);
	this.SetMotion(7020, 3);
	this.sx = this.sy = 0,10000000.0;
	this.stateLabel = function ()
	{
		this.rz -= 0,01745329.0;
	};
}

function SpellShot_C_Star( t )
{
	this.SetMotion(7020, 1);
	this.atkRate_Pat = t.rate;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 20 * 0,01000000.0;
	this.initTable.range += 100 - this.abs(this.initTable.y);
	this.cancelCount = 1;
	this.atk_id = 67108864;
	this.Warp(this.initTable.pare.x + this.initTable.range * this.initTable.pare.sx * this.cos(this.initTable.rot) * this.direction, this.initTable.pare.y + this.initTable.y + this.initTable.range * this.initTable.pare.sx * 0,20000000.0 * this.sin(this.initTable.rot));
	this.subState = function ()
	{
		this.initTable.rot += this.initTable.rotSpeed;
		this.Warp(this.initTable.pare.x + this.initTable.range * this.initTable.pare.sx * this.cos(this.initTable.rot) * this.direction, this.initTable.pare.y + this.initTable.y + this.initTable.range * this.initTable.pare.sx * 0,20000000.0 * this.sin(this.initTable.rot));
	};
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
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
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.subState();
		this.alpha += 0,10000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.count++;

		if (this.count >= 120 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
		}
	};
}

function SpellShot_D( t )
{
	this.sy = 0,01000000.0;

	if (t.type == 1)
	{
		this.SetMotion(7030, 1);
	}
	else
	{
		this.SetMotion(7030, 0);
	}

	this.atk_id = 67108864;
	this.FitBoxfromSprite();
	this.atkRate_Pat = t.rate;
	this.cancelCount = 99;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
	{
		this.callbackGroup = 0;
		this.func = function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,98000002.0;
				this.alpha = this.green = this.blue -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		};
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,02500000.0;
			this.count++;

			if (this.count % 6 == 0)
			{
				this.rz = this.rand() % 360 * 0,01745329.0;
			}
		};
	}, {}).weakref();
	this.func = [
		function ()
		{
			this.SetKeyFrame(2);
			this.keyAction = this.ReleaseActor;
			this.callbackGroup = 0;

			if (this.flag1)
			{
				this.flag1.func();
			}

			this.stateLabel = function ()
			{
				this.sy *= 0,80000001.0;
			};
		}
	];
	this.subState = function ()
	{
		this.sy += (1,00000000.0 - this.sy) * 0,10000000.0;

		if (this.sy > 0,98000002.0)
		{
			this.subState = function ()
			{
				this.sy += 0,00500000.0;
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion == 4030 || this.owner.motion == 4031)
		{
			if (this.subState)
			{
				this.subState();
			}

			this.FitBoxfromSprite();
			this.HitCycleUpdate(6);

			if (this.flag1)
			{
				this.Warp.call(this.flag1, this.x, this.y);
			}
		}
		else
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Climax_Shot( t )
{
	this.SetMotion(4909, 0);
	this.DrawActorPriority(210);
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
	};
}

function Climax_CutIn( t )
{
	this.SetMotion(4909, 3);
	this.DrawActorPriority(170);
	this.alpha = this.red = this.green = this.blue = 0,00000000.0;
	this.sx = this.sy = 0,50000000.0;
	this.stateLabel = function ()
	{
		this.alpha = this.red = this.green = this.blue += 0,01500000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = this.red = this.green = this.blue = 1,00000000.0;
		}

		this.sx = this.sy += 0,00150000.0;
	};
}

function Climax_Blade( t )
{
	this.SetMotion(4909, 6);

	if (this.direction == -1,00000000.0)
	{
		this.SetMotion(4909, 8);
	}

	this.DrawActorPriority(220);
	this.rz = 60 * 0,01745329.0;
	this.x -= 500 * 0,50000000.0 * this.direction;
	this.y -= 500 * 0,86600000.0;
	this.SetSpeed_XY(150 * 0,50000000.0 * this.direction, 150 * 0,86600000.0);
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(this.va.x * 0,88000000.0, this.va.y * 0,88000000.0);
		this.AddSpeed_XY(0,50000000.0 * this.direction * 0,20000000.0, 0,86600000.0 * 0,20000000.0);
		this.count++;

		if (this.count % 2 == 1)
		{
			this.SetFreeObject(this.x - 20 + this.rand() % 40, this.y - 20 + this.rand() % 40, this.direction, function ( t )
			{
				this.rz = 60 * 0,01745329.0;
				this.SetMotion(4909, 6);

				if (this.direction == -1,00000000.0)
				{
					this.SetMotion(4909, 8);
				}

				this.DrawActorPriority(220);
				this.SetSpeed_XY(20 * 0,50000000.0 * this.direction - 10 * this.direction, 20 * 0,86600000.0);
				this.stateLabel = function ()
				{
					this.alpha -= 0,05000000.0;
					this.sy *= 0,89999998.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}, {});
		}

		if (this.count >= 90)
		{
			this.alpha -= 0,02500000.0;
			this.sy *= 0,98000002.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_Red( t )
{
	this.SetMotion(4909, 4);
	this.DrawScreenActorPriority(220);
	this.func = [
		function ()
		{
			this.ReleaseActor();
			this.func[0] = null;
			this.flag1.Foreach(function ()
			{
				if (this.func[0])
				{
					this.func[0].call(this);
				}
			});
		}
	];
	this.stateLabel = function ()
	{
		if (this.x < 640)
		{
			this.x += 60;
		}
	};
}

function Climax_Blue( t )
{
	this.SetMotion(4909, 5);
	this.DrawScreenActorPriority(220);
	this.func = [
		function ()
		{
			this.ReleaseActor();
			this.func[0] = null;
			this.flag1.Foreach(function ()
			{
				if (this.func[0])
				{
					this.func[0].call(this);
				}
			});
		}
	];
	this.stateLabel = function ()
	{
		if (this.x > 640)
		{
			this.x -= 60;
		}
	};
}

function Climax_Capture( t )
{
	this.SetMotion(4909, 1);
	this.DrawActorPriority(210);
	this.target = this.owner.target.weakref();
	this.SetParent(this.target, 0, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
			this.func[0] = null;
			this.flag1.Foreach(function ()
			{
				if (this.func[0])
				{
					this.func[0].call(this);
				}
			});
		}
	];
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.alpha = this.red = this.green = this.blue = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;
		this.rz -= 1,00000000.0 * 0,01745329.0;
		this.alpha = this.red = this.green = this.blue += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = this.red = this.green = this.blue = 1,00000000.0;
		}

		this.sx = this.sy = 0,75000000.0 + 0,05000000.0 * this.sin(this.count * 4 * 0,01745329.0);

		if (this.count % 12 == 1)
		{
			this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.owner.Climax_CaptureAura, {}));
		}
	};
}

function Climax_CaptureAura( t )
{
	this.SetMotion(4909, 1);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.DrawActorPriority(180);
	this.target = this.owner.target.weakref();
	this.sx = this.sy = 0,80000001.0;
	this.alpha = 0,00000000.0;
	this.SetParent(this.target, 0, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
			this.func[0] = null;
		}
	];
	this.subState = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
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
		this.sx = this.sy += 0,00250000.0;
		this.subState();
	};
}

