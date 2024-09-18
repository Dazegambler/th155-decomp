function Boss_Shot_MS1( t )
{
	this.SetMotion(4919, 1);
	this.sx = this.sy = 0.25000000;
	this.owner.shot_actor.Add(this);
	this.flag2 = 0.50000000 + this.rand() % 10 * 0.10000000;
	this.flag1 = 0.00000000;
	this.flag3 = 0.00000000;
	this.cancelCount = 1;
	this.subState = function ()
	{
		this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;

		if (this.sx >= 0.94999999)
		{
			this.sx = this.sy = 1.00000000;
			this.SetMotion(this.motion, 0);
			this.subState = function ()
			{
			};
		}
	};
	this.func = [
		function ()
		{
			this.SetMotion(4919, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.80000001;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.SetSpeed_Vec(1.00000000, r_, this.direction);
			this.flag1 = this.va.x * 0.10000000;
			this.flag3 = this.va.y * 0.10000000;
			this.stateLabel = function ()
			{
				if (this.IsScreen(100))
				{
					this.ReleaseActor();
					return;
				}

				if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
				{
					this.func[0].call(this);
					return;
				}

				this.C_AddFreeSpeed_XY(this.va, this.flag1, this.flag3);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();

		if (this.C_Vec_Brake(this.va, 0.10000000))
		{
			this.stateLabel = function ()
			{
				if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
				{
					this.func[0].call(this);
					return;
				}

				this.subState();
				this.count++;

				if (this.count >= 120)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	};
}

function Boss_Shot_MS2_Leaf( t )
{
	this.SetMotion(4928, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(12.50000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.subState = function ()
	{
		this.C_Vec_BrakeLimited(this.va, 0.25000000, 1.00000000);
		this.count++;

		if (this.count >= 90 || this.team.current == this.team.slave)
		{
			this.func[1].call(this);
		}
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
		},
		function ()
		{
			this.SetMotion(4928, 1);
			this.func[0] = this.func[2];
			this.va.RotateByDegree(90 * this.direction);
			this.subState = function ()
			{
				this.C_AddSpeed_Vec(this.va, 0.20000000, null, 4.00000000, this.direction);
			};
		},
		function ()
		{
			this.SetMotion(4928, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.10000000;

				if (this.sx <= 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(50) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_MS2_BackFire( t )
{
	this.SetMotion(4929, 0);
	this.DrawActorPriority(189);
	this.cancelCount = 99;
	this.SetParent(this.owner, 0, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(10);
	};
}

function Boss_Shot_DS1_Leaf( t )
{
	this.SetMotion(4927, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(15.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.flag1 = 0.34906584;
	this.subState = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0.94999999;
		this.Vec_Brake(0.75000000, 1.00000000);
		this.count++;

		if (this.count >= 60)
		{
			this.func[1].call(this);
		}
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
		},
		function ()
		{
			local t_ = {};
			t_.rot <- this.initTable.rot;
			this.team.slave.SetLightShot(this.x, this.y, this.direction, this.team.slave.Boss_Shot_DS1, t_);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
			};
			this.SetMotion(2009, 6);
			this.keyAction = this.ReleaseActor;
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(50) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_DS1_Leaf2( t )
{
	this.SetMotion(4927, 3);
	this.DrawActorPriority(201);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(10.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.flag1 = 0.34906584;
	this.keyAction = function ()
	{
		this.func[1].call(this);
	};
	this.subState = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0.94999999;
		this.C_Vec_BrakeLimited(this.va, 1.25000000, 1.00000000);
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
		},
		function ()
		{
			this.PlaySE(2612);
			local t_ = {};
			t_.rot <- this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
			this.team.slave.SetLightShot(this.x, this.y, this.direction, this.team.slave.Boss_Shot_DS1_Big, t_);
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurstB, {});
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
			};
			this.SetMotion(2009, 6);
			this.keyAction = this.ReleaseActor;
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(50) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_SL1( t )
{
	this.SetMotion(4949, 1);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.C_SetSpeed_Vec(this.va, 1.00000000, this.rz, this.direction);
	this.flag1 = this.va.x * 0.05000000;
	this.flag2 = this.va.y * 0.05000000;
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
			};
			this.SetMotion(this.motion, 6);
			this.keyAction = this.ReleaseActor;
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return true;
		}

		this.count++;

		if (this.count <= 60)
		{
			this.C_AddFreeSpeed_XY(this.va, this.flag1, this.flag2);
		}

		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Boss_Shot_SL2( t )
{
	this.SetMotion(4926, 0);
	this.SetParent(t.pare, 0, 0);
	this.owner.shot_actor.Add(this);
	this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurst, {});
	this.flag3 = 0.52359873;
	this.cancelCount = 1;
	this.flag2 = t.pare.weakref();
	this.rz = this.rand() % 360 * 0.01745329;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.ReleaseActor();
			return;
		},
		function ()
		{
			this.SetParent(null, 0, 0);

			if (this.flag2)
			{
				this.flag2.func[2].call(this.flag2);
			}

			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return true;
		}

		this.flag3 *= 0.92000002;

		if (this.flag3 < 0.10471975)
		{
			this.flag3 = 0.10471975;
		}

		this.rz += this.flag3;
	};
}

function Boss_Shot_SL3_Bake( t )
{
	this.SetMotion(4948, this.rand() % 3);
	this.DrawActorPriority(180);
	this.owner.shot_actor.Add(this);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.direction = this.va.x >= 0.00000000 ? 1.00000000 : -1.00000000;
	this.cancelCount = 6;
	this.hitResult = 128;
	this.func = [
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurstB, {});
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(3);
	};
}

function Boss_Shot_SL3( t )
{
	this.SetMotion(4948, 3);
	this.DrawActorPriority(180);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 99;
	this.SetSpeed_XY(t.v.x, t.v.y);
	this.rz = this.rand() % 360 * 0.01745329;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0.07500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.PlaySE(2629);
			::camera.Shake(10.00000000);
			this.SetFreeObject(this.x, this.y, this.direction, this.Common_SmokeBurstB, {});
			this.func[2].call(this);
			this.ReleaseActor();
		},
		function ()
		{
		}
	];

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.func[2] = function ()
		{
			for( local i = 0; i < 6; i++ )
			{
				local t_ = {};
				t_.rot <- 1.04719746 * i;
				t_.v <- 4.00000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}
		};
		break;

	case 1:
		this.func[2] = function ()
		{
			for( local i = 0; i < 6; i++ )
			{
				local t_ = {};
				t_.rot <- 1.04719746 * i;
				t_.v <- 4.00000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}

			for( local i = 0; i < 6; i++ )
			{
				local t_ = {};
				t_.rot <- 0.52359873 + 1.04719746 * i;
				t_.v <- 6.50000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}
		};
		break;

	case 2:
		this.func[2] = function ()
		{
			for( local i = 0; i < 9; i++ )
			{
				local t_ = {};
				t_.rot <- 0.69813168 * i;
				t_.v <- 4.00000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}

			for( local i = 0; i < 9; i++ )
			{
				local t_ = {};
				t_.rot <- 0.34906584 + 0.69813168 * i;
				t_.v <- 6.50000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}
		};
		break;

	case 3:
		this.func[2] = function ()
		{
			for( local i = 0; i < 9; i++ )
			{
				local t_ = {};
				t_.rot <- 0.34906584 + 0.69813168 * i;
				t_.v <- 3.00000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}

			for( local i = 0; i < 9; i++ )
			{
				local t_ = {};
				t_.rot <- 0.69813168 * i;
				t_.v <- 5.00000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}

			for( local i = 0; i < 9; i++ )
			{
				local t_ = {};
				t_.rot <- 0.34906584 + 0.69813168 * i;
				t_.v <- 7.00000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}
		};
		break;

	case 4:
		this.func[2] = function ()
		{
			for( local i = 0; i < 12; i++ )
			{
				local t_ = {};
				t_.rot <- 0.26179937 + 0.52359873 * i;
				t_.v <- 3.00000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}

			for( local i = 0; i < 12; i++ )
			{
				local t_ = {};
				t_.rot <- 0.52359873 * i;
				t_.v <- 6.00000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}

			for( local i = 0; i < 12; i++ )
			{
				local t_ = {};
				t_.rot <- 0.26179937 + 0.52359873 * i;
				t_.v <- 9.00000000;
				this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3_Bake, t_);
			}
		};
		break;
	}

	this.stateLabel = function ()
	{
		if (this.IsScreen(300))
		{
			this.func[1].call(this);
			return true;
		}

		this.HitCycleUpdate(60);
		this.rz += 0.03490658;
	};
}

