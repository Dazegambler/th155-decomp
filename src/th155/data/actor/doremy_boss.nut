function Slave_Dream_1()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
	};
}

function Slave_Attack_Dream( t )
{
	this.LabelClear();
	this.SetMotion(4970, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag4 = t;
	this.flag5 = 300;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5 = 270;
		break;

	case 2:
		this.flag5 = 240;
		break;

	case 3:
		this.flag5 = 210;
		break;
	}

	this.count = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.05000000, 1.00000000);

		if (this.count >= this.flag5)
		{
			this.flag4();
		}
	};
}

function Slave_Smash_Dream( t )
{
	this.LabelClear();
	this.SetMotion(4979, 0);
	this.Warp(this.team.master.x, this.team.master.y);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.PlaySE(900);
	this.direction = this.team.master.direction;
	this.SetSpeed_XY(-3.00000000 * this.direction, -12.50000000);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.25000000, null, 10.00000000);

		if (this.va.y > 3.00000000 && this.keyTake <= 2)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.25000000, null, 10.00000000);
				this.alpha -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	};
}

function Master_Spell_1_Start()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4992, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 - 400 * this.direction;
	this.flag5.pos.y = 240;
	this.SetSpeed_Vec(0.25000000, -160 * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.flag5.moveV += 0.25000000;

		if (this.flag5.moveV > 10.00000000)
		{
			this.flag5.moveV = 10.00000000;
		}

		this.va.x = this.flag5.pos.x - this.x;
		this.va.y = this.flag5.pos.y - this.y;

		if (this.va.Length() <= 100)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.stateLabel = function ()
			{
				this.Boss_WalkMotionUpdate(0);

				if (this.Vec_Brake(0.25000000))
				{
					this.Master_Spell_1_Dream_Attack();
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(-this.direction);
		}
	};
}

