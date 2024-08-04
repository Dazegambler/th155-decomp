function Shion_BerserkAura( t )
{
	this.SetMotion(0, 1);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.DrawActorPriority(190);
	this.stateLabel = function ()
	{
		this.Warp(this.owner.x, this.owner.y);
	};
}

function Shion_BerserkAura_Fire( t )
{
	this.SetMotion(0, 2);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,05000000.0;
		this.alpha = this.red -= 0,00250000.0;
	};
}

function Master_Spell_1_Shot( t )
{
	this.SetMotion(5309, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.cancelCount = 1;
	this.sx = this.sy = 0,50000000.0;
	this.SetSpeed_Vec(t.v + this.rand() % 21 * 0,10000000.0, t.rot, this.direction);
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.va.y = this.vy;
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.C_Vec_Brake(this.va, 0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,25000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (!(this.grazeCount <= 0 && this.hitCount <= 0 && this.cancelCount > 0))
		{
			this.func[0].call(this);
			return;
		}

		this.vy += 0,01000000.0;
	};
}

function Aura_LastAttackStart( t )
{
	this.SetMotion(5319, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.PlaySE(4682);
}

function Shion_Back( t )
{
	this.SetMotion(5319, 1);
	this.DrawBackActorPriority(110);
	this.flag1 = this.SetFreeObject(this.x, this.y, 1,00000000.0, this.Shion_BackVortex, {}).weakref();
	this.func = [
		function ()
		{
			this.flag1.ReleaseActor();

			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.ReleaseActor();
		},
		function ()
		{
			this.PlaySE(4683);
			::camera.Shake(3,00000000.0);
			this.flag2 = this.SetFreeObject(this.x, this.y, 1,00000000.0, this.Shion_Crack, {}).weakref();
		},
		function ()
		{
			this.PlaySE(4684);
			this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 10);
			::camera.Shake(3,00000000.0);
			this.flag2.SetMotion(5319, 4);
		},
		function ()
		{
			this.PlaySE(4685);
			::camera.Shake(8,00000000.0);
			this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 30);
			this.flag2.SetMotion(5319, 5);
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy = 1,00000000.0 + 0,03000000.0 * this.sin(this.count * 0,03490658.0);
		this.count++;
	};
}

function Shion_Crack( t )
{
	this.SetMotion(5319, 3);
	this.DrawBackActorPriority(110);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,00050000.0;
	};
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += (5,00000000.0 - this.sx) * 0,10000000.0;
				this.alpha -= 0,01500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function Shion_BackVortex( t )
{
	this.SetMotion(5319, 2);
	this.DrawBackActorPriority(111);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.rx = 1,04719746.0;
	this.stateLabel = function ()
	{
		this.rz += 0,50000000.0 * 0,01745329.0;
	};
}

function Shion_BackHeaven( t )
{
	this.SetMotion(5319, 6);
	this.DrawActorPriority(10);
	this.keyAction = this.ReleaseActor;
	this.func = [
		function ()
		{
			this.SetKeyFrame(1);
		}
	];
}

function Master_Spell_2_ShotA( t )
{
	this.SetMotion(5318, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.cancelCount = 1;
	this.sx = this.sy = 0,50000000.0;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		local s_ = (1,00000000.0 - this.sx) * 0,25000000.0;

		if (s_ <= 0,00500000.0)
		{
			s_ = 0,00500000.0;
		}

		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (!(this.grazeCount <= 0 && this.hitCount <= 0 && this.cancelCount > 0))
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Master_Spell_2_ShotB( t )
{
	this.SetMotion(5318, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.cancelCount = 1;
	this.sx = this.sy = 0,50000000.0;
	this.SetSpeed_Vec(0,50000000.0, this.atan2(this.owner.target.y - this.y, this.owner.target.x - this.x), this.direction);
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		local s_ = (1,00000000.0 - this.sx) * 0,25000000.0;

		if (s_ <= 0,00500000.0)
		{
			s_ = 0,00500000.0;
		}

		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (!(this.grazeCount <= 0 && this.hitCount <= 0 && this.cancelCount > 0))
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Master_Spell_2_ShotC( t )
{
	this.flag1 = this.rand() % 4;
	this.SetMotion(5317, this.flag1);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.cancelCount = 1;
	this.sx = this.sy = 0,50000000.0;
	this.SetSpeed_Vec(1,50000000.0 + this.rand() % 21 * 0,10000000.0, t.rot, this.direction);
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.flag1 + 4);
			this.va.y = this.vy;
			this.stateLabel = function ()
			{
				this.C_Vec_Brake(this.va, 0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		local s_ = (1,00000000.0 - this.sx) * 0,25000000.0;

		if (s_ <= 0,00250000.0)
		{
			s_ = 0,00250000.0;
		}

		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (!(this.grazeCount <= 0 && this.hitCount <= 0 && this.cancelCount > 0))
		{
			this.func[0].call(this);
			return;
		}

		this.vy += 0,00500000.0;
	};
}

function Master_Spell_2_ShotBig( t )
{
	this.flag1 = this.rand() % 4;
	this.SetMotion(5316, this.flag1);
	this.DrawActorPriority(201);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.cancelCount = 3;
	this.sx = this.sy = 0,50000000.0;
	this.SetSpeed_Vec(1,50000000.0 + this.rand() % 21 * 0,10000000.0, t.rot, this.direction);
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.flag1 + 4);
			this.stateLabel = function ()
			{
				this.C_Vec_Brake(this.va, 0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
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
		if (this.IsScreen(300))
		{
			this.ReleaseActor();
			return;
		}

		local s_ = (2,00000000.0 - this.sx) * 0,10000000.0;

		if (s_ <= 0,01000000.0)
		{
			s_ = 0,01000000.0;
		}

		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (!(this.grazeCount <= 10 && this.hitCount <= 0 && this.cancelCount > 0))
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(0);
	};
}

function Boss_Shot_SL1( t )
{
	this.SetMotion(4919, this.rand() % 4);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.cancelCount = 1;
	this.SetSpeed_Vec(3 + this.rand() % 6, this.rz, this.direction);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.stateLabel = function ()
			{
				this.C_SetSpeed_XY(this.va, this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
				this.sx = this.sy += 0,10000000.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(150))
		{
			this.ReleaseActor();
			return;
		}

		if (!(this.grazeCount <= 0 && this.hitCount <= 0 && this.cancelCount > 0))
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += 0,01000000.0;

		if (this.sx > this.initTable.scale)
		{
			this.sx = this.sy = this.initTable.scale;
		}

		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.rz += 0,05235988.0;
	};
}

function Boss_Shot_SL1_OD( t )
{
	this.SetMotion(4919, this.rand() % 4);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.cancelCount = 1;
	this.SetSpeed_Vec(1,75000000.0 + this.rand() % 9, this.rz, this.direction);
	this.flag1 = 0,01000000.0 + this.rand() % 75 * 0,00100000.0;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.stateLabel = function ()
			{
				this.C_SetSpeed_XY(this.va, this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
				this.sx = this.sy += 0,10000000.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(150))
		{
			this.ReleaseActor();
			return;
		}

		if (!(this.grazeCount <= 0 && this.hitCount <= 0 && this.cancelCount > 0))
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += this.flag1;

		if (this.sx > this.initTable.scale)
		{
			this.sx = this.sy = this.initTable.scale;
		}

		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.rz += 0,05235988.0;
	};
}

function Boss_Shot_SL2_OD( t )
{
	this.SetMotion(4929, this.rand() % 4);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.cancelCount = 3;
	this.SetSpeed_Vec(2,50000000.0 + this.rand() % 21 * 0,10000000.0, this.rz, this.direction);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.stateLabel = function ()
			{
				this.C_SetSpeed_XY(this.va, this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
				this.sx = this.sy += 0,10000000.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(250) && this.grazeCount <= 0 && this.hitCount <= 0 && this.cancelCount > 0))
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += 0,02500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.rz += 0,05235988.0;
	};
}

