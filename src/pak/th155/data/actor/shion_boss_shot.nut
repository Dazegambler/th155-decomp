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
		this.sx = this.sy += 0.05000000;
		this.alpha = this.red -= 0.00250000;
	};
}

function Master_Spell_1_Shot( t )
{
	this.SetMotion(5309, this.rand() % 4);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.03490658);
	this.cancelCount = 1;
	this.sx = this.sy = 0.50000000;
	this.SetSpeed_Vec(t.v + this.rand() % 21 * 0.10000000, t.rot, this.direction);
	this.owner.boss_shot.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.50000000);
				this.sx = this.sy *= 0.92000002;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
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

		this.sx = this.sy += (1.00000000 - this.sx) * 0.25000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount == 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0.00000000, 0.01000000);
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
	this.flag1 = this.SetFreeObject(this.x, this.y, 1.00000000, this.Shion_BackVortex, {}).weakref();
	this.func = [
		function ()
		{
			this.flag1.ReleaseActor();
			this.flag2.func[0].call(this.flag2);
			this.ReleaseActor();
		},
		function ()
		{
			this.PlaySE(4683);
			::camera.Shake(3.00000000);
			this.flag2 = this.SetFreeObject(this.x, this.y, 1.00000000, this.Shion_Crack, {}).weakref();
		},
		function ()
		{
			this.PlaySE(4684);
			this.FadeIn(1.00000000, 1.00000000, 1.00000000, 10);
			::camera.Shake(3.00000000);
			this.flag2.SetMotion(5319, 4);
		},
		function ()
		{
			this.PlaySE(4685);
			::camera.Shake(8.00000000);
			this.FadeIn(1.00000000, 1.00000000, 1.00000000, 30);
			this.flag2.SetMotion(5319, 5);
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy = 1.00000000 + 0.03000000 * this.sin(this.count * 0.03490658);
		this.count++;
	};
}

function Shion_Crack( t )
{
	this.SetMotion(5319, 3);
	this.DrawBackActorPriority(110);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.00050000;
	};
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += (5.00000000 - this.sx) * 0.10000000;
				this.alpha -= 0.01500000;

				if (this.alpha <= 0.00000000)
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
	this.rx = 1.04719746;
	this.stateLabel = function ()
	{
		this.rz += 0.50000000 * 0.01745329;
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
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.03490658);
	this.cancelCount = 1;
	this.sx = this.sy = 0.50000000;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.owner.boss_shot.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.50000000);
				this.sx = this.sy *= 0.92000002;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
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

		local s_ = (1.00000000 - this.sx) * 0.25000000;

		if (s_ <= 0.00500000)
		{
			s_ = 0.00500000;
		}

		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount == 0)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Master_Spell_2_ShotB( t )
{
	this.SetMotion(5318, this.rand() % 4);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.03490658);
	this.cancelCount = 1;
	this.sx = this.sy = 0.50000000;
	this.SetSpeed_Vec(0.50000000, this.atan2(this.owner.target.y - this.y, this.owner.target.x - this.x), this.direction);
	this.owner.boss_shot.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.50000000);
				this.sx = this.sy *= 0.92000002;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
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

		local s_ = (1.00000000 - this.sx) * 0.25000000;

		if (s_ <= 0.00500000)
		{
			s_ = 0.00500000;
		}

		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount == 0)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Master_Spell_2_ShotC( t )
{
	this.SetMotion(5317, this.rand() % 4);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.03490658);
	this.cancelCount = 1;
	this.sx = this.sy = 0.50000000;
	this.SetSpeed_Vec(1.50000000 + this.rand() % 21 * 0.10000000, t.rot, this.direction);
	this.owner.boss_shot.Add(this);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.50000000);
				this.sx = this.sy *= 0.92000002;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
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

		local s_ = (1.00000000 - this.sx) * 0.25000000;

		if (s_ <= 0.00250000)
		{
			s_ = 0.00250000;
		}

		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0.00000000, 0.00500000);
	};
}

function Boss_Shot_SL1( t )
{
	this.SetMotion(4919, this.rand() % 4);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.rz = this.rand() % 360 * 0.01745329;
	this.cancelCount = 1;
	this.SetSpeed_Vec(3 + this.rand() % 6, this.rz, this.direction);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
				this.sx = this.sy += 0.10000000;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
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

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += 0.01000000;

		if (this.sx > this.initTable.scale)
		{
			this.sx = this.sy = this.initTable.scale;
		}

		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.rz += 0.05235988;
	};
}

