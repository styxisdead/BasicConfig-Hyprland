#!/usr/bin/env python3

import subprocess
import signal
import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib


def playerctl(args):
    try:
        return subprocess.check_output(
            ["playerctl"] + args,
            text=True,
            stderr=subprocess.DEVNULL
        ).strip()
    except subprocess.CalledProcessError:
        return ""


class MediaPopup(Gtk.Window):
    def __init__(self):
        super().__init__(title="Media")

        self.set_default_size(360, 180)
        self.set_resizable(False)
        self.set_keep_above(True)

        self.connect("destroy", Gtk.main_quit)

        box = Gtk.Box(
            orientation=Gtk.Orientation.VERTICAL,
            spacing=8
        )

        box.set_margin_top(18)
        box.set_margin_bottom(18)
        box.set_margin_start(20)
        box.set_margin_end(20)

        self.add(box)

        self.title_label = Gtk.Label()
        self.title_label.set_ellipsize(3)
        self.title_label.set_markup("<b>No media playing</b>")

        self.artist_label = Gtk.Label()
        self.artist_label.set_ellipsize(3)

        controls = Gtk.Box(
            orientation=Gtk.Orientation.HORIZONTAL,
            spacing=16
        )

        controls.set_halign(Gtk.Align.CENTER)

        previous = Gtk.Button(label="⏮")
        play_pause = Gtk.Button(label="▶ / ⏸")
        next_button = Gtk.Button(label="⏭")

        previous.connect(
            "clicked",
            lambda _: playerctl(["previous"])
        )

        play_pause.connect(
            "clicked",
            lambda _: playerctl(["play-pause"])
        )

        next_button.connect(
            "clicked",
            lambda _: playerctl(["next"])
        )

        controls.pack_start(previous, False, False, 0)
        controls.pack_start(play_pause, False, False, 0)
        controls.pack_start(next_button, False, False, 0)

        box.pack_start(self.title_label, False, False, 0)
        box.pack_start(self.artist_label, False, False, 0)
        box.pack_start(controls, False, False, 8)

        GLib.timeout_add(500, self.update)

        self.update()

    def update(self):
        metadata = playerctl([
            "metadata",
            "--format",
            "{{artist}}|||{{title}}"
        ])

        if metadata and "|||" in metadata:
            artist, title = metadata.split("|||", 1)

            self.title_label.set_markup(
                "<b>" + GLib.markup_escape_text(title) + "</b>"
            )

            self.artist_label.set_text(artist)

        else:
            self.title_label.set_markup("<b>No media playing</b>")
            self.artist_label.set_text("")

        return True


signal.signal(signal.SIGINT, signal.SIG_DFL)

window = MediaPopup()
window.show_all()

Gtk.main()