function BeginBattle_Ran( t )
{
	this.SetMotion(9000, 3);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.PlaySE(4449);
			this.SetMotion(9000, 4);
			this.keyAction = this.ReleaseActor;
		}
	];
}

function BeginBattle_ChenA( t )
{
	this.SetMotion(9000, 5);
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(9000, 6);
			this.keyAction = this.ReleaseActor;
		}
	];
}

function BeginBattle_ChenB( t )
{
	this.SetMotion(9000, 7);
	this.DrawActorPriority(180);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(9000, 8);
			this.keyAction = this.ReleaseActor;
		}
	];
}

function GrabHit_Effect( t )
{
	this.SetMotion(1803, 0);
	this.keyAction = this.ReleaseActor;
}

function Shot_Normal( t )
{
	this.SetMotion(2009, 0);
	this.SetSpeed_XY(t.v.x * this.direction * 3,50000000.0, t.v.y * 3,50000000.0);
	this.cancelCount = 2;
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.initTable.v.x = 0,50000000.0 * this.cos(this.rz) * this.direction;
	this.initTable.v.y = 0,50000000.0 * this.sin(this.rz);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 1);
			this.sx = this.sy = 1,50000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,10000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(this.initTable.v.x * 0,50000000.0, this.initTable.v.y * 0,50000000.0);
				this.sx += this.flag1;
				this.flag1 += 0,05000000.0;
				this.sy *= 0,89999998.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.flag1 = 0,05000000.0;
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
				{
					this.ReleaseActor();
					return;
				}

				if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.count >= 60)
				{
					this.func[1].call(this);
					return;
				}

				this.count++;
				this.sx += this.flag1;
				this.flag1 += 0,15000001.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
				this.AddSpeed_XY(this.initTable.v.x * 0,50000000.0, this.initTable.v.y * 0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;

		if (this.count >= 20)
		{
			this.func[2].call(this);
		}
	};
}

function Shot_Front_Core( t )
{
	this.SetMotion(2019, 2);
	this.anime.is_write = true;
	local t_ = {};
	t_.rot <- this.rz;
	this.flag1 = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.Shot_Front_Back, t_).weakref();
	this.flag1.anime.stencil = this;
	this.flag2 = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.Shot_Front_Mask, {});
	this.linkObject = [
		this.flag1,
		this.flag2.weakref()
	];
	this.flag3 = 0;
	this.flag4 = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag4[0].x;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(2019, 4);
			this.stateLabel = null;
			this.keyAction = this.ReleaseActor;
		}
	];
	this.keyAction = function ()
	{
		this.keyAction = null;
		this.stateLabel = function ()
		{
			this.count++;

			if (this.count >= 3 && this.count % 2 == 1 && this.flag3 < 6)
			{
				this.PlaySE(4428);
				local t_ = {};
				t_.mask <- this.flag2;
				this.SetShotStencil(this.x - 180 * this.direction, this.y + this.owner.shot_front[this.flag3].y, this.direction, this.Shot_Front, t_);
				this.flag3++;
			}
		};
	};
}

function Shot_Front_Back( t )
{
	this.SetMotion(2019, 5);
	this.SetSpeed_XY(0,00000000.0, -3,00000000.0);
	this.anime.is_equal = true;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count * 3 >= 128)
		{
			this.count = 0;
			this.y += 256;
		}
	};
}

function Shot_Front_Mask( t )
{
	this.SetMotion(2019, 6);
	this.anime.is_write = true;
}

function Shot_Front( t )
{
	this.SetMotion(2019, 0);
	this.anime.stencil = t.mask;
	this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
	this.cancelCount = 1;
	this.rx = 0,08726646.0;
	this.func = [
		function ()
		{
			this.rx = 0;
			this.SetMotion(2019, 1);
			this.SetSpeed_XY(this.va.x * 0,25000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.red = this.green = this.blue -= 0,05000000.0;
				this.alpha -= 0,05000000.0;
				this.rz -= 0,10000000.0 * 0,01745329.0 * this.va.y;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 1) || this.IsScreen(256))
		{
			this.ReleaseActor();
			return;
		}

		this.rx += 0,34906584.0;

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 5 || this.owner.IsDamage())
		{
			this.func[0].call(this);
			return true;
		}
	};
}

function Shot_Charge_Option( t )
{
	this.SetMotion(2029, 0);
	this.DrawActorPriority(189);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag1 = 0;
	this.flag2 = null;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 2);
			this.stateLabel = null;
			this.keyAction = this.ReleaseActor;
		},
		function ()
		{
			this.flag2 = this.SetShot(this.x, this.y, this.direction, this.Shot_Charge_Core, {}).weakref();
			local t_ = {};
			t_.rot <- 10,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- -0,20000000.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(5, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			a_.hitOwner = this.flag2;
			this.flag2.flag1.Add(a_);
			local t_ = {};
			t_.rot <- 5,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- -0,44999999.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(4, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			a_.hitOwner = this.flag2;
			this.flag2.flag1.Add(a_);
			local t_ = {};
			t_.rot <- -10,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- 0,44999999.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(3, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			a_.hitOwner = this.flag2;
			this.flag2.flag1.Add(a_);
			local t_ = {};
			t_.rot <- -10,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- 0,50000000.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(2, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			a_.hitOwner = this.flag2;
			this.flag2.flag1.Add(a_);
			local t_ = {};
			t_.rot <- 10,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- -0,50000000.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(1, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			a_.hitOwner = this.flag2;
			this.flag2.flag1.Add(a_);
			local t_ = {};
			t_.rot <- 10,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- -0,25000000.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			a_.hitOwner = this.flag2;
			this.flag2.flag1.Add(a_);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.count++;
				this.sx = this.sy = 1,00000000.0 + 0,02500000.0 * this.sin(this.count * 0,08726646.0);
				this.direction = this.owner.direction;
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.count++;
				this.sx = this.sy = 1,00000000.0 + 0,02500000.0 * this.sin(this.count * 0,08726646.0);
				this.direction = this.owner.direction;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.sx = this.sy = 1,00000000.0 + 0,02500000.0 * this.sin(this.count * 0,08726646.0);
		this.direction = this.owner.direction;
	};
}

function Shot_Charge_Core( t )
{
	this.SetMotion(2028, 3);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.func = [
		function ()
		{
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.func[0].call(this);
			return true;
		}

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(5);
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2028, 0);
	this.rz = t.rot;
	this.sy = 0,05000000.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.SetParent(null, 0, 0);
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
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sy += (1,00000000.0 - this.sy) * 0,20000000.0;
				this.rz += this.initTable.rotSpeed;
				this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
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
		this.rz += this.initTable.rotSpeed;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	};
}

function Shot_Barrage_Option( t )
{
	this.SetMotion(2029, 0);
	this.DrawActorPriority(189);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag1 = 0;
	this.flag2 = null;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 2);
			this.stateLabel = null;
			this.keyAction = this.ReleaseActor;
		},
		function ()
		{
			this.flag2 = this.SetShot(this.x, this.y, this.direction, this.Shot_Charge_Core, {}).weakref();
			local t_ = {};
			t_.rot <- 10,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- -0,20000000.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(5, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			this.flag2.flag1.Add(a_);
			local t_ = {};
			t_.rot <- 5,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- -0,44999999.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(4, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			this.flag2.flag1.Add(a_);
			local t_ = {};
			t_.rot <- -10,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- 0,44999999.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(3, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			this.flag2.flag1.Add(a_);
			local t_ = {};
			t_.rot <- -10,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- 0,50000000.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(2, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			this.flag2.flag1.Add(a_);
			local t_ = {};
			t_.rot <- 10,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- -0,50000000.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(1, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			this.flag2.flag1.Add(a_);
			local t_ = {};
			t_.rot <- 10,00000000.0 * 0,01745329.0;
			t_.rotSpeed <- -0,25000000.0 * 0,01745329.0;
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			local a_ = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Charge, t_);
			this.flag2.flag1.Add(a_);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.count++;
				this.sx = this.sy = 1,00000000.0 + 0,02500000.0 * this.sin(this.count * 0,08726646.0);
				this.direction = this.owner.direction;
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.count++;
				this.sx = this.sy = 1,00000000.0 + 0,02500000.0 * this.sin(this.count * 0,08726646.0);
				this.direction = this.owner.direction;

				if (this.count % 4 == 1)
				{
					this.PlaySE(4430);
					local t_ = {};
					t_.rot <- this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
					local pos_ = this.Vector3();
					this.GetPoint(this.flag1, pos_);
					this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Barrage, t_);
					this.flag1++;

					if (this.flag1 >= 6)
					{
						this.flag1 = 0;
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.sx = this.sy = 1,00000000.0 + 0,02500000.0 * this.sin(this.count * 0,08726646.0);
		this.direction = this.owner.direction;
	};
}

function Shot_Barrage_Flash( t )
{
	this.SetMotion(2026, 0);
	this.sx = this.sy = 4,00000000.0;
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
	this.SetMotion(2026, 1);
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Barrage_Flash, {});
	this.rz = t.rot;
	this.SetSpeed_Vec(9,00000000.0 + this.rand() % 4, this.rz, this.direction);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, 2);
		this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
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
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		this.sx += 0,02500000.0;

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}
	};
}

function Occult_Object_Foot( t )
{
	this.SetMotion(2500, 1);
	this.DrawActorPriority(189);
	this.func = [
		function ()
		{
			this.SetMotion(2503, 3);
			this.keyAction = this.ReleaseActor;
		},
		function ()
		{
			this.SetMotion(2504, 0);
			this.keyAction = this.ReleaseActor;
		}
	];
}

function Occult_Object_End_Upper( t )
{
	this.SetMotion(2503, 2);
	this.DrawActorPriority(189);
	this.keyAction = this.ReleaseActor;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.atk_id = 536870912;
	this.SetSpeed_Vec(12,50000000.0, t.rot, this.direction);
	this.cancelCount = 2;
	this.flag2 = this.Vector3();
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 1);
			this.sx = this.sy = 1,50000000.0;
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,10000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(this.flag2.x * 0,50000000.0, this.flag2.y * 0,50000000.0);
				this.sx += this.flag1;
				this.flag1 += 0,01250000.0;
				this.sy *= 0,89999998.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
			this.flag2.x = this.cos(this.rz) * this.direction * 0,25000000.0;
			this.flag2.y = this.sin(this.rz) * 0,25000000.0;
			this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
			this.SetMotion(this.motion, 2);
			this.flag1 = 0,01250000.0;
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.PlaySE(4425);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
				{
					this.ReleaseActor();
					return;
				}

				if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.count >= 60)
				{
					this.func[1].call(this);
					return;
				}

				this.count++;
				this.sx += this.flag1;
				this.flag1 += 0,15000001.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
				this.AddSpeed_XY(this.flag2.x, this.flag2.y);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.Vec_Brake(0,50000000.0, 1,00000000.0);
		this.count++;

		if (this.count >= this.initTable.wait)
		{
			this.func[2].call(this);
		}
	};
}

function SPShot_A( t )
{
	this.SetMotion(6000, 0);
	this.cancelCount = 10;
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
	this.SetMotion(3019, 0);
	this.cancelCount = 3;
	this.flag1 = this.owner.direction;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.rz += 0,17453292.0 * this.flag1;
				this.alpha = this.blue = this.green -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ( dir_ )
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(3019, 1);
			this.SetSpeed_XY(10,00000000.0 * dir_, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.rz += 0,17453292.0 * this.flag1;
				this.count++;

				if (this.count >= 90 || this.hitCount >= 4 || this.cancelCount <= 0)
				{
					this.func[0].call(this);
					return;
				}

				this.HitCycleUpdate(2);
			};
		}
	];
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.stateLabel = function ()
	{
		this.rz += 0,34906584.0 * this.flag1;
		this.sx = this.sy += (1,25000000.0 - this.sy) * 0,10000000.0;
	};
}

function SPShot_C( t )
{
	this.SetMotion(3029, 0);
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
	};
}

function SPShot_D( t )
{
	this.SetMotion(3039, 0);
	this.sy = this.sx = 0,60000002.0;
	this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx += (30,00000000.0 - this.sx) * 0,05000000.0;
			this.sy *= 0,92000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.func();
			return;
		}

		this.sx += (30,00000000.0 - this.sx) * 0,05000000.0;
		this.sy *= 0,92000002.0;
		this.count++;

		if (this.count == 18)
		{
			if (this.initTable.se)
			{
				this.PlaySE(4445);
			}

			local t_ = {};
			t_.rot <- this.rz;
			this.SetShot(this.x, this.y, this.direction, this.SPShot_D_Main, t_);
			this.func();
		}
	};
}

function SPShot_D_Main( t )
{
	this.SetMotion(3039, 1);
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.cancelCount = 3;
	this.SetSpeed_Vec(100,00000000.0, this.rz, this.direction);
	this.func = function ()
	{
		this.SetMotion(3039, 2);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.sx *= 0,99000001.0;
			this.sy *= 0,89999998.0;
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.sx += 0,50000000.0;

		if (this.keyTake == 1)
		{
			if (this.Damage_ConvertOP(this.x, this.y, 3) || this.cancelCount <= 0)
			{
				this.sy *= 0,10000000.0;
				this.SetMotion(this.motion, 2);
			}
		}

		if (this.va.x > 0 && this.x > ::battle.scroll_right || this.va.x < 0 && this.x < ::battle.scroll_left || this.va.y > 0 && this.y > ::battle.scroll_bottom || this.va.y < 0 && this.y < ::battle.scroll_top)
		{
			this.func();
			return;
		}
	};
}

function SPShot_E( t )
{
	this.SetMotion(3049, 5);
	this.DrawActorPriority(180);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.func = [
		function ()
		{
			this.SetMotion(3049, 0);
			this.sx = this.sy = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.sx += (3,00000000.0 - this.sx) * 0,15000001.0;
				this.sy *= 0,92000002.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.PlaySE(4442);
			this.count = 0;

			for( local i = this.rz; i < 3,14159203.0 + this.rz; i = i + 0,34906584.0 )
			{
				local t_ = {};
				t_.rot <- i;
				this.SetShot(this.x, this.y, 1,00000000.0, this.SPShot_E_Bullet, t_);
			}

			for( local i = 3,14159203.0 + this.rz; i < 6,28318548.0 + this.rz; i = i + 0,34906584.0 )
			{
				local t_ = {};
				t_.rot <- i;
				this.SetShot(this.x, this.y, 1,00000000.0, this.SPShot_E_Bullet, t_);
			}

			this.ReleaseActor();
			return;
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP.call(this, this.x, this.y, 5))
		{
			this.func[0].call(this);
			return;
		}

		this.count++;

		if (this.count == 60)
		{
			this.PlaySE(4447);
		}

		if (this.count == 120)
		{
			this.PlaySE(4448);
		}

		if (this.count >= 240)
		{
			this.func[1].call(this);
			return;
		}
	};
}

function SPShot_E_Bullet2( t )
{
	this.SPShot_E_Bullet(t);
	this.SetMotion(3049, 6);
}

function SPShot_E_Bullet( t )
{
	this.SetMotion(3049, 6);
	this.flag1 = this.Vector3();
	this.flag1.x = 1,00000000.0;
	this.flag1.RotateByRadian(t.rot);
	this.rz = t.rot;
	this.flag2 = 30,00000000.0;
	this.SetSpeed_XY(this.flag2 * this.flag1.x, this.flag2 * this.flag1.y);
	this.cancelCount = 1;
	this.subState = function ()
	{
		this.flag2 -= 2,00000000.0;
		this.SetSpeed_XY(this.flag2 * this.flag1.x, this.flag2 * this.flag1.y);

		if (this.flag2 <= 5,00000000.0)
		{
			this.subState = function ()
			{
			};
		}
	};
	this.func = [
		function ()
		{
			this.SetMotion(3049, 3);
			this.sx = this.sy = 2,00000000.0;
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
		}
	];
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP.call(this, this.x, this.y, 1) || this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0 || this.count >= 180)
		{
			this.func[0].call(this);
			return;
		}

		this.flag2 += (15 - this.flag2) * 0,10000000.0;
		this.subState();
		this.count++;
	};
}

function SpellShot_A_Exp( t )
{
	this.SetMotion(4009, 4);
	this.DrawActorPriority(180);
	this.keyAction = this.ReleaseActor;
}

function SpellShot_A( t )
{
	if (t.type == 0)
	{
		this.SetMotion(4009, 0);
	}
	else
	{
		this.SetMotion(4008, 0);
	}

	this.DrawActorPriority(180 - t.type);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		null,
		function ()
		{
			::camera.shake_radius = 30,00000000.0;
			this.SetMotion(4009, 2);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 1)
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_A_Exp, {});
				}

				if (this.count == 3)
				{
					this.SetShot(this.point1_x, this.point1_y, this.direction, this.SpellShot_A_Exp, {});
				}

				if (this.count == 5)
				{
					this.SetShot(this.point2_x, this.point2_y, this.direction, this.SpellShot_A_Exp, {});
				}

				if (this.count == 10)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	::camera.shake_radius = 6,00000000.0;
	this.rz = 0,26179937.0;
	this.SetSpeed_Vec(45,00000000.0, this.rz, this.direction);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

	switch(t.type)
	{
	case 0:
		this.func[1] = function ()
		{
			this.SetMotion(4009, 1);
			this.HitReset();
			this.PlaySE(4460);
			::camera.shake_radius = 10,00000000.0;
			this.SetSpeed_XY(10,00000000.0 * this.direction, -0,50000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				this.VX_Brake(1,50000000.0);
				local r_ = (0,52359873.0 - this.rz) * 0,10000000.0;

				if (r_ < 0,25000000.0 * 0,01745329.0)
				{
					r_ = 0,25000000.0 * 0,01745329.0;
				}

				this.rz += r_;
				this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

				if (this.count == 50)
				{
					this.PlaySE(4461);
					this.func[2].call(this);
				}
			};
		};
		this.stateLabel = function ()
		{
			this.count++;

			if (this.count == 18)
			{
				if (this.initTable.type <= 1)
				{
					local t_ = {};
					t_.type <- 1;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_A, t_, this.weakref());
				}
			}

			if (this.count == 40)
			{
				this.func[1].call(this);
			}
		};
		break;

	case 1:
		this.func[1] = function ()
		{
			this.SetMotion(4009, 1);
			this.HitReset();
			::camera.shake_radius = 10,00000000.0;
			this.SetSpeed_XY(15,00000000.0 * this.direction, -30,00000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				this.VX_Brake(0,50000000.0);
				this.AddSpeed_XY(0,00000000.0, 0,80000001.0, 0,00000000.0, -0,25000000.0);
				local r_ = (-40 * 0,01745329.0 - this.rz) * 0,07500000.0;

				if (r_ > -0,25000000.0 * 0,01745329.0)
				{
					r_ = -0,25000000.0 * 0,01745329.0;
				}

				this.rz += r_;
				this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

				if (this.count == 50)
				{
					this.func[2].call(this);
				}
			};
		};
		this.stateLabel = function ()
		{
			this.count++;

			if (this.count == 18)
			{
				if (this.initTable.type <= 1)
				{
					local t_ = {};
					t_.type <- 2;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_A, t_, this.weakref());
				}
			}

			if (this.count == 24)
			{
				this.func[1].call(this);
			}
		};
		break;

	case 2:
		this.func[1] = function ()
		{
			this.SetMotion(4009, 1);
			this.HitReset();
			::camera.shake_radius = 10,00000000.0;
			this.SetSpeed_XY(12,50000000.0 * this.direction, -15,00000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				this.VX_Brake(0,40000001.0, 1,00000000.0 * this.direction);
				this.AddSpeed_XY(0,00000000.0, 1,00000000.0, 0,00000000.0, 1,00000000.0);
				local r_ = (60 * 0,01745329.0 - this.rz) * 0,10000000.0;

				if (r_ < 0,25000000.0 * 0,01745329.0)
				{
					r_ = 0,25000000.0 * 0,01745329.0;
				}

				this.rz += r_;
				this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

				if (this.count == 50)
				{
					this.func[2].call(this);
				}
			};
		};
		this.stateLabel = function ()
		{
			this.count++;

			if (this.count == 8)
			{
				this.func[1].call(this);
			}
		};
		break;
	}
}

function SpellShot_B( t )
{
	this.SetMotion(4017, 0);
	this.stateLabel = function ()
	{
	};
}

function SpellShot_B_Ran( t )
{
	this.SetMotion(4019, 2);
	this.flag1 = this.Vector3();
	this.flag1 = this.y;
	this.flag2 = 200;
	this.flag3 = 3;
	this.EnableTimeStop(false);
	this.func = [
		function ()
		{
		},
		function ()
		{
			this.SetMotion(4019, 1);
			this.EnableTimeStop(true);
			this.SetSpeed_Vec(15, 80 * 0,01745329.0, this.direction);
			this.PlaySE(4464);
			this.stateLabel = function ()
			{
				this.rz -= 0,34906584.0;
				this.flag2 += 1;

				if (this.y >= this.flag1 + this.flag2 && this.flag3 > 0)
				{
					this.PlaySE(4464);
					this.Warp(this.x + 80 * this.direction, this.flag1 - this.flag2);
					this.HitReset();
					this.flag3--;
				}
			};
		}
	];
}

function SpellShot_B_Chen( t )
{
	this.SetMotion(4018, 2);
	this.DrawActorPriority(180);
	this.flag1 = this.Vector3();
	this.flag1 = this.y;
	this.flag2 = 200;
	this.flag3 = 3;
	this.EnableTimeStop(false);
	this.func = [
		function ()
		{
		},
		function ()
		{
			this.SetMotion(4018, 1);
			this.DrawActorPriority(199);
			this.EnableTimeStop(true);
			this.SetSpeed_Vec(15, -80 * 0,01745329.0, this.direction);
			this.PlaySE(4464);
			this.stateLabel = function ()
			{
				this.rz -= 0,34906584.0;
				this.flag2 += 1;

				if (this.y <= this.flag1 - this.flag2 && this.flag3 > 0)
				{
					this.PlaySE(4464);
					this.Warp(this.x + 80 * this.direction, this.flag1 + this.flag2);
					this.HitReset();
					this.flag3--;
				}
			};
		}
	];
}

function SpellShot_C( t )
{
	this.SetMotion(4029, 0);
	this.option = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.SpellShot_C_Mask, {}).weakref();
	this.EnableTimeStop(false);
	this.func = [
		function ()
		{
			this.SetKeyFrame(2);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count % 2 == 1)
				{
					if (this.count % 6 == 1)
					{
						this.PlaySE(4467);
					}

					local t_ = {};
					t_.rot <- (-30 + this.rand() % 91) * 0,01745329.0;
					this.SetShotStencil(this.x, this.y, this.direction, this.SpellShot_C_Attack, t_, this.option);
				}
			};
		}
	];
	this.keyAction = function ()
	{
		if (this.option)
		{
			this.option.ReleaseActor();
		}

		this.ReleaseActor();
	};
}

function SpellShot_C_Attack( t )
{
	this.SetMotion(4029, 2);
	this.rz = t.rot;
	this.DrawActorPriority(180);
	this.anime.stencil = t.pare;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(20,00000000.0, this.rz, this.direction);
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return;
		}
	};
}

function SpellShot_C_Mask( t )
{
	this.SetMotion(4029, 1);
	this.DrawActorPriority(180);
	this.anime.is_write = true;
}

function Climax_Shot( t )
{
	this.SetMotion(4907, 1);
	this.DrawActorPriority(180);
	this.keyAction = this.ReleaseActor;
	local t_ = {};
	t_.rot <- 20 * 0,01745329.0;
	this.SetShot(this.x, this.y, this.direction, this.Climax_ShotSlash, t_);
	local t_ = {};
	t_.rot <- -20 * 0,01745329.0;
	this.SetShot(this.x, this.y, this.direction, this.Climax_ShotSlash, t_);
	local t_ = {};
	t_.rot <- 35 * 0,01745329.0;
	this.SetShot(this.x, this.y, this.direction, this.Climax_ShotSlash, t_);
	local t_ = {};
	t_.rot <- -35 * 0,01745329.0;
	this.SetShot(this.x, this.y, this.direction, this.Climax_ShotSlash, t_);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 30)
		{
			this.PlaySE(4452);
		}
	};
}

function Climax_ShotSlash( t )
{
	this.SetMotion(4907, 2);
	this.sx = 0,00000000.0;
	this.rz = t.rot;
	this.stateLabel = function ()
	{
		this.sx += (0,50000000.0 - this.sx) * 0,10000000.0;
		this.sy += (5,00000000.0 - this.sy) * 0,10000000.0;
		this.count++;

		if (this.count >= 30)
		{
			this.sx *= 10,00000000.0;
			this.SetMotion(4907, 3);
			this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			this.stateLabel = function ()
			{
				this.sx += (0,00000000.0 - this.sx) * 0,10000000.0;
				this.sy += (10,00000000.0 - this.sy) * 0,20000000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Climax_CrackBack( t )
{
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4907, 6);
			this.DrawActorPriority(100);
			this.flag1 = 0,01000000.0;
			this.stateLabel = function ()
			{
				this.flag1 += 0,02000000.0;
				this.sx = this.sy += this.flag1;
			};
		}
	];
	this.func[1].call(this);
}

function Climax_CrackB( t )
{
	this.SetMotion(4907, 5);
	this.DrawActorPriority(1000);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.flag1 += 0,03500000.0;
				this.sx = this.sy += this.flag1;
			};
		}
	];
	this.func[1].call(this);
}

function Climax_Crack( t )
{
	this.SetMotion(4907, 4);
	this.DrawActorPriority(1000);
	this.sx = this.sy = 0,00000000.0;
	this.flag1 = 0,01000000.0;
	this.flag5 = [
		null,
		null
	];
	this.func = [
		function ()
		{
			foreach( a in this.flag5 )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 60)
				{
					this.flag5[0] = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_CrackB, {}).weakref();
					this.flag5[1] = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_CrackBack, {}).weakref();
				}

				if (this.count >= 60)
				{
					this.flag1 += 0,03000000.0;
				}

				this.sx = this.sy += this.flag1;
			};
		}
	];
	this.func[1].call(this);
}

function Climax_CrackRed( t )
{
	this.SetMotion(4907, 7);
	this.DrawActorPriority(1000);
	this.sx = this.sy = 0,00000000.0;
	this.flag1 = 0,01000000.0;
	this.flag5 = [
		null,
		null
	];
	this.func = [
		function ()
		{
			foreach( a in this.flag5 )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.count++;
				this.flag1 += 0,03000000.0;
				this.sx = this.sy += this.flag1;

				if (this.count >= 60)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.red -= 0,02500000.0;

				if (this.red < 0,00000000.0)
				{
					this.red = 0,00000000.0;
				}
			};
		}
	];
	this.func[1].call(this);
}

function Climax_Grab( t )
{
	this.SetMotion(4907, 8);
	this.DrawActorPriority(1000);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,50000000.0 - this.sx) * 0,10000000.0;
	};
}

function Climax_Cut( t )
{
	this.SetMotion(4909, 0);
	this.DrawScreenActorPriority(1000);
	this.red = this.green = this.blue = 0,00000000.0;
	this.sx = this.sy = 1,50000000.0;
	this.flag1 = 1,00010002.0;
	this.EnableTimeStop(false);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0,03000000.0;
				this.sx = this.sy *= this.flag1;
				this.flag1 += 0,01000000.0;
				this.AddSpeed_XY(5,00000000.0 * this.direction * this.flag1 * this.flag1, 0,00000000.0);

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.red = this.green = this.blue += (1,00000000.0 - this.red) * 0,05000000.0;
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;
	};
}

function Climax_Slash( t )
{
	this.SetMotion(4908, 1);
	this.DrawActorPriority(1010);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4908, 2);
			this.red = this.green = this.blue = 0,00000000.0;
			this.keyAction = this.ReleaseActor;
		}
	];
}

function Climax_SlashEnemy( t )
{
	this.SetMotion(4908, 3);
	this.rz = 10 * 0,01745329.0;
	this.SetParent(t.pare, 0, 0);
	this.DrawActorPriority(1010);
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
			this.alpha = 2,00000000.0;
			this.stateLabel = function ()
			{
				this.SetParent(null, 0, 0);
				this.sx += 0,15000001.0;
				this.sy *= 0,80000001.0;
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
		if (t.pare == null || t.pare.motion != 311)
		{
			this.func[0].call(this);
		}
	};
}

function Climax_Back( t )
{
	this.SetMotion(4909, 2);
	this.DrawActorPriority(990);
	this.EnableTimeStop(false);
	this.red = this.green = this.blue = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.isVisible = true;
			this.red = 1,00000000.0;
			this.green = this.blue = 0,00000000.0;
			this.alpha = 0,00000000.0;
			this.stateLabel = function ()
			{
				this.alpha += 0,05000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.stateLabel = null;
				}
			};
		},
		function ()
		{
			this.alpha = 1,00000000.0;
			this.stateLabel = function ()
			{
				this.red -= 0,02500000.0;

				if (this.red <= 0,00000000.0)
				{
					this.red = 0;
				}
			};
		},
		function ()
		{
			this.red = 1,00000000.0;
			this.green = this.blue = 0,00000000.0;
			this.stateLabel = function ()
			{
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

