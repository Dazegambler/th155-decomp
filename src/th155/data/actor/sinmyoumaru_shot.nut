function Shot_Normal( t )
{
	this.SetMotion(2009, 0);
	this.atk_id = 16384;
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0, 0, (-6,50000000.0 - this.rand() % 65 * 0,10000000.0) * 0,01745329.0);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.SetSpeed_XY(this.va.x * 0,66000003.0, null);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
		}

		this.count++;
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);

		if (this.count >= 7)
		{
			this.count = this.rand() % 3 - 1;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalTrail, {});
		}
	};
}

function Shot_NormalTrail( t )
{
	this.SetMotion(2009, 3);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = 0,50000000.0 + this.rand() % 5 * 0,10000000.0;
	this.sx = this.sy = 0,50000000.0;
	this.subState = function ()
	{
		this.alpha -= 0,03300000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += (this.flag1 - this.sx) * 0,15000001.0;
		this.AddSpeed_XY(0,00000000.0, 0,10000000.0);
		this.subState();
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 1);
	this.atk_id = 65536;
	this.SetFreeObject(this.x, this.y, this.direction, function ( t )
	{
		this.SetMotion(2019, 3);
		this.stateLabel = function ()
		{
			this.sx += 0,15000001.0;
			this.sy *= 0,89999998.0;
			this.alpha = this.red = this.green -= 0,20000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	}, {});
	this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sy *= 0,89999998.0;
				this.alpha = this.red = this.green -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100,00000000.0) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.hitResult & 32)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2029, 0);
	this.atk_id = 131072;
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
	};
}

function Shot_ChargeFull( t )
{
	this.flag1 = 1,50000000.0;
	this.flag2 = 0;
	this.rz = -15 * 0,01745329.0;
	local t_ = {};
	t_.scale <- this.flag1;
	t_.rot <- this.rz;
	this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeFull_Slash, t_);
	this.flag1 += 0,25000000.0;
	this.flag2++;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 16 == 0)
		{
			this.PlaySE(3434);
			this.x += 500 * this.direction * this.cos(this.rz) + 50 * this.direction;
			this.y += 500 * this.sin(this.rz);
			this.rz += 3,14159203.0;
			local t_ = {};
			t_.scale <- this.flag1;
			t_.rot <- this.rz;

			if (this.flag2 <= 3)
			{
				this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeFull_Slash, t_);
			}
			else
			{
				this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeFull_SlashF, t_);
			}

			this.flag1 += 0,05000000.0;
			this.flag2++;
		}

		if (this.flag2 >= 5)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_ChargeFull_Slash( t )
{
	this.SetMotion(2028, 0);
	this.sx = this.sy = t.scale;
	this.cancelCount = 3;
	this.rz = t.rot;
	this.FitBoxfromSprite();
	this.stateLabel = function ()
	{
	};
	this.keyAction = this.ReleaseActor;
}

function Shot_ChargeFull_SlashF( t )
{
	this.SetMotion(2028, 1);
	this.sx = this.sy = t.scale;
	this.cancelCount = 3;
	this.rz = t.rot;
	this.FitBoxfromSprite();
	this.stateLabel = function ()
	{
	};
	this.keyAction = this.ReleaseActor;
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, 0);
	this.atk_id = 262144;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.va.y *= 0,50000000.0;
	this.AddSpeed_XY(this.owner.va.x * 0,50000000.0, -2,00000000.0 + this.owner.va.y * 0,25000000.0);
	this.sx = this.sy = 0,80000001.0 + this.rand() % 21 * 0,01000000.0;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, 2);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,92000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 32 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}

		this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
	};
}

function Shot_Barrage_DummyBack( t )
{
	this.SetMotion(2026, 2);
	this.DrawActorPriority(180);
	this.sx = this.sy = 2,00000000.0 + this.rand() % 51 * 0,01000000.0;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
		this.sx = this.sy *= 0,98000002.0;
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Barrage_Dummy( t )
{
	this.SetMotion(2026, 2);
	this.sx = this.sy = 2,00000000.0 + this.rand() % 51 * 0,01000000.0;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
		this.sx = this.sy *= 0,98000002.0;
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.atk_id = 536870912;
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0, 0, (-6,50000000.0 - this.rand() % 65 * 0,10000000.0) * 0,01745329.0);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.AddSpeed_XY(this.rand() % 11 * 0,10000000.0, -3,00000000.0 - this.rand() % 11 * 0,10000000.0);
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_NormalTrail, {});
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
		}

		this.count++;
		this.AddSpeed_XY(0,00000000.0, 0,10000000.0);
	};
}

function SPShot_A( t )
{
	this.SetMotion(3009, 0);
	this.SetParent(this.owner, 0, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy = 1,00000000.0;
				this.SetMotion(3009, 0);
				this.stateLabel = function ()
				{
					this.sx = this.sy += 0,02500000.0;
				};
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
	};
}

function SPShot_B_Core( t )
{
	this.flag1 = [
		60 * 0,01745329.0,
		180 * 0,01745329.0,
		320 * 0,01745329.0
	];
	this.flag2 = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag2[0].x = 25,00000000.0;
	this.flag2[1].x = 10,00000000.0;
	this.flag2[2].x = 15,00000000.0;
	this.SPShot_B_Core_Base(null);
}

function SPShot_B2_Core( t )
{
	this.flag1 = [
		40 * 0,01745329.0,
		200 * 0,01745329.0,
		300 * 0,01745329.0
	];
	this.flag2 = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag2[0].x = 45,00000000.0;
	this.flag2[1].x = 50,00000000.0;
	this.flag2[2].x = 35,00000000.0;
	this.SPShot_B_Core_Base(null);
}

function SPShot_B3_Core( t )
{
	this.flag1 = [
		-80 * 0,01745329.0,
		60 * 0,01745329.0,
		190 * 0,01745329.0
	];
	this.flag2 = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag2[0].x = 60,00000000.0;
	this.flag2[1].x = 42,00000000.0;
	this.flag2[2].x = 55,00000000.0;
	this.SPShot_B_Core_Base(null);
}

function SPShot_B_Core_Base( t )
{
	this.flag3 = ::manbow.Actor2DProcGroup();

	for( local i = 0; i < 3; i++ )
	{
		this.flag2[i].RotateByRadian(this.flag1[i]);
		local t_ = {};
		t_.rot <- this.flag1[i];
		this.flag3.Add(this.SetFreeObject(this.x + this.flag2[i].x * this.direction, this.y + this.flag2[i].y, this.direction, this.owner.SPShot_B_Line, t_));
	}

	this.func = [
		function ()
		{
			this.flag3.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.target.va.x != 0)
		{
			this.func[0].call(this);
		}
	};
}

function SPShot_B_Line( t )
{
	this.SetMotion(3019, 0);
	this.sx = 0,10000000.0;
	this.sy = 0,50000000.0;
	this.rz = t.rot + 90 * 0,01745329.0;
	this.SetSpeed_Vec(2,50000000.0, t.rot, this.direction);
	this.func = [
		function ()
		{
			this.SetSpeed_Vec(15,00000000.0, this.initTable.rot, this.direction);
			this.stateLabel = function ()
			{
				this.sy *= 0,94999999.0;
				this.alpha = this.red = this.green -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx += (1,00000000.0 - this.sx) * 0,60000002.0;
		this.sy += (1,00000000.0 - this.sy) * 0,60000002.0;
		this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	};
}

function SPShot_B( t )
{
	this.SetMotion(3019, t.take);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,01000000.0;
		this.alpha -= 0,03300000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_B2( t )
{
	this.SetMotion(3019, 3);
	this.sx = this.sy = 2,00000000.0;
	this.SetParent(this.owner.target, 0, 0);
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.blue = this.green -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.sx > 1,00000000.0)
		{
			this.sx = this.sy -= 0,20000000.0;
		}

		if (this.owner.target.va.x != 0)
		{
			this.func[0].call(this);
		}
	};
}

function SPShot_C( t )
{
	this.SetMotion(3029, 0);
	this.atk_id = 4194304;
	this.rz = t.rot;
	this.sx = this.sy = t.scale * 0,50000000.0;
	this.SetSpeed_Vec(20,00000000.0, this.rz, this.direction);
	this.rz += (-10 + this.rand() % 21) * 0,01745329.0;
	this.DrawActorPriority(t.priority);
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.actorType = 4;
	this.atkOwner = this.owner.weakref();
	this.stateLabel = function ()
	{
		this.Vec_Brake(4,00000000.0);
		this.count++;

		if (this.count >= 10)
		{
			this.alpha -= 0,02500000.0;
			this.green = this.red -= 0,02500000.0;
			this.sy *= 0,98000002.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
		else if (this.hitResult && this.owner.motion == 3020)
		{
			this.owner.hitResult = this.hitResult | this.owner.hitResult;
		}
	};
}

function SPShot_C2( t )
{
	this.SetMotion(3029, 3);
	this.atk_id = 4194304;
	this.rz = t.rot;
	this.sx = this.sy = t.scale * 0,50000000.0;
	this.SetSpeed_Vec(20,00000000.0, this.rz, this.direction);
	this.rz += (-10 + this.rand() % 21) * 0,01745329.0;
	this.DrawActorPriority(t.priority);
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.actorType = 4;
	this.atkOwner = this.owner.weakref();
	this.stateLabel = function ()
	{
		this.Vec_Brake(4,00000000.0);
		this.count++;

		if (this.count >= 10)
		{
			this.alpha -= 0,02500000.0;
			this.green = this.red -= 0,02500000.0;
			this.sy *= 0,98000002.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
		else if (this.hitResult && this.owner.motion == 3020)
		{
			this.owner.hitResult = this.hitResult | this.owner.hitResult;
		}
	};
}

function SPShot_C_Hit( t )
{
	this.SetMotion(3029, 2);
	this.SetCollisionScaling(t.scale, t.scale, 1,00000000.0);
	this.keyAction = this.ReleaseActor;
	this.actorType = 4;
	this.atkOwner = this.owner.weakref();
}

function SPShot_D( t )
{
	this.SetMotion(3039, 0);
	this.atk_id = 8388608;
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(20,00000000.0, this.rz, this.direction);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.count = 12;
	this.func = [
		function ()
		{
			this.SetMotion(3039, 1);
			this.stateLabel = function ()
			{
				this.Vec_Brake(5,00000000.0);
				this.flag1.Foreach(function ( a = this )
				{
					this.subState(a);
				});
				this.count++;

				if (this.count >= 12)
				{
					this.count = 0;
					local t_ = {};
					t_.rot <- this.rz;
					this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_D_Aura, t_));
				}
			};
		},
		function ()
		{
			if (!(this.hitResult & 1))
			{
				local t_ = {};
				t_.rot <- this.initTable.rot;

				if (t_.rot > 0)
				{
					t_.rot = 0;
				}

				this.SetShot(this.x, this.y, this.direction, this.owner.SPShot_D_FishShot, t_);
				this.flag1.Foreach(function ()
				{
					this.ReleaseActor();
				});
				this.HitReset();
				this.SetEffect(this.x, this.y, this.direction, this.EF_HitSmashC, {});
				this.SetMotion(3039, 3);
				this.rz = 60 * 0,01745329.0;
				this.SetSpeed_Vec(35,00000000.0, this.rz + 3,14159203.0, this.direction);
				this.stateLabel = function ()
				{
					this.flag1.Foreach(function ( a = this )
					{
						this.subState(a);
					});
					this.HitCycleUpdate(6);
					this.sy *= 0,94000000.0;
					this.alpha -= 0,05000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}
			else
			{
				this.HitReset();
				local t_ = {};
				t_.rot <- this.initTable.rot;
				this.SetShot(this.x, this.y, this.direction, this.owner.SPShot_D_Fish, t_);
				this.SetEffect(this.x, this.y, this.direction, this.EF_HitSmashC, {});
				this.direction = -this.direction;
				this.SetMotion(3039, 2);
				this.rz -= 20 * 0,01745329.0;
				this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
				this.SetSpeed_Vec(35,00000000.0, -this.rz + 3,14159203.0, -this.direction);
				this.flag1.Foreach(function ()
				{
					this.ReleaseActor();
				});
				this.stateLabel = function ()
				{
					this.sy *= 0,94000000.0;
					this.alpha -= 0,05000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
			}
		},
		function ()
		{
			this.flag1.Foreach(function ()
			{
				this.ReleaseActor();
			});
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 5) || this.owner.motion != 3030 && this.owner.motion != 3031)
		{
			this.func[3].call(this);
			return;
		}
		else
		{
			this.flag1.Foreach(function ( a = this )
			{
				this.subState(a);
			});
			this.count++;

			if (this.count >= 12)
			{
				this.count = 0;
				local t_ = {};
				t_.rot <- this.rz;
				this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_D_Aura, t_));
			}

			if (this.hitResult & 1)
			{
				this.Vec_Brake(3,00000000.0);
			}
			else
			{
				this.VX_Brake(0,10000000.0);
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.rz = this.atan2(this.va.y, this.va.x * this.direction);
				this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
			}
		}
	};
}

function SPShot_D_Aura( t )
{
	this.SetMotion(3039, 4);
	this.DrawActorPriority(199);
	this.alpha = 0,00000000.0;
	this.rz = t.rot;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 21 * 0,01000000.0;
	this.flag1 = this.Vector3();
	this.flag1.x = 90,00000000.0;
	this.flag1.RotateByRadian(this.rz + 3,14159203.0);
	this.subState = function ( a )
	{
		this.rz = a.rz;
		this.x = a.x + this.va.x + this.flag1.x * (this.sx - 1,00000000.0) * this.direction;
		this.y = a.y + this.va.y + this.flag1.y * (this.sx - 1,00000000.0);
	};
	this.func = [
		function ()
		{
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
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,05000000.0;
		this.alpha += 0,25000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.func[0].call(this);
		}
	};
}

function SPShot_D_Fish( t )
{
	this.SetMotion(3039, 6);
	this.sx = this.sy = 2,00000000.0;
	this.rz = t.rot;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.keyAction = this.ReleaseActor;
}

function SPShot_D_FishShot( t )
{
	this.SetMotion(3039, 5);
	this.atk_id = 8388608;
	this.sx = this.sy = 2,00000000.0;
	this.rz = t.rot;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.keyAction = this.ReleaseActor;
}

function SPShot_E( t )
{
	this.SetMotion(3049, 0);
	this.atk_id = 16777216;
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(10,00000000.0, this.rz, this.direction);
	this.cancelCount = 3;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,94999999.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.count >= 75 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.func();
			return;
		}

		this.count++;
		this.Vec_Brake(0,10000000.0, 5,00000000.0);
	};
}

function Shot_Occult( t )
{
	this.SetMotion(2509, 0);
	this.atk_id = 524288;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OccultPat, {});
	this.sx = this.sy = 0,10000000.0;
	this.flag2 = this.Vector3();
	this.flag2.x = 0,50000000.0;
	this.cancelCount = 1;
	this.SetSpeed_XY(t.v.x, t.v.y);
	this.flag3 = 150;
	this.flag3 = 180;
	this.func = [
		function ()
		{
			this.SetMotion(2509, 5);

			if (this.flag5)
			{
				this.flag5.ReleaseActor();
			}

			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.sx = this.sy = 2,00000000.0;
			this.alpha = 1,50000000.0;
			this.rz = 0,00000000.0;
			this.stateLabel = function ()
			{
				this.sy *= 0,60000002.0;
				this.sx += 0,40000001.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(2509, 1);
			this.SetSpeed_XY(-8,00000000.0 * this.direction, this.rand() % 7 - 3);
			this.stateLabel = function ()
			{
				if (this.cancelCount <= 0 || this.Damage_ConvertOP(this.x, this.y, 2))
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OccultPat, {});
					this.ReleaseActor();
					return;
				}

				this.Vec_Brake(0,50000000.0);
			};
		}
	];
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3438);
			this.flag5 = this.SetTrail(2509, 4, 15, 40, null).weakref();
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.cancelCount <= 0 || this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OccultPat, {});
					this.ReleaseActor();
					return;
				}

				this.TargetHoming(this.owner.target, 0,01745329.0, this.direction);
				this.rz = this.atan2(this.va.y, this.va.x * this.direction);

				if (this.hitCount > 0)
				{
					this.SetMotion(2509, 3);

					if (this.flag5)
					{
						this.flag5.stateLabel = function ()
						{
							this.alpha -= 0,10000000.0;
							this.anime.length *= 0,94999999.0;
							this.anime.radius0 *= 0,80000001.0;

							if (this.alpha <= 0,00000000.0)
							{
								this.ReleaseActor();
							}
						};
					}

					this.stateLabel = function ()
					{
						if (this.IsScreen(100))
						{
							this.ReleaseActor();
							return;
						}

						this.AddSpeed_XY(this.va.x * this.direction < 15,00000000.0 ? 0,50000000.0 * this.direction : 0,00000000.0, 0,00000000.0);
					};
				}

				this.AddSpeed_XY(this.va.x * this.direction < 15,00000000.0 ? 0,50000000.0 * this.direction : 0,00000000.0, 0,00000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OccultPat, {});
			this.ReleaseActor();
			return;
		}

		this.count++;

		if (this.count >= 30)
		{
			this.Vec_Brake(0,75000000.0);
		}
		else
		{
			this.AddSpeed_XY(0,00000000.0, 0,40000001.0);
		}

		if ((this.owner.target.x - this.x) * this.direction < 0)
		{
			this.direction = -this.direction;
		}

		if (this.count >= 45 && (this.owner.target.x - this.x) * this.direction >= 0 && this.direction == this.owner.target.direction)
		{
			this.func[1].call(this);
			return;
		}

		if (this.count >= 300)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,20000000.0;
	};
}

function Shot_OccultPat( t )
{
	this.SetMotion(2508, 0);
	this.sx = this.sy = 0,75000000.0 + this.rand() % 25 * 0,01000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.alpha = 0,00000000.0;
	this.subState = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.subState = function ()
			{
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
		this.AddSpeed_XY(0,00000000.0, 0,15000001.0);
		this.subState();
	};
}

function SpellShot_A( t )
{
	this.SetMotion(4009, this.rand() % 2);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(4 + this.rand() % 12, (-45 + this.rand() % 91) * 0,01745329.0, this.direction);
	this.SetTaskAddColor(-0,05000000.0 - this.rand() % 15 * 0,00010000.0, 0, 0, 0);
	this.SetCallbackColorA(this.ReleaseActor, 0, false);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
	};
}

function SpellShot_A_Flash( t )
{
	this.SetMotion(4009, 2);
	this.sx = this.sy = 2,00000000.0 + this.rand() % 11 * 0,10000000.0;
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

function SpellShotA_ShotBaria( t )
{
	this.SetMotion(4008, 4);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.cancelCount = 3;
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		if (this.hitResult)
		{
			for( local i = -20; i <= 20; i = i + 6 )
			{
				local t_ = {};
				t_.rot <- (i - this.rand() % 6) * 0,01745329.0;
				t_.rate <- this.initTable.rate;
				this.SetShot(this.x, this.y, this.direction, this.SpellShotA_CounterShot, t_);
			}

			this.ReleaseActor();
		}
	};
}

function SpellShotA_CounterShot( t )
{
	this.SetMotion(4008, 0);
	this.atk_id = 67108864;
	this.atkRate_Pat = t.rate;
	this.cancelCount = 3;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0, 0, (-6,50000000.0 - this.rand() % 65 * 0,10000000.0) * 0,01745329.0);
	this.SetSpeed_Vec(20 + this.rand() % 10, t.rot, this.direction);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
		}

		this.count++;
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);

		if (this.count >= 7)
		{
			this.count = this.rand() % 3 - 1;
			this.SetFreeObject(this.x, this.y, this.direction, this.Shot_NormalTrail, {});
		}
	};
}

function SpellShot_B_SmallEnd( t )
{
	this.SetMotion(4018, 0);
	this.SetParent(this.owner, 0, 0);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 0,10000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.alpha = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,25000000.0;
				this.count++;

				if (this.count >= 20)
				{
					this.alpha -= 0,20000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				}
				else if (this.count % 2 == 1)
				{
					local t_ = {};
					t_.scale <- this.sx;
					local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_B_SmallEndB, t_);
					a_.SetParent(this, 0, 0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.sx = this.sy += 0,40000001.0;
		}
	};
}

function SpellShot_B_SmallEndB( t )
{
	this.SetMotion(4018, 1);
	this.sx = this.sy = t.scale;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 1,20000005.0;
		this.alpha -= 0,20000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_B_Small( t )
{
	this.SetMotion(4019, 0);
	this.SetParent(this.owner, 0, 0);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.alpha = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (0,10000000.0 - this.sx) * 0,25000000.0;
				this.count++;

				if (this.count >= 20)
				{
					this.alpha -= 0,20000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				}
				else if (this.count % 2 == 1)
				{
					local t_ = {};
					t_.scale <- this.sx;
					local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_B_SmallB, t_);
					a_.SetParent(this, 0, 0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.sx = this.sy += 0,20000000.0;
		}
	};
}

function SpellShot_B_SmallB( t )
{
	this.SetMotion(4019, 1);
	this.sx = this.sy = t.scale;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 1,20000005.0;
		this.alpha -= 0,20000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_C_Shot( t )
{
	this.SetMotion(4029, 0);
	this.atk_id = 67108864;
	this.rz = t.rot;
	this.atkRate_Pat = t.rate;
	this.SetSpeed_Vec(50,00000000.0, this.rz, this.direction);
	this.cancelCount = 3;
	this.sx = this.sy = 0,10000000.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.stateLabel = function ()
	{
		if (this.IsScreen(300))
		{
			this.ReleaseActor();
		}

		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,15000001.0;
	};
}

function Spell_C_ShotB( t )
{
	this.SetMotion(4029, 3);
	this.stateLabel = function ()
	{
		if (this.count >= 240)
		{
			this.team.spell_enable_end = true;
			this.ReleaseActor();
			return;
		}

		this.count++;

		if (this.count <= 120)
		{
			if (this.count % 10 == 1)
			{
				this.SetFreeObject(this.x, this.y, -this.direction, this.Spell_C_ShotB_Pilar, {});
			}

			if (this.count % 7 == 1)
			{
				local t_ = {};
				t_.rate <- this.initTable.rate;
				this.SetShot(this.x, ::battle.scroll_bottom + 125, -this.direction, this.Spell_C_ShotB_Fish, t_);
			}
		}
	};
}

function Spell_C_ShotB_Fish( t )
{
	this.SetMotion(4028, 0);
	this.atk_id = 67108864;
	this.atkRate_Pat = t.rate;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 1,00000000.0 + this.rand() % 61 * 0,01000000.0;
	this.flag1 = 9,50000000.0 * 0,01745329.0;
	this.SetSpeed_XY((3,00000000.0 + this.rand() % 4) * this.direction, -25,00000000.0 - this.rand() % 4);
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		this.rz += this.flag1;

		if (this.va.y > 0,00000000.0)
		{
			this.flag1 *= 0,92000002.0;

			if (this.flag1 < 2,00000000.0 * 0,01745329.0)
			{
				this.flag1 = 2,00000000.0 * 0,01745329.0;
			}
		}

		this.AddSpeed_XY(0,00000000.0, this.va.y > 0,00000000.0 ? 0,75000000.0 : 0,50000000.0);

		if (this.keyTake == 0 && this.va.y > 3,00000000.0)
		{
			this.SetMotion(4028, this.keyTake + 1);
		}

		if (this.y > ::battle.scroll_bottom + 150 && this.va.y > 0)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_C_ShotB_Pilar( t )
{
	this.SetMotion(4029, 1);
	this.rz = 20 * 0,01745329.0;
	this.sx = this.sy = 0,10000000.0;
	this.DrawActorPriority(180);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,66000003.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.count++;

		if (this.count >= 12)
		{
			this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
			this.alpha = this.red = this.green -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_CrackA( t )
{
	this.SetMotion(4908, 5);
	this.DrawActorPriority(180);
	this.sx = this.sy = 0,50000000.0;
	this.func = [
		function ()
		{
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
			this.stateLabel = function ()
			{
				this.sx += 0,25000000.0;
				this.sy += 0,10000000.0;
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
		this.sx = this.sy += (1,20000005.0 - this.sx) * 0,50000000.0;
	};
}

function Climax_CrackB( t )
{
	this.SetMotion(4908, 6);
	this.DrawActorPriority(210);
	this.sx = this.sy = 0,50000000.0;
	this.func = [
		function ()
		{
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
			this.stateLabel = function ()
			{
				this.sx += 0,25000000.0;
				this.sy += 0,10000000.0;
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
		this.sx = this.sy += (1,20000005.0 - this.sx) * 0,50000000.0;
	};
}

function Climax_Koduchi( t )
{
	this.SetMotion(4908, 1);
	this.SetSpeed_XY(0,00000000.0, -30,00000000.0);
	this.atkRate_Pat = t.rate;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = false;
	this.flag5 = {};
	this.flag5.fall <- false;
	this.flag5.light <- null;
	this.func = [
		function ()
		{
			this.SetMotion(4908, 3);
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});

			if (this.flag2)
			{
				this.owner.target.SetParent(null, 0, 0);
				this.owner.KnockBackTarget(-this.owner.direction);
				this.flag2 = null;
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.y = ::battle.scroll_top - 256;
			this.x = this.owner.x + 200 * this.direction;
			this.SetMotion(4908, 2);
			this.HitReset();
			this.SetSpeed_XY(0,00000000.0, 17,50000000.0);
			this.rz = 0,00000000.0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 1,00000000.0);
				this.rz += 25,00000000.0 * 0,01745329.0;
				this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

				if (this.flag2)
				{
					this.SetSpeed_XY.call(this.owner.target, (this.x - this.owner.target.x) * 0,34999999.0, (this.y - this.owner.target.y) * 0,34999999.0);
				}
				else if (this.hitResult & 1)
				{
					this.flag2 = true;
					this.owner.target.DamageGrab_Common(304, 0, -this.direction);
					this.owner.target.SetParent(this, this.owner.target.x - this.x, this.owner.target.y - (this.y + 75));
					this.SetMotion(4908, 3);
				}

				if (this.y >= ::battle.scroll_bottom - 100)
				{
					this.PlaySE(3474);
					this.y = ::battle.scroll_bottom - 100;

					if (this.flag2)
					{
						this.owner.target.x = this.x;
						this.owner.target.y = this.y + 75;
						this.owner.target.SetParent(null, 0, 0);
					}

					::camera.shake_radius = 10,00000000.0;
					this.flag1.Add(this.SetFreeObject(this.x, ::battle.scroll_bottom, this.direction, this.Climax_CrackA, {}));
					this.flag1.Add(this.SetFreeObject(this.x, ::battle.scroll_bottom, this.direction, this.Climax_CrackB, {}));
					this.SetMotion(4908, 3);
					this.rz = 20,00000000.0 * 0,01745329.0;
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.callbackGroup = 0;
					this.stateLabel = null;

					if (this.flag2)
					{
						this.owner.target.DamageGrab_Common(304, 1, -this.direction);
					}
				}
			};
		},
		function ()
		{
			if (!this.flag5.light)
			{
				this.flag5.light = this.SetFreeObject(this.x, this.y + 100, this.direction, this.ClimaxShot_HammerLight, {}).weakref();
			}
		},
		function ()
		{
			if (this.flag5.light)
			{
				this.flag5.light.func[0].call(this.flag5.light);
				this.flag5.light = null;
			}
		},
		function ()
		{
			this.SetMotion(4908, 3);
			this.SetSpeed_XY(-10,00000000.0 * this.direction, -40,00000000.0);
			this.stateLabel = function ()
			{
				this.rz -= 55 * 0,01745329.0;

				if (this.y < ::battle.scroll_top - 256)
				{
					this.ReleaseActor();
				}
			};
			this.flag1.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.owner.target.SetParent(null, 0, 0);
		}
	];
	this.stateLabel = function ()
	{
		this.rz -= 29,50000000.0 * 0,01745329.0;
	};
}

function ClimaxShot_HammerLight( t )
{
	this.SetMotion(4908, 7);
	this.count = 0;
	this.alpha = 0,00000000.0;
	this.flag1 = 0,20000000.0;
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
	this.PlaySE(3479);
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;
		local sr_ = (this.sx + this.flag1) / this.sx;
		this.sx = this.sy += this.flag1;
		this.flag2.Foreach(function ( s_ = sr_ )
		{
			this.sx = this.sy *= s_;
		});
		this.flag1 -= 0,00250000.0;

		if (this.flag1 < 0,00500000.0)
		{
			this.flag1 = 0,00500000.0;
		}

		this.count++;

		if (this.count == 10)
		{
			this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.ClimaxShot_HammerLightB, {}));
		}

		if (this.count == 20)
		{
			this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.ClimaxShot_HammerLightRing, {}));
		}

		if (this.count == 45)
		{
			this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.ClimaxShot_HammerLightRay, {}));
		}

		if (this.count == 60)
		{
			this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.ClimaxShot_HammerLightRay, {}));
		}
	};
}

function ClimaxShot_HammerLightB( t )
{
	this.SetMotion(4908, 8);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 2,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;
		this.sx = this.sy += 0,01500000.0;
	};
}

function ClimaxShot_HammerLightRay( t )
{
	this.SetMotion(4908, 9);
	this.DrawActorPriority(180);
	this.sx = this.sy = 0,10000000.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, (1,00000000.0 - this.rand() % 21 * 0,10000000.0) * 0,01745329.0);
	this.flag2 = 10,00000000.0 + this.rand() % 51 * 0,10000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (this.flag2 - this.sx) * 0,05000000.0;
	};
}

function ClimaxShot_HammerLightRing( t )
{
	this.SetMotion(4908, 10);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 1,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.flag1 = 0,40000001.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;
		this.sx = this.sy += this.flag1;
		this.flag1 -= 0,02500000.0;

		if (this.flag1 < 0,02000000.0)
		{
			this.flag1 = 0,02000000.0;
		}
	};
}

function Climax_Cut( t )
{
	this.SetMotion(4909, 0);
	this.DrawScreenActorPriority(210);
	this.PlaySE(3480);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(0,20000000.0 * this.direction, 0,50000000.0);
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,00050000.0;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 50)
		{
			this.PlaySE(3481);
		}
	};
}

function Climax_Giant( t )
{
	this.SetMotion(4909, 3);
	this.DrawScreenActorPriority(208);
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.ReleaseActor();
			}

			this.ReleaseActor();
		}
	];
	this.keyAction = function ()
	{
		this.SetSpeed_XY(-0,20000000.0 * this.direction, -0,25000000.0);
		this.stateLabel = function ()
		{
			this.count++;

			if (this.count == 10)
			{
				this.PlaySE(3482);
				this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_GiantEye, {}).weakref();
				this.flag1.SetParent(this, this.flag1.x - this.x, this.flag1.y - this.y);
			}

			this.sx = this.sy += 0,00050000.0;

			if (this.flag1)
			{
				this.flag1.sx = this.sx;
				this.flag1.sy = this.sy;
			}
		};
	};
}

function Climax_GiantEye( t )
{
	this.SetMotion(4909, 5);
	this.DrawScreenActorPriority(209);
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}
	};
}

function Climax_Back( t )
{
	this.SetMotion(4909, 2);
	this.DrawScreenActorPriority(200);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_GiantFoot( t )
{
	this.SetMotion(4908, 11);
	this.atkRate_Pat = t.rate;
	this.SetSpeed_XY(0,00000000.0, 100,00000000.0);
	this.alpha = 2,50000000.0;
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 70 - 360)
		{
			this.PlaySE(3476);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.y = ::battle.scroll_bottom + 70 - 360;
			this.SetMotion(4908, 12);
			::camera.shake_radius = 15,00000000.0;
			this.owner.KnockBackTarget.call(this, -this.direction);

			if (this.owner.flag2)
			{
				this.owner.flag2.func[4].call(this.owner.flag2);
			}

			this.stateLabel = function ()
			{
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 1,00000000.0)
				{
					this.red = this.green = this.blue = this.alpha;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

