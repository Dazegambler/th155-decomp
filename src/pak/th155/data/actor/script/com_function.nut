this.InitBase <- this.Init;
function Init()
{
	this.InitBase();
	this.CPU_Clear();
	this.com_difficulty = this.difficulty;

	switch(this.difficulty)
	{
	case 0:
		this.com_level = 0;
		break;

	case 1:
		this.com_level = 33;
		break;

	case 2:
		this.com_level = 66;
		break;

	case 3:
		this.com_level = 100;
		break;
	}

	this.cpuState = this.CPU_Update_VS;
	this.com_senser = ::manbow.Sensor();
	this.com_senser.Init(this, 128, 192, 352);
	this.com_search = [
		this.array(1, 0),
		this.array(8, 0),
		this.array(8, 0)
	];
	this.com_keyFlag = this.Vector3();
	this.com_count = [
		0,
		0,
		0,
		0
	];
	this.com_rand = [
		0,
		0,
		0,
		0
	];
	this.com_subState = [
		this.CPU_Defence,
		null,
		this.CPU_MoveBase,
		this.CPU_AttackBase
	];
	this.Com_Init();
}

function Com_Init()
{
}

function Break_Basic_Com()
{
	this.CPU_Clear();
	this.cpuState = null;
}

function Run_Basic_Com()
{
	this.CPU_Clear();
	this.com_difficulty = this.difficulty;

	switch(this.difficulty)
	{
	case 0:
		this.com_level = 0;
		break;

	case 1:
		this.com_level = 33;
		break;

	case 2:
		this.com_level = 66;
		break;

	case 3:
		this.com_level = 100;
		break;
	}

	this.cpuState = this.CPU_Update_VS;
	this.com_senser = ::manbow.Sensor();
	this.com_senser.Init(this, 128, 192, 352);
	this.com_search = [
		this.array(1, 0),
		this.array(8, 0),
		this.array(8, 0)
	];
	this.com_keyFlag = this.Vector3();
	this.com_count = [
		0,
		0,
		0,
		0
	];
	this.com_rand = [
		0,
		0,
		0,
		0
	];
	this.com_stackState = [];
	this.com_subState = [
		this.CPU_Defence,
		null,
		this.CPU_MoveBase,
		this.CPU_AttackBase
	];
	this.Com_Init();
}

function CPU_Clear()
{
	this.command.rsv_k0 = 0;
	this.command.rsv_k1 = 0;
	this.command.rsv_k2 = 0;
	this.command.rsv_k3 = 0;
	this.command.rsv_k3_r = 0;
	this.command.rsv_k4 = 0;
	this.command.rsv_k5 = 0;
	this.command.rsv_k01 = 0;
	this.command.rsv_k12 = 0;
	this.command.rsv_k23 = 0;
	this.input.b0 = 0;
	this.input.b1 = 0;
	this.input.b2 = 0;
	this.input.b3 = 0;
	this.input.b4 = 0;
	this.input.b5 = 0;
	this.input.x = 0;
	this.input.y = 0;
	this.com_subState = null;
	this.com_senser = null;
	this.com_search = null;
	this.com_enemyPos = 0;
	this.com_level = 0;
	this.com_difficulty = 0;
	this.com_guard_rate = 0;
	this.com_guard_stance = 0;
	this.com_baria_rate = 0;
	this.com_aggro_stance = 0;
	this.com_sleep = 0;
	this.com_front = 1.00000000;
	this.com_disable_attack = 0;
	this.com_dash = 0.00000000;
	this.com_command = 0;
	this.cpuState = null;
	this.com_count = [
		0,
		0,
		0,
		0
	];
	this.com_rand = [
		0,
		0,
		0,
		0
	];
	this.com_rand_def = 0;
	this.com_stackState = [];
	this.com_stackCount = 0;
	this.com_stackFlag = 0;
	this.com_subState = [
		null,
		null,
		null,
		null
	];
}

function CPU_BossDamageFunc( d_ )
{
	if (this.spellBaria)
	{
		this.BossOccult_Damage(d_ * this.shield_rate);
		this.spellBaria.func[3].call(this.spellBaria);

		if (this.shield_rate == 1)
		{
			this.PlaySE(881);
		}
	}
}

function CPU_SetLevel( diff_ )
{
	switch(diff_)
	{
	case 0:
		this.com_baria_rate = 0;
		this.com_guard_rate = 25;
		break;

	case 1:
		this.com_baria_rate = 25;
		this.com_guard_rate = 33;
		break;

	case 2:
		this.com_baria_rate = 33;
		this.com_guard_rate = 50;
		break;

	case 3:
		this.com_baria_rate = 66;
		this.com_guard_rate = 90;
		break;

	case 4:
		this.com_baria_rate = 90;
		this.com_guard_rate = 95;
		break;
	}
}

function CPU_EnemySearch( near_, far_ )
{
	if (!this.target)
	{
		this.com_enemyPos = 0;
		return false;
	}

	local pos_ = this.Vector3();
	pos_.x = (this.target.x - this.x) * this.direction;
	pos_.y = this.target.y - this.y;
	local r_ = pos_.Length();

	if (r_ <= near_)
	{
		if (pos_.y <= -50)
		{
			this.com_enemyPos = 8;
		}
		else if (pos_.y >= 50)
		{
			this.com_enemyPos = 2;
		}
		else
		{
			this.com_enemyPos = 5;
		}
	}
	else
	{
		local rot_ = pos_.GetDegree();

		if (rot_ >= -22.50000000 && rot_ <= 22.50000000)
		{
			this.com_enemyPos = 16;
		}
		else if (rot_ <= -157.50000000 || rot_ >= 157.50000000)
		{
			this.com_enemyPos = 14;
		}
		else if (rot_ >= 0)
		{
			if (rot_ >= -67.50000000)
			{
				this.com_enemyPos = 13;
			}
			else if (rot_ <= -112.50000000)
			{
				this.com_enemyPos = 11;
			}
			else
			{
				this.com_enemyPos = 12;
			}
		}
		else if (rot_ <= 67.50000000)
		{
			this.com_enemyPos = 19;
		}
		else if (rot_ >= 112.50000000)
		{
			this.com_enemyPos = 17;
		}
		else
		{
			this.com_enemyPos = 18;
		}

		if (r_ >= far_)
		{
			this.com_enemyPos += 10;
		}
	}

	return true;
}

function CPU_CheckEnemyPos( array_ )
{
	if (this.com_enemyPos == 0)
	{
		return false;
	}

	foreach( a in array_ )
	{
		if (this.com_enemyPos == a)
		{
			return true;
		}
	}

	return false;
}

