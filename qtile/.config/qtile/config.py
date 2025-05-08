from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

fix_group_apps_wm_class = [
    "brave-browser",
    "copyq",
    "telegram-desktop",
    "mullvad vpn",
]
@hook.subscribe.client_new
def fix_group(window):
    if any(app in window.get_wm_class() for app in fix_group_apps_wm_class):
        group = qtile.current_group
        if window.group != group:
            window.togroup(group.name)

@hook.subscribe.client_new
def assign_group(window):
    app_group_map = {
        "mullvad vpn": "3",
    }

    wm_class = window.get_wm_class()
    if wm_class:
        for app, group in app_group_map.items():
            if app in wm_class:
                window.togroup(group)
                break


def shorten_window_name(window_name):
    max_length = 32
    if len(window_name) > max_length:
        return window_name[:max_length] + "..."
    return window_name


mod = "mod4"
terminal = guess_terminal()

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key([mod], i.name, lazy.group[i.name].toscreen(), desc="Switch to group {}".format(i.name)),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True,), 
                desc="Switch to & move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(
        border_focus_stack="#ffffff",
        border_normal_stack="#000000",
        border_focus="#777777",
        border_normal="#000000",
        border_width=3,
        insert_position=1, # attachbelow
    ),
    layout.Max(),
]

widget_defaults = dict(
    font="monospace",
    fontsize=17,
    padding=2,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.Sep(
                    padding=10,
                    linewidth=2,
                ),
                widget.GroupBox(
                    fontsize=22,
                    spacing=5,
                    disable_drag=True,
                    this_current_screen_border="#ffffff",
                    highlight_method="line",
                ),
                widget.Sep(
                    padding=10,
                    linewidth=2,
                ),
                widget.Prompt(),
                widget.WindowTabs(
                    selected=("<u>", "</u>"),
                    separator="  |  ",
                    parse_text=shorten_window_name,
                    mouse_callbacks={"Button1": lazy.layout.next()},
                ),
                widget.Battery(
                    format="{char} {percent:2.0%}",
                    show_short_text=False,
                    low_percentage=0.2,
                    discharge_char="Ba",
                    charge_char="Ch",
                    full_char="Ba",
                    not_charging_char="Ba",
                ),
                widget.Sep(
                    padding=10,
                    linewidth=2,
                ),
                widget.Volume(
                    get_volume_command="pactl get-sink-volume @DEFAULT_SINK@",
                    check_mute_command="pactl get-sink-mute @DEFAULT_SINK@",
                    check_mute_string="yes",
                    mute_command="pactl set-sink-mute @DEFAULT_SINK@ toggle",
                    volume_up_command="pactl set-sink-volume @DEFAULT_SINK@ +10%",
                    volume_down_command="pactl set-sink-volume @DEFAULT_SINK@ -10%",
                    mute_format="MUTE",
                    fmt="Vo {}",
                ),
                widget.Sep(
                    padding=10,
                    linewidth=2,
                ),
                widget.Backlight(backlight_name="amdgpu_bl2", fmt="Br {}", step=5),
                widget.Sep(
                    padding=10,
                    linewidth=2,
                ),
                widget.Systray(icon_size=22),
                widget.Sep(
                    padding=20,
                    linewidth=2,
                ),
                widget.Clock(format="%H:%M | %a %d-%m "),
            ],
            33,
            background="#000000",
        ),
    ),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and namjava's whitelist.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    border_focus="#ffffff",
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# compatibility (leave as is)
wmname = "LG3D"
