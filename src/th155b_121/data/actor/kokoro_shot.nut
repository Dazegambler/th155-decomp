function BeginBattle_Fire( t )
{
	this.SetMotion(9000, 9);
	this.func = function ()
	{
		this.SetSpeed_XY(0,00000000.0, -10,00000000.0);
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
		this.Warp(this.owner.x, this.owner.y);
	};
}

function BattleBegin_Mask( t )
{
	this.SetMotion(9000, t.type);
	this.flag1 = {};
	this.flag1.radius <- 600,00000000.0;
	this.flag1.yaw <- 0,00000000.0;
	this.flag1.pitch <- 0,00000000.0;
	this.flag1.rot <- t.rot;
	this.flag2 = this.Vector3();
	this.flag3 = 0,00000000.0;
	this.flag4 = 0,00000000.0;
	this.alpha = 0,00000000.0;
	this.subState = function ()
	{
		this.flag2.x = this.flag1.radius * this.cos(this.flag1.rot) * this.direction;
		this.flag2.y = this.flag1.radius * this.sin(this.flag1.rot);

		if (this.flag2.y <= 0,00000000.0)
		{
			this.ConnectRenderSlot(::graphics.slot.actor, 180);
		}
		else
		{
			this.ConnectRenderSlot(::graphics.slot.actor, 210);
		}

		this.flag2.y *= 0,10000000.0;
		this.flag2.RotateByRadian(this.flag1.yaw);
		this.flag2.x += this.owner.x;
		this.flag2.y += this.owner.y;
		this.Warp(this.flag2.x, this.flag2.y + this.flag3);
	};
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.flag1.radius += (115 - this.flag1.radius) * 0,15000001.0;
		this.flag1.rot += 2,00000000.0 * 0,01745329.0;
		this.subState();
	};
	this.func = function ()
	{
		this.SetMotion(9000, 10);
		this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
		this.flag4 = -10 - this.rand() % 15;
		this.stateLabel = function ()
		{
			this.flag3 += this.flag4;
			this.flag1.radius += 10;
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
				return;
			}

			this.subState();
		};
	};
}

function MaskObject( t )
{
	this.flag1 = 0,00000000.0;
	this.flag2 = this.Vector3();

	switch(this.initTable.type)
	{
	case 1:
		this.SetMotion(5990, 1);
		break;

	case 2:
		this.SetMotion(5990, 2);
		break;

	case 3:
		this.SetMotion(5990, 3);
		break;

	default:
		this.SetMotion(5990, 0);
		break;
	}

	this.stateLabel = function ()
	{
		local a_ = this.owner;
		this.flag1 += (115 - this.flag1) * 0,15000001.0;
		this.flag2.x = this.flag1 * this.cos(a_.maskRot + this.initTable.rot) * this.direction;
		this.flag2.y = this.flag1 * this.sin(a_.maskRot + this.initTable.rot);

		if (this.sin(a_.maskRot + this.initTable.rot) < 0,00000000.0)
		{
			if (this.drawPriority == 200)
			{
				this.DrawActorPriority(180);
			}
		}
		else if (this.drawPriority == 180)
		{
			this.DrawActorPriority(200);
		}

		this.flag2.y *= 0,50000000.0 + this.sin(a_.maskPitch) * 0,50000000.0;
		this.flag2.RotateByRadian(a_.maskYaw);
		this.flag2.x += this.team.current.x;
		this.flag2.y += this.team.current.y;
		this.direction = this.owner.direction;
		this.SetSpeed_XY((this.flag2.x - this.x) * 0,20000000.0, (this.flag2.y - this.y) * 0,20000000.0);
		local r_ = this.va.LengthXY();

		if (r_ <= 10,00000000.0)
		{
			this.flag5 = true;
		}

		if (r_ > 20,00000000.0)
		{
			this.va.Normalize();
			this.SetSpeed_XY(this.va.x * 20,00000000.0, this.va.y * 20,00000000.0);
		}
	};
	this.func = [
		function ()
		{
			switch(this.initTable.type)
			{
			case 1:
				this.SetMotion(5990, 1);
				break;

			case 2:
				this.SetMotion(5990, 2);
				break;

			case 3:
				this.SetMotion(5990, 3);
				break;

			default:
				this.SetMotion(5990, 0);
				break;
			}

			this.flag1 = 0,01745329.0 * (5 - this.rand() % 10);
			this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
			this.stateLabel = function ()
			{
				this.rz += this.flag1;
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function EmotionChange_Aura( t )
{
	this.flag1 = this.Vector3();
	this.SetMotion(6900, t.keyTake);
	this.DrawActorPriority(180);
	this.sx = this.sy = 0,25000000.0;
	this.flag2 = -22,00000000.0;
	local t_ = {};
	t_.keyTake <- this.keyTake;
	this.SetFreeObject(this.owner.x, this.owner.y, 1,00000000.0, function ( tab_ )
	{
		this.SetMotion(6902, tab_.keyTake);
		this.flag1 = 0,25000000.0;
		this.sx = this.sy = 0,00000000.0;
		this.stateLabel = function ()
		{
			this.Warp(this.owner.x, this.owner.y);
			this.sx = this.sy += this.flag1;
			this.flag1 *= 0,92000002.0;
			this.alpha -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	}, t_);
	this.stateLabel = function ()
	{
		if (this.count % 6 == 0 && this.count <= 18)
		{
			local t_ = {};
			t_.keyTake <- this.keyTake;
			this.SetFreeObject(this.owner.x, this.owner.y + 80, 1,00000000.0, this.EmotionChange_AuraB, t_);
		}

		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,25000000.0;
		this.flag1.y += this.flag2;
		this.flag2 *= 0,85000002.0;
		this.Warp(this.owner.x, this.owner.y + this.flag1.y);
		this.count++;

		if (this.count >= 25)
		{
			this.alpha -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function EmotionChange_AuraB( t )
{
	this.SetMotion(6901, t.keyTake);
	this.sx = 0,10000000.0 + this.rand() % 25 * 0,01000000.0;
	this.sy = 0,10000000.0 + this.rand() % 25 * 0,01000000.0;

	if (this.rand() % 100 <= 50)
	{
		this.direction = -this.direction;
	}

	this.ry = this.rand() % 45 * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.Warp(this.owner.x, this.owner.y + 80);
		this.sx = this.sy += 0,10000000.0;
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function NormalShot( t )
{
	this.DrawActorPriority(200);
	this.SetMotion(2006, this.keyTake);
	this.atk_id = 16384;
	this.direction = this.owner.direction;
	local r_ = 0,00000000.0;

	if (t.rot == 0,00000000.0)
	{
		r_ = this.GetTargetAngle(this.owner.target, this.direction);
		r_ = this.Math_MinMax(r_, -30,00000000.0 * 0,01745329.0, 30,00000000.0 * 0,01745329.0);
	}
	else
	{
		r_ = t.rot;
	}

	this.SetSpeed_Vec(15,00000000.0, r_, this.direction);
	this.cancelCount = 3;
	this.hitCount = 0;
	this.HitReset();
	this.flag5 = false;
	this.count = 0;
	this.stateLabel = function ()
	{
		this.TargetHoming(this.owner.target, 2,00000000.0 * 0,01745329.0, this.direction);
		this.count++;

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.IsScreen(100,00000000.0) || this.count >= 75 || this.Damage_ConvertOP(this.x, this.y, 3))
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.owner.MaskObject.call(this, null);
			return;
		}
	};
}

function NormalShot_Aura( t )
{
	this.SetMotion(t.motion, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 1,50000000.0 + this.rand() % 20 * 0,10000000.0;
	this.flag1 = (-4,00000000.0 + this.rand() % 9) * 0,01745329.0;
	this.SetSpeed_XY(-2,00000000.0 + this.rand() % 40 * 0,10000000.0, -2,00000000.0 + this.rand() % 40 * 0,10000000.0);
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.AddSpeed_XY(0,00000000.0, -0,34999999.0);
		this.sx = this.sy *= 0,89999998.0;

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

function NormalShot_S( t )
{
	this.DrawActorPriority(200);
	this.SetMotion(2007, this.keyTake);
	this.direction = this.owner.direction;
	this.HitReset();
	this.atk_id = 16384;
	this.flag5 = false;
	this.flag4 = t.rot;
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.owner.MaskObject.call(this, null);
			return;
		}

		this.Vec_Brake(3,00000000.0);
		this.count++;

		if (this.count == 6)
		{
			local t_ = {};
			t_.rot <- 0,00000000.0;
			t_.keyTake <- this.keyTake + 3;

			if (this.flag4 == 0,00000000.0)
			{
				t_.rot = this.GetTargetAngle(this.owner.target, this.direction);
				t_.rot = this.Math_MinMax(t_.rot, -30,00000000.0 * 0,01745329.0, 30,00000000.0 * 0,01745329.0);
			}
			else
			{
				t_.rot = this.flag4;
			}

			if (this.keyTake == 0)
			{
				this.PlaySE(2824);
			}

			this.SetShot(this.point0_x, this.point0_y, this.direction, this.owner.NormalShot_S_Beam, t_);
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.owner.NormalShot_S_Beam, t_);
		}

		if (this.count >= 40 || this.owner.IsDamage())
		{
			this.owner.MaskObject.call(this, null);
			return;
		}
	};
}

function NormalShot_S_Beam( t )
{
	this.atk_id = 16384;
	this.SetMotion(2007, t.keyTake);
	this.rz = t.rot;
	this.sx = this.sy = 0,25000000.0;
	this.FitBoxfromSprite();
	this.SetSpeed_Vec(12,50000000.0, this.rz, this.direction);
	this.cancelCount = 2;
	local t_ = {};
	t_.keyTake <- this.keyTake + 3;
	this.SetFreeObject(this.x, this.y, this.direction, function ( init_ )
	{
		this.sx = this.sy = 6,00000000.0;
		this.SetMotion(2007, init_.keyTake);
		this.stateLabel = function ()
		{
			if (this.sx >= 2,00000000.0)
			{
				this.sx = this.sy *= 0,85000002.0;
			}

			this.sx = this.sy *= 0,98000002.0;
			this.count++;

			if (this.count >= 5)
			{
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			}
		};
	}, t_);
	this.func = function ()
	{
		this.callbackGroup = 0;
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
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;
		this.FitBoxfromSprite();

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0 || this.IsScreen(100,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.func();
		}
	};
}

function NormalShot_D( t )
{
	this.DrawActorPriority(200);
	this.SetMotion(2008, this.keyTake);
	this.direction = this.owner.direction;
	this.SetSpeed_Vec(30,00000000.0, t.rot, this.direction);
	this.HitReset();
	this.flag5 = false;
	this.cancelCount = 3;
	this.hitCount = 0;
	this.HitReset();
	this.atk_id = 16384;
	this.count = 0;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 2 == 1)
		{
			local t_ = {};
			t_.motion <- 5007 + this.keyTake;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShot_Aura, t_);
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.IsScreen(200,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 3))
		{
			this.count = 0;
			this.SetMotion(this.motion, this.initTable.type + 3);
			this.stateLabel = function ()
			{
				this.Vec_Brake(2,00000000.0);
				this.count++;

				if (this.count >= 35)
				{
					this.owner.MaskObject.call(this, null);
					return;
				}
			};
		}

		this.HitCycleUpdate(0);
	};
}

function NormalShot_B( t )
{
	this.DrawActorPriority(200);
	this.SetMotion(2009, this.keyTake);
	this.direction = this.owner.direction;
	this.HitReset();
	local r_ = this.GetTargetAngle(this.owner, this.direction);
	r_ = r_ + 3,14159203.0;
	this.SetSpeed_Vec(8,00000000.0, r_, this.direction);
	this.SetSpeed_XY(this.va.x * 0,20000000.0, 0,00000000.0);
	this.AddSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
	this.flag5 = false;
	this.cancelCount = 6;
	this.grazeCount = 0;
	this.hitCount = 0;
	this.HitReset();
	this.atk_id = 16384;
	this.count = 0;
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,30000001.0, 2,50000000.0);
		this.TargetHoming(this.owner.target, 2,00000000.0 * 0,01745329.0, this.direction);
		this.count++;

		if (this.count % 2 == 1)
		{
			local t_ = {};
			t_.motion <- 5007 + this.keyTake;
			this.SetFreeObject(this.x + this.rand() % 40 - 80, this.y + this.rand() % 20 - 40, this.direction, this.owner.NormalShot_Aura, t_);
		}

		if (this.count % 5 == 1)
		{
			local t_ = {};
			t_.motion <- 5007 + this.keyTake;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShot_B_Aura, t_);
		}

		if (this.hitCount >= 3 || this.cancelCount <= 0 || this.count >= 22 || this.grazeCount >= 3 || this.Damage_ConvertOP(this.x, this.y, 3))
		{
			this.count = 0;
			this.SetMotion(this.motion, this.initTable.type + 3);
			this.stateLabel = function ()
			{
				this.Vec_Brake(2,00000000.0, 1,00000000.0);
				this.count++;

				if (this.count >= 40)
				{
					this.owner.MaskObject.call(this, null);
					return;
				}
			};
		}

		this.HitCycleUpdate(4);
	};
}

function NormalShot_B_Aura( t )
{
	this.DrawActorPriority(190);
	this.SetMotion(t.motion, 4 + this.rand() % 2);
	this.sx = 0,75000000.0 + this.rand() % 25 * 0,01000000.0;
	this.sy = 0,75000000.0 + this.rand() % 25 * 0,01000000.0;

	if (this.rand() % 100 >= 50)
	{
		this.sx = -this.sx;
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,10000000.0;
		this.alpha -= 0,07500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Front( t )
{
	this.atk_id = 65536;
	this.flag1 = 0;
	this.cancelCount = 3;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy = 2,00000000.0;
			this.Vec_Brake(1,00000000.0, 1,00000000.0);
			this.sx = this.sy *= 0,98000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.SetSpeed_Vec(this.owner.shotRand[t.type].x, t.rot + this.owner.shotRand[t.type].y, this.direction);
	this.AddSpeed_XY(this.owner.shotRand[t.type].z * this.direction, 0,00000000.0);

	if (this.va.y <= 0)
	{
		this.SetMotion(2016, 0);
	}
	else
	{
		this.SetMotion(2016, 1);
	}

	this.flag1 = -this.va.y / 30;
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 5 || this.IsScreen(200,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.func();
		}

		this.count++;

		if (this.count % 15 == 1)
		{
			local t_ = {};
			t_.motion <- 5008;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShot_Aura, t_);
		}

		if (this.va.y <= 0 && this.keyTake == 1)
		{
			this.SetMotion(2016, 0);
		}
		else if (this.va.y >= 0 && this.keyTake == 0)
		{
			this.SetMotion(2016, 1);
		}

		this.AddSpeed_XY(0,00000000.0, this.flag1);
		this.HitCycleUpdate(0);
	};
}

function Shot_FrontV( t )
{
	this.flag1 = 0;
	this.cancelCount = 3;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy = 2,00000000.0;
			this.Vec_Brake(1,00000000.0, 1,00000000.0);
			this.sx = this.sy *= 0,98000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.SetSpeed_Vec(12,00000000.0 + this.rand() % 3, t.rot + (30 - this.rand() % 60) * 0,01745329.0, this.direction);
	this.AddSpeed_XY(this.rand() % 3 * this.direction, 0,00000000.0);

	if (this.va.y <= 0)
	{
		this.SetMotion(2016, 0);
	}
	else
	{
		this.SetMotion(2016, 1);
	}

	this.flag1 = -this.va.y / 300;
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 5 || this.IsScreen(200,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.func();
		}

		this.count++;

		if (this.count % 15 == 1)
		{
			local t_ = {};
			t_.motion <- 5008;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShot_Aura, t_);
		}

		if (this.va.y <= 0 && this.keyTake == 1)
		{
			this.SetMotion(2016, 0);
		}
		else if (this.va.y >= 0 && this.keyTake == 0)
		{
			this.SetMotion(2016, 1);
		}

		this.AddSpeed_XY(0,00000000.0, this.flag1);
		this.HitCycleUpdate(0);
	};
}

function Shot_FrontS( t )
{
	this.atk_id = 65536;
	this.flag1 = 0;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy = 2,00000000.0;
			this.Vec_Brake(1,00000000.0, 1,00000000.0);
			this.sx = this.sy *= 0,98000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.SetSpeed_Vec(12,00000000.0, t.rot, this.direction);

	if (this.va.y <= 0)
	{
		this.SetMotion(2017, 0);
		this.flag1 = 0,05000000.0;
	}
	else
	{
		this.SetMotion(2017, 1);
		this.flag1 = -0,05000000.0;
	}

	this.stateLabel = function ()
	{
		this.TargetHoming(this.owner.target, 0,50000000.0 * 0,01745329.0, this.direction);

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 2 || this.IsScreen(200,00000000.0) || this.count >= 150 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.func();
		}

		this.count++;

		if (this.count % 15 == 1)
		{
			local t_ = {};
			t_.motion <- 5008;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShot_Aura, t_);
		}

		if (this.va.y <= 0 && this.keyTake == 1)
		{
			this.SetMotion(2017, 0);
		}
		else if (this.va.y >= 0 && this.keyTake == 0)
		{
			this.SetMotion(2017, 1);
		}

		this.AddSpeed_XY(0,00000000.0, this.flag1);
		this.HitCycleUpdate(0);
	};
}

function Shot_FrontD( t )
{
	this.atk_id = 65536;
	this.SetMotion(2018, 0);
	this.flag1 = 5;
	this.flag2 = t.rot;
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(2018, 0);
			this.stateLabel = function ()
			{
				this.Vec_Brake(3,00000000.0, 1,00000000.0);
				this.sx = this.sy *= 0,98000002.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(2018, 1);
			this.SetSpeed_Vec(20,00000000.0 * (0,50000000.0 + this.sx * 0,50000000.0), this.flag2, this.direction);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count % 4 == 1)
				{
					local t_ = {};
					t_.motion <- 5007;
					this.SetFreeObject(this.x + (25 - this.rand() % 50) * this.sx, this.y + (25 - this.rand() % 50) * this.sx, this.direction, this.owner.NormalShot_Aura, t_);
				}

				if (this.hitTarget.len() > 0)
				{
					this.SetSpeed_Vec(2,00000000.0, this.flag2, this.direction);
				}
				else
				{
					this.SetSpeed_Vec(20,00000000.0 * (0,50000000.0 + this.sx * 0,50000000.0), this.flag2, this.direction);
				}

				this.HitCycleUpdate(5);

				if (this.hitCount >= this.flag1 || this.cancelCount <= 0 || this.IsScreen(200,00000000.0) || this.grazeCount >= 5 || this.Damage_ConvertOP(this.x, this.y, 8))
				{
					this.func[0].call(this);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion == 2010 || this.owner.motion == 2011)
		{
			this.count++;

			if (this.count % 5 == 1)
			{
				local t_ = {};
				t_.motion <- 5007;
				this.SetFreeObject(this.x + (25 - this.rand() % 50) * this.sx, this.y + (25 - this.rand() % 50) * this.sx, this.direction, this.owner.NormalShot_Aura, t_);
			}

			this.sx = this.sy += 0,05000000.0;

			if (this.sx >= 1,50000000.0)
			{
				this.flag1 = 6;
				this.cancelCount = 6;
				this.grazeCount = -3;
			}

			if (this.sx >= 2,00000000.0)
			{
				this.flag1 = 7;
				this.cancelCount = 9;
				this.grazeCount = -8;
			}

			if (this.sx > 3,00000000.0)
			{
				this.cancelCount = 12;
				this.grazeCount = -15;
				this.flag1 = 8;
				this.sx = this.sy = 3,00000000.0;
			}

			this.FitBoxfromSprite();
			this.Warp(this.owner.point0_x, this.owner.point0_y);
		}
		else
		{
			this.func[0].call(this);
		}
	};
}

function Shot_FrontB( t )
{
	this.atk_id = 65536;

	if (this.initTable.rot <= 20,00000000.0 * 0,01745329.0)
	{
		this.SetMotion(2019, 0);
	}
	else
	{
		this.SetMotion(2019, 1);
	}

	this.flag1 = {};
	this.flag1.range <- 0,00000000.0;
	t.group.append(this.weakref());

	if (this.initTable.pare != this.owner)
	{
		this.hitOwner = this.initTable.pare;
	}

	if (t.scale < 1,50000000.0)
	{
		local t_ = {};
		t_.scale <- t.scale + 0,40000001.0;
		t_.rot <- t.rot;
		t_.root <- this;
		t_.group <- t.group;

		if (t.pare != this.owner)
		{
			this.SetShot(this.x, this.y, this.direction, this.owner.Shot_FrontB, t_, t.pare);
		}
		else
		{
			this.SetShot(this.x, this.y, this.direction, this.owner.Shot_FrontB, t_, this.weakref());
		}
	}

	this.cancelCount = 3;
	this.sx = this.sy = 0,10000000.0;
	this.FitBoxfromSprite();
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.SetSpeed_XY(2,00000000.0 - this.rand() % 5, -this.rand() % 3);
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0,00000000.0, -0,20000000.0);
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
		if (this.hitCount >= 4 || this.cancelCount <= 0 || this.grazeCount >= 6 || this.count >= 30 || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.func();
			return;
		}

		if (this.owner.motion == 2010 || this.owner.motion == 2011)
		{
		}
		else
		{
			this.func();
			return;
		}

		this.flag1.range += (45 * this.sx - this.flag1.range) * 0,25000000.0;
		this.sx = this.sy += (this.initTable.scale - this.sx) * 0,25000000.0;
		this.FitBoxfromSprite();
		this.count++;

		if (this.count % 4 == 1)
		{
			local t_ = {};
			t_.motion <- 5009;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShot_Aura, t_);
		}

		if (this.initTable.pare)
		{
			this.Warp(this.initTable.root.point0_x + this.flag1.range * this.cos(this.initTable.rot) * this.direction, this.initTable.root.point0_y + this.flag1.range * this.sin(this.initTable.rot));
		}

		this.HitCycleUpdate(7);
	};
}

function BurrageShot()
{
	this.PlaySE(2824);
	local t_ = {};
	t_.rot <- this.atan2(this.owner.target.y - this.owner.y, (this.owner.target.x - this.owner.x) * this.direction);
	t_.type <- this.initTable.type * 3;
	this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Barrage, t_);
	local t2_ = {};
	t2_.type <- t_.type;
	this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Barrage_Fire, t2_);
}

function BurrageShot_S()
{
	this.PlaySE(2824);
	local t_ = {};
	t_.rot <- this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
	t_.type <- this.initTable.type * 3;
	this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Barrage_S, t_);
	local t2_ = {};
	t2_.type <- t_.type;
	this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Barrage_Fire, t2_);
}

function BurrageShot_D()
{
	this.PlaySE(2824);
	local t_ = {};
	t_.type <- this.initTable.type * 3;
	this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Barrage_D, t_);
	local t2_ = {};
	t2_.type <- t_.type;
	this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Barrage_Fire, t2_);
}

function BurrageShot_B()
{
	this.PlaySE(2824);
	local t_ = {};
	t_.rot <- this.sin(this.owner.maskRot + this.initTable.rot) * 0,52359873.0;
	t_.type <- this.initTable.type * 3;
	this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Barrage_B, t_);
	local t2_ = {};
	t2_.type <- t_.type;
	this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Barrage_Fire, t2_);
}

function Shot_Barrage_Fire( t )
{
	this.SetMotion(2026, t.type + 2);
	this.sx = this.sy = 6,00000000.0;
	this.stateLabel = function ()
	{
		if (this.sx >= 2,00000000.0)
		{
			this.sx = this.sy *= 0,85000002.0;
		}

		this.sx = this.sy *= 0,98000002.0;
		this.count++;

		if (this.count >= 5)
		{
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, t.type);
	this.atk_id = 262144;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(10,00000000.0, this.rz, this.direction);
	local t_ = {};
	t_.type <- t.type;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Barrage_Fire, t_);
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, t.type + 1);
		this.stateLabel = function ()
		{
			this.sy *= 0,85000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
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
	};
}

function Shot_Barrage_S( t )
{
	this.SetMotion(2026, t.type);
	this.atk_id = 262144;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(8,00000000.0, this.rz, this.direction);
	local t_ = {};
	t_.type <- t.type;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Barrage_Fire, t_);
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, t.type + 1);
		this.stateLabel = function ()
		{
			this.sy *= 0,85000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
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
	};
}

function Shot_Barrage_D( t )
{
	this.SetMotion(2026, t.type);
	this.atk_id = 262144;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = 0,00000000.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(25,00000000.0, this.rz, this.direction);
	local t_ = {};
	t_.type <- t.type;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Barrage_Fire, t_);
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, t.type + 1);
		this.stateLabel = function ()
		{
			this.sy *= 0,85000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
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
	};
}

function Shot_Barrage_B( t )
{
	this.SetMotion(2026, t.type);
	this.atk_id = 262144;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(9,00000000.0, this.rz, this.direction);
	local t_ = {};
	t_.type <- t.type;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Barrage_Fire, t_);
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, t.type + 1);
		this.stateLabel = function ()
		{
			this.sy *= 0,85000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		this.count++;

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.count >= 30)
		{
			this.func();
			return true;
		}
	};
}

function Shot_Charge( t )
{
	this.atk_id = 131072;
	this.SetMotion(2027, t.keyTake);
	this.flag5 = this.SetFreeObject(this.x, this.y, this.direction, function ( t )
	{
		this.SetMotion(2027, 4);
		this.rz = this.rand() % 360 * 0,01745329.0;
		this.stateLabel = function ()
		{
			this.rz -= 6,00000000.0 * 0,01745329.0;
		};
		this.func = function ()
		{
			this.stateLabel = function ()
			{
				this.rz -= 9,00000000.0 * 0,01745329.0;
				this.sx = this.sy += (1,50000000.0 - this.sx) * 0,10000000.0;
			};
		};
	}, {});

	if (this.sin(t.rot) < 0,00000000.0)
	{
		this.flag5.DrawActorPriority(180);
		this.DrawActorPriority(180);
	}
	else
	{
		this.flag5.DrawActorPriority(200);
		this.DrawActorPriority(200);
	}

	this.func = [
		function ()
		{
			for( local i = 0; i < 6; i++ )
			{
				this.SetFreeObject(this.x + 25 - this.rand() % 50, this.y + 25 - this.rand() % 50, this.direction, this.owner.Shot_ChargeAura, {});
			}

			this.ReleaseActor.call(this.flag5);
			this.flag5 = null;
			this.SetSpeed_XY(-2,00000000.0 * this.direction, 0,00000000.0);
			this.SetMotion(2027, 5);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha -= 0,05000000.0;

				if (this.linkObject)
				{
					this.linkObject[0].alpha -= 0,05000000.0;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.flag5.func();
			this.SetTrail(6032, 3, 20, 40);
			this.PlaySE(2903);
			this.flag5.DrawActorPriority(200);
			this.DrawActorPriority(200);
			this.SetMotion(2028, this.keyTake);
			this.cancelCount = 3;
			this.SetSpeed_Vec(10,00000000.0, this.GetTargetAngle(this.owner.target, this.direction), this.direction);
			this.stateLabel = function ()
			{
				this.flag5.Warp(this.x, this.y);
				this.count++;

				if (this.count % 3 == 0)
				{
					this.SetFreeObject(this.x + 25 - this.rand() % 50, this.y + 25 - this.rand() % 50, this.direction, this.owner.Shot_ChargeAura, {});
				}

				if (this.hitResult == 32)
				{
					this.HitReset();
				}

				if (this.cancelCount <= 0 || this.hitCount >= 1 || this.IsScreen(100,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 2))
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	];
	this.flag2 = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 180 || this.owner.IsGuard() || this.owner.motion == 2020 && this.owner.keyTake == 0 || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.func[0].call(this);
			return;
		}

		if (this.abs(this.y - this.owner.target.y) <= 75 && this.abs(this.x - this.owner.target.x) <= 450 && this.count >= 120)
		{
			this.func[1].call(this);
			return;
		}

		this.flag2 += (150 - this.flag2) * 0,10000000.0;
		this.initTable.rot += 4,00000000.0 * 0,01745329.0;
		this.Warp(this.owner.x + this.flag2 * this.cos(this.initTable.rot), this.owner.y + this.flag2 * 0,33000001.0 * this.sin(this.initTable.rot));
		this.flag5.Warp(this.x, this.y);

		if (this.sin(this.initTable.rot) < 0,00000000.0)
		{
			if (this.drawPriority == 200)
			{
				this.flag5.DrawActorPriority(180);
				this.DrawActorPriority(180);
			}
		}
		else if (this.drawPriority == 180)
		{
			this.DrawActorPriority.call(this.flag5, 200);
			this.DrawActorPriority(200);
		}
	};
}

function Shot_ChargeAura( t )
{
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetMotion(2029, this.rand() % 4);
	this.flag1 = (-1 + this.rand() % 3) * 0,01745329.0;
	this.sx = 1,50000000.0 + this.rand() % 3 * 0,10000000.0;
	this.sy = 1,50000000.0 + this.rand() % 3 * 0,10000000.0;
	this.flag2 = 0,02500000.0 + this.rand() % 10 * 0,00100000.0;
	this.subState = function ()
	{
		this.alpha -= this.flag2;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.sx = this.sy *= 0,92000002.0;
		this.AddSpeed_XY(0,00000000.0, -0,50000000.0);
		this.subState();
	};
}

function Shot_ChargeFullBack( t )
{
	this.SetMotion(2029, 4);
	this.SetParent(t.pare, 0, 0);
	this.keyAction = this.ReleaseActor;
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.SetKeyFrame(1);
	};
}

function Shot_ChargeFull( t )
{
	this.SetMotion(2026, 0);
	this.flag4 = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_ChargeFullBack, {}, this.weakref());
	this.cancelCount = 3;
	this.flag5 = this.SetFreeObject(this.x, this.y, this.direction, function ( t )
	{
		this.SetMotion(2027, 4);
		this.rz = this.rand() % 360 * 0,01745329.0;
		this.stateLabel = function ()
		{
			this.rz -= 6,00000000.0 * 0,01745329.0;
		};
		this.func = function ()
		{
			this.stateLabel = function ()
			{
				this.rz -= 9,00000000.0 * 0,01745329.0;
				this.sx = this.sy += (1,50000000.0 - this.sx) * 0,10000000.0;
			};
		};
	}, {});
	this.SetParent.call(this.flag5, this, 0, 0);

	if (this.sin(t.rot) < 0,00000000.0)
	{
		this.DrawActorPriority.call(this.flag5, 180);
		this.DrawActorPriority(180);
	}
	else
	{
		this.DrawActorPriority.call(this.flag5, 200);
		this.DrawActorPriority(200);
	}

	this.func = [
		function ()
		{
			this.ReleaseActor.call(this.flag5);
			this.flag5 = null;

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetSpeed_XY(-2,00000000.0 * this.direction, 0,00000000.0);
			this.SetMotion(2027, 5);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha -= 0,05000000.0;

				if (this.linkObject)
				{
					this.linkObject[0].alpha -= 0,05000000.0;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.flag2 = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.grazeCount > 2 || this.cancelCount <= 0 || this.hitCount >= 1 || this.count >= 180 || this.owner.motion == 2020 && this.owner.keyTake == 0)
		{
			this.func[0].call(this);
			return;
		}

		local r_ = (150 - this.flag2) * 0,10000000.0;

		if (r_ < 0,50000000.0)
		{
			r_ = 0,50000000.0;
		}

		this.flag2 += r_;
		this.initTable.rot += 4,00000000.0 * 0,01745329.0;
		this.Warp(this.owner.x + this.flag2 * this.cos(this.initTable.rot), this.owner.y + this.flag2 * 0,25000000.0 * this.sin(this.initTable.rot));
		this.flag5.Warp(this.x, this.y);

		if (this.hitResult == 32)
		{
			this.HitReset();
		}

		if (this.sin(this.initTable.rot) < 0,00000000.0)
		{
			if (this.drawPriority == 200)
			{
				this.flag5.DrawActorPriority(180);
				this.DrawActorPriority(180);
			}
		}
		else if (this.drawPriority == 180)
		{
			this.flag5.DrawActorPriority(200);
			this.DrawActorPriority(200);
		}
	};
}

function HighShot( t )
{
	this.flag1 = 0;
	this.cancelCount = 4;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy = 2,00000000.0;
			this.Vec_Brake(1,00000000.0, 1,00000000.0);
			this.sx = this.sy *= 0,98000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.SetSpeed_Vec(15,00000000.0 + this.rand() % 5, t.rot + (40 - this.rand() % 80) * 0,01745329.0, this.direction);
	this.AddSpeed_XY(this.rand() % 3 * this.direction, 0,00000000.0);

	if (this.va.y <= 0)
	{
		this.SetMotion(5010, 0);
	}
	else
	{
		this.SetMotion(5010, 1);
	}

	this.flag1 = -this.va.y / 30;
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 5 || this.IsScreen(200,00000000.0))
		{
			this.func();
		}

		this.count++;

		if (this.count % 15 == 1)
		{
			local t_ = {};
			t_.motion <- 5008;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShot_Aura, t_);
		}

		if (this.va.y <= 0 && this.keyTake == 1)
		{
			this.SetMotion(5010, 0);
		}
		else if (this.va.y >= 0 && this.keyTake == 0)
		{
			this.SetMotion(5010, 1);
		}

		this.AddSpeed_XY(0,00000000.0, this.flag1);
		this.HitCycleUpdate(0);
	};
}

function HighShot_V( t )
{
	this.flag1 = 0;
	this.cancelCount = 4;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy = 2,00000000.0;
			this.Vec_Brake(1,00000000.0, 1,00000000.0);
			this.sx = this.sy *= 0,98000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.SetSpeed_Vec(12,00000000.0 + this.rand() % 3, t.rot + (30 - this.rand() % 60) * 0,01745329.0, this.direction);
	this.AddSpeed_XY(this.rand() % 3 * this.direction, 0,00000000.0);

	if (this.va.y <= 0)
	{
		this.SetMotion(5010, 0);
	}
	else
	{
		this.SetMotion(5010, 1);
	}

	this.flag1 = -this.va.y / 300;
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 5 || this.IsScreen(200,00000000.0))
		{
			this.func();
		}

		this.count++;

		if (this.count % 15 == 1)
		{
			local t_ = {};
			t_.motion <- 5008;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShot_Aura, t_);
		}

		if (this.va.y <= 0 && this.keyTake == 1)
		{
			this.SetMotion(5010, 0);
		}
		else if (this.va.y >= 0 && this.keyTake == 0)
		{
			this.SetMotion(5010, 1);
		}

		this.AddSpeed_XY(0,00000000.0, this.flag1);
		this.HitCycleUpdate(0);
	};
}

function HighShot_S( t )
{
	this.flag1 = 0;
	this.cancelCount = 3;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy = 2,00000000.0;
			this.Vec_Brake(1,00000000.0, 1,00000000.0);
			this.sx = this.sy *= 0,98000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.SetSpeed_Vec(12,00000000.0, t.rot + (2 - this.rand() % 5) * 0,01745329.0, this.direction);
	this.AddSpeed_XY(this.rand() % 3 * this.direction, 0,00000000.0);

	if (this.va.y <= 0)
	{
		this.SetMotion(5011, 0);
		this.flag1 = 0,05000000.0;
	}
	else
	{
		this.SetMotion(5011, 1);
		this.flag1 = -0,05000000.0;
	}

	this.stateLabel = function ()
	{
		this.TargetHoming(this.owner.target, 0,50000000.0 * 0,01745329.0, this.direction);

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount >= 2 || this.IsScreen(200,00000000.0) || this.count >= 150)
		{
			this.func();
		}

		this.count++;

		if (this.count % 15 == 1)
		{
			local t_ = {};
			t_.motion <- 5008;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShot_Aura, t_);
		}

		if (this.va.y <= 0 && this.keyTake == 1)
		{
			this.SetMotion(5011, 0);
		}
		else if (this.va.y >= 0 && this.keyTake == 0)
		{
			this.SetMotion(5011, 1);
		}

		this.AddSpeed_XY(0,00000000.0, this.flag1);
		this.HitCycleUpdate(0);
	};
}

function HighShot_D( t )
{
	this.SetMotion(5012, 0);
	this.flag1 = 5;
	this.flag2 = t.rot;
	this.cancelCount = 3;
	this.callbackGroup = 0;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(3,00000000.0, 1,00000000.0);
				this.sx = this.sy *= 0,98000002.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.hitTarget = [];
			this.SetSpeed_Vec(20,00000000.0 * (0,50000000.0 + this.sx * 0,50000000.0), this.flag2, this.direction);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count % 4 == 1)
				{
					local t_ = {};
					t_.motion <- 5007;
					this.SetFreeObject(this.x + (25 - this.rand() % 50) * this.sx, this.y + (25 - this.rand() % 50) * this.sx, this.direction, this.owner.NormalShot_Aura, t_);
				}

				if (this.hitTarget.len() > 0)
				{
					this.SetSpeed_Vec(2,00000000.0, this.flag2, this.direction);
				}
				else
				{
					this.SetSpeed_Vec(20,00000000.0 * (0,50000000.0 + this.sx * 0,50000000.0), this.flag2, this.direction);
				}

				this.HitCycleUpdate(5);

				if (this.hitCount >= this.flag1 || this.cancelCount <= 0 || this.IsScreen(200,00000000.0) || this.grazeCount >= 5)
				{
					this.func[0].call(this);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion == 2500)
		{
			this.count++;

			if (this.count % 5 == 1)
			{
				local t_ = {};
				t_.motion <- 5007;
				this.SetFreeObject(this.x + (25 - this.rand() % 50) * this.sx, this.y + (25 - this.rand() % 50) * this.sx, this.direction, this.owner.NormalShot_Aura, t_);
			}

			this.sx = this.sy += 0,05000000.0;

			if (this.sx >= 1,50000000.0)
			{
				this.flag1 = 6;
				this.cancelCount = 6;
				this.grazeCount = -3;
			}

			if (this.sx >= 2,00000000.0)
			{
				this.flag1 = 7;
				this.cancelCount = 9;
				this.grazeCount = -8;
			}

			if (this.sx > 3,00000000.0)
			{
				this.cancelCount = 12;
				this.grazeCount = -15;
				this.flag1 = 8;
				this.sx = this.sy = 3,00000000.0;
			}

			this.FitBoxfromSprite();
			this.Warp(this.owner.point0_x, this.owner.point0_y);
		}
		else
		{
			this.func[0].call(this);
		}
	};
}

function HighShot_B( t )
{
	this.flag1 = {};
	this.flag1.range <- 0,00000000.0;
	t.group.append(this.weakref());

	if (t.scale < 1,50000000.0)
	{
		local t_ = {};
		t_.scale <- t.scale + 0,40000001.0;
		t_.rot <- t.rot;
		t_.group <- t.group;
		this.SetShot(this.x, this.y, this.direction, this.owner.HighShot_B, t_, this.weakref());
	}
	else
	{
		foreach( a in t.group )
		{
			a.p.hitGroup = t.group;
		}
	}

	this.cancelCount = 3;
	this.sx = this.sy = 0,10000000.0;
	this.FitBoxfromSprite();
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.SetSpeed_XY(2,00000000.0 - this.rand() % 5, -this.rand() % 3);
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0,00000000.0, -0,20000000.0);
			this.sx = this.sy *= 0,98000002.0;
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};

	if (this.initTable.rot <= 20,00000000.0 * 0,01745329.0)
	{
		this.SetMotion(5013, 0);
	}
	else
	{
		this.SetMotion(5013, 1);
	}

	this.stateLabel = function ()
	{
		if (this.owner.motion == 2500)
		{
		}
		else
		{
			this.func();
			return;
		}

		if (this.hitCount >= 4 || this.cancelCount <= 0 || this.grazeCount >= 6 || this.count >= 30)
		{
			this.func();
			return;
		}

		this.flag1.range += (45 * this.sx - this.flag1.range) * 0,25000000.0;
		this.sx = this.sy += (this.initTable.scale - this.sx) * 0,25000000.0;
		this.FitBoxfromSprite();
		this.count++;

		if (this.count % 4 == 1)
		{
			local t_ = {};
			t_.motion <- 5009;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.NormalShot_Aura, t_);
		}

		if (this.initTable.pare)
		{
			this.Warp(this.initTable.pare.point0_x + this.flag1.range * this.cos(this.initTable.rot) * this.direction, this.initTable.pare.point0_y + this.flag1.range * this.sin(this.initTable.rot));
		}

		this.HitCycleUpdate(7);
	};
}

function Occult_Mark( t )
{
	this.SetMotion(2509, 4);
	this.DrawActorPriority(180);
	this.EnableTimeStop(false);
	this.keyAction = this.ReleaseActor;
}

function Occult_Mask( t )
{
	this.SetMotion(2508, 0);
	this.EnableTimeStop(false);
	this.DrawActorPriority(180);
	this.SetSpeed_XY(-10,00000000.0 * this.direction, -5,00000000.0);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, this.va.y < 6,00000000.0 ? 0,50000000.0 : 0,01000000.0);
		this.flag1 += 0,05000000.0;
		this.rz = this.Math_Bezier(0,00000000.0, -280 * 0,01745329.0, -240 * 0,01745329.0, this.flag1);

		if (this.flag1 > 1,00000000.0)
		{
			this.alpha -= 0,05000000.0;
		}

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Occult_Face( t )
{
	this.SetMotion(2509, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.sx = this.sy = 0,50000000.0;
	this.SetFreeObject(this.x, this.y, this.direction, this.owner.Occult_FaceWaveA, {}, this.weakref());
	this.SetFreeObject(this.x, this.y, this.direction, this.owner.Occult_FaceWaveB, {}, this.weakref());
	this.flag2 = this.sx;
	this.flag3 = 0;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 3)
		{
			this.count = 0;
			local t_ = {};
			t_.scale <- this.sx;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Occult_FaceAura, t_, this.weakref());

			if (this.flag3 < 2)
			{
				this.flag3++;
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.Occult_FaceWaveB, {});
			}
		}

		this.flag1 += 0,05000000.0;
		this.alpha = this.Math_Bezier(2,50000000.0, 0,00000000.0, 0,01000000.0, this.flag1);
		this.sx = this.sy = this.Math_Bezier(0,50000000.0, 2,00000000.0, 1,98000002.0, this.flag1);
		this.SetSpeed_XY((this.sx - this.flag2) * 100 * this.direction, 0,00000000.0);
		this.flag2 = this.sx;

		if (this.flag1 >= 1,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Occult_FaceAura( t )
{
	this.SetMotion(2509, 0);
	this.DrawActorPriority(199);
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
	this.sx = this.sy = t.scale;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 1,04999995.0;
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Occult_FaceWaveA( t )
{
	this.SetMotion(2509, 2);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.sx = this.sy = 0,50000000.0;
	this.stateLabel = function ()
	{
		this.flag1 += 0,05000000.0;
		this.alpha = this.green = this.blue = this.Math_Bezier(2,50000000.0, 0,00000000.0, 0,01000000.0, this.flag1);
		this.sx = this.sy = this.Math_Bezier(0,50000000.0, 2,00000000.0, 1,98000002.0, this.flag1);

		if (this.flag1 >= 1,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Occult_FaceWaveB( t )
{
	this.SetMotion(2509, 3);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.sx = this.sy = 0,50000000.0;
	this.stateLabel = function ()
	{
		this.flag1 += 0,03300000.0;
		this.alpha = this.green = this.blue = this.Math_Bezier(2,50000000.0, 0,00000000.0, 0,01000000.0, this.flag1);
		this.sx = this.sy = this.Math_Bezier(0,50000000.0, 4,00000000.0, 3,98000002.0, this.flag1);

		if (this.flag1 >= 1,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Okult_Shot( t )
{
	this.Okult_Shot_Kama(t);
	return;
}

function Okult_Shot_Kama( t )
{
	this.atk_id = 524288;
	this.SetMotion(2506, 3);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.DrawActorPriority(t.priority);
	this.rz = 90 * 0,01745329.0;
	this.SetSpeed_XY(0,00000000.0, 12,50000000.0);
	this.alpha = 0,00000000.0;
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetMotion(2506, 3);
			this.alpha = 1,00000000.0;
			this.flag1 = (-6,00000000.0 + this.rand() % 13) * 0,01745329.0;
			this.SetParent(null, 0, 0);
			this.SetSpeed_XY(1,50000000.0 - this.rand() % 31 * 0,10000000.0, -(this.rand() % 15) * 0,10000000.0);
			this.stateLabel = function ()
			{
				this.rz += this.flag1;
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
			this.SetMotion(2507, 3);
			this.DrawActorPriority(200);
			this.SetParent(null, 0, 0);
			this.SetSpeed_XY(25,00000000.0 * this.direction + this.initTable.pos.x * 0,02000000.0 * this.direction, this.initTable.pos.y * 0,02000000.0);
			this.va.RotateByRadian(this.initTable.shotRot * this.direction);
			this.SetSpeed_XY(null, null);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
				{
					this.ReleaseActor();
					return true;
				}

				this.rz += 0,50000000.0;

				if (this.cancelCount <= 0 || this.hitCount > 0)
				{
					this.func[0].call(this);
					this.SetSpeed_XY((-3,00000000.0 - this.rand() % 21 * 0,10000000.0) * this.direction, -4,00000000.0 + this.va.y);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,25000000.0;
		this.VY_Brake(1,00000000.0);
	};
}

function Shot_Change_MaskCore( t )
{
	this.SetMotion(3929, 6);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag2 = [
		[],
		[]
	];
	this.flag3 = {};
	this.flag3.rot <- 0,00000000.0;
	this.flag3.range <- 0,00000000.0;
	this.flag4 = false;

	for( local i = 0; i < 12; i++ )
	{
		local t_ = {};
		t_.rot <- i * 30 * 0,01745329.0;
		t_.keyTake <- i % 3;
		this.flag2[0].append(this.SetShot(this.x, this.y, this.direction, this.Shot_Change_Mask, t_).weakref());
	}

	foreach( a in this.flag2[0] )
	{
		a.hitOwner = this.weakref();
	}

	for( local i = 0; i < 6; i++ )
	{
		local t_ = {};
		t_.rot <- i * 60 * 0,01745329.0;
		t_.keyTake <- i % 3;
		this.flag2[1].append(this.SetShot(this.x, this.y, this.direction, this.Shot_Change_Mask, t_).weakref());
	}

	foreach( a in this.flag2[1] )
	{
		a.hitOwner = this.weakref();
	}

	this.func = [
		function ()
		{
			foreach( a in this.flag2[0] )
			{
				a.func[0].call(a);
			}

			foreach( a in this.flag2[1] )
			{
				a.func[0].call(a);
			}

			this.ReleaseActor();
		},
		function ()
		{
			local r_ = this.atan2(this.owner.target.y - this.owner.y, (this.owner.target.x - this.owner.x) * this.direction);
			r_ = this.Math_MinMax(r_, -1,04719746.0, 1,04719746.0);

			foreach( a in this.flag2[0] )
			{
				a.func[1].call(a, r_, 10);
			}

			foreach( a in this.flag2[1] )
			{
				a.func[1].call(a, r_, 10);
			}

			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.flag3.rot += 0,05235988.0;
		local r_ = (175 - this.flag3.range) * 0,10000000.0;
		this.flag3.range += r_;
		this.HitCycleUpdate(10);

		foreach( a in this.flag2[0] )
		{
			if (a)
			{
				a.Warp(this.point0_x + this.flag3.range * this.cos(this.flag3.rot + a.initTable.rot) * this.direction, this.point0_y + this.flag3.range * this.sin(this.flag3.rot + a.initTable.rot));
			}
		}

		foreach( a in this.flag2[1] )
		{
			if (a)
			{
				a.Warp(this.point0_x + this.flag3.range * 0,50000000.0 * this.cos(-this.flag3.rot + a.initTable.rot) * this.direction, this.point0_y + this.flag3.range * 0,50000000.0 * this.sin(-this.flag3.rot + a.initTable.rot));
			}
		}
	};
}

function Shot_Change_Mask( t )
{
	this.SetMotion(3929, t.keyTake + 3);
	this.func = [
		function ()
		{
			this.SetMotion(3929, t.keyTake + 6);
			this.SetSpeed_XY(-2,00000000.0 + this.rand() % 40 * 0,10000000.0, -(this.rand() % 30) * 0,10000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ( rot_, v_ )
		{
			this.HitReset();
			this.hitCount = 0;
			this.grazeCount = 0;
			this.cancelCount = 3;
			this.hitOwner = this.weakref();
			this.SetSpeed_Vec(v_, rot_, this.direction);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 3))
				{
					this.ReleaseActor();
					return true;
				}

				if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
					return;
				}

				this.TargetHoming(this.owner.target, 0,10000000.0 * 0,01745329.0, this.direction);
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function SPShot_A( t )
{
	this.rz = t.rot;
	this.SetMotion(3009, 6);
	this.sx = this.sy = 1,50000000.0;
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

function SPShot_A_Aura( t )
{
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetMotion(3009, 1 + this.rand() % 4);
	this.flag1 = (-1 + this.rand() % 3) * 0,01745329.0;
	this.sx = 0,75000000.0 + this.rand() % 15 * 0,10000000.0;
	this.sy = 0,75000000.0 + this.rand() % 15 * 0,10000000.0;
	this.alpha = 1,00000000.0;
	this.SetSpeed_XY(-2 + this.rand() % 5, -(this.rand() % 2));
	this.flag2 = 0,02500000.0 + this.rand() % 10 * 0,00100000.0;
	this.subState = function ()
	{
		this.alpha += this.flag2;

		if (this.alpha >= 0,50000000.0)
		{
			this.subState = function ()
			{
				this.alpha -= this.flag2;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.sx = this.sy *= 0,94999999.0;
		this.AddSpeed_XY(0,00000000.0, -0,02500000.0);
		this.subState();
	};
}

function SPShot_B_Web( t )
{
	this.atk_id = 2097152;
	this.SetMotion(6010, 0);
	this.cancelCount = 3;
	this.rz = t.rot;
	this.sx = this.sy = 0,10000000.0;
	this.FitBoxfromSprite();
	this.func = function ()
	{
		this.SetMotion(6010, 1);
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,00250000.0;
			this.alpha -= 0,10000000.0;
			this.AddSpeed_XY(0,00000000.0, 0,25000000.0);

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.owner.motion == 3010)
		{
			if (this.owner.keyTake <= 1)
			{
				this.Warp(this.owner.point0_x, this.owner.point0_y);
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
	this.stateLabel = function ()
	{
		if (!this.flag2)
		{
			if (this.hitResult & 1)
			{
				if (this.owner.captureString.len() > 0)
				{
					foreach( a in this.owner.captureString )
					{
						if (a)
						{
							a.func();
						}
					}
				}

				this.owner.captureString = [];
				this.owner.capture = this.owner.target.weakref();

				for( local i = 0; i < 8; i++ )
				{
					this.owner.captureString.append(this.SetFreeObject(this.owner.x, this.owner.y - 50, this.direction, this.owner.SPShot_B_String, {}).weakref());
				}

				this.flag2 = true;
			}
		}

		if (this.cancelCount <= 0)
		{
			this.func();
			return;
		}

		this.sx = this.sy += (1,10000002.0 - this.sx) * 0,50000000.0;
		this.FitBoxfromSprite();

		if (this.sx > 1,00000000.0)
		{
			this.SetMotion(6010, 1);
			this.sx = this.sy = 1,00000000.0;
			this.FitBoxfromSprite();
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,00250000.0;
				this.subState();
			};
			return;
		}

		this.subState();
	};
	this.keyAction = this.func;
}

function SPShot_B_String( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(6010, 2);
	this.alpha = 0,00000000.0;
	this.flag2 = this.Vector3();
	this.flag2.x = this.rand() % 40 - 20;
	this.flag2.y = this.rand() % 100 - 50;
	this.target = this.owner.target.weakref();
	this.func = function ()
	{
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
		this.alpha += 0,10000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		if (this.count >= 450 || this.owner.capture == null)
		{
			this.owner.capture = null;
			this.subState = function ()
			{
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			return true;
		}
	};
	this.stateLabel = function ()
	{
		this.count++;
		this.subState();
		this.Warp(this.team.current.x, this.team.current.y - 50);
		local Pos_ = this.Vector3();
		Pos_.x = (this.owner.target.x + this.flag2.x - this.x) * this.direction;
		Pos_.y = this.owner.target.y + this.flag2.y - this.y;
		this.sx = Pos_.LengthXY() / 128;
		this.rz = this.atan2(Pos_.y, Pos_.x);
	};
}

function SPShot_B_Pull( t )
{
	this.atk_id = 2097152;
	this.DrawActorPriority(180);
	this.SetMotion(6010, 3);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 2)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_C( t )
{
	this.SetMotion(6020, t.keyTake);
	this.flag5 = this.SetFreeObject(this.x, this.y, this.direction, function ( t )
	{
		this.SetMotion(6020, 4);
		this.rz = this.rand() % 360 * 0,01745329.0;
		this.stateLabel = function ()
		{
			this.rz -= 6,00000000.0 * 0,01745329.0;
		};
		this.func = function ()
		{
			this.stateLabel = function ()
			{
				this.rz -= 9,00000000.0 * 0,01745329.0;
				this.sx = this.sy += (1,50000000.0 - this.sx) * 0,10000000.0;
			};
		};
	}, {});

	if (this.sin(t.rot) < 0,00000000.0)
	{
		this.DrawActorPriority.call(this.flag5, 180);
		this.DrawActorPriority(180);
	}
	else
	{
		this.DrawActorPriority.call(this.flag5, 200);
		this.DrawActorPriority(200);
	}

	this.func = [
		function ()
		{
			for( local i = 0; i < 6; i++ )
			{
				this.SetFreeObject(this.x + 25 - this.rand() % 50, this.y + 25 - this.rand() % 50, this.direction, this.owner.SPShot_C_Aura, {});
			}

			this.ReleaseActor.call(this.flag5);
			this.flag5 = null;
			this.SetSpeed_XY(-2,00000000.0 * this.direction, 0,00000000.0);
			this.SetMotion(6020, 5);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha -= 0,05000000.0;

				if (this.linkObject)
				{
					this.linkObject[0].alpha -= 0,05000000.0;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.flag5.func();
			this.SetTrail(6032, 3, 20, 40);
			this.PlaySE(2903);
			this.DrawActorPriority.call(this.flag5, 200);
			this.DrawActorPriority(200);
			this.SetMotion(6021, this.keyTake);
			this.cancelCount = 3;
			this.SetSpeed_Vec(10,00000000.0, this.GetTargetAngle(this.owner.target, this.direction), this.direction);
			this.stateLabel = function ()
			{
				this.flag5.Warp(this.x, this.y);
				this.count++;

				if (this.count % 3 == 0)
				{
					this.SetFreeObject(this.x + 25 - this.rand() % 50, this.y + 25 - this.rand() % 50, this.direction, this.owner.SPShot_C_Aura, {});
				}

				if (this.hitResult == 32)
				{
					this.HitReset();
				}

				if (this.cancelCount <= 0 || this.hitCount >= 1 || this.IsScreen(100,00000000.0))
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	];
	this.flag2 = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 180 || this.owner.IsDamage() || this.IsGuard.call(this.owner) || this.owner.motion == 3020 && this.owner.keyTake == 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.abs(this.y - this.owner.target.y) <= 75 && this.abs(this.x - this.owner.target.x) <= 450 && this.count >= 120)
		{
			this.func[1].call(this);
			return;
		}

		this.flag2 += (150 - this.flag2) * 0,10000000.0;
		this.initTable.rot += 4,00000000.0 * 0,01745329.0;
		this.Warp(this.owner.x + this.flag2 * this.cos(this.initTable.rot), this.owner.y + this.flag2 * 0,33000001.0 * this.sin(this.initTable.rot));
		this.flag5.Warp(this.x, this.y);

		if (this.sin(this.initTable.rot) < 0,00000000.0)
		{
			if (this.drawPriority == 200)
			{
				this.flag5.DrawActorPriority(180);
				this.DrawActorPriority(180);
			}
		}
		else if (this.drawPriority == 180)
		{
			this.flag5.DrawActorPriority(200);
			this.DrawActorPriority(200);
		}
	};
}

function SPShot_C_Aura( t )
{
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetMotion(6022, this.rand() % 4);
	this.flag1 = (-1 + this.rand() % 3) * 0,01745329.0;
	this.sx = 1,50000000.0 + this.rand() % 3 * 0,10000000.0;
	this.sy = 1,50000000.0 + this.rand() % 3 * 0,10000000.0;
	this.flag2 = 0,02500000.0 + this.rand() % 10 * 0,00100000.0;
	this.subState = function ()
	{
		this.alpha -= this.flag2;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.sx = this.sy *= 0,92000002.0;
		this.AddSpeed_XY(0,00000000.0, -0,50000000.0);
		this.subState();
	};
}

function SPShot_D( t )
{
	this.SetShot(this.x, this.y, this.direction, this.owner.SPShot_D_Shadow, {});
	this.stateLabel = function ()
	{
		this.ReleaseActor();
	};
}

function SPShot_D_Shadow( t )
{
	this.PlaySE(2912);
	this.SetMotion(6030, 0);
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_D_ShadowB, {}).weakref();
	this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.owner.SPShot_D_SetAura, {});
	this.DrawActorPriority(200);
	this.sx = this.sy = 1,00000000.0;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

			if (this.flag1)
			{
				this.flag1.func();
				this.flag1 = null;
			}

			this.owner.shadow = null;
			this.SetMotion(6030, 2);
			this.stateLabel = function ()
			{
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}

				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

			if (this.flag1)
			{
				this.flag1.func();
				this.flag1 = null;
			}

			this.PlaySE(2913);
			this.owner.shadow = null;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.owner.SPShot_D_Mask, {});
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.SetSpeed_XY(0,00000000.0, 0,05000000.0 * this.cos(this.count * 2 * 0,01745329.0));

		if (this.count >= 600 || this.owner.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		if (this.count % 12 == 1)
		{
			local t_ = {};
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.owner.SPShot_D_Aura, t_, this.weakref());
		}
	};
}

function SPShot_D_ShadowB( t )
{
	this.SetMotion(6030, 1);
	this.alpha = 0,00000000.0;
	this.flag1 = this.Vector3();
	this.flag1.x = this.x;
	this.flag1.y = this.y;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,00500000.0;
			this.alpha = this.red = this.green -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.alpha <= 0,94999999.0)
		{
			this.alpha += 0,05000000.0;
		}

		this.count++;
		this.sx = 1,00000000.0 + 0,02500000.0 * this.sin(this.count * 3 * 0,01745329.0);
		this.sy = 1,00000000.0 + 0,02500000.0 * this.sin(-this.count * 1,25000000.0 * 0,01745329.0);
	};
}

function SPShot_D_SetAura( t )
{
	this.SetMotion(6031, 4);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count <= 10)
		{
			for( local i = 0; i < 2; i++ )
			{
				local t_ = {};
				t_.rot <- this.rand() % 360 * 0,01745329.0;
				local r_ = 10 + this.rand() % 35 + this.count * 10;
				this.SetFreeObject(this.x + this.cos(t_.rot) * r_ * this.direction, this.y + this.sin(t_.rot) * r_, this.direction, this.owner.SPShot_D_SetAuraB, t_);
			}
		}

		this.sx = this.sy *= 0,98000002.0;
		this.red = this.green -= 0,05000000.0;

		if (this.red <= 0,00000000.0)
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
		}
	};
}

function SPShot_D_SetAuraB( t )
{
	this.SetMotion(6031, this.rand() % 4);
	this.sx = this.sy = 1,00000000.0 + this.rand() % 30 * 0,10000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(2,00000000.0 + this.rand() % 6, t.rot, this.direction);
	this.flag1 = (7 - this.rand() % 15) * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0,98000002.0;
		this.VX_Brake(0,25000000.0);
		this.AddSpeed_XY(0,00000000.0, -0,34999999.0);
		this.sx = this.sy *= 0,94999999.0;

		if (this.red > 0,00000000.0)
		{
			this.red -= 0,05000000.0;
		}
		else
		{
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SPShot_D_Aura( t )
{
	this.DrawActorPriority(190);
	this.SetMotion(6031, this.rand() % 4);
	this.sx = this.sy = 6,00000000.0 + this.rand() % 10 * 0,10000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.rx = (20 - this.rand() % 41) * 0,01745329.0;
	this.ry = (20 - this.rand() % 41) * 0,01745329.0;
	this.alpha = 0,00000000.0;
	this.subState = function ()
	{
		this.sx = this.sy -= 0,05000000.0;
		this.alpha += 0,01250000.0;

		if (this.alpha > 0,50000000.0)
		{
			this.alpha = 0,50000000.0;
		}

		if (this.sx <= 3,00000000.0 || this.initTable.pare == null)
		{
			this.subState = function ()
			{
				this.alpha -= 0,02500000.0;
				this.sx = this.sy -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0 || this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.flag1 = (0,50000000.0 + this.rand() % 5 * 0,10000000.0) * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.rz -= 0,50000000.0 * 0,01745329.0;
		this.subState();
	};
}

function SPShot_D_Mask( t )
{
	this.SetMotion(6032, 0);
	this.flag1 = this.SetShot(this.x, this.y, this.direction, this.owner.SPShot_D_MaskBack, {}).weakref();
	local gp_ = [
		this.weakref(),
		this.flag1.weakref()
	];
	this.flag1.hitOwner = this;
	this.DrawActorPriority(200);
	this.func = function ()
	{
		if (this.flag1)
		{
			this.flag1.func[0].call(this.flag1);
		}

		this.flag1 = null;
		this.SetMotion(6032, 6);
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};

	for( local i = 0; i < 8; i++ )
	{
		local t_ = {};
		this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_D_MaskTrail, t_, this.weakref());
	}

	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.func();
			return;
		}

		this.count++;

		if (this.count <= 8)
		{
			for( local i = 0; i < 2; i++ )
			{
				local t_ = {};
				t_.rot <- this.rand() % 360 * 0,01745329.0;
				local r_ = 10 + this.rand() % 35 + this.count * 10;
				this.SetFreeObject(this.x + this.cos(t_.rot) * r_ * this.direction, this.y + this.sin(t_.rot) * r_, this.direction, this.owner.SPShot_D_SetAuraB, t_);
			}
		}

		if (this.count >= 20)
		{
			this.count = 0;

			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			this.stateLabel = function ()
			{
				if (this.owner.IsDamage())
				{
					this.func();
					return;
				}

				this.count++;
				local vec_ = this.Vector3();

				if (this.hitCount <= 2)
				{
					this.HitCycleUpdate(6);
				}
				else
				{
					this.callbackGroup = 0;
				}

				if (this.hitTarget && this.hitTarget.len() > 0)
				{
					vec_.x = (this.owner.x - this.x) * 0,01000000.0;
					vec_.y = (this.owner.y - this.y - 70) * 0,01000000.0;
				}
				else
				{
					vec_.x = (this.owner.x - this.x) * 0,15000001.0;
					vec_.y = (this.owner.y - this.y - 70) * 0,15000001.0;
				}

				local r_ = vec_.LengthXY();

				if (this.count >= 40 && r_ <= 10,00000000.0)
				{
					this.func();
					return;
				}

				if (r_ > 30,00000000.0)
				{
					vec_.Normalize();
					vec_.Mul(30,00000000.0);
				}

				this.Warp(this.x + vec_.x, this.y + vec_.y);

				if (this.flag1)
				{
					this.flag1.Warp(this.x, this.y);
				}
			};
		}
	};
}

function SPShot_D_MaskBackB( t )
{
	this.SetMotion(6032, 5);
	this.DrawActorPriority(180);
	this.sx = this.sy = 0,00000000.0;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,92000002.0;
			this.alpha -= 0,09000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
}

function SPShot_D_MaskBack( t )
{
	this.atk_id = 8388608;
	this.SetMotion(6032, 1);
	this.sx = this.sy = 0,10000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.flag2 = -8,00000000.0 * 0,01745329.0;
	this.flag3 = this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_D_MaskBackB, {}).weakref();
	this.DrawActorPriority(180);
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,25000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.rz += this.flag2;

		if (this.flag3)
		{
			this.flag3.sx = this.flag3.sy = this.sx * 1,75000000.0;
			this.flag3.rz += this.flag2 * 0,50000000.0;
			this.flag3.Warp(this.x, this.y);
		}
	};
	this.func = [
		function ()
		{
			this.callbackGroup = 0;

			if (this.flag3)
			{
				this.flag3.func();
			}

			this.stateLabel = function ()
			{
				this.rz += this.flag2;
				this.flag2 *= 0,94999999.0;
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
			this.SetMotion(6032, 2);
			this.sx = this.sy = 2,00000000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			this.HitReset();
			this.hitCount = 0;
			this.flag2 = -16,00000000.0 * 0,01745329.0;
			this.count = 0;
			this.stateLabel = function ()
			{
				this.rz += this.flag2;
				this.sx = this.sy = 0,50000000.0 + (this.sx - 0,50000000.0) * 0,94999999.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

				if (this.hitCount > 2)
				{
					this.callbackGroup = 0;
				}

				if (this.flag3)
				{
					this.flag3.sx = this.flag3.sy = this.sx * 1,75000000.0;
					this.flag3.rz += this.flag2 * 0,50000000.0;
					this.flag3.Warp(this.x, this.y);
				}

				this.count++;
			};
		}
	];
}

function SPShot_D_MaskTrail( t )
{
	this.SetTrail(6032, 3 + this.rand() % 2, 15, 120 + this.rand() % 120);
	this.SetSpeed_Vec(10 + this.rand() % 10, this.rand() % 360 * 0,01745329.0, this.direction);
	this.flag2 = 0,10000000.0 + this.rand() % 16 * 0,01000000.0;
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(this.va.x * 0,94999999.0, this.va.y * 0,94999999.0);
		this.count++;

		if (this.count >= 20)
		{
			this.func[1].call(this);
		}
	};
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.linkObject[0].alpha -= 0,05000000.0;
				this.linkObject[0].anime.radius0 *= 0,50000000.0;
				this.linkObject[0].anime.length *= 0,80000001.0;

				if (this.linkObject[0].alpha <= 0,05000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.initTable.pare)
				{
					this.linkObject[0].anime.radius0 *= 0,95999998.0;
					local vec_ = this.Vector3();
					vec_.x = (this.owner.x - this.x) * 0,15000001.0;
					vec_.y = (this.owner.y - this.y - 70) * 0,15000001.0;
					local r_ = vec_.LengthXY();

					if (this.count >= 40 && r_ <= 10,00000000.0)
					{
						this.func[0].call(this);
						return;
					}

					if (r_ > 30,00000000.0)
					{
						vec_.Normalize();
						vec_.Mul(30,00000000.0);
					}

					this.Warp(this.x + vec_.x, this.y + vec_.y);
				}
				else
				{
					this.func[0].call(this);
				}
			};
		}
	];
}

function SPShot_E( t )
{
	this.atk_id = 16777216;
	this.SetMotion(6040, 0);
	this.rz = t.rot;
	this.FitBoxfromSprite();
	this.cancelCount = 9;
	this.flag1 = 0,00000000.0;
	this.keyAction = this.ReleaseActor;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.callbackGroup = 0;
		this.SetKeyFrame(12);
		this.stateLabel = function ()
		{
		};
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion == 3040)
		{
			if (this.owner.keyTake == 2)
			{
				if (this.count >= 20)
				{
					this.func();
					return;
				}

				if (this.initTable.addRot)
				{
					this.flag1 += this.initTable.addRot;
					this.rz += this.flag1 * 0,01745329.0;
					this.FitBoxfromSprite();
				}

				if (this.hitCount <= 3)
				{
					this.HitCycleUpdate(6);
				}
			}
			else
			{
				this.func();
				return;
			}
		}
		else
		{
			this.func();
			return;
		}
	};
}

function SPShot_F( t )
{
	this.atk_id = 33554432;
	this.SetMotion(6050, 0);
	this.SetTrail(6050, 1, 10, 20);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		this.count++;

		if (this.count >= this.initTable.count)
		{
			if (this.initTable.se)
			{
				this.PlaySE(2918);
			}

			this.HitReset();
			this.SetMotion(6050, 2);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.count = 0;
			this.sx = this.sy = 1,00000000.0 + this.rand() % 6 * 0,10000000.0;

			if (this.linkObject)
			{
				this.linkObject[0].ReleaseActor();
				this.linkObject = null;
			}

			this.keyAction = this.ReleaseActor;
			this.stateLabel = function ()
			{
				this.count++;
				this.sx = this.sy += 0,01000000.0;

				if (this.count >= 5)
				{
					this.alpha -= 0,05000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.stateLabel = null;
					}

					return;
				}
			};
		}

		this.AddSpeed_XY(0,00000000.0, 0,75000000.0);

		if (this.IsScreen(300))
		{
			this.ReleaseActor();
		}
	};
	this.keyAction = this.ReleaseActor;
}

function SPShot_F_Mask( t )
{
	this.SetMotion(6051, 0);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(-2,00000000.0 + this.rand() % 40 * 0,10000000.0, -(this.rand() % 30) * 0,10000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ( t_ )
		{
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.owner.SPShot_F, t_);
		},
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion != 3050)
		{
			this.func[0].call(this);
		}
	};
}

function SPShot_G_Mask( t )
{
	if (t.hit)
	{
		this.SetMotion(6064, t.keyTake);
	}
	else
	{
		this.SetMotion(6060, t.keyTake);
	}

	this.func = [
		function ()
		{
			this.SetSpeed_XY(-2,00000000.0 + this.rand() % 40 * 0,10000000.0, -(this.rand() % 30) * 0,10000000.0);
			this.stateLabel = function ()
			{
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
			this.DrawActorPriority(200);
			this.owner.ChangeEmotion(this.keyTake);
			local t_ = {};
			t_.keyTake <- this.keyTake;
			this.SetFreeObject(this.owner.point1_x, this.owner.point1_y, this.direction, function ( tab_ )
			{
				this.SetMotion(6062, tab_.keyTake);
				this.stateLabel = function ()
				{
					this.alpha -= 0,02500000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}, t_);
			local t_ = {};
			t_.keyTake <- this.keyTake;
			t_.hit <- false;

			if (this.motion == 6064)
			{
				t_.hit = true;
			}

			this.SetShot(this.owner.point1_x, this.owner.point1_y, this.direction, this.owner.SPShot_G_Flash, t_);
			this.SetMotion(6061, this.keyTake);
			this.stateLabel = function ()
			{
				if (this.owner.motion == 3060)
				{
					if (this.owner.keyTake >= 5)
					{
						this.func[2].call(this);
						return;
					}
					else
					{
						this.Warp(this.x + (this.owner.point1_x - this.x) * 0,34999999.0, this.y + (this.owner.point1_y - this.y) * 0,34999999.0);
					}
				}
				else
				{
					this.sx = this.sy = 1,00000000.0;
					this.func[0].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.sx = this.sy = 1,50000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,02500000.0;
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
		if (this.owner.motion != 3060)
		{
			this.func[0].call(this);
		}
	};
}

function SPShot_G_Font( t )
{
	this.SetShot(this.x, this.y, this.direction, this.owner.SPShot_G_Flash, {});
	this.SetMotion(6061, t.keyTake);
	this.DrawActorPriority(180);
	this.sx = this.sy = 1,50000000.0;
	local t_ = {};
	t_.keyTake <- this.keyTake;
	this.SetFreeObject(this.x, this.y, 1,00000000.0, function ( init_ )
	{
		this.SetMotion(6061, t.keyTake);
		this.sx = this.sy = 1,50000000.0;
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,05000000.0;
			this.alpha -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	}, t_);
	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0,01000000.0;
		this.count++;

		if (this.count >= 5)
		{
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SPShot_G_Flash( t )
{
	if (t.hit)
	{
		this.SetCollisionScaling(2,00000000.0, 2,00000000.0, 1,00000000.0);
		this.PlaySE(2917);
		this.SetMotion(6065, t.keyTake);
		this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
		{
			this.DrawActorPriority(180);
			this.SetMotion(6065, 3);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = function ()
			{
				this.alpha -= 0,03300000.0;
				this.AddSpeed_XY(0,00000000.0, 0,01500000.0);

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}, {});
	}
	else
	{
		this.SetMotion(6063, t.keyTake);
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,20000000.0;
		this.alpha -= 0,03000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A( t )
{
	this.SetMotion(4009, 0);
	this.atk_id = 67108864;
	this.sx = this.sy = t.scale;
	this.atkRate_Pat = t.rate;
	this.FitBoxfromSprite();
	this.SetParent(this.owner, 0, 0);
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.alpha -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(15);

		if (this.owner.motion != 4000)
		{
			this.func();
		}
	};
}

function SpellShot_A_Aura( t )
{
	this.func = [
		function ()
		{
			this.ReleaseActor();

			if (this.owner.spellA_Aura == this)
			{
				this.owner.spellA_Aura = null;
			}
		},
		function ()
		{
			if (this.owner.spellA_Charge < 10)
			{
				this.SetFreeObject(this.owner.x, this.owner.y, this.direction, this.owner.SpellShot_A_ChargeUp, {});
				this.owner.spellA_Charge++;
				this.PlaySE(2950);
			}
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 11 == 1)
		{
			local t_ = {};
			t_.scale <- 0,25000000.0 + this.owner.spellA_Charge * 0,20000000.0;
			this.SetFreeObject(this.owner.x, this.owner.y, this.direction, this.owner.SpellShot_A_AuraB, t_);
		}

		if (this.team.spell_time <= 0)
		{
			this.func[0].call(this);
		}
	};
}

function SpellShot_A_AuraB( t )
{
	this.SetMotion(7001, this.rand() % 2);

	if (this.rand() % 100 <= 50)
	{
		this.direction = -this.direction;
	}

	if (this.rand() % 100 <= 50)
	{
		this.DrawActorPriority(180);
	}

	this.sx = t.scale + this.rand() % 100 * 0,01000000.0;
	this.sy = t.scale + this.rand() % 100 * 0,01000000.0;
	this.alpha = 0,00000000.0;
	this.rz = (10 - this.rand() % 20) * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.Warp(this.owner.x, this.owner.y + 65);
		this.sx = this.sy += 0,02500000.0;
		this.sy += 0,02500000.0;
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.Warp(this.owner.x, this.owner.y + 65);
				this.sx = this.sy += 0,02500000.0;
				this.sy += 0,02500000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_A_ChargeUp( t )
{
	this.SetMotion(7001, 2);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.Warp(this.owner.x, this.owner.y);
		this.rz -= 4,00000000.0 * 0,01745329.0;
		this.sx = this.sy += 0,25000000.0;
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_B( t )
{
	this.SetMotion(7010, t.type);
	this.atk_id = 67108864;
	this.cancelCount = 15;
	this.atkRate_Pat = t.rate;
	this.flag1 = true;
	this.flag2 = true;
	this.keyAction = this.ReleaseActor;
	this.SetParent(this.owner, 0, 0);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.hitResult & 1)
		{
			if (this.flag2)
			{
				switch(this.keyTake)
				{
				case 0:
					this.target.DebuffSet_Fear(600);
					break;

				case 1:
					this.target.DebuffSet_Hyper(600);
					break;

				case 2:
					this.target.DebuffSet_Hate(600);
					break;
				}

				this.flag2 = false;
			}
		}

		this.HitCycleUpdate(5);

		if (this.owner.motion == 4010)
		{
			if (this.owner.keyTake != 3)
			{
				this.SetParent(null, 0, 0);
			}
		}
		else if (this.owner.keyTake != 3)
		{
			this.SetParent(null, 0, 0);
		}
	};
}

function SpellShot_C_Pilar( t )
{
	this.SetMotion(7023, 0);
	this.atk_id = 67108864;
	this.atkRate_Pat = t.rate;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.SetKeyFrame(2);
		this.stateLabel = function ()
		{
			this.sx *= 0,85000002.0;
		};
	};
	this.cancelCount = 20;
	this.stateLabel = function ()
	{
		this.count++;
		this.HitCycleUpdate(3);

		if (this.count % 8 == 1)
		{
			local t_ = {};
			t_.dir <- 1,00000000.0;
			t_.priority <- 180;
			t_.count <- 60;
			this.SetFreeObject(this.x + 150 - this.rand() % 300, this.owner.centerY + 400 + this.rand() % 100, this.direction, this.owner.SpellShot_C, t_);
		}

		if (this.count >= 72 || this.owner.IsDamage() || this.cancelCount <= 0)
		{
			this.func();
		}
	};
}

function SpellShot_C( t )
{
	this.SetMotion(7020, 0);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 0,85000002.0 + this.rand() % 30 * 0,01000000.0;

	if (this.sx < 1,00000000.0)
	{
		this.DrawActorPriority(180);
	}

	this.SetSpeed_XY(0,00000000.0, (-15,00000000.0 - this.rand() % 6) * this.sx);
	this.flag1 = this.rand() % 360 * 0,01745329.0;
	this.flag2 = 3,00000000.0 + this.rand() % 7;
	this.SetTrail(7022, 2, 20 + this.rand() % 15, 50 + this.rand() % 50);
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;
		this.flag1 += 6,00000000.0 * 0,01745329.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.SetSpeed_XY(this.flag2 * this.cos(this.flag1) * this.direction, this.va.y);

		if (this.IsScreen(200,00000000.0))
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_C_B( t )
{
	this.SetMotion(7021, 0);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 0,85000002.0 + this.rand() % 30 * 0,01000000.0;
	this.FitBoxfromSprite();

	if (this.sx < 1,00000000.0)
	{
		this.DrawActorPriority(180);
	}

	this.SetSpeed_XY(0,00000000.0, 25,00000000.0 * this.sx);
	this.rz = 3,14159203.0;
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.VY_Brake(0,40000001.0);
		local vy_ = 5,00000000.0 * this.sx;

		if (this.va.y < vy_)
		{
			this.SetSpeed_XY(0,00000000.0, vy_);
		}

		if (this.hitCount == 0 && this.grazeCount <= 5)
		{
			this.HitCycleUpdate(0);
		}

		if (this.IsScreen(200,00000000.0))
		{
			this.ReleaseActor();
		}
	};
}

function Climax_Shot( t )
{
	this.SetMotion(4909, 4);
	this.target = this.owner.target.weakref();
	this.DrawActorPriority(220);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			if (this.hitResult & 1)
			{
				this.func[2].call(this);
				return true;
			}
			else
			{
				this.func[0].call(this);
				return false;
			}
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				::camera.shake_radius = 3,00000000.0;
				this.count++;
				this.sx = this.sy += 0,02500000.0;

				if (this.count % 5 == 1)
				{
					local t_ = {};
					t_.scale <- this.sx;
					this.SetFreeObject(this.x, this.y, this.direction, this.owner.Climax_SmokeB, t_);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,02500000.0;
				this.alpha -= 0,03300000.0;
				this.red *= 0,94999999.0;
				this.green *= 0,94999999.0;
				this.blue *= 0,94999999.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.flag1 = 1,00000000.0;
	this.flag2 = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;
		this.flag1 += 0,01000000.0;
		this.sx = this.sy += (this.flag1 - this.sx) * 0,08000000.0;
		this.flag2 += 0,00750000.0;

		if (this.count % 3 == 2)
		{
			local t_ = {};
			t_.scale <- this.sx * 1,25000000.0;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Climax_Smoke, t_);
		}

		if (this.count % 6 == 1)
		{
			local t_ = {};
			t_.scale <- this.sx;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Climax_Pilar, t_);
		}
	};
}

function Climax_Smoke( t )
{
	this.SetMotion(4909, 1);
	this.DrawActorPriority(180);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = t.scale * (0,89999998.0 + this.rand() % 21 * 0,01000000.0);
	this.SetSpeed_Vec(10,00000000.0 * t.scale, this.rand() % 360 * 0,01745329.0, this.direction);
	this.flag1 = (10 - this.rand() % 21) * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += this.sx * 0,01000000.0;
		this.flag1 *= 0,94999999.0;
		this.rz += this.flag1;
		this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
	};
	this.SetTaskAddColor(-0,05000000.0, 0,00500000.0, 0,00000000.0, 0,00000000.0);
	this.SetCallbackColorA(function ()
	{
		this.ReleaseActor();
	}, 0,00000000.0, false);
}

function Climax_SmokeB( t )
{
	this.SetMotion(4909, 1);
	this.DrawActorPriority(180);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = t.scale * (0,89999998.0 + this.rand() % 21 * 0,01000000.0);
	this.SetSpeed_Vec(10,00000000.0 * t.scale, this.rand() % 360 * 0,01745329.0, this.direction);
	this.flag1 = (10 - this.rand() % 21) * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += this.sx * 0,01000000.0;
		this.flag1 *= 0,94999999.0;
		this.rz += this.flag1;
		this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
	};
	this.SetTaskAddColor(-0,01500000.0, 0,00500000.0, 0,00000000.0, 0,00000000.0);
	this.SetCallbackColorA(function ()
	{
		this.ReleaseActor();
	}, 0,00000000.0, false);
}

function Climax_SmokeC( t )
{
	this.SetMotion(4909, 1);
	this.DrawBackActorPriority(219);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 1,50000000.0 * (0,89999998.0 + this.rand() % 21 * 0,01000000.0);
	this.flag1 = (3 - this.rand() % 61 * 0,10000000.0) * 0,01745329.0;
	this.alpha = 0,01000000.0;
	this.subState = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha -= 0,02500000.0;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += this.sx * 0,00100000.0;
		this.flag1 *= 0,98000002.0;
		this.rz += this.flag1;
		this.AddSpeed_XY(0,00000000.0, -0,01000000.0);
		this.subState();
	};
	this.SetCallbackColorA(function ()
	{
		this.ReleaseActor();
	}, 0,00000000.0, false);
}

function Climax_Pilar( t )
{
	this.SetMotion(4909, 2);
	this.DrawActorPriority(180);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sy = 0,01000000.0;
	this.SetSpeed_Vec(10,00000000.0 * t.scale, this.rz, this.direction);
	this.stateLabel = function ()
	{
		this.sy += (t.scale - this.sy) * 0,10000000.0;
	};
	this.SetTaskAddColor(-0,05000000.0, 0,00500000.0, 0,00000000.0, 0,00000000.0);
	this.SetCallbackColorA(function ()
	{
		this.ReleaseActor();
	}, 0,00000000.0, false);
}

function Climax_Cut_Arm( t )
{
	this.SetMotion(4909, 9);
	this.DrawBackActorPriority(102);
	this.SetSpeed_XY(0,05000000.0 * this.direction, 0,02500000.0);
	this.flag1 = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.flag1 += 0,01250000.0;

		if (this.flag1 > 1,00000000.0)
		{
			this.flag1 = 1,00000000.0;
		}

		this.flag2 = this.Math_Bezier(4,00000000.0, 0,25000000.0, 0,50000000.0, this.flag1);
		this.rz = this.Math_Bezier(0,00000000.0, 10,00000000.0 * 0,01745329.0, 10,00000000.0 * 0,01745329.0, this.flag1);
		this.SetSpeed_XY(this.flag2 * this.direction, 0,02500000.0);
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_Cut_Mask( t )
{
	this.SetMotion(4909, 10);
	this.DrawBackActorPriority(101);
	this.stateLabel = function ()
	{
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_Cut( t )
{
	this.SetMotion(4909, 8);
	this.DrawBackActorPriority(100);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag4 = 0,10000000.0;
	this.flag5 = {};
	this.flag5.vib <- 20,00000000.0;
	this.flag5.scale <- 3,50000000.0;
	this.sx = this.sy = 1,00000000.0;
	this.rz = -5,00000000.0 * 0,01745329.0;
	this.SetSpeed_XY(0,20000000.0 * this.direction, 0,02000000.0);
	this.func = [
		function ()
		{
			this.flag1.Foreach(function ()
			{
				this.ReleaseActor();
			});
			this.ReleaseActor();
		},
		function ()
		{
			this.FadeIn(1,00000000.0, 0,00000000.0, 0,00000000.0, 20);
			this.flag1.Foreach(function ()
			{
				this.ReleaseActor();
			});
			this.SetMotion(4909, 10);
			this.flag2 = 20,00000000.0;
			this.rz = 0,00000000.0;
			this.stateLabel = function ()
			{
				this.flag5.vib -= 0,20000000.0;

				if (this.flag5.vib <= 0)
				{
					this.flag5.vib = 0;
				}

				if (this.flag5.vib > 0)
				{
					this.x = 640 + this.rand() % this.flag5.vib;
					this.y = 360 + this.rand() % this.flag5.vib;
				}

				this.count += 1 + this.rand() % 2;
				this.sx = this.sy += (this.flag5.scale - this.flag4 - this.sx) * 0,20000000.0;
				this.flag4 = 0,15000001.0 * this.sin(this.count * 30 * 0,01745329.0);
				this.flag5.scale += (1,20000005.0 - this.flag5.scale) * 0,15000001.0;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,00125000.0;
		this.rz += 0,05000000.0 * 0,01745329.0;
		this.count++;

		if (this.count % 20 == 1)
		{
			this.flag1.Add(this.SetFreeObject(640, 360, 1,00000000.0, this.owner.Climax_Aura, {}));
		}

		if (this.count == 30)
		{
			this.SetMotion(this.motion, 9);
		}
	};
}

function Climax_Aura( t )
{
	this.SetMotion(4909, 7);
	this.DrawBackActorPriority(110);
	this.rx = -40 * 0,01745329.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 1,50000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.subState = function ()
	{
		this.alpha = this.red = this.green = this.blue -= 0,00500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
	this.stateLabel = function ()
	{
		this.rz -= 0,50000000.0 * 0,01745329.0;
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,05000000.0;
		this.subState();
	};
}

