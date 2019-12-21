#!python3
# -*- coding: utf-8 -*-

from tkinter import *

class Attr:
	def __init__(self, main, text='', funct=None, i=None, j=None, secret=False):
		if secret:
			self.box = Entry(main, show='*')
		else:
			self.box = Entry(main)
		self.box.insert(0, text)
		self.box.bind("<FocusIn>", self.clear_widget)
		self.box.bind('<FocusOut>', self.repopulate_defaults)
		if funct:
			self.box.bind('<Return>', funct)
		self.box.grid(row=i, column=j, sticky='NS')
		self.defaultText = text
		self.main = main
	def clear_widget(self, event):
		if self.box == self.main.focus_get() and self.box.get() == self.defaultText:
			self.box.delete(0, END)
	def repopulate_defaults(self, event):
		if self.box != self.main.focus_get() and self.box.get() == '':
			self.box.insert(0, self.defaultText)

class Meth:
	def __init__(self, main, caption, funct, i=None, j=None):
		self.btn = Button(main, text=caption, command=funct)
		self.btn.bind('<Return>', funct)
		self.btn.grid(row=i, column=j, sticky='NESW')

class Conn:
	def __init__(self, callback, title = "PostGIS connection wizard!"):
		# creates the main window object, defines its name, and default size
		main = Tk()
		main.title(title)
		self.host  = Attr(main, 'host',   None, 1, 5)
		self.port  = Attr(main, 'port',   None, 2, 5)
		self.dbnam = Attr(main, 'dbname', None, 3, 5)
		self.schem = Attr(main, 'scheme', None, 4, 5)
		self.table = Attr(main, 'table',  None, 5, 5)
		self.usern = Attr(main, 'usernm', None, 6, 5)
		self.passw = Attr(main, 'passwd', self.login, 7, 5, True)
		self.btn = Meth(main, 'Connect', self.login, 8, 5)
		self.main = main
		self.callback = callback
	def login(self, event=None):
		values = [self.host.box.get(),
		          self.port.box.get(),
		          self.dbnam.box.get(),
		          self.usern.box.get(),
		          self.passw.box.get(),
		          self.schem.box.get(),
		          self.table.box.get()]
		base = "PG:host=%s port=%s dbname='%s' user='%s' password='%s' schema='%s' table='%s' mode='2'"
		self.string = base % tuple(values)
		values[4] = '*'
		self.protected_string = base % tuple(values)
		self.main.destroy()
		self.callback(self)
	def show(self):
		self.main.mainloop()

if __name__ == '__main__':
	def test(obj):
		print(obj.string)
	conn = Conn(test, "Configure")
	conn.show()