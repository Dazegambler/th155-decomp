this.MASK_GLOBAL <- 65536;
this.mask <- this.MASK_GLOBAL;
function Update()
{
	::manbow.effect.SetUpdateMask(this.mask);
	this.mask = this.MASK_GLOBAL;
}

function AddUpdateMask( _mask )
{
	this.mask = this.mask | _mask;
}

this.Load <- ::manbow.effect.LoadEffect;
this.Create <- ::manbow.effect.Create;
this.Clear <- ::manbow.effect.Clear;
::loop.AddTask(this);
this.Load("cursor_flower_A.eft", 0);
this.Load("cursor_flower_B.eft", 1);
this.Load("chara_pick_1p.eft", 10);
this.Load("chara_pick_2p.eft", 11);
this.Load("staff_blossum.eft", 20);
this.Load("title_back_petal.eft", 21);
