function Boss_Shot_Tutorial( t )
{
	this.SetMotion(4918, 0);
	this.SetSpeed_Vec(6.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
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
		if (this.IsScreen(100) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
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

	this.SetSpeed_Vec(3.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x * 0.05000000;
	this.flag1.y = this.va.y * 0.05000000;
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
		if (this.IsScreen(100) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(this.flag1.x, this.flag1.y);

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
	this.SetSpeed_Vec(3.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x * 0.05000000;
	this.flag1.y = this.va.y * 0.05000000;
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
		if (this.IsScreen(100) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(this.flag1.x, this.flag1.y);
	};
}

function Boss_Shot_ChangeWave( t )
{
	this.SetMotion(4917, 0);
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
		}
	];
	this.flag1 = true;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.50000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.flag1 && this.hitResult & 1)
		{
			this.flag1 = false;
			this.func[1].call(this);
			return;
		}

		this.count++;

		if (this.count >= 30)
		{
			this.func[0].call(this);
		}
	};
}

