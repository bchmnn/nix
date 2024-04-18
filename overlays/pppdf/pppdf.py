#!/usr/bin/env python

import sys
import math
import os

try:
    import notify2
except:
    print('Missing library: notify2')
    exit(1)

notify2.init('pppdf')
# notify2.Notification('pppdf', f'Working dir: {os.getcwd()}').show()

try:
    import pikepdf
except:
    notify2.Notification('pppdf', 'Missing library: pikepdf').show()
    print('Missing library: pikepdf')
    exit(1)

try:
    import gi
    gi.require_version("Gtk", "3.0")
    from gi.repository import Gtk
except:
    notify2.Notification('pppdf', 'Missing library: gi').show()
    print('Missing library: gi')
    exit(1)

if len(sys.argv) != 5:
    notify2.Notification('pppdf', 'Error: invalid arguments.').show()
    print('Error: invalid arguments.')
    print(f'Usage: {sys.argv[0]} <mime> <keep_original=true|false> <file> <mode=zip|rzip>')
    exit(1)

mime = sys.argv[1]
keep = sys.argv[2]
source = sys.argv[3]
mode = sys.argv[4]

if mime != 'application/pdf':
    notify2.Notification('pppdf', 'Error: Only support for pdf.').show()
    print('Error: Only support for pdf.')
    exit(1)


def pppdf_zip():
    try:
        with pikepdf.open(source) as pdf:

            target = pikepdf.Pdf.new()

            n = len(pdf.pages)
            if mode == "zip":
                pattern = [i // 2 if i % 2 == 0 else math.ceil(n / 2) + i // 2 for i in range(n)]
            else:
                pattern = [i // 2 if i % 2 == 0 else n - (i // 2) - 1 for i in range(n)]
            print(pattern)
            for i in pattern:
                target.pages.append(pdf.pages[i])

            if keep != "false":
                pdf.save(source + ".orig")
            target.save(source)
            notify2.Notification('pppdf', f'Success: {source}').show()
    except Exception as error:
        notify2.Notification('pppdf', f'Error: {error}').show()



class Dialog(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="pppdf")

        self.set_border_width(6)
        label = Gtk.Label(label=f"Do you want to zip {source}?")

        btn_cancel = Gtk.Button(label="Cancel")
        btn_ok = Gtk.Button(label="Ok")
        btn_cancel.connect("clicked", self.on_btn_cancel_clicked)
        btn_ok.connect("clicked", self.on_btn_ok_clicked)

        buttons = Gtk.Box(spacing=6)
        buttons.pack_start(btn_cancel, True, True, 0)
        buttons.pack_start(btn_ok, True, True, 0)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)

        vbox.pack_start(label, True, True, 0)
        vbox.pack_start(buttons, True, True, 0)

        self.add(vbox)

    def on_btn_cancel_clicked(self, widget):
        Gtk.main_quit()

    def on_btn_ok_clicked(self, widget):
        pppdf_zip()
        Gtk.main_quit()

win = Dialog()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()

