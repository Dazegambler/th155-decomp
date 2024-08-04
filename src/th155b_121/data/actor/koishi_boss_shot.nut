function Boss_Shot_T_HeartFall( t )
{
	this.SetMotion(4919, 0);
	this.SetSpeed_XY(4 - this.rand() % 81 * 0,10000000.0, -12,00000000.0 - this.rand() % 5);
	this.rz = this.atan2(this.va.y, this.va.x * this.direction);
	this.cancelCount = 1;
	this.flag1 = 3,00000000.0 + this.rand() % 3;
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,05000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);

		if (this.va.y > 6,50000000.0)
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.y >= ::battle.scroll_bottom || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.va.y < 0 && this.y < ::battle.scroll_top - 200)
		{
			this.SetSpeed_XY(this.va.x, 0,00000000.0);
		}

		this.subState();
	};
}

function Boss_Shot_T_HeartFall_B( t )
{
	this.SetMotion(4919, 0);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(10,00000000.0, this.rz, this.direction);
	this.cancelCount = 1;
	this.flag1 = 3,00000000.0 + this.rand() % 3;
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,05000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);

		if (this.va.y > 6,50000000.0)
		{
			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(300) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.va.y < 0 && this.y < ::battle.scroll_top - 150)
		{
			this.SetSpeed_XY(this.va.x, 0,00000000.0);
		}

		this.subState();
	};
}

function Boss_Shot_M1( t )
{
	this.SetMotion(4929, 0);
	this.owner.shot_actor.Add(this);
	this.sx = this.sy = 0,10000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,10000000.0;
	};
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
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
	];
	this.keyAction = function ()
	{
		this.PlaySE(2436);

		switch(this.owner.com_difficulty)
		{
		case 0:
			this.Boss_Shot_M1_EASY();
			break;

		case 1:
			this.Boss_Shot_M1_NORMAL();
			break;

		case 2:
			this.Boss_Shot_M1_HARD();
			break;

		case 3:
		case 4:
			this.Boss_Shot_M1_LUNATIC();
			break;
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

function Boss_Shot_M1_OD( t )
{
	this.SetMotion(4929, 0);
	this.owner.shot_actor.Add(this);
	this.sx = this.sy = 0,10000000.0;
	this.flag1 = 1,50000000.0 + this.rand() % 16 * 0,10000000.0;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
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
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,75000000.0, 1,00000000.0);
		this.sx = this.sy += (this.flag1 - this.sx) * 0,10000000.0;
	};
	this.SetSpeed_Vec(15,00000000.0 + this.rand() % 11, t.rot + (6 - this.rand() % 13) * 0,01745329.0, this.direction);
	this.keyAction = function ()
	{
		this.PlaySE(2436);
		local r_ = this.rand() % 360;

		for( local i = 0; i < 12; i++ )
		{
			local t_ = {};
			t_.rot <- (r_ + i * 30) * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M1_BarrageB, t_);
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

function Boss_Shot_M1_EASY()
{
	local r_ = this.rand() % 360;

	for( local i = 0; i < 3; i++ )
	{
		local t_ = {};
		t_.rot <- (r_ + i * 120) * 0,01745329.0;
		this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M1_Barrage, t_);
	}
}

function Boss_Shot_M1_NORMAL()
{
	local r_ = this.rand() % 360;

	for( local i = 0; i < 6; i++ )
	{
		local t_ = {};
		t_.rot <- (r_ + i * 60) * 0,01745329.0;
		this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M1_Barrage, t_);
	}
}

function Boss_Shot_M1_HARD()
{
	local r_ = this.rand() % 360;

	for( local i = 0; i < 8; i++ )
	{
		local t_ = {};
		t_.rot <- (r_ + i * 45) * 0,01745329.0;
		this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M1_Barrage, t_);
	}
}

function Boss_Shot_M1_LUNATIC()
{
	local r_ = this.rand() % 360;

	for( local i = 0; i < 12; i++ )
	{
		local t_ = {};
		t_.rot <- (r_ + i * 30) * 0,01745329.0;
		this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M1_Barrage, t_);
	}
}

function Boss_Shot_M1_Barrage( t )
{
	this.SetMotion(4929, 2);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.SetSpeed_Vec(17,50000000.0, this.rz, this.direction);
	this.cancelCount = 1;
	this.func = [
		function ()
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
		}
	];
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return true;
		}

		this.subState();
		this.count++;

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.count >= 120)
		{
			this.func[0].call(this);
			return true;
		}
	};
}

function Boss_Shot_M1_BarrageB( t )
{
	this.SetMotion(4929, 2);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.SetSpeed_Vec(17,50000000.0, this.rz, this.direction);
	this.cancelCount = 1;
	this.sx = this.sy = 1,00000000.0 + this.rand() % 4 * 0,10000000.0;
	this.func = [
		function ()
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
		}
	];
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return true;
		}

		this.subState();
		this.count++;

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return true;
		}
	};
}

function Boss_Shot_SL1( t )
{
	this.SetMotion(4919, 0);
	this.rz = t.rot;
	this.SetSpeed_Vec(t.v, this.rz, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,05000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0 || this.IsScreen(100))
		{
			this.func[0].call(this);
			return;
		}
	};
}

