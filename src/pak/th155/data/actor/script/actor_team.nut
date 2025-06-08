function SetTeam_Player( type_ )
{
	switch(type_)
	{
	case 1:
		this.group = 1;
		this.callbackGroup = 1;
		this.callbackMask = 2 | 131072 | 8192 | 4 | 262144 | 16384;
		break;

	case 2:
		this.group = 2;
		this.callbackGroup = 2;
		this.callbackMask = 1 | 65536 | 4096 | 4 | 262144 | 16384;
		break;

	default:
		this.group = this.UG_PLAYER_C;
		this.callbackGroup = 4;
		this.callbackMask = 1 | 65536 | 4096 | 2 | 131072 | 8192;
		break;
	}
}

function SetTeamCheck()
{
	this.group = this.team.group_object;
	this.callbackGroup = this.team.callback_mask_self;
	this.callbackMask = this.team.callback_group_self;
}

function SetTeamCheckTarget()
{
	this.group = this.team.group_object;
	this.callbackGroup = this.team.callback_group_self;
	this.callbackMask = this.team.callback_mask_self;
}

function SetTeamFreeObject()
{
	this.group = this.team.group_object;
}

function SetTeamShot()
{
	this.group = this.team.group_object;
	this.callbackGroup = this.team.callback_group_shot;
	this.callbackMask = this.team.callback_mask_shot;
}

function SetEnemyTeamShot()
{
	this.group = this.team.group_object;
	this.callbackGroup = this.owner.target.team.callback_group_shot;
	this.callbackMask = this.owner.target.team.callback_mask_shot;
}

function SetAllHitShot()
{
	this.group = this.team.group_object;
	this.callbackGroup = 64;
	this.callbackMask = 1 | 16 | 65536 | 4096 | 2 | 32 | 131072 | 8192;
}

function SetTeamSelfShot()
{
	this.group = this.team.group_object;

	if (this.team.index != 0)
	{
		this.callbackGroup = 16;
		this.callbackMask = 2 | 32 | 131072 | 8192 | 4 | 64 | 262144 | 16384;
	}
	else
	{
		this.callbackGroup = 32;
		this.callbackMask = 1 | 16 | 65536 | 4096 | 4 | 64 | 262144 | 16384;
	}
}

function SetTeamObject()
{
	this.group = this.team.group_object;
	this.callbackGroup = this.team.callback_group_object;
	this.callbackMask = this.team.callback_mask_object;
}

