function Boss_Shot_TutorialFire( t )
{
	this.SetMotion(4918, 2);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.05000000;
		this.alpha -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Boss_Shot_Tutorial( t )
{
	this.SetMotion(4918, 0);
	this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_TutorialFire, {});
	this.SetSpeed_Vec(12.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.C_SetSpeed_XY(this.va, 0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.10000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.C_Vec_BrakeLimited(this.va, 0.25000000, 2.50000000))
		{
			this.subState = null;
		}
	};
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(100) && this.hitCount == 0 && this.cancelCount > 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		if (this.subState)
		{
			this.subState();
		}
	};
}

function Boss_Shot_Tutorial2Fire( t )
{
	this.SetMotion(4919, 2);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.05000000;
		this.alpha -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Boss_Shot_Tutorial2( t )
{
	this.SetMotion(4919, 0);

	if (this.owner.target != this.owner.target.team.master)
	{
		this.SetMotion(this.motion, 1);
	}

	this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_Tutorial2Fire, {});
	this.SetSpeed_Vec(1.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.flag1 = this.va.x * 0.05000000;
	this.flag2 = this.va.y * 0.05000000;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.C_SetSpeed_XY(this.va, 0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.10000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(100) && this.hitCount == 0 && this.cancelCount > 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.vx += this.flag1;
		this.vy += this.flag2;

		if (this.keyTake == 0)
		{
			if (this.owner.target != this.owner.target.team.master)
			{
				this.SetMotion(this.motion, 1);
			}
		}
		else if (this.owner.target == this.owner.target.team.master)
		{
			this.SetMotion(this.motion, 0);
		}
	};
}

function Boss_Shot_Tutorial2B( t )
{
	this.SetMotion(4918, 0);
	this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_TutorialFire, {});
	this.SetSpeed_Vec(1.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.flag1 = this.va.x * 0.15000001;
	this.flag2 = this.va.y * 0.15000001;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0.10000000;

				if (this.sx <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(100) && this.hitCount == 0 && this.cancelCount > 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.vx += this.flag1;
		this.vy += this.flag2;
	};
}

function Boss_Shot_ChangeWave( t )
{
	this.SetMotion(4917, 0);
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (this.target.team.current == this.target.team.slave)
			{
				this.target.team.current.Team_Change_Slave(null);
			}
			else
			{
				this.target.team.current.Team_Change_Master(null);
			}

			this.func[0].call(this);
		}
	];
	this.flag1 = true;
	this.flag2 = 0.02000000 + this.rand() % 9 * 0.01000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += this.flag2;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.flag1 && this.hitResult & 1)
		{
			this.flag1 = false;
			this.func[1].call(this);
			return;
		}
	};
}

