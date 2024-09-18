this.width <- 1280;
this.height <- 720;
::manbow.graphics.CompileFile("data/script/renderer_vm.nut");
::manbow.graphics.SetRenderFunction("Render");
::manbow.graphics.CreateCommandSlot("background2d_base");
::manbow.graphics.CreateCommandSlot("background2d_0");
::manbow.graphics.CreateCommandSlot("background2d_1");
::manbow.graphics.CreateCommandSlot("background3d_0");
::manbow.graphics.CreateCommandSlot("background3d_1");
::manbow.graphics.CreateCommandSlot("background3d_2");
::manbow.graphics.CreateCommandSlot("background3d_3");
::manbow.graphics.CreateCommandSlot("background3d_alpha");
::manbow.graphics.CreateCommandSlot("background3d_add");
::manbow.graphics.CreateCommandSlot("background_begin");
::manbow.graphics.CreateCommandSlot("background_end");
::manbow.graphics.CreateCommandSlot("background_end2");
::manbow.graphics.CreateCommandSlot("actor");
::manbow.graphics.CreateCommandSlot("info");
::manbow.graphics.CreateCommandSlot("info_back");
::manbow.graphics.CreateCommandSlot("status");
::manbow.graphics.CreateCommandSlot("talk");
::manbow.graphics.CreateCommandSlot("ui");
::manbow.graphics.CreateCommandSlot("overlay");
::manbow.graphics.CreateCommandSlot("front");
this.slot <- ::manbow.graphics.slot;
this.camera_screen <- ::manbow.Camera2D();
this.camera_screen.width = this.width;
this.camera_screen.height = this.height;
this.camera_screen.left = 0;
this.camera_screen.top = 0;
this.camera_screen.right = this.width;
this.camera_screen.bottom = this.height;
this.camera_screen.render_target_width = this.width;
this.camera_screen.render_target_height = this.height;
this.camera_screen.ConnectRenderSlot(this.slot.info, -1);
this.camera_screen.ConnectRenderSlot(this.slot.info_back, -1);
this.camera_screen.ConnectRenderSlot(this.slot.front, -1);
::manbow.effect.ConnectCamera(this.camera_screen);
this.fade_rect <- ::manbow.Rectangle();
this.fade_rect.SetPosition(-1, -1, this.width + 1, this.height + 1);
this.fade_rect.SetColor(1, 0, 0, 0);
this.fade_rect.visible = false;
this.fade_rect.ConnectRenderSlot(this.slot.front, 65535);
class this.FadeTask 
{
	callback_function = null;
	count = 0;
	alpha_delta = 0;
	function Update()
	{
		::graphics.fade_rect.alpha += this.alpha_delta;

		if (::graphics.fade_rect.alpha < 0)
		{
			::graphics.fade_rect.alpha = 0;
		}
		else if (::graphics.fade_rect.alpha > 1)
		{
			::graphics.fade_rect.alpha = 1;
		}

		if (this.count-- == 0)
		{
			::loop.DeleteTask(this);

			if (this.alpha_delta < 0)
			{
				::graphics.fade_rect.visible = false;
			}

			if (this.callback_function)
			{
				this.callback_function();
			}
		}
	}

}

this.fade_task <- this.FadeTask();
function FadeOut( count, func = null, r = 0, g = 0, b = 0 )
{
	this.fade_rect.red = r;
	this.fade_rect.green = g;
	this.fade_rect.blue = b;
	this.fade_rect.visible = true;
	this.fade_task.count = count;
	this.fade_task.callback_function = func;
	this.fade_task.alpha_delta = (1.00000000 - this.fade_rect.alpha) / count.tofloat();
	::loop.AddTask(this.fade_task);
}

function FadeIn( count, func = null )
{
	this.fade_rect.visible = true;
	this.fade_task.count = count;
	this.fade_task.callback_function = func;
	this.fade_task.alpha_delta = -this.fade_rect.alpha / count.tofloat();
	::loop.AddTask(this.fade_task, true);
}

function IsFading()
{
	return this.fade_rect.visible;
}

function ShowBackground( t )
{
	this.slot.background2d_base.Show(t);
	this.slot.background2d_0.Show(t);
	this.slot.background2d_1.Show(t);
	this.slot.background3d_0.Show(t);
	this.slot.background3d_1.Show(t);
	this.slot.background3d_2.Show(t);
	this.slot.background3d_add.Show(t);
}

function ShowActor( t )
{
	this.slot.actor.Show(t);
	this.slot.info.Show(t);
	this.slot.info_back.Show(t);
}

function CreateSprite( filename )
{
	local texture = ::manbow.Texture();
	texture.Load(filename);
	local sprite = ::manbow.Sprite();
	sprite.Initialize(texture, 0, 0, texture.width, texture.height);
	return sprite;
}

