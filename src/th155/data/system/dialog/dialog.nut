local _texture = ::manbow.Texture();
_texture.Load("data/system/dialog/mini_window.png");
local help_0 = [
	"B1",
	"ok",
	null,
	"B2",
	"return"
];
local help_1 = [
	"B1",
	"ok",
	null,
	"B2",
	"return",
	null,
	"LR",
	"select"
];
class this.Dialog 
{
	static texture = _texture;
	static OK = 0;
	static YESNO = 1;
	static TEXT = 2;
	type = 0;
	obj = null;
	proc = null;
	task = null;
	cursor = null;
	item = null;
	callback = null;
	constructor( type, message, callback = null, arg = null )
	{
		this.Initialize(type, message, callback, arg);
	}

	Update = null;
	function Initialize( _type, message, _callback = null, arg = null )
	{
		::loop.Begin(this);
		this.callback = _callback;
		this.obj = [];
		local sprite = ::manbow.Sprite();
		sprite.Initialize(this.texture, 0, 0, this.texture.width, this.texture.height);
		sprite.x = -this.texture.width / 2;
		sprite.y = -this.texture.height / 2;
		local text = ::font.CreateSystemString(message);
		text.x = -text.width / 2;
		this.obj.append(sprite);
		this.obj.append(text);
		this.type = _type;

		switch(_type)
		{
		case 1:
			text.y = -40;
			this.item = [];
			this.item.append(this.AddTextObject("‚\x2550‚¢", -80, 0));
			this.item.append(this.AddTextObject("‚¢‚¢‚¦", 80, 0));
			this.cursor = this.Cursor(1, this.item.len(), ::input_all);

			if (arg)
			{
				this.cursor.val = arg;
			}

			this.Update = this.UpdateSelect;
			::menu.cursor.Activate();
			break;

		case 2:
			text.y = -24;
			this.item = {};
			this.item.count <- 0;
			this.item.pos <- 0;
			local width = 400;
			local left = -width / 2;
			local right = width / 2;
			local top = 16;
			local bottom = 16 + 16;
			local margin = 2;
			this.item.left <- left;
			local input_rect = ::manbow.Rectangle();
			input_rect.SetPosition(left, top - margin, right, bottom + margin);
			input_rect.SetColor(1, 0,20000000.0, 0,20000000.0, 0,20000000.0);
			this.item.input_rect <- input_rect;
			this.obj.append(input_rect);
			local text = arg ? arg : "";
			this.item.text <- this.AddTextObject(text, 0, top, 64);
			this.item.text.x = left;
			local comp_rect = ::manbow.Rectangle();
			comp_rect.SetPosition(0, top - margin, 0, bottom + margin);
			comp_rect.SetColor(1, 0,20000000.0, 0,20000000.0, 0,20000000.0);
			comp_rect.visible = false;
			this.item.comp_rect <- comp_rect;
			this.obj.append(comp_rect);
			this.item.comp <- this.AddTextObject("", 0, 16, 64);
			this.item.comp.red = this.item.comp.blue = 0;
			local cursor_rect = ::manbow.Rectangle();
			cursor_rect.SetPosition(0, top, 1, bottom);
			this.item.cursor <- cursor_rect;
			this.obj.append(cursor_rect);
			this.Update = this.UpdateInputText;
			::manbow.SetIMEText(text);
			::manbow.SetIMECursor(0);
			::manbow.BeginIME();
			break;

		default:
			text.y = -text.height / 2;
			this.Update = this.UpdateOK;
			break;
		}

		this.task = ::loop.GeneratorTask();
		this.task.Set(function ( t )
		{
			// Function is a generator.
			foreach( v in this.obj )
			{
				v.ConnectRenderSlot(::graphics.slot.front, 10000);
			}

			local mat = ::manbow.Matrix();

			for( local i = 0; i <= 5; i = ++i )
			{
				mat.SetScaling(i / 5,00000000.0, i / 5,00000000.0, 1);
				mat.Translate(::graphics.width / 2, ::graphics.height / 2, 0);

				foreach( v in this.obj )
				{
					v.alpha = i / 5,00000000.0;
					v.SetWorldTransform(mat);
				}

				yield true;
			}
		}(this));
	}

	function Terminate()
	{
		::menu.help.Reset();

		if (this.type == 1)
		{
			::menu.cursor.Deactivate();
		}
		else
		{
		}

		this.task.Set(function ( t )
		{
			// Function is a generator.
			local mat = ::manbow.Matrix();

			for( local i = 5; i > 0; i = --i )
			{
				mat.SetScaling(i / 5,00000000.0, i / 5,00000000.0, 1);
				mat.Translate(::graphics.width / 2, ::graphics.height / 2, 0);

				foreach( v in this.obj )
				{
					v.alpha = i / 5,00000000.0;
					v.SetWorldTransform(mat);
				}

				yield true;
			}
		}(this));
	}

	function Suspend()
	{
	}

	function Resume()
	{
	}

	function AddTextObject( text, offset_x, offset_y )
	{
		local t = ::font.CreateSystemString(text);
		t.x = -t.width / 2 + offset_x;
		t.y = offset_y;
		this.obj.append(t);
		return t;
	}

	function UpdateOK()
	{
		::menu.help.Set(help_0);

		if (::input_all.b0 == 1 || ::input_all.b1 == 1)
		{
			::loop.End();

			if (this.callback)
			{
				this.callback();
			}
		}
	}

	function UpdateSelect()
	{
		::menu.help.Set(help_1);
		this.cursor.Update();

		foreach( i, v in this.item )
		{
			if (i == this.cursor.val)
			{
				v.red = v.green = v.blue = 1;
			}
			else
			{
				v.red = v.green = v.blue = 0,50000000.0;
			}
		}

		if (this.cursor.ok)
		{
			::loop.End();

			if (this.callback)
			{
				this.callback(this.cursor.val == 0);
			}
		}

		if (this.cursor.cancel)
		{
			::loop.End();

			if (this.callback)
			{
				this.callback(null);
			}
		}

		local cur = this.item[this.cursor.val];
		::menu.cursor.SetTarget(cur.x - 20 + ::graphics.width / 2, cur.y + 24 + ::graphics.height / 2, 0,69999999.0);
	}

	function UpdateInputText()
	{
		local im_state = {};
		::manbow.GetIMEState(im_state);

		if (im_state.text.len() > 32)
		{
			im_state.text = im_state.text.slice(0, 32);
			::manbow.SetIMEText(im_state.text);
		}

		this.item.text.Set(im_state.text);

		if (im_state.composition != "")
		{
			this.item.comp.Set(im_state.composition);
			this.item.comp.x = this.item.left + im_state.cursor * 8;
			this.item.comp_rect.x0 = this.item.comp.x;
			this.item.comp_rect.x1 = this.item.comp.x + im_state.composition.len() * 8;
			this.item.comp.visible = this.item.comp_rect.visible = true;
		}
		else
		{
			this.item.comp.visible = this.item.comp_rect.visible = false;
		}

		if (this.item.pos != im_state.cursor)
		{
			this.item.pos = im_state.cursor;
			this.item.count = 0;
		}

		this.item.cursor.visible = this.item.count++ % 60 < 30;
		this.item.cursor.x0 = this.item.left + im_state.cursor * 8;
		this.item.cursor.x1 = this.item.cursor.x0 + 1;

		if (::manbow.IsFinishedIME())
		{
			if (::manbow.IsKeyDown(28) || ::manbow.IsKeyDown(156))
			{
				::manbow.EndIME();
				::loop.End();
				::input_all.Lock();

				if (this.callback)
				{
					this.callback(im_state.text);
				}
			}
			else if (::manbow.IsKeyDown(1))
			{
				::manbow.EndIME();
				::loop.End();
				::input_all.Lock();

				if (this.callback)
				{
					this.callback(null);
				}
			}
		}
	}

}

