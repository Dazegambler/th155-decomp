function Team_BinbouCrash( t_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.SetMotion(3912, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.PlaySE(4680);
	::camera.Shake(9,00000000.0);

	for( local i = 0; i < 15; i++ )
	{
		local t_ = {};
		t_.rot <- i * 24 * 0,01745329.0;
		this.SetShot(this.x, this.y, 1,00000000.0, this.Binbou_Shot, t_);
	}

	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			if (this.centerStop * this.centerStop >= 4)
			{
				this.LabelClear();
				this.ResetSpeed();
				this.team.op_stop = 120;
				this.team.op_stop_max = this.team.op_stop;
				this.Team_Change_Common();
				this.Team_Bench_In();
				this.team.current.Team_Change_MasterB(this.direction);
				local val_ = this.team.op;
				this.team.op_stop = (1200 - 1140 * (val_ / 2000,00000000.0)).tointeger();
				this.team.op_stop_max = this.team.op_stop;
				this.team.op = 0;
			}
			else
			{
				this.LabelClear();
				this.ResetSpeed();
				this.team.op_stop = 120;
				this.team.op_stop_max = this.team.op_stop;
				this.Team_Change_Common();
				this.Team_Bench_In();
				this.team.current.Team_Change_MasterB(this.direction);
				local val_ = this.team.op;
				this.team.op_stop = (1200 - 1140 * (val_ / 2000,00000000.0)).tointeger();
				this.team.op_stop_max = this.team.op_stop;
				this.team.op = 0;
			}

			return true;
		}
	};
	return true;
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_BinbouCrash(t_);
	return true;
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.Team_BinbouCrash(t_);
	return true;
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_BinbouCrash(t_);
	return true;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_BinbouCrash(t_);
	return true;
}

function Team_Change_AirMove( t_ )
{
	this.Team_BinbouCrash(t_);
	return true;
}

function Team_Change_SlaveB( t_ )
{
	this.Team_BinbouCrash(t_);
	return true;
}

function Team_Change_AttackB( t_ )
{
	this.Team_BinbouCrash(t_);
}

function Team_Change_Attack_AirB( t_ )
{
	this.Team_BinbouCrash(t_);
}

function Team_Change_ShotB( t_ )
{
	this.Team_BinbouCrash(t_);
}

function Team_Change_ShotFin( t, ky_ )
{
	local v_ = this.Vector3();
	v_.x = this.va.x;
	v_.y = this.va.y;
	this.Team_Change_Common();
	this.team.current.Warp(this.x, this.y);
	this.team.current.Team_Change_ShotFinB(v_, ky_);
}

function Team_Change_ShotFinB( va_, ky_ )
{
	this.Team_BinbouCrash(null);
}

function Team_Change_SpellB( t )
{
	this.Team_BinbouCrash(t);
	return true;
}

